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

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# SiX prop edits
PRODUCT_PROPERTY_OVERRIDES += \
    ro.substratum.verified=true \
    ro.telephony.call_ring.delay=0 \
    ring.delay=0 \
    drm.service.enabled=true

PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/nephilim/prebuilt/common/bin/sysinit:system/bin/sysinit

# Init file
PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/common/etc/init.local.rc:root/init.six.rc

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

# Bootanimation
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/nephilim/prebuilt/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/nephilim/prebuilt/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

# Packages
include vendor/nephilim/config/packages.mk

# Branding
include vendor/nephilim/config/branding.mk

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/nephilim/overlay/common

# Google sounds
include vendor/nephilim/google/GoogleAudio.mk

$(call inherit-product-if-exists, vendor/nephilim/prebuilt/common/prebuilt.mk)
