# Versioning System
SIX_BASE_VERSION = pie-v1.7

ifndef SIX_BUILD_TYPE
    SIX_BUILD_TYPE := R3Ds
endif

# Only include Six Updates for official builds
#ifeq ($(filter-out R3Ds,$(SIX_BUILD_TYPE)),)
#    PRODUCT_PACKAGES += \
#        SixUpdates
#endif

TARGET_PRODUCT_SHORT := $(subst sixrom_,,$(SIX_BUILD_TYPE))

# Set all versions
DATE := $(shell date -u +%Y%m%d)
SIX_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
SIX_BUILD_VERSION := sixrom-$(SIX_BASE_VERSION)-$(DATE)-$(SIX_BUILD_TYPE)
SIX_VERSION := sixrom-$(SIX_BASE_VERSION)-$(DATE)-$(SIX_BUILD)-$(SIX_BUILD_TYPE)
SIX_MOD_VERSION := sixrom-$(SIX_BASE_VERSION)-$(SIX_BUILD_DATE)-$(SIX_BUILD_TYPE)
ROM_FINGERPRINT := sixrom/$(SIX_BASE_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(SIX_BUILD_DATE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.six.build.version=$(SIX_BUILD_VERSION) \
    ro.six.version=$(SIX_VERSION) \
    ro.six.releasetype=$(SIX_BUILD_TYPE) \
    ro.mod.version=$(SIX_MOD_VERSION) \
    ro.six.fingerprint=$(ROM_FINGERPRINT)
