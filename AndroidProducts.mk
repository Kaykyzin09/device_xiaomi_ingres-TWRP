#
# Copyright (C) 2022 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Registra o produto TWRP deste dispositivo e os alvos disponíveis no lunch.
# As variantes diferem do tipo de build; a configuração do produto fica em twrp_ingres.mk.
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_ingres.mk

# Opções usadas pelo comando lunch para selecionar a variante do recovery.
COMMON_LUNCH_CHOICES := \
    twrp_ingres-user \
    twrp_ingres-userdebug \
    twrp_ingres-eng
