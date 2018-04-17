PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1

PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/nephilim/prebuilt/common/bin/sysinit:system/bin/sysinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/etc/init.local.rc:root/init.du.rc

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/nephilim/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/nephilim/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Charging sounds
PRODUCT_COPY_FILES += \
    vendor/nephilim/google/effects/BatteryPlugged.ogg:system/media/audio/ui/BatteryPlugged.ogg \
    vendor/nephilim/google/effects/BatteryPlugged_48k.ogg:system/media/audio/ui/BatteryPlugged_48k.ogg

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/extras/tools/backuptool.sh:install/bin/backuptool.sh \
    vendor/extras/tools/backuptool.functions:install/bin/backuptool.functions \
    vendor/extras/tools/50-nephilim.sh:system/addon.d/50-nephilim.sh

# Clean cache
PRODUCT_COPY_FILES += \
    vendor/extras/tools/clean_cache.sh:system/bin/clean_cache.sh

# Packages
include vendor/nephilim/config/packages.mk

# Branding
include vendor/nephilim/config/branding.mk

# Bootanimation
include vendor/nephilim/config/bootanimation.mk

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/nephilim/overlay/common

# Google sounds
include vendor/nephilim/google/GoogleAudio.mk

$(call inherit-product-if-exists, vendor/nephilim/prebuilt/common/prebuilt.mk)
