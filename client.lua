RegisterNetEvent("dc_weedroll:rollblunt")
AddEventHandler("dc_weedroll:rollblunt", function()
    local player = PlayerPedId()
    local playcoords = GetEntityCoords(player)
    RequestModel("dc_backwood")
    RequestModel("dc_weednug")
    RequestModel("dc_backwoodlit")
    RequestAnimDict("custom@rollingupanim")
    while not HasAnimDictLoaded("custom@rollingupanim") do
        Citizen.Wait(10)
    end

    if not IsPedInAnyVehicle(player) then
        local Wood = CreateObject(GetHashKey('dc_backwood'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        local Bud = CreateObject(GetHashKey('dc_weednug'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        local Blunt = CreateObject(GetHashKey('dc_backwoodlit'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        AttachEntityToEntity(Wood, player, GetPedBoneIndex(player, 60309), 0.079, -0.01, 0.025, 0.0, 0.0, 1.0, true, true, false, false, 2, true)
        AttachEntityToEntity(Bud, player, GetPedBoneIndex(player, 28422), 0.085, 0.02, -0.045, 0.0, 0.0, 1.0, true, true, false, false, 2, true)
        TaskPlayAnim(player, "custom@rollingupanim", "rollingup_clip", 8.0, -8, -1, 49, 0, 0, 0, 0)

        Citizen.Wait(9300)
        DeleteObject(Bud)
        DeleteObject(Wood)
        Wood = CreateObject(GetHashKey('dc_backwood'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        AttachEntityToEntity(Wood, player, GetPedBoneIndex(player, 60309), 0.095, -0.003, 0.068, -37.0, 15.0, 45.0, true, true, false, false, 2, true)
        Citizen.Wait(11000)
        DeleteObject(Wood)
        AttachEntityToEntity(Blunt, player, GetPedBoneIndex(player, 60309), 0.095, -0.003, 0.068, 70.0, 45.0, 45.0, true, true, false, false, 2, true)
        Citizen.Wait(4300)
        DeleteObject(Blunt)
        ClearPedTasks(player)
        RemoveAnimDict("custom@rollingupanim")
    end
end)

RegisterNetEvent("dc_weedroll:rollpaper")
AddEventHandler("dc_weedroll:rollpaper", function()
    local player = PlayerPedId()
    local playcoords = GetEntityCoords(player)
    RequestModel("dc_rollpaper")
    RequestModel("dc_weednug")
    RequestModel("p_cs_joint_02")
    RequestAnimDict("custom@rollingupanim")
    while not HasAnimDictLoaded("custom@rollingupanim") do
        Citizen.Wait(10)
    end

    if not IsPedInAnyVehicle(player) then
        local Paper = CreateObject(GetHashKey('dc_rollpaper'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        local Bud = CreateObject(GetHashKey('dc_weednug'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        local Joint = CreateObject(GetHashKey('p_cs_joint_02'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        AttachEntityToEntity(Paper, player, GetPedBoneIndex(player, 60309), 0.079, -0.01, 0.025, 0.0, 0.0, 1.0, true, true, false, false, 2, true)
        AttachEntityToEntity(Bud, player, GetPedBoneIndex(player, 28422), 0.085, 0.02, -0.045, 0.0, 0.0, 1.0, true, true, false, false, 2, true)
        TaskPlayAnim(player, "custom@rollingupanim", "rollingup_clip", 8.0, -8, -1, 49, 0, 0, 0, 0)

        Citizen.Wait(9300)
        DeleteObject(Bud)
        DeleteObject(Paper)
        Paper = CreateObject(GetHashKey('dc_rollpaper'), playcoords.x, playcoords.y, playcoords.z, true, true, false)
        AttachEntityToEntity(Paper, player, GetPedBoneIndex(player, 60309), 0.095, -0.003, 0.068, -37.0, 15.0, 45.0, true, true, false, false, 2, true)
        Citizen.Wait(11000)
        DeleteObject(Paper)
        AttachEntityToEntity(Joint, player, GetPedBoneIndex(player, 60309), 0.095, -0.003, 0.068, 70.0, 45.0, 45.0, true, true, false, false, 2, true)
        Citizen.Wait(4300)
        DeleteObject(Joint)
        ClearPedTasks(player)
        RemoveAnimDict("custom@rollingupanim")
    end
end)
