#
# Copyright (C) 2022 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/ingres

# Versão de SDK do sistema suportada por esta configuração de placa.
BOARD_SYSTEMSDK_VERSIONS := 31

# Architecture
# Arquitetura principal e ABI secundária; mantenha-as alinhadas à plataforma.
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a-branchprot
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

# A/B
# Partições atualizadas em conjunto pelo mecanismo A/B do Android.
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    recovery \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# AVB
# Chaves, algoritmo e índices para a verificação AVB das imagens de recovery/sistema.
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Bootloader
# Recursos esperados do bootloader e formato de compressão do ramdisk.
TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_USES_REMOTEPROC := true
TARGET_NO_KERNEL := false
BOARD_RAMDISK_USE_LZ4 := true

# Build
# Exceções de build para compatibilidade com dependências legadas deste dispositivo.
BUILD_BROKEN_NINJA_USES_ENV_VARS += SDCLANG_AE_CONFIG SDCLANG_CONFIG SDCLANG_SA_ENABLE
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Crypto
# Suporte de descriptografia do TWRP para criptografia de arquivos e metadados.
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# File systems
# Sistemas de arquivos usados no dispositivo; DLKM armazena módulos do kernel.
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true

# Kernel / Recovery image
# Arquitetura dos cabeçalhos e imagem de kernel usada pelo recovery.
# Ao migrar de kernel, confira a ABI e recompile os módulos listados para o recovery.
TARGET_KERNEL_ARCH            := arm64
TARGET_KERNEL_HEADER_ARCH     := arm64
TARGET_PREBUILT_KERNEL        := /dev/null # empty kernel image

BOARD_KERNEL_PAGESIZE         := 4096
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_BOOT_HEADER_VERSION     := 4
BOARD_MKBOOTIMG_ARGS          += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS          += --pagesize $(BOARD_KERNEL_PAGESIZE)

# GSI && GKI
# Opções de compatibilidade GKI/GSI e conteúdo da imagem do recovery.
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# minha modificação para que o recovery seja movido para o vendor_boot, pois o TWRP não consegue lidar com a partição recovery separada do vendor_boot
BOARD_MOVE_RECOVERY_TO_VENDOR_BOOT := true

# Partitions
# Tamanhos e agrupamento das partições; devem corresponder ao layout real do aparelho.
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_USERDATAIMAGE_PARTITION_SIZE := 48318382080
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_DTBOIMG_PARTITION_SIZE := 24117248
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Properties
# Acrescenta as propriedades deste dispositivo à imagem de sistema.
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Recovery
# Formato da tela e caminho do fstab usado pelo TWRP para descobrir partições.
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# Screen density
TARGET_SCREEN_HEIGHT  := 2400
TARGET_SCREEN_DENSITY := 395
TARGET_SCREEN_WIDTH   := 1080

# TWRP specific build flags
# Opções de interface, ferramentas e recursos incluídos no TWRP.
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := false
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_EXCLUDE_APEX := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
#TW_STATUS_ICONS_ALIGN := center
#TW_CUSTOM_CPU_POS := "50"
#TW_CUSTOM_CLOCK_POS := "600"
#TW_CUSTOM_BATTERY_POS := "800"

# TWRP Display flags
# Caminho sysfs e limites usados para ajustar o brilho do painel.
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1024
TW_NO_SCREEN_BLANK := true

# TWRP Haptics
# Identifica a interface AIDL do vibrador para os recursos hápticos do TWRP.
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"
TW_EXCLUDE_TWRPAPP := true

# TWRP Version
# Sufixo informativo da compilação deste recovery.
TW_DEVICE_VERSION := itz 

# Load kernel modules for touch & vibrator
# A lista deve corresponder aos módulos disponíveis para o kernel usado no recovery.
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko atmel_mxt_ts.ko focaltech_fts.ko fts_touch_spi.ko nt36xxx-i2c.ko nt36xxx-spi.ko synaptics_dsx.ko xiaomi_touch.ko"

# The path to a temperature sensor
# Sensor térmico consultado pelo TWRP para mostrar a temperatura da CPU.
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"

# Namespace definition for librecovery_updater
# Configuração de namespace consumida pelo build do librecovery_updater.
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg
