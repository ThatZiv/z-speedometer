-- Made by Zua @ https://github.com/thatziv/z-speedometer -- Discord: http://zavaar.cf/discord

-----------------------------USER--CONFIG-----------------------------------------------
local locationOnscreen = 'bottom-right' --[[ Types -> 'bottom-left', 'bottom-right', 'top-right' of the screen ]]
local legalSpeed = 70 -- This speed limit will trigger red number and the warning speed message
local mph = true -- change to false if you want KPH and Make sure you change the type var to 'kph' in case you made mph = false 
local type = 'MPH'
local typeFont = 'default' --[[ Types -> 'default': The best one, 'fancy' : Cursive and looks likes pure shit but the fivem community has shit taste so i left it here for you shitters, 'normal': fancy, but not cursive and also looks like poop ]]
local warningSpeedMsg = false --This meessage will stay for ~10-15 seconds when past the speed limit (legalspeed)
local warningSpeedMsgSTRING = "Warning: ~w~You are above the speed limit."
local RichPresence = true -- Makes a discord rich presence with Fivem that tells the speed
----------------------------------------------------------------------------------------
if(locationOnscreen == 'bottom-right') then
    x1 = 0.9
    y1 = 0.87
    x2 = 0.9
    y2 = 0.83
elseif(locationOnscreen == 'bottom-left') then
    x1 = 0.016
    y1 = 0.843
    x2 = 0.016
    y2 = 0.803
elseif(locationOnscreen == 'top-right') then
    x1 = 0.915
    y1 = 0.104
    x2 = 0.915
    y2 = 0.065
end

if(typeFont == 'fancy') then
    font = 1
elseif(typeFont == 'default') then
    font = 2
elseif(typeFont == 'normal') then
    font = 0
end
function onScreen(content) -- The speed integer itself
        SetTextFont(font)
        SetTextProportional(0)
        SetTextScale(0.9, 0.9)
        SetTextEntry("STRING")
        AddTextComponentString(content)
        DrawText(x1, y1)
end

function unScreen(content) -- the MPH or KPH string (above the int)
		SetTextFont(font)
        SetTextScale(0.91, 0.91)
		SetTextEntry("STRING")
		AddTextComponentString(content)
        DrawText(x2, y2)
end

function notify(string)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(string)
        DrawNotification(true, false)
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        local spd = 0
        if(mph == true)then
            spd = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*2.2369
        else
            spd = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6
        end
            if(IsPedInAnyVehicle(GetPlayerPed(-1), false))
            then
		if(RichPresence == true) then
                    SetRichPresence("Going " .. math.ceil(spd) .. " " .. type)
                elseif (RichPresence == false) then
                    SetRichPresence(nil)
                end
                if(spd > legalSpeed)then
                    onScreen("~r~" .. math.ceil(spd))
                        if(warningSpeedMsg == true)then
                            notify("~r~".. warningSpeedMsgSTRING)
                        end
                end
                if(spd < legalSpeed)then
                    onScreen("~g~" .. math.ceil(spd))
                 end
                 unScreen( type )
          
        end
--[[          if IsControlJustReleased(1,  38) then
            notify("~r~U ded")
            SetEntityHealth(PlayerPedId(), 0)
        end   ]]
    end
end)

