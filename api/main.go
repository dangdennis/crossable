package main

import (
	"fmt"
	"log"

	"github.com/dangdennis/health-cross/api/dataloader"
)

func main() {
	healthRecords, err := dataloader.Read()
	if err != nil {
		log.Fatalf("%+v", err)
	}

	fmt.Printf("%+v", healthRecords)
}
