------------------------------------------------------------------------
--                  Race script exemple                               --
--                  Created for HappinessMP                           -- 
--                  Based on race from redrp                          --
--                  Custom By LeChapellierFou                         --
--                                                         18/05/2025 --
------------------------------------------------------------------------

local LoadModels = function(model)
    
    local hash
    if isNumber(model) then 
        hash = model
    else
        hash = Game.GetHashKey(model)
    end
    
    if(Game.IsModelInCdimage(hash)) then 
        Game.RequestModel(hash)
        while not Game.HasModelLoaded(hash) do
            Game.RequestModel(hash)
            Thread.Pause(0)
        end

        return true
    else
        --Console.Log("Error, hash :"..hash.." doesnt exist")
        return false
    end
end

Spawn_Car = function(model, x, y, z, h) -- 806.98706, -273.95477, 15.34273, 300.296813964844
	
	if(LoadModels(model)) then 
        local hash
        if isNumber(model) then 
            hash = model
        else
            hash = Game.GetHashKey(model)
        end

        local veh = Game.CreateCar(hash, x, y, z, true)
        Game.SetCarHeading(veh, h)
        Game.SetCarOnGroundProperly(veh)
        Game.WarpCharIntoCar(Game.GetPlayerChar(Game.GetPlayerId()), veh)
        Game.MarkModelAsNoLongerNeeded(hash)
        Game.MarkCarAsNoLongerNeeded(veh)
        Game.SetCarOnGroundProperly(veh)
	    return veh
    else
        Console.Log("Error, hash car :"..hash.." doesnt exist")
    end
end

function Print(_text_print, time)
	Game.ClearPrints()
    if (time == nil) then 
	    Game.PrintStringWithLiteralStringNow("STRING", _text_print, 1000, 1)
    else
	    Game.PrintStringWithLiteralStringNow("STRING", _text_print, time, 1)
    end
end

function IsPlayerNearCoords(x, y, z, radius)
	local ped = Game.GetPlayerChar(Game.GetPlayerId())
    local pos = table.pack(Game.GetCharCoordinates(ped))
   local dist = Game.GetDistanceBetweenCoords3d(x, y, z, pos[1], pos[2], pos[3])
   if(dist < radius) then return true
   else return false
   end
end
