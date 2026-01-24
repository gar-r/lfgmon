local addonName, addon = ...

function LFGMon_OnAddonCompartmentClick()
    if addon and addon.settings and addon.settings.category then
        Settings.OpenToCategory(addon.settings.category.ID)
        return
    end
end
