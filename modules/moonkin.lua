if select(2, UnitClass("player")) == "DRUID" then
	local ffDuration = 300
	local insectswarmDuration = 14
	local starfireGlyph = 54845
	local moonfireDuration = function()
		local maxValue = 15

		-- Glyph of Starfire
		if evl_SliceDice:hasGlyph(starfireGlyph) then 
			maxValue = maxValue + 9
		end

		return maxValue
	end	

	-- Insect Swarm
	local isBar = evl_SliceDice:CreateBar("target", "Insect Swarm", insectswarmDuration, 14)
	isBar.colors = {{0/255, 150/255, 0/255}}

	-- Moonfire
	local mfBar = evl_SliceDice:CreateBar("target", "Moonfire", moonfireDuration, 14)
	mfBar.colors = {{150/255, 0/255, 255/255}}

	-- Faerie Fire
	local ffBar = evl_SliceDice:CreateBar("target", "Faerie Fire", ffDuration, 6)
	ffBar.auraFilter = "HARMFUL"
	ffBar.label:Hide()
	
	-- Eclipse
	local eclipseDuration = 15
	local eclipseCooldown = 15
	local eclipseColor
	local eclipseExpiration = 0
	local eclipseOrangeBuff = 48517 -- http://www.wowhead.com/?spell=48517
	local eclipseBlueBuff = 48518 -- http://www.wowhead.com/?spell=48518
	local eclipseAuraFunction = function(unit, spellName, rank, filter)
		local name, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitAura(unit, spellName, nil, filter)
		
		if name then
			eclipseColor = eclipseOrangeBuff and 1 or 2
			eclipseExpiration = expirationTime + eclipseCooldown
		end
		
		if eclipseExpiration < GetTime() then
			return name, _, _, eclipseColor, _, _, eclipseExpiration
		end
		
		return nil
	end

	local eclipseBar = evl_SliceDice:CreateBar("player", "Eclipse", eclipseDuration + eclipseCooldown, 14)
	eclipseBar.colors = {{200/255, 200/255, 0/255}, {0/255, 0/255, 200/255}}
	eclipseBar.auraFunction = eclipseAuraFunction
end