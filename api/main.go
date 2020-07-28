package main

import (
	"context"
	"crypto/rand"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"

	"github.com/onflow/flow-go-sdk"
	"github.com/onflow/flow-go-sdk/client"
	"github.com/onflow/flow-go-sdk/crypto"
	"github.com/onflow/flow-go-sdk/templates"
	"google.golang.org/grpc"

	"github.com/dangdennis/health-cross/api/dataloader"
)

const mockHealthKitFile = "./dennis-export-07-25.csv"
const healthCrossContractFile = "../smart-contracts/HealthCrossCore.cdc"
const flowConfigFile = "./flow.json"

var (
	servicePrivateKeyHex     string
	servicePrivateKeySigAlgo crypto.SignatureAlgorithm
)

type flowConfig struct {
	Accounts struct {
		Service struct {
			Address    string `json:"address"`
			PrivateKey string `json:"privateKey"`
			SigAlgo    string `json:"sigAlgorithm"`
			HashAlgo   string `json:"hashAlgorithm"`
		}
	}
}

func readConfig() (flowConfig, error) {
	f, err := os.Open(flowConfigFile)
	if err != nil {
		if os.IsNotExist(err) {
			fmt.Println("Emulator examples must be run from the flow-go-sdk/examples directory. Please see flow-go-sdk/examples/README.md for more details.")
		} else {
			fmt.Printf("Failed to load config from %s: %s\n", flowConfigFile, err.Error())
		}

		os.Exit(1)
	}

	d := json.NewDecoder(f)

	var conf flowConfig

	err = d.Decode(&conf)
	if err != nil {
		return conf, err
	}

	return conf, nil
}

func init() {
	conf, err := readConfig()
	if err != nil {
		log.Fatalf("%+v", err)
	}
	servicePrivateKeyHex = conf.Accounts.Service.PrivateKey
	servicePrivateKeySigAlgo = crypto.StringToSignatureAlgorithm(conf.Accounts.Service.SigAlgo)
}

func main() {
	healthRecords, err := dataloader.ReadFile(mockHealthKitFile)
	if err != nil {
		log.Fatalf("%+v", err)
	}

	fmt.Printf("%+v", healthRecords)

	err = DeployContractDemo()
	if err != nil {
		log.Fatalf("%+v", err)
	}
}

