# SIX System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.modversion=$(SIX_VERSION) \
    ro.six.version=$(SIX_VERSION) \
    ro.six.version.update=$(SIX_VERSION)

# SIX Statistics
ADDITIONAL_BUILD_PROPERTIES += \
    ro.six.branch=$(SIX_BRANCH) \
    ro.romstats.url=https://notinuseplaceholder.c0m/ \
    ro.romstats.name=SIX \
    ro.romstats.buildtype=$(SIX_BUILDTYPE) \
    ro.romstats.version=$(VERSION) \
    ro.romstats.tframe=1 \
    ro.romstats.askfirst=1 \
    ro.romstats.ga=UA-48128535-2

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
