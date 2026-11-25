#!/system/bin/sh

# Escolhe o conjunto de módulos da variante de firmware e prepara o caminho comum.
# A identificação do firmware precisa continuar alinhada aos módulos recompilados do kernel.
# Detect current firmware and use proper kernel modules.

LOGF=/tmp/recovery.log;
# Lê o slot ativo; usa bootctl como alternativa quando a propriedade está vazia.
slot=`getprop ro.boot.slot_suffix`;
[[ -z $slot ]] && slot=`bootctl get-current-slot | xargs bootctl get-suffix`;
modules=/vendor/lib/modules;

# Cria o ponto de montagem comum e associa o diretório da variante detectada.
mkdir -p $modules/1.1;
if strings /dev/block/bootdevice/by-name/xbl_config${slot} | grep -q 'led_blink'; then
	echo "I:modules_fix: Use kernel modules for HyperOS firmware!" >> $LOGF;
	mount $modules/hos1 $modules/1.1 --bind
else
	echo "I:modules_fix: Use kernel modules for MIUI14 firmware!" >> $LOGF;
	mount $modules/miui14 $modules/1.1 --bind
fi

exit 0
