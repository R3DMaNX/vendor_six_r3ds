include vendor/six/config/BoardConfigKernel.mk

# Charger
ifeq ($(WITH_SIX_CHARGER),true)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.six
endif

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/six/config/BoardConfigQcom.mk
endif

include vendor/six/config/BoardConfigSoong.mk
