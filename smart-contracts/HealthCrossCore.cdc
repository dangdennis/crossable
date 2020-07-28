
access(all) contract HealthCrossCore {

    access(all) resource interface Interactible {}
    access(all) resource BodyNFT: Interactible {}
    access(all) resource WearableNFT: Interactible {}
    access(all) resource BodyNFTCollection {}
    access(all) resource WearableNFTCollection {}
    access(all) resource WearableNFTMarketplace {}

    access(all) resource Avatar {
        pub let id: UInt64
        pub let createdAt: String
        pub let healthData: {String: UFix64}
        pub let bodyNFTCollection: @BodyNFTCollection
        pub let wearableNFTCollection: @WearableNFTCollection

        init() {
            self.id = 0
            self.createdAt = "2006-04-20"
            self.healthData = {
                activeEnergy: UFix64(0),         
                exerciseTime: UFix64(0),         
                pushCount: UFix64(0),              
                hoursAsleep: UFix64(0),            
                hoursInBed: UFix64(0),             
                stepCount: UFix64(0),              
                DistanceWalkingRunning: UFix64(0)
            }
        }
    }

    // Collections

    // Avatar 
    // pub fun mintAvatar(): @Avatar
    // pub fun updateAttributes(avatar: @Avatar, healthDataMap: {String: UFix64}): @Avatar
    // pub fun updateAttribute(avatar: @Avatar, healthDataKey: string, value: UFix64): @Avatar
    
    // // Interactibles
    // pub fun mintBodyNFT(): @BodyNFT
    // pub fun mintWearableNFT(): @WearableNFT
    // pub fun addBodyNFT(avatar: @Avatar, nft: @BodyNFT): @Avatar
    // pub fun addWearableNFT(avatar: @Avatar, nft: @WearableNFT): @Avatar
    // pub fun removeBodyNFT(avatar: @Avatar, id: UInt64): @Avatar
    // pub fun removeWearableNFT(avatar: @Avatar, id: UInt64): @Avatar

    // // Marketplace
    // pub fun mintMarketplace(): @WearableNFTMarketplace
    // pub fun addToMarket(nft: @WearableNFT)
    // pub fun addToMarket(id: UInt64): @WearableNFT

    // // Achievement Board
    // // Rewards and unlockables
    // // 1. Unlock based on absolute growth
    // // 2. Unlock based on relative growth
    // pub struct AchievementBoard {

    // }

    init() {

    }
}