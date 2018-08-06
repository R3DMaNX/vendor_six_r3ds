# Inherit full common SIX stuff
$(call inherit-product, vendor/aicp/config/common_full.mk)

PRODUCT_PACKAGES += AppDrawer

DEVICE_PACKAGE_OVERLAYS += vendor/aicp/overlay/tv
