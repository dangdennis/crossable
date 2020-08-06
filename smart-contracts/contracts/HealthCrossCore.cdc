
access(all) contract HealthCrossCore {
    
    // AvatarAttributeUpdated is emitted when an avatar's attribute is updated
    pub event AvatarAttributeUpdated(avatarId: UInt64, type: String)

    // AvatarAttributeUpdated is emitted when an avatar's attribute fails to update
    pub event AvatarFailAttributeUpdated(avatarId: UInt64)

    access(all) resource interface Interactible {}
    access(all) resource BodyNFT: Interactible {}
    access(all) resource WearableNFT: Interactible {}
    access(all) resource BodyNFTCollection {}
    access(all) resource WearableNFTCollection {}
    access(all) resource WearableNFTMarketplace {}

    // HealthStat is a single data point as part of an Avatar's health stats.
    pub struct HealthStat {
        // type is the name of the health. i.e. "activeEnergy"
        pub var type: String
        pub var value: UFix64
        // unit is the unit of measurement. i.e. "minutes/miles"
        pub var unit: String
        
        init(type: String, value: UFix64, unit: String) {
            self.type = type
            self.value = value
            self.unit = unit
        }
    }

    pub resource Avatar {
        pub let id: UInt64
        pub let createdAt: String
        pub let bodyNFTCollection: @BodyNFTCollection
        pub let wearableNFTCollection: @WearableNFTCollection
        pub let healthStats: {String: HealthStat}
        pub var name: String
        pub var age: UInt64
        
        init(id: UInt64, name: String) {
            self.id = id
            self.createdAt = "2006-04-20" // TODO: Get data creation time
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
            self.name = name
            self.age = 0
        }

        pub fun setName(name: String) {
            self.name = name
        }

        pub fun updateAttribute(type: String, value: UFix64) {
            let prevStat = self.healthStats[type]!
            self.healthStats[type] = HealthStat(type: prevStat.type, value: prevStat.value + value, unit: prevStat.unit)
            emit AvatarAttributeUpdated(avatarId: self.id, type: prevStat.type)
        }


        destroy() {
            destroy self.bodyNFTCollection
            destroy self.wearableNFTCollection
        }
    }

    pub resource AvatarMinter {
        pub var idCount: UInt64
        pub var totalSupply: UInt64

        init() {
            self.idCount = 0
            self.totalSupply = 0
        }

        pub fun mintAvatar(name: String): @Avatar {
            self.idCount = self.idCount + UInt64(1)
            self.totalSupply = self.totalSupply + UInt64(1)
            return <- create HealthCrossCore.Avatar(id: self.idCount, name: name)
        }
    }

    pub resource AvatarController {
        pub fun updateAttributes(avatar: @HealthCrossCore.Avatar, attributes: {String: UFix64}): @HealthCrossCore.Avatar {
            for attributeType in attributes.keys {
                avatar.updateAttribute(type: attributeType, value: attributes[attributeType]!)
            }
            return <- avatar
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
        self.account.save(<-create AvatarMinter(), to: /storage/HealthCrossAvatarMinter)
        self.account.save(<-create AvatarController(), to: /storage/HealthCrossAvatarController)
    }
}
