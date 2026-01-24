local name, addon = ...

local settings = {}

function settings:Init()
    self.category, self.layout = Settings.RegisterVerticalLayoutCategory(name)

    self.layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(addon.MonitoringSettingsTitle))
    self:CreateProxiedCheckBox(addon.MonitorDungeonsText, addon.MonitorDungeonsTooltip, "monitorDungeons")
    self:CreateProxiedCheckBox(addon.MonitorRaidsText, addon.MonitorRaidsTooltip, "monitorRaids")
    self:CreateProxiedCheckBox(addon.PlayAlertText, addon.PlayAlertTooltip, "playAlert")
    self:CreateProxiedCheckBox(addon.ConsiderLockoutText, addon.ConsiderLockoutTooltip, "considerLockout")

    self.layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(addon.RoleSettingsTitle))
    self:CreateProxiedCheckBox(addon.IgnoreTank, addon.IgnoreTankTooltip, "ignoreTank")
    self:CreateProxiedCheckBox(addon.IgnoreHealer, addon.IgnoreHealerTooltip, "ignoreHealer")
    self:CreateProxiedCheckBox(addon.IgnoreDamage, addon.IgnoreDamageTooltip, "ignoreDamage")

    Settings.RegisterAddOnCategory(self.category)
end

function settings:CreateProxiedCheckBox(text, tooltip, variable)
    local setting = Settings.RegisterAddOnSetting(self.category, variable, variable, LfgMonConf,
        Settings.VarType.Boolean, text, addon.defaults[variable])
    Settings.CreateCheckbox(self.category, setting, tooltip)
end

addon.settings = settings
