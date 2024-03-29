local _, addon = ...

local icon = {
    shortages = {}
}

local info = addon.info
local notifier = addon.notifier

function icon:Init()
    self.frame = self:createFrame()
    self.texture = self:createTexture(self.frame, "Interface/ICONS/Ability_Hunter_MasterMarksman")
    self:SetShown(false)
    notifier:Subscribe(function (payload)
        self.shortages = payload.current
        self:SetShown(addon.hasShortage(self.shortages))
    end)
end

function icon:SetShown(shown)
    self.frame:SetShown(shown)
end

function icon:ResetPosition()
    self.frame:ClearAllPoints()
    self.frame:SetPoint("CENTER")
end

function icon:createFrame()
    local frame = CreateFrame("Frame", "LfgMonIcon", UIParent)
    frame:SetSize(40, 40)
    frame:SetPoint("CENTER")
    self:enableMouseDrag(frame)
    self:createTooltip(frame)
    return frame
end

function icon:createTexture(frame, path)
    local texture = frame:CreateTexture(nil, "ARTWORK")
    texture:SetAllPoints(frame)
    texture:SetTexture(path)
    self:maskTexture(frame, texture)
    return texture
end

function icon:maskTexture(frame, texture)
    local mask = frame:CreateMaskTexture()
    mask:SetSize(28, 28)
    mask:SetPoint("CENTER", texture, "CENTER")
    mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    texture:AddMaskTexture(mask)
end

function icon:enableMouseDrag(frame)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnMouseDown", function(s)
        s:StartMoving()
    end)
    frame:SetScript("OnMouseUp", function(s)
        s:StopMovingOrSizing()
    end)
end

function icon:createTooltip(frame)
    frame:EnableMouse(true)
    frame:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        info:SetTooltipContent(self.shortages)
        GameTooltip:Show()
    end)
    frame:SetScript("OnLeave", function(s)
        GameTooltip:Hide()
    end)
end

addon.icon = icon
