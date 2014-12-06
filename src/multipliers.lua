local _, addon = ...
addon.multipliers = {}
local multipliers = addon.multipliers

multipliers.MAX = {
  Rake   = 1.15 * 1.4 * 1.4 * 2.0,
  Rip    = 1.15 * 1.4 * 1.4 * 5.0,
  Thrash = 1.15 * 1.4 * 1.4,
}

-- Current Multipliers

function multipliers:Base()
  local multiplier = 1.0

  if UnitBuff("player", "Tiger's Fury") then
    multiplier = multiplier * 1.15
  end

  if UnitBuff("player", "Savage Roar") then
    multiplier = multiplier * 1.4
  end

  if UnitBuff("player", "Bloodtalons") then
    multiplier = multiplier * 1.4
  end

  return multiplier
end

function multipliers:Rake()
  local multiplier = self:Base()

  if UnitBuff("player", "Prowl") or UnitBuff("player", "Incarnation: King of the Jungle") then
    multiplier = multiplier * 2.0
  end

  return multiplier
end

function multipliers:Rip()
  return self:Base() * GetComboPoints("player", "target")
end

function multipliers:Thrash()
  return self:Base()
end

-- Multiplier Tracking

local eventFrame = CreateFrame("Frame", nil, UIParent)
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", function(self, event, ...)
  print(event)
end)
