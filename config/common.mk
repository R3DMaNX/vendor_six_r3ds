PRODUCT_BRAND ?= Six

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.setupwizard.rotation_locked=true \
    ro.adb.secure=0 \
    ro.debuggable=1 \
    ro.secure=0 \
    persist.service.adb.enable=1 \
    persist.sys.usb.config=mtp,adb \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.build.selinux=1 \
    ro.carrier=unknown

PRODUCT_PROPERTY_OVERRIDES := \
    persist.sys.wfd.nohdcp=1 \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# SiX prop edits
PRODUCT_PROPERTY_OVERRIDES += \
    ro.substratum.verified=true \
    ro.telephony.call_ring.delay=0 \
    ring.delay=0 \
    drm.service.enabled=true

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.ringtone=The_big_adventure.ogg \
    ro.config.notification_sound=Ping.ogg \
    ro.config.alarm_alert=Spokes.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

# Whitelist packages for location providers not in system
PRODUCT_PROPERTY_OVERRIDES += \
    ro.services.whitelist.packagelist=com.google.android.gms

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/six/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/six/prebuilt/common/bin/50-six.sh:system/addon.d/50-six.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/six/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/six/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/six/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/six/config/permissions/six-power-whitelist.xml:system/etc/sysconfig/six-power-whitelist.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Copy all six-specific init rc files
$(foreach f,$(wildcard vendor/six/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/sensitive_pn.xml:system/etc/sensitive_pn.xml

# World APN list
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Latin IME lib
ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/six/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/six/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Six Packages
PRODUCT_PACKAGES += \
    Calculator \
    DeskClock \
    LiveWallpapers \
    LiveWallpapersPicker\
    messaging \
    PixelLauncher \
    SoundPickerPrebuilt \
    Stk \
    Terminal \
    WallpaperPickerGooglePrebuilt \
    WeatherProvider \
    WellbeingPrebuilt \
    Eleven
    #Jelly
    #Substratum
    #SixPie

# Six Fonts
PRODUCT_PACKAGES += \
    Six-Fonts

# WeatherProvider
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/permissions/com.android.providers.weather.xml:system/etc/permissions/com.android.providers.weather.xml \
    vendor/six/prebuilt/common/etc/default-permissions/com.android.providers.weather.xml:system/etc/default-permissions/com.android.providers.weather.xml

# Ambient Play
PRODUCT_PACKAGES += \
    AmbientPlayHistoryProvider

# Substratum Key
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/priv-app/SubstratumKey.apk:system/priv-app/SubstratumKey/SubstratumKey.apk
	
# Themes
PRODUCT_PACKAGES += \
    SettingsDarkTheme \
    SystemDarkTheme \
    SystemUIDarkTheme \
    SettingsBlackTheme \
    SystemBlackTheme \
    SystemUIBlackTheme

# Notification themes
PRODUCT_PACKAGES += \
    NotificationBlackTheme \
    NotificationDarkTheme \
    NotificationLightTheme

# Accents
PRODUCT_PACKAGES += \
    Amber \
    Black \
    Blue \
    BlueGrey \
    Brown \
    CandyRed \
    Cyan \
    DeepOrange \
    DeepPurple \
    ExtendedGreen \
    Green \
    Grey \
    Indigo \
    JadeGreen \
    LightBlue \
    LightGreen \
    Lime \
    Orange \
    PaleBlue \
    PaleRed \
    Pink \
    Purple \
    Red \
    Teal \
    Yellow \
    White \
    UserOne \
    UserTwo \
    UserThree \
    UserFour \
    UserFive \
    UserSix \
    UserSeven \
    ObfusBleu \
    NotImpPurple \
    Holillusion \
    MoveMint \
    FootprintPurple \
    BubblegumPink \
    FrenchBleu \
    Stock \
    ManiaAmber \
    SeasideMint \
    DreamyPurple \
    SpookedPurple \
    HeirloomBleu \
    TruFilPink \
    WarmthOrange \
    ColdBleu \
    DiffDayGreen \
    DuskPurple \
    BurningRed \
    HazedPink \
    ColdYellow \
    NewHouseOrange \
    IllusionsPurple

# QS tile styles
PRODUCT_PACKAGES += \
    QStileDefault \
    QStileCircleTrim \
    QStileCircleDualTone \
    QStileCircleGradient \
    QStileDottedCircle \
    QStileDualToneCircle \
    QStileInk \
    QStileInkdrop \
    QStileMountain \
    QStileNinja \
    QStileOreo \
    QStileOreoCircleTrim \
    QStileOreoSquircleTrim \
    QStilePokesign \
    QStileSquaremedo \
    QStileSquircle \
    QStileSquircleTrim \
    QStileTeardrop \
    QStileWavey

# QS header styles
PRODUCT_PACKAGES += \
    QSHeaderBlack \
    QSHeaderGrey \
    QSHeaderLightGrey \
    QSHeaderAccent \
    QSHeaderTransparent

# QS accents
PRODUCT_PACKAGES += \
    QSAccentBlack \
    QSAccentWhite

# UI themes
PRODUCT_PACKAGES += \
    AOSPUI \
    PixelUI

# Switch themes
PRODUCT_PACKAGES += \
    MD2Switch \
    OnePlusSwitch \
    StockSwitch

# Sysconfig
PRODUCT_COPY_FILES += \
    vendor/six/prebuilt/common/etc/sysconfig/google-hiddenapi-package-whitelist.xml:system/etc/sysconfig/google-hiddenapi-package-whitelist.xml \
    vendor/six/prebuilt/common/etc/sysconfig/pixel.xml:system/etc/sysconfig/pixel.xml

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in six
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_SIX_CHARGER),true)
PRODUCT_PACKAGES += \
    six_charger_res_images \
    font_log.png \
    libhealthd.six
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# GBoard Themes
PRODUCT_COPY_FILES += \
    vendor/six/themes/GBoard/MD2.zip:system/etc/gboard/MD2.zip \
    vendor/six/themes/GBoard/MD2Black.zip:system/etc/gboard/MD2Black.zip \
    vendor/six/themes/GBoard/MD2Dark.zip:system/etc/gboard/MD2Dark.zip

# Set Pixel blue light MD2 theme on Gboard
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.ime.themes_dir=/system/etc/gboard \
    ro.com.google.ime.theme_file=MD2.zip

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Google Assistant
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.opa.eligible_device=true

# Disable rescue party
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.disable_rescue=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/six/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/six/overlay/common

# Bootanimation
include vendor/six/config/bootanimation.mk

# Version
include vendor/six/config/version.mk

# Miracast Support
PRODUCT_PROPERTY_OVERRIDES += \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

