-- Variables
local isEscorting = false

-- Functions
exports('IsHandcuffed', function()
    return isHandcuffed
end)

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function IsTargetDead(playerId)
    local retval = false
    exports['lxr-core']:TriggerCallback('police:server:isPlayerDead', function(result)
        retval = result
    end, playerId)
    Wait(100)
    return retval
end

-- Events
RegisterNetEvent('police:client:SetOutVehicle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)
    end
end)

RegisterNetEvent('police:client:PutInVehicle', function()
    local ped = PlayerPedId()
    if isHandcuffed or isEscorted then
        local vehicle = exports['lxr-core']:GetClosestVehicle()
        if DoesEntityExist(vehicle) then
			for i = GetVehicleMaxNumberOfPassengers(vehicle), 1, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    isEscorted = false
                    TriggerEvent('hospital:client:isEscorted', isEscorted)
                    ClearPedTasks(ped)
                    DetachEntity(ped, true, false)

                    Wait(100)
                    SetPedIntoVehicle(ped, vehicle, i)
                    return
                end
            end
		end
    end
end)

RegisterNetEvent('police:client:SearchPlayer', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
        TriggerServerEvent("police:server:SearchPlayer", playerId)
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:SeizeCash', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeCash", playerId)
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:SeizeDriverLicense', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeDriverLicense", playerId)
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)


