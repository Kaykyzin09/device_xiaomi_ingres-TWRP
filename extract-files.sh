#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

# Identifica o dispositivo e o fabricante para as ferramentas de extração.
DEVICE=ingres
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
# Localiza a raiz do Android e carrega os utilitários comuns de extração de blobs.
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}"/../../..

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    # Ajustes pontuais em blobs extraídos quando uma dependência precisa ser adicionada.
    case "${1}" in
        vendor/lib64/libqtikeymint.so)
            "${PATCHELF}" --add-needed "android.hardware.security.rkp-V1-ndk.so" "${2}"
           ;;
    esac
}

# Initialize the helper
# Prepara o diretório vendor; CLEAN_VENDOR controla a limpeza antes da extração.
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

# Extrai os arquivos listados e regenera os makefiles que os instalam.
extract "${MY_DIR}/proprietary-files.txt" "${SRC}" \
        "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
