#
# Copyright (C) 2022 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Diretório base deste device tree para os módulos Make incluídos abaixo.
LOCAL_PATH := $(call my-dir)

# Inclui subdiretórios somente quando o alvo em compilação é o ingres.
ifeq ($(TARGET_DEVICE),ingres)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
