#!/bin/ksh
CICLO=$1
if [ -z ${CICLO} ]; then
    echo "Debe ingresa un Ciclo..."
    exit 1
fi
echo "----------------------------------------------------------------------------------"
date
echo "----------------------------------------------------------------------------------"
echo "CICLO      [${CICLO}]"
integer IND_ORDENTOTAL
integer POSICION

DIR_LOG=${XPF_LOG}/ImpresionScl/ciclo/${CICLO}
DIR_DAT=${XPF_DAT}/ImpresionScl/ciclo/${CICLO}

ls ${DIR_LOG} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error No existe Directorio ${DIR_LOG}"
    exit 2
fi

ls ${DIR_DAT} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error No existe Directorio ${DIR_DAT}"
    exit 3
fi

echo "DIRECTORIO [${DIR_LOG}]"
echo "----------------------------------------------------------------------------------"
echo "CLIENTE|IND_ORDENTOTAL|ARCHIVO|POSICION"
ARCHIVO_TEMPORAL=${DIR_LOG}/`date "+%Y%d%m"`.tmp
grep -n "OPEN curConcTrafico using" ${DIR_LOG}/* > ${ARCHIVO_TEMPORAL}
for ELEMENTO in `ls -tr ${DIR_DAT}/ImpScl*.err`;do
    CLIENTE=`head -1 ${ELEMENTO} | cut -c6-13`
    ELEMENTO=`echo ${ELEMENTO} | awk 'BEGIN {FS="/"}{ print $NF }'`
    ELEMENTO=`echo ${ELEMENTO} | awk 'BEGIN {FS="."}{ print $1 }'`
    ELEMENTO=`echo ${ELEMENTO} | awk 'BEGIN {FS="_"}{ print $NF }'`
    IND_ORDENTOTAL=`expr ${ELEMENTO}`
    POSICION=`grep -n "OPEN curConcTrafico using ${IND_ORDENTOTAL}" ${ARCHIVO_TEMPORAL} | awk 'BEGIN {FS=":"}{ print $3 }'`
    ARCHIVO_RUTA=`grep -n "OPEN curConcTrafico using ${IND_ORDENTOTAL}" ${ARCHIVO_TEMPORAL} | awk 'BEGIN {FS=":"}{ print $2 }'`
    ARCHIVO=`echo ${ARCHIVO_RUTA} | awk 'BEGIN {FS="/"}{ print $NF }'`
    echo "${CLIENTE}|${IND_ORDENTOTAL}|${ARCHIVO}|${POSICION}|"
done
rm -f ${ARCHIVO_TEMPORAL} /dev/null 2>&1
echo "----------------------------------------------------------------------------------"
date
echo "----------------------------------------------------------------------------------"