RegisterNetEvent('police:client:RobPlayer', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)

        if IsEntityPlayingAnim(playerPed, 'mech_busted@arrest', 'hands_up_transition', 3) then
            exports['lxr-core']:Progressbar("robbing_player", Lang:t("progressbar.robbing"), math.random(5000, 7000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(ped)
                if #(pos - plyCoords) < 2.5 then
                    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                    TriggerEvent("inventory:server:RobPlayer", playerId)
                else
                    exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                end
            end, function() -- Cancel
                exports['lxr-core']:Notify(9, Lang:t("error.canceled"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end)
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:JailCommand', function(playerId, time)
    TriggerServerEvent("police:server:JailPlayer", playerId, tonumber(time))
end)

RegisterNetEvent('police:client:BillCommand', function(playerId, price)
    TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(price))
end)

RegisterNetEvent('police:client:JailPlayer', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialogInput = LocalInput(Lang:t('info.jail_time_input'), 11)
        if tonumber(dialogInput) > 0 then
            TriggerServerEvent("police:server:JailPlayer", playerId, tonumber(dialogInput))
        else
            exports['lxr-core']:Notify(9, Lang:t("error.time_higher"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:BillPlayer', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialogInput = LocalInput(Lang:t('info.jail_time_input'), 11)
        if tonumber(dialogInput) > 0 then
            TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(dialogInput))
        else
            exports['lxr-core']:Notify(9, Lang:t("error.amount_higher"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:PutPlayerInVehicle", playerId)
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:EscortPlayer", playerId)
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:KidnapPlayer', function()
    local player, distance = exports['lxr-core']:GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) then
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("police:server:KidnapPlayer", playerId)
            end
        end
    else
        exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:client:CuffPlayerSoft', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = exports['lxr-core']:GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent("police:server:CuffPlayer", playerId, true)                
            else
                exports['lxr-core']:Notify(9, Lang:t("error.vehicle_cuff"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        else
            exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:CuffPlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = exports['lxr-core']:GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            exports['lxr-core']:TriggerCallback('LXRCore:HasItem', function(result)
                if result then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                        TriggerServerEvent("police:server:CuffPlayer", playerId, false)                        
                    else
                        exports['lxr-core']:Notify(9, Lang:t("error.vehicle_cuff"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                    end
                else
                    exports['lxr-core']:Notify(9, Lang:t("error.no_cuff"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                end
            end, Config.HandCuffItem)
        else
            exports['lxr-core']:Notify(9, Lang:t("error.none_nearby"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetEscorted', function(playerId)
    local ped = PlayerPedId()
    exports['lxr-core']:GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('police:client:GetKidnappedTarget', function(playerId)
    local ped = PlayerPedId()
    exports['lxr-core']:GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or isHandcuffed then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))               
                AttachEntityToEntity(ped, dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)                
            else
                isEscorted = false
                DetachEntity(ped, true, false)
                ClearPedTasksImmediately(ped)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:GetKidnappedDragger', function(playerId)
    exports['lxr-core']:GetPlayerData(function(PlayerData)
        if not isEscorting then
            draggerId = playerId
            local dragger = PlayerPedId()          
            isEscorting = true
        else
            local dragger = PlayerPedId()
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('hospital:client:SetEscortingState', isEscorting)
        TriggerEvent('lxr-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

RegisterNetEvent('police:client:GetCuffed', function(playerId, isSoftcuff)
    local ped = PlayerPedId()
    if not isHandcuffed then
        isHandcuffed = true
        TriggerServerEvent("police:server:SetHandcuffStatus", true)
        ClearPedTasksImmediately(ped)
        if Citizen.InvokeNative(0x8425C5F057012DAB,ped) ~= GetHashKey("WEAPON_UNARMED") then
            SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
        end
        if not isSoftcuff then
            cuffType = 16            
            exports['lxr-core']:Notify(9, Lang:t("info.cuff"), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        else
            cuffType = 49            
            exports['lxr-core']:Notify(9, Lang:t("info.cuffed_walk"), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        end
    else
        isHandcuffed = false
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', isEscorted)
        DetachEntity(ped, true, false)
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
        ClearPedTasksImmediately(ped)
        SetEnableHandcuffs(ped, false)
        DisablePlayerFiring(ped, false)
        SetPedCanPlayGestureAnims(ped, true)
        DisplayRadar(true)
        if cuffType == 49 then
            FreezeEntityPosition(ped, false)
        end        
        exports['lxr-core']:Notify(9, Lang:t("success.uncuffed"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
    end
end)

-- Threads
CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Wait(1)
        if isEscorted or isHandcuffed then
            DisableControlAction(0, 0x295175BF, true) -- Disable break
            DisableControlAction(0, 0x6E9734E8, true) -- Disable suicide
            DisableControlAction(0, 0xD8F73058, true) -- Disable aiminair
            DisableControlAction(0, 0x4CC0E2FE, true) -- B key
            DisableControlAction(0, 0xDE794E3E, true) -- Cover
            DisableControlAction(0, 0x06052D11, true) -- Cover
            DisableControlAction(0, 0x5966D52A, true) -- Cover
            DisableControlAction(0, 0xCEFD9220, true) -- Cover
            DisableControlAction(0, 0xC75C27B0, true) -- Cover
            DisableControlAction(0, 0x41AC83D1, true) -- Cover
            DisableControlAction(0, 0xADEAF48C, true) -- Cover
            DisableControlAction(0, 0x9D2AEA88, true) -- Cover
            DisableControlAction(0, 0xE474F150, true) -- Cover
            DisableControlAction(0, 0xB2F377E8, true) -- Attack
			DisableControlAction(0, 0xC1989F95, true) -- Attack 2
			DisableControlAction(0, 0x07CE1E61, true) -- Melee Attack 1
			DisableControlAction(0, 0xF84FA74F, true) -- MOUSE2
			DisableControlAction(0, 0xCEE12B50, true) -- MOUSE3
			DisableControlAction(0, 0x8FFC75D6, true) -- Shift
			DisableControlAction(0, 0xD9D0E1C0, true) -- SPACE
            DisableControlAction(0, 0xF3830D8E, true) -- J
            DisableControlAction(0, 0x80F28E95, true) -- L
            DisableControlAction(0, 0xDB096B85, true) -- CTRL
            DisableControlAction(0, 0xE30CD707, true) -- R
        end

   

        if cuffType == 16 and isHandcuffed then  -- soft cuff
            SetEnableHandcuffs(ped, true)
            DisablePlayerFiring(ped, true)
            SetPedCanPlayGestureAnims(ped, false)
            DisplayRadar(false)
        end

        if cuffType == 49 and isHandcuffed then  -- hard cuff
            SetEnableHandcuffs(ped, true)
            DisablePlayerFiring(ped, true)
            SetPedCanPlayGestureAnims(ped, false)
            DisplayRadar(false)
            FreezeEntityPosition(ped, true)
        end

        if not isHandcuffed and not isEscorted then
            Wait(2000)
        end
    end
end)