func DeployContractDemo() error {
	// Connect to an emulator running locally
	ctx := context.Background()
	flowClient, err := client.New("127.0.0.1:3569", grpc.WithInsecure())
	if err != nil {
		return err
	}

	serviceAcctAddr, serviceAcctKey, serviceSigner, err := NewServiceAccount(flowClient)
	if err != nil {
		return err
	}

	myPrivateKey := RandomPrivateKey()
	myAcctKey := flow.NewAccountKey().
		FromPrivateKey(myPrivateKey).
		SetHashAlgo(crypto.SHA3_256).
		SetWeight(flow.AccountKeyWeightThreshold)

	// mySigner := crypto.NewInMemorySigner(myPrivateKey, myAcctKey.HashAlgo)

	createAccountTx := templates.CreateAccount([]*flow.AccountKey{myAcctKey}, nil, serviceAcctAddr)
	createAccountTx.SetProposalKey(
		serviceAcctAddr,
		serviceAcctKey.ID,
		serviceAcctKey.SequenceNumber,
	)
	createAccountTx.SetPayer(serviceAcctAddr)

	err = createAccountTx.SignEnvelope(serviceAcctAddr, serviceAcctKey.ID, serviceSigner)
	if err != nil {
		return err

	}

	err = flowClient.SendTransaction(ctx, *createAccountTx)
	if err != nil {
		return err
	}

	accountCreationTxRes, err := WaitForSeal(ctx, flowClient, createAccountTx.ID())
	if accountCreationTxRes != nil && accountCreationTxRes.Error != nil {
		return accountCreationTxRes.Error
	}
	if err != nil {
		return err
	}

	// Successful Tx, increment sequence number
	serviceAcctKey.SequenceNumber++

	var myAddress flow.Address

	for _, event := range accountCreationTxRes.Events {
		if event.Type == flow.EventAccountCreated {
			accountCreatedEvent := flow.AccountCreatedEvent(event)
			myAddress = accountCreatedEvent.Address()
		}
	}

	fmt.Println("My Address:", myAddress.Hex())

	// Deploy the Great NFT contract
	nftCode := ReadFile(healthCrossContractFile)
	deployContractTx := templates.CreateAccount(nil, nftCode, myAddress)

	deployContractTx.SetProposalKey(myAddress, myAcctKey.ID, myAcctKey.SequenceNumber)
	deployContractTx.SetPayer(myAddress)

	err = deployContractTx.SignEnvelope(myAddress, myAcctKey.ID, crypto.NewInMemorySigner(myPrivateKey, myAcctKey.HashAlgo))
	if err != nil {
		return err
	}

	// err = flowClient.SendTransaction(ctx, *deployContractTx)
	// if err != nil {
	// 	return err
	// }
	//
	// deployContractTxResp := examples.WaitForSeal(ctx, flowClient, deployContractTx.ID())
	// if deployContractTxResp.Error != nil {
	// 	return err
	// }
	//
	// // Successful Tx, increment sequence number
	// myAcctKey.SequenceNumber++
	//
	// var nftAddress flow.Address
	//
	// for _, event := range deployContractTxResp.Events {
	// 	if event.Type == flow.EventAccountCreated {
	// 		accountCreatedEvent := flow.AccountCreatedEvent(event)
	// 		nftAddress = accountCreatedEvent.Address()
	// 	}
	// }
	//
	// fmt.Println("My Address:", nftAddress.Hex())

	// // Next, instantiate the minter
	// createMinterScript := GenerateCreateMinterScript(nftAddress, 1, 2)
	//
	// createMinterTx := flow.NewTransaction().
	// 	SetScript(createMinterScript).
	// 	SetProposalKey(myAddress, myAcctKey.ID, myAcctKey.SequenceNumber).
	// 	SetPayer(myAddress).
	// 	AddAuthorizer(myAddress)
	//
	// err = createMinterTx.SignEnvelope(myAddress, myAcctKey.ID, mySigner)
	// if err != nil {
	// return err
	// }
	//
	// err = flowClient.SendTransaction(ctx, *createMinterTx)
	// if err != nil {
	// return err
	// }
	//
	// createMinterTxResp := examples.WaitForSeal(ctx, flowClient, deployContractTx.ID())
	// examples.Handle(createMinterTxResp.Error)
	//
	// // Successful Tx, increment sequence number
	// myAcctKey.SequenceNumber++
	//
	// mintScript := GenerateMintScript(nftAddress)
	//
	// // Mint the NFT
	// mintTx := flow.NewTransaction().
	// 	SetScript(mintScript).
	// 	SetProposalKey(myAddress, myAcctKey.ID, myAcctKey.SequenceNumber).
	// 	SetPayer(myAddress).
	// 	AddAuthorizer(myAddress)
	//
	// err = mintTx.SignEnvelope(myAddress, myAcctKey.ID, mySigner)
	// if err != nil {
	// return err
	// }
	//
	// err = flowClient.SendTransaction(ctx, *mintTx)
	// if err != nil {
	// return err
	// }
	//
	// mintTxResp := examples.WaitForSeal(ctx, flowClient, mintTx.ID())
	// examples.Handle(mintTxResp.Error)
	//
	// // Successful Tx, increment sequence number
	// myAcctKey.SequenceNumber++
	//
	// fmt.Println("NFT minted!")
	//
	// result, err := flowClient.ExecuteScriptAtLatestBlock(ctx, GenerateGetNFTIDScript(nftAddress, myAddress), nil)
	// if err != nil {
	// return err
	// }
	//
	// myTokenID := result.(cadence.Int)
	//
	// fmt.Printf("You now own the Great NFT with ID: %d\n", myTokenID.Int())

	return nil
}

// ReadFile reads a file from the file system.
func ReadFile(path string) []byte {
	contents, err := ioutil.ReadFile(path)
	if err != nil {
		panic(err)
	}
	return contents
}

