PROCESO=${1:?Proceso}
MODGENER=${2:?Modo Generacion}
#
export XPF_HOME=~xpfactur/facturacion
export XPF_LOG=${XPF_HOME}/log
export XPF_DAT=${XPF_HOME}/dat
export XPF_EXE=${XPF_HOME}/exe
#
${XPF_EXE}/New_impresion -u / -m${MODGENER} -p${PROCESO}
#
ret_impre=$?
#
/usr/bin/sleep 1
#
exit ${ret_impre}
