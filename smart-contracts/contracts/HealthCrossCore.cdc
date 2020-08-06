
access(all) contract HealthCrossCore {
    access(all) resource interface Interactible {}
    access(all) resource BodyNFT: Interactible {}
    access(all) resource WearableNFT: Interactible {}
    access(all) resource BodyNFTCollection {}
    access(all) resource WearableNFTCollection {}
    access(all) resource WearableNFTMarketplace {}

    pub struct HealthStat {
        pub var type: String
        pub var value: UFix64
        pub var unit: String
        
        init(type: String, value: UFix64, unit: String) {
            self.type = type
            self.value = value
            self.unit = unit
        }
    }

    access(all) resource Avatar {
        pub let id: UInt64
        pub let createdAt: String
        pub let healthStats: {String: HealthStat}
        pub let bodyNFTCollection: @BodyNFTCollection
        pub let wearableNFTCollection: @WearableNFTCollection
        pub var age: UInt64
        
        init() {
            self.id = 0
            self.createdAt = "2006-04-20" // TODO: Get data creation time
            self.age = 0
            self.bodyNFTCollection <- create HealthCrossCore.BodyNFTCollection()
            self.wearableNFTCollection <- create HealthCrossCore.WearableNFTCollection()
            self.healthStats = {
                "activeEnergy": HealthCrossCore.HealthStat(type: "activeEnergy", value: UFix64(0), unit: "kcal"),
                "exerciseTime": HealthCrossCore.HealthStat(type: "exerciseTime", value: UFix64(0), unit: "kcal"),
                "pushCount": HealthCrossCore.HealthStat(type: "pushCount", value: UFix64(0), unit: "kcal"),
                "hoursAsleep": HealthCrossCore.HealthStat(type: "hoursAsleep", value: UFix64(0), unit: "kcal"),
                "hoursInBed": HealthCrossCore.HealthStat(type: "hoursInBed", value: UFix64(0), unit: "kcal"),
                "stepCount": HealthCrossCore.HealthStat(type: "stepCount", value: UFix64(0), unit: "kcal"),
                "distanceWalkingRunning": HealthCrossCore.HealthStat(type: "distanceWalkingRunning", value: UFix64(0), unit: "kcal")
            }
        }

        destroy() {
            destroy self.bodyNFTCollection
            destroy self.wearableNFTCollection
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