// ServiceAccount creates a new service account
func NewServiceAccount(flowClient *client.Client) (flow.Address, *flow.AccountKey, crypto.Signer, error) {
	privateKey, err := crypto.DecodePrivateKeyHex(servicePrivateKeySigAlgo, servicePrivateKeyHex)
	if err != nil {
		return flow.Address{}, nil, nil, err
	}

	addr := flow.ServiceAddress(flow.Emulator)

	acc, err := flowClient.GetAccount(context.Background(), addr)
	if err != nil {
		return flow.Address{}, nil, nil, err
	}

	acctKey := acc.Keys[0]
	signer := crypto.NewInMemorySigner(privateKey, acctKey.HashAlgo)

	return addr, acctKey, signer, nil
}

// WaitForSeal attempts to wait for a transaction to be sealed before returning the results
// If not yet sealed, it will sleep for a second and retry once
func WaitForSeal(ctx context.Context, c *client.Client, id flow.Identifier) (*flow.TransactionResult, error) {
	result, err := c.GetTransactionResult(ctx, id)
	if err != nil {
		return nil, err
	}

	fmt.Printf("Waiting for transaction %s to be sealed...\n", id)

	for result.Status != flow.TransactionStatusSealed {
		time.Sleep(time.Second)
		fmt.Print(".")
		result, err = c.GetTransactionResult(ctx, id)
		if err != nil {
			return nil, err
		}
	}

	fmt.Println()
	fmt.Printf("Transaction %s sealed\n", id)

	return result, nil
}

// RandomPrivateKey returns a randomly generated ECDSA P-256 private key.
func RandomPrivateKey() crypto.PrivateKey {
	seed := make([]byte, crypto.MinSeedLength)

	_, err := rand.Read(seed)
	if err != nil {
		panic(err)
	}

	privateKey, err := crypto.GeneratePrivateKey(crypto.ECDSA_P256, seed)
	if err != nil {
		panic(err)
	}

	return privateKey
}

// GenerateCreateMinterScript Creates a script that instantiates
// a new GreatNFTMinter instance and stores it in memory.
// Initial ID and special mod are arguments to the GreatNFTMinter constructor.
// The GreatNFTMinter must have been deployed already.
func GenerateCreateMinterScript(nftAddr flow.Address, initialID, specialMod int) []byte {
	template := `
		import GreatToken from 0x%s
		transaction {
			prepare(acct: AuthAccount) {
				let minter <- GreatToken.createGreatNFTMinter(firstID: %d, specialMod: %d)
				acct.save(<-minter, to: /storage/GreatNFTMinter)
			}
		}
	`

	return []byte(fmt.Sprintf(template, nftAddr, initialID, specialMod))
}

// GenerateMintScript Creates a script that mints an NFT and put it into storage.
// The minter must have been instantiated already.
func GenerateMintScript(nftCodeAddr flow.Address) []byte {
	template := `
		import GreatToken from 0x%s
		transaction {
			prepare(acct: AuthAccount) {
			  let minter = acct.borrow<&GreatToken.GreatNFTMinter>(from: /storage/GreatNFTMinter)!
			  if let nft <- acct.load<@GreatToken.GreatNFT>(from: /storage/GreatNFT) {
				  destroy nft
			  }
			  acct.save(<-minter.mint(), to: /storage/GreatNFT)
			  acct.link<&GreatToken.GreatNFT>(/public/GreatNFT, target: /storage/GreatNFT)
			}
		  }
	`

	return []byte(fmt.Sprintf(template, nftCodeAddr.String()))
}

// GenerateGetNFTIDScript creates a script that retrieves an NFT from storage and returns its ID.
func GenerateGetNFTIDScript(nftCodeAddr, userAddr flow.Address) []byte {
	template := `
		import GreatToken from 0x%s
		pub fun main(): Int {
			let acct = getAccount(0x%s)
			let nft = acct.getCapability(/public/GreatNFT)!.borrow<&GreatToken.GreatNFT>()!
			return nft.id()
		}
	`

	return []byte(fmt.Sprintf(template, nftCodeAddr, userAddr))
}
