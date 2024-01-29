ADDON_NAME := lfgmon
ADDON_DIR := $(shell find ~ -path '*/World of Warcraft/_retail_/Interface/AddOns' 2>/dev/null | head -1)
ADDON_VERSION := $(shell grep '## Version' lfgmon.toc | cut -d ' ' -f 3)

install: uninstall
	mkdir -p "$(ADDON_DIR)/$(ADDON_NAME)"
	cp -rf . "$(ADDON_DIR)/$(ADDON_NAME)"

uninstall:
	rm -rf "$(ADDON_DIR)/$(ADDON_NAME)"

release: clean
	mkdir -p dist/$(ADDON_NAME)
	rsync -av --exclude=".*" --exclude="assets/" --exclude="dist" . dist/$(ADDON_NAME)
	cd dist && zip -r $(ADDON_NAME)_v$(ADDON_VERSION).zip $(ADDON_NAME)/*
	
clean:
	rm -rf dist/*
