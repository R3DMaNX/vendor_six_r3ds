# Inherit full common SIX stuff
$(call inherit-product, vendor/aicp/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include SIX LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/aicp/overlay/dictionaries

$(call inherit-product, vendor/aicp/config/telephony.mk)
