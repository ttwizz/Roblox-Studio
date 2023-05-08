return function(plr: Player, item: number)
    assert(plr, "Player missing or invalid")
    local itemId = assert(item, "Item missing or invalid")
    local success, productInfo = pcall(game:GetService("MarketplaceService").GetProductInfo, game:GetService("MarketplaceService"), itemId)
    assert(success and productInfo, "Invalid item ID")
    local typeId = productInfo.AssetTypeId
    local SingleAssetIds = {
        [2] = "GraphicTShirt",
        [11] = "Shirt",
        [12] = "Pants",
        [17] = "Head",
        [18] = "Face",
        [27] = "Torso",
        [28] = "RightArm",
        [29] = "LeftArm",
        [30] = "LeftLeg",
        [31] = "RightLeg",
        [48] = "ClimbAnimation",
        [49] = "DeathAnimation",
        [50] = "FallAnimation",
        [51] = "IdleAnimation",
        [52] = "JumpAnimation",
        [53] = "RunAnimation",
        [54] = "SwimAnimation",
        [55] = "WalkAnimation"
    }
    local AccessoryAssetIds = {
        [8] = "HatAccessory",
        [41] = "HairAccessory",
        [42] = "FaceAccessory",
        [43] = "NeckAccessory",
        [44] = "ShouldersAccessory",
        [45] = "FrontAccessory",
        [46] = "BackAccessory",
        [47] = "WaistAccessory"
    }
    local LayeredAccessoryAssetIds = {
        [64] = Enum.AccessoryType.TShirt,
        [65] = Enum.AccessoryType.Shirt,
        [66] = Enum.AccessoryType.Pants,
        [67] = Enum.AccessoryType.Jacket,
        [68] = Enum.AccessoryType.Sweater,
        [69] = Enum.AccessoryType.Shorts,
        [70] = Enum.AccessoryType.LeftShoe,
        [71] = Enum.AccessoryType.RightShoe,
        [72] = Enum.AccessoryType.DressSkirt
    }
    for _, v: Player in game:GetService("Players"):GetPlayers() do
        if v.Name == plr.Name then
            local humanoid: Humanoid? = v.Character and v.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                local humanoidDesc = humanoid:GetAppliedDescription()
                if SingleAssetIds[typeId] then
                    humanoidDesc[SingleAssetIds[typeId]] = itemId
                elseif AccessoryAssetIds[typeId] then
                    if string.find(humanoidDesc[AccessoryAssetIds[typeId]], tostring(itemId)) then continue end
                    humanoidDesc[AccessoryAssetIds[typeId]] ..= "," .. itemId
                elseif LayeredAccessoryAssetIds[typeId] then
                    local accessories = humanoidDesc:GetAccessories(true)
                    table.insert(accessories, {
                        Order = #accessories,
                        AssetId = itemId,
                        AccessoryType = LayeredAccessoryAssetIds[typeId]
                    })
                    humanoidDesc:SetAccessories(accessories, true)
                elseif typeId == 61 then
                    humanoidDesc:AddEmote(productInfo.Name, itemId)
                else
                    error("Item not supported")
                end
                task.defer(humanoid.ApplyDescription, humanoid, humanoidDesc, Enum.AssetTypeVerification.Always)
            end
        end
    end
end