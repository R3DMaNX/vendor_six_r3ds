# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_ID=OPM2.171019.029 BUILD_DISPLAY_ID=OPM2.171019.029 BUILD_UTC_DATE=$(shell date +"%s")

# Versioning System
NEPHILIM_BASE_VERSION = v3.2

ifndef NEPHILIM_BUILD_TYPE
    NEPHILIM_BUILD_TYPE := R3Ds
endif

# Sign builds if building an official or weekly build
ifeq ($(filter-out OFFICIAL WEEKLIES,$(NEPHILIM_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := ../.keys/releasekey
endif

# Set all versions
DATE := $(shell date -u +%Y%m%d)
NEPHILIM_VERSION := $(TARGET_PRODUCT)-$(NEPHILIM_BASE_VERSION)-$(DATE)-$(NEPHILIM_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.nephilim.version=$(NEPHILIM_VERSION) \
    ro.mod.version=$(NEPHILIM_VERSION)
