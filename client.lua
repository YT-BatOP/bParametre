ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

------------------------------ Création du Menu -----------------------------------

RMenu.Add('batop', 'main', RageUI.CreateMenu("Paramètres", "~y~Parametres"))
RMenu.Add('batop', 'affichage', RageUI.CreateSubMenu(RMenu:Get('batop', 'main'), "Affichage"))

Citizen.CreateThread(function()
  while true do
      RageUI.IsVisible(RMenu:Get('batop', 'main'), true, true, true, function()

          RageUI.Button("Affichage", "Menu Affichage", {RightLabel = "→→→"},true, function()
          end, RMenu:Get('batop', 'affichage'))
      end, function()
      end)

      RageUI.IsVisible(RMenu:Get('batop', 'affichage'), true, true, true, function()

          RageUI.Button("Afficher/Cacher HUD", "Afficher ou Cacher son HUD", {RightLabel = ""}, true, function(Hovered, Active, Selected)
              if (Selected) then
                openInterface()
              end
          end)

          RageUI.Button("Afficher/Cacher GPS", "Afficher ou Cacher son GPS", {RightLabel = ""}, true, function(Hovered, Active, Selected)
            if (Selected) then
              toggleMinimap()
            end
        end)

        RageUI.Button("Mode Cinématique", "Activé ou Désactivé le Mode Cinématique", {RightLabel = ""}, true, function(Hovered, Active, Selected)
          if (Selected) then
            openCinematique()
          end
      end)
      end, function()
      end)
  
          Citizen.Wait(0)
      end
  end)

----------------------------- Fonction du Menu ------------------------------------

-- HUD
local interface = false

function openInterface()
	interface = not interface
	if interface then -- hide
  		TriggerEvent('ui:toggle', false)
  else -- show
	  	TriggerEvent('ui:toggle', true)
	end
  end

-- GPS
local hasMinimap = false

function toggleMinimap()

	hasMinimap = not hasMinimap

	if hasMinimap == true then

		DisplayRadar(false)

	else

		DisplayRadar(true)

	end

end

-- Mode Cinématique
function openCinematique()

	hasCinematic = not hasCinematic

	if not hasCinematic then -- show

		SendNUIMessage({openCinema = true})

		ESX.UI.HUD.SetDisplay(0.0)

		TriggerEvent('es:setMoneyDisplay', 0.0)

		TriggerEvent('esx_status:setDisplay', 0.0)

		DisplayRadar(false)

		TriggerEvent('ui:toggle', false)

	elseif hasCinematic then -- hide

		SendNUIMessage({openCinema = false})

		ESX.UI.HUD.SetDisplay(1.0)

		TriggerEvent('es:setMoneyDisplay', 1.0)

		TriggerEvent('esx_status:setDisplay', 1.0)

		DisplayRadar(true)

		TriggerEvent('ui:toggle', true)

	end

end

----------------------------- Ouverture du Menu ------------------------------------

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if (IsControlJustPressed(0, 344)) then
        RageUI.Visible(RMenu:Get('batop', 'main'), not RageUI.Visible(RMenu:Get('batop', 'main')))
    end
end
end)