IPAD_HOST_DOC1_SERVER='172.28.8.232'
PORT_HOST_DOC1_SERVER='8080'

SECUENCIAL=${1:?Secuencial}
TIPDOC=${2:?Tipdoc}
#-----------------------------------------------------------------------#
#   Seteo de Memoria de Stack para ejecución de Binarios Unix           #
#-----------------------------------------------------------------------#
#
ulimit -s
ulimit -s 32768
ulimit -s
#
MV='/usr/bin/mv -i'
CHMOD='/usr/bin/chmod 777'
AWK=/usr/bin/awk
SQLPLUS='/app10/oracle/OracleHomes/db_1/bin/sqlplus'
USER=/

export XPFACTUR_LOG=${XPF_LOG}
export XPFACTUR_DAT=${XPF_DAT}
export XPFACTUR_LST=${XPF_LST}
#
#-----------------------------------------------------------------------#
#   Definicion de Variables de TCPCLIE para transferencia de Achivo DOC1#  
#-----------------------------------------------------------------------#
#
export SQL_UP_IMPDESC=@${XPF_SQL}/up_impresdesc.sql
export ESTADO_OK=3


#
export NOM_FILE_DAT=$(echo ${SECUENCIAL} | ${AWK} '{printf("00_%015ld.dat\n",$0)}')
export NOM_FILE_PDF=$(echo ${SECUENCIAL} | ${AWK} '{printf("00_%015ld.pdf\n",$0)}')
#echo "Archiv de Salida " ${NOM_FILE_DAT}
#exit 0
export DIR_PATH_DAT=${XPF_DAT}/ImpresionScl/nociclo
export HOST_IP_DOC1=${IPAD_HOST_DOC1_SERVER}
export PORT_DOC1=${PORT_HOST_DOC1_SERVER}
export PATH_BKP=${XPF_BKP}/ImpresionScl/nociclo/bkp
export PATH_ERR=${XPF_ERR}/ImpresionScl/nociclo/err
#
echo $PATH_BKP
echo $PATH_ERR
mkdir -p ${PATH_BKP}
mkdir -p ${PATH_ERR}
#
#-----------------------------------------------------------------------#
# Control de Generacion de Archivo de Datos de la Factura
#-----------------------------------------------------------------------#
echo ${XPF_EXE}/ImpresionScl -u ${USER} -n ${SECUENCIAL} -l 5 -t ${TIPDOC}
#
${XPF_EXE}/ImpresionScl -u ${USER} -n ${SECUENCIAL} -l 5 -t ${TIPDOC}
#
ret_impre=$?
#
if [ $ret_impre != 0 ]  
then
    print -u2  "Error: ImpresionScl(ImpresionScl): Generación de Archivo de Datos";
    exit 1;
fi
#
echo ${CHMOD} ${XPF_TMP}/ImpresionScl/nociclo/${NOM_FILE_DAT}
#
echo ${MV} ${XPF_TMP}/ImpresionScl/nociclo/${NOM_FILE_DAT} ${XPF_DAT}/ImpresionScl/nociclo
#
${CHMOD} ${XPF_TMP}/ImpresionScl/nociclo/${NOM_FILE_DAT}
${MV} ${XPF_TMP}/ImpresionScl/nociclo/${NOM_FILE_DAT} ${XPF_DAT}/ImpresionScl/nociclo

#-----------------------------------------------------------------------#
# Control de la Transferencia del Archivo de Datos a Servidor Doc-1
#-----------------------------------------------------------------------#
#
#echo ${XPF_EXE}/fa_tcpcli ${NOM_FILE_DAT} ${DIR_PATH_DAT} ${HOST_IP_DOC1} ${PORT_DOC1} ${PATH_BKP} ${PATH_ERR}
#
#${XPF_EXE}/fa_tcpcli ${NOM_FILE_DAT} ${DIR_PATH_DAT} ${HOST_IP_DOC1} ${PORT_DOC1} ${PATH_BKP} ${PATH_ERR}
${XPF_EXE}/fa_tcpcli ${NOM_FILE_DAT} ${DIR_PATH_DAT} ${HOST_IP_DOC1} ${PORT_DOC1} 
#
#ret_tcpcli=$?
#
#if [ $ret_tcpcli != 0 ]  
#then
#    print -u2  "Error: ImpresionScl(ret_tcpcli): Transferencia de Archivo de Datos a Servidor Doc1";
#    exit 2;
#fi
#
#-----------------------------------------------------------------------#
# Actualiza Control de Impresion                                        #
#-----------------------------------------------------------------------#
#
#echo ${SQLPLUS} -s ${USER} ${SQL_UP_IMPDESC} ${NOM_FILE_PDF} ${ESTADO_OK} ${SECUENCIAL}
#
#${SQLPLUS} -s ${USER} ${SQL_UP_IMPDESC} ${NOM_FILE_PDF} ${ESTADO_OK} ${SECUENCIAL} 
#
#ret_sqlplus=$?
#
#if [ $ret_sqlplus != 0 ]  
#then
#    print -u2  "Error: ImpresionScl(sqlplus): Actualización de Control de Impresion";
#    exit 3;
#fi
#
exit 0
#
#
