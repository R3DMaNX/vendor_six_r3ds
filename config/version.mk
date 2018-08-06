# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_ID=OPM2.171026.006.G1 BUILD_DISPLAY_ID=OPM2.171026.006.G1 BUILD_UTC_DATE=$(shell date +"%s")

SIX_BRANCH=8.1.0

# SIX RELEASE VERSION
SIX_VERSION_MAJOR = v2
SIX_VERSION_MINOR = 5
SIX_VERSION_MAINTENANCE =

VERSION := $(SIX_VERSION_MAJOR).$(SIX_VERSION_MINOR)$(SIX_VERSION_MAINTENANCE)

ifndef SIX_BUILDTYPE
    ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^SIX_||g')
        SIX_BUILDTYPE := $(RELEASE_TYPE)
    else
        SIX_BUILDTYPE := R3Ds
    endif
endif

ifdef SIX_BUILDTYPE
    ifeq ($(SIX_BUILDTYPE), RELEASE)
       SIX_VERSION := $(SIX_BRANCH)_$(TARGET_PRODUCT)-$(shell date -u +%Y%m%d)-$(VERSION)-RELEASE
    endif
    ifeq ($(SIX_BUILDTYPE), NIGHTLY)
        SIX_VERSION := $(SIX_BRANCH)_$(TARGET_PRODUCT)-$(shell date -u +%Y%m%d)-$(VERSION)-NIGHTLY
    endif
    ifeq ($(SIX_BUILDTYPE), WEEKLY)
        SIX_VERSION := $(SIX_BRANCH)_$(TARGET_PRODUCT)-$(shell date -u +%Y%m%d)-$(VERSION)-WEEKLY
    endif
    ifeq ($(SIX_BUILDTYPE), EXPERIMENTAL)
        SIX_VERSION := $(SIX_BRANCH)_$(TARGET_PRODUCT)-$(shell date -u +%Y%m%d)-$(VERSION)-EXPERIMENTAL
    endif
    ifeq ($(SIX_BUILDTYPE), R3Ds)
        SIX_VERSION := $(TARGET_PRODUCT)-$(SIX_BRANCH)-$(shell date -u +%Y%m%d)-$(VERSION)-R3Ds
    endif
else
    #We reset back to SIX
        SIX_VERSION := $(TARGET_PRODUCT)-$(SIX_BRANCH)-$(shell date -u +%Y%m%d)-$(VERSION)-R3Ds
endif
