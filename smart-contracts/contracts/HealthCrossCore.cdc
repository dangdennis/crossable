
access(all) contract HealthCrossCore {
    
    // AvatarAttributeUpdated is emitted when an avatar's attribute is updated
    pub event AvatarAttributeUpdated(avatarId: UInt64, type: String)

    // AvatarAttributeUpdated is emitted when an avatar's attribute fails to update
    pub event AvatarFailAttributeUpdated(avatarId: UInt64)

    // Interactible enforces the base requirements of a resource that interacts with an Avatar
    access(all) resource interface Interactible {
        pub let id: UInt64
        pub var name: String
    }

    // BodyNFT are physical characteristics that form the Avatar's unique identity
    access(all) resource BodyNFT: Interactible {
        pub let id: UInt64
        pub var name: String

        init(id: UInt64, name: String) {
            self.id = id
            self.name = name
        }
    }

    // BodyNFTCollection is a collection for BodyNFTs
    access(all) resource BodyNFTCollection {
        // physique is the makeup of the Avatar's physique
        pub let physique: @{String: BodyNFT}

        init() {
            self.physique <- {} // TODO: Set default physiques
        }

        destroy() {
            destroy self.physique
        }
    }

    // WearableNFT are items that an Avatar can don and trade with other Avatars
    access(all) resource WearableNFT: Interactible {
        pub let id: UInt64
        pub var name: String
        pub var outfitType: String

        init(id: UInt64, name: String, outfitType: String) {
            self.id = id
            self.name = name
            self.outfitType = outfitType
        }
    }

    // WearableNFTCollection is a collection for WearableNFTs
    access(all) resource WearableNFTCollection {
        // closet is a collection of unworn WearableNFTs
        pub let closet: @{UInt64: WearableNFT}
        // outfit is a collection of WearableNFTs currently worn by the Avatar
        pub let outfit: @{String: WearableNFT}

        init() {
            self.closet <- {} 
            self.outfit <- {} // TODO: Set default outfit
        }

        destroy() {
            destroy self.closet
            destroy self.outfit
        }
    }

    // WearableNFTMarketplace is public marketplace to sell wearables
    access(all) resource WearableNFTMarketplace {}

    access(all) resource Avatar {
        pub let id: UInt64
        pub let createdAt: String
        pub let bodyNFTCollection: @HealthCrossCore.BodyNFTCollection
        pub let wearableNFTCollection: @HealthCrossCore.WearableNFTCollection
        pub let healthStats: {String: HealthCrossCore.HealthStat}
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

        // changeBodyNFT replaces the old body part with the new one.
        // Destroy the old one because they are not meant to exist apart from an Avatar.
        pub fun changeBodyNFT(type: String, bodyPart: @HealthCrossCore.BodyNFT) {
            let prevBodyPart <- self.bodyNFTCollection.physique.remove(key: type) ?? panic("are you missing a body part?!")
            self.bodyNFTCollection.physique[type] <-! bodyPart
            destroy prevBodyPart
        }

        // storeWearableNFT stores a wearableNFT into the Avatar's closet
        pub fun storeWearableNFT(wearable: @HealthCrossCore.WearableNFT) {
            self.wearableNFTCollection.closet[wearable.id] <-! wearable
        }

        // wearWearableNFT puts the wearableNFT onto the Avatar itself
        pub fun wearWearableNFT(wearable: @HealthCrossCore.WearableNFT) {
            self.wearableNFTCollection.outfit[wearable.outfitType] <-! wearable
        }

        // updateAttribute updates a single health stat
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

    access(all) resource AvatarMinter {
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

    access(all) resource AvatarController {
        pub fun updateAttributes(avatar: @HealthCrossCore.Avatar, attributes: {String: UFix64}): @HealthCrossCore.Avatar {
            for attributeType in attributes.keys {
                avatar.updateAttribute(type: attributeType, value: attributes[attributeType]!)
            }
            return <- avatar
        }
    }

    // TODO: COMPLETE AVATAR PROGRESSION LOGIC 
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
