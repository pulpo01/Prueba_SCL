#############################################################################
#
#                       revArchImpre.ksh
#
#############################################################################
#   Revisa Archivos de impresion por ciclo de Ffacturación
#---------------------------------------------------------------------------#
#   Parametros :  Ciclo de Facturacion
#---------------------------------------------------------------------------#
#   Revisiones  :
#   31-08-2000  : Mauricio Villagra Villalobos
#                 Creacion de Shell
#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="REV-ARCHIVOS"
USERID=/
BASE_REVARCH="informes/Ciclo"
#
#---------------------------------------------------------------------------#
# Traza define's                                                            #
#---------------------------------------------------------------------------#
COD_PROCESO_FACT=5000
COD_PROCESO_DPAG=5100
COD_PROCESO_DLLA=5200
COD_ESTA_PROCESO_IMP_OK=3
COD_COMP_ARCH_OK=1
CERO_DUPLICADOS=0

STAT_IND_FACTURACION_NOPROC=0
STAT_IND_FACTURACION_INPROC=1
STAT_IND_FACTURACION_OUTPROC=2
TIP_IMPRE_FACT=1
TIP_IMPRE_DPAG=2
TIP_IMPRE_DLLAM=3
STAT_FAIL=2
STAT_OK=3
OBS_INI="Proceso de anomalias en ejecucion"
OBS_FAIL="Proceso de anomalias terminado anormalmente"
OBS_OK="Proceso de anomalias finalizado normalmente"
#
#---------------------------------------------------------------------------#
#
#  Definicion de Macros
#---------------------------------------------------------------------------#
RCMD=remsh
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus -s"
SQLLOAD="sqlload"
AWK_COMMAND="awk -f"
CAT="cat"
SORT="sort"
DIFF="diff"
#
#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Shell Scripts                            #
#---------------------------------------------------------------------------#
#
SQL_VAL_CICLFACT=val_ciclfact
SQL_VAL_TRAZAIMP=val_TrazaImpre
SQL_SEL_ARCHIMPRE=rev_RecArchImpre
SQL_SEL_SECUINFO=rev_RecSecuInfo
SQL_GENERA_DATA_FACTURA=Genera_Data_Facturas
SQL_GENERA_DATA_RESUMEN=Genera_Data_Resumen
SQL_ACT_FACTURAS=Facturas_Act
SQL_INS_FACTURAS=Facturas_Ins
SQL_FACTURAS_ERR=FACTURASerr
SQL_ACT_RESUMEN=Resumen_Act
SQL_INS_RESUMEN=Resumen_Ins
SQL_RESUMEN_ERR=RESUMENerr
SQL_LLAMADAS_ERR=LLAMADASerr
SQL_ACT_FACTURA_RESUMEN=Facturas_Resumen_Act
SQL_INS_FACTURA_RESUMEN=Facturas_Resumen_Ins
SQL_ACT_RESUMEN_LLAMADAS=Resumen_Llamadas_Act
SQL_INS_RESUMEN_LLAMADAS=Resumen_Llamadas_Ins
SQL_COMP_DIRECCIONES=Comp_direcciones


#
AWK_REVARCH_FACTURA="revArchFac.awk"
AWK_REVARCH_RESUMEN="revArchRes.awk"
AWK_REVARCH_LLAMADA="revArchDet.awk"
AWK_REVARCH_CMPDATAFACT="Compara_Total_Facturas.awk"
AWK_REVARCH_CMPDATARESU="Compara_Total_Resumen.awk"
AWK_REVARCH_CMP_FACTURA_RESUMEN="Compara_Factura_Resumen.awk"
AWK_REVARCH_RECNOMFILE="Rec_Nombre_Archivo.awk"
#
#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}
CTL=${XPF_CTL}
TMP=${XPF_TMP}
SQL=${XPF_SQL}
AWK=${XPF_AWK}
export DAT=${XPFACTUR_DAT}/${BASE_REVARCH}
export LOG=${XPFACTUR_LOG}/${BASE_REVARCH}
#
#---------------------------------------------------------------------------#
# Machine detection                                                         #
#---------------------------------------------------------------------------#
MACHINE="$(uname -n)"
#
#---------------------------------------------------------------------------#
# Environment Functions                                                     #
#---------------------------------------------------------------------------#
PrintLog()
{
   print "\n$(date +'[%d-%m-%Y][%H:%M:%S]') $@"
}
#
#---------------------------------------------------------------------------#
# External arguments                                                        #
#---------------------------------------------------------------------------#
CICLFACT=${1:?Cod_CiclFact}
#
#---------------------------------------------------------------------------#
# Files Temporales                                                          #
#---------------------------------------------------------------------------#
FACTURAS_CLI=${DAT}/${CICLFACT}/FACTURAS.cli
RESUMEN_CLI=${DAT}/${CICLFACT}/RESUMEN.cli

FACTURAS_TOT=${DAT}/${CICLFACT}/FACTURAS.tot
RESUMEN_TOT=${DAT}/${CICLFACT}/RESUMEN.tot
LLAMADAS_TOT=${DAT}/${CICLFACT}/LLAMADAS.tot

FACTURAS_DAT=${DAT}/${CICLFACT}/FACTURAS.dat
RESUMEN_DAT=${DAT}/${CICLFACT}/RESUMEN.dat
LLAMADAS_DAT=${DAT}/${CICLFACT}/LLAMADAS.dat

RESUMEN_DIR=${DAT}/${CICLFACT}/RESUMEN.dir
FACTURAS_DIR=${DAT}/${CICLFACT}/FACTURAS.dir

#---------------------------------------------------------------------------#
# Output Environment Creation                                               #
#---------------------------------------------------------------------------#
set -A OUT_ARR ${DAT} ${LOG}
for OUT_DIR in "${OUT_ARR[@]}"
do
   ${CREATEDIR} ${OUT_DIR}/${CICLFACT}
   [ $? -ne 0 ] &&
   {
     print [mkdir]: No fue posible crear directorio ${OUT_DIR}/${CICLFACT}. Se cancela.
     exit 1
   }
done

#
#---------------------------------------------------------------------------#
# File Names                                                                #
#---------------------------------------------------------------------------#
FILE_LOG_REVARCH=${LOG}/${CICLFACT}/rev_archivos_${CICLFACT}.log
#
(
#---------------------------------------------------------------------------#
# Header                                                                    #
#---------------------------------------------------------------------------#
print
print "======================================================================"
print "PROCESO     : " $0
print "DESCRIPCION : " ${GLOSA_PROG}
print "VERSION     : " ${VER}
print "REVISION    : " ${REV}
print "MAQUINA     : " ${MACHINE}
print "FECHA       : " "$(date +'%d-%B-%Y')"
print "HORA        : " "$(date +'%X')"
print "======================================================================"
#
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Revisando estado de Ciclo en Tabla de Ciclo de Facturacion ...
status="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_VAL_CICLFACT} ${CICLFACT})"
[ "${status}" = "" ] &&
{
  status=0
}
[ ${status} -eq ${STAT_IND_FACTURACION_NOPROC} ] &&
{
   print El Ciclo de Facturacion aun no es procesado
   print Esta ejecucion se cancela.
   print
   exit 1
}
[ ${status} -eq ${STAT_IND_FACTURACION_OUTPROC} ] &&
{
   print El Ciclo de Facturacion ya fue procesado
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
# Validación de procesos de Impresion en Tablas de Control de Impresion
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Selecciona Secuencia de Informe de Impresion de Facturas/Boletas
iNumSecuInfo_1="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_SECUINFO} ${CICLFACT} ${TIP_IMPRE_FACT})"
[ "${iNumSecuInfo_1}" = "" ] &&
{
   print No se Han Impreso los Documentos Facturas/Boletas del Ciclo de Facturacion
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
PrintLog Selecciona Archivos Generados por Proceso de Impresion de Facturas/Boletas
FILE_LIST_1="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_ARCHIMPRE} ${iNumSecuInfo_1} ${CICLFACT} ${TIP_IMPRE_FACT})"
[ "${FILE_LIST_1}" = "" ] &&
{
   print No Existen Archivos de Facturas/Boletas
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Selecciona Secuencia de Informe de Impresion de Detalle de Pago/Resumen Consumo
iNumSecuInfo_2="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_SECUINFO} ${CICLFACT} ${TIP_IMPRE_DPAG})"
[ "${iNumSecuInfo_2}" = "" ] &&
{
   print No se Han Impreso los Documentos Detalle de Pago/Resumen Consumo del Ciclo de Facturacion
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
PrintLog Selecciona Archivos Generados por Proceso de Impresion de Detalle de Pago/Resumen Consumo
FILE_LIST_2="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_ARCHIMPRE} ${iNumSecuInfo_2} ${CICLFACT} ${TIP_IMPRE_DPAG} )"
[ "${FILE_LIST_2}" = "" ] &&
{
   print No Existen Archivos de Detalle de Pago/Resumen Consumo
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Selecciona Secuencia de Informe de Impresion de Detalle de Llamadas
iNumSecuInfo_3="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_SECUINFO} ${CICLFACT} ${TIP_IMPRE_DLLAM})"
[ "${iNumSecuInfo_3}" = "" ] &&
{
   print No se Han Impreso los Documentos Detalle de Llamadas Ciclo de Facturacion
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
PrintLog Selecciona Archivos Generados por Proceso de Impresion de Detalle de Llamadas
FILE_LIST_3="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_ARCHIMPRE} ${iNumSecuInfo_3} ${CICLFACT} ${TIP_IMPRE_DLLAM})"
[ "${FILE_LIST_3}" = "" ] &&
{
   print No Existen Archivos de Detalle de Detalle de Llamadas
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
# Validación de procesos de Impresion en Traza de Facturacion de Ciclo
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Valida Proceso de Impresion de Facturas/Boletas
iCodEstaProc="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_VAL_TRAZAIMP} ${CICLFACT} ${COD_PROCESO_FACT})"
[ "${iCodEstaProc}" = "" ] &&
{
  iCodEstaProc=0
}
[ ${iCodEstaProc} -ne ${COD_ESTA_PROCESO_IMP_OK} ] &&
{
   print El Proceso de Impresion No ha Sido Ejecutado Satisfactoriamente
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Valida Proceso de Impresion de Detalle de Pago/Resumen Consumo
iCodEstaProc="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_VAL_TRAZAIMP} ${CICLFACT} ${COD_PROCESO_DPAG})"
[ "${iCodEstaProc}" = "" ] &&
{
  iCodEstaProc=0
}
[ ${iCodEstaProc} -ne ${COD_ESTA_PROCESO_IMP_OK} ] &&
{
   print El Proceso de Impresion No ha Sido Ejecutado Satisfactoriamente
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
PrintLog Valida Proceso de Impresion de Detalle de Llamadas
iCodEstaProc="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_VAL_TRAZAIMP} ${CICLFACT} ${COD_PROCESO_DLLA})"
[ "${iCodEstaProc}" = "" ] &&
{
  iCodEstaProc=0
}
[ ${iCodEstaProc} -ne ${COD_ESTA_PROCESO_IMP_OK} ] &&
{
   print El Proceso de Impresion No ha Sido Ejecutado Satisfactoriamente
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
#Revisa Archivos de Facturas/Boletas                COD_TIPIMPRE = 1
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
${RM} ${FACTURAS_CLI}
${RM} ${FACTURAS_TOT}
${RM} ${FACTURAS_DAT}
${RM} ${FACTURAS_DIR}
#
print "SET FEEDBACK OFF " > ${DAT}/${CICLFACT}/${SQL_FACTURAS_ERR}.sql
print "DELETE FAD_CTLERRIMPRE WHERE NUM_SECUINFO= " ${iNumSecuInfo_1} ";" >> ${DAT}/${CICLFACT}/${SQL_FACTURAS_ERR}.sql
print "UPDATE FAD_CTLIMPRES SET COD_ESTADO=0 WHERE NUM_SECUINFO=" ${iNumSecuInfo_1} ";" >> ${DAT}/${CICLFACT}/${SQL_FACTURAS_ERR}.sql
#
PrintLog Ejecuta Validador de Facturas/Boletas
set -A OUT_ARR_FILE ${FILE_LIST_1}

for OUT_FILE in "${OUT_ARR_FILE[@]}"
do
    ${AWK_COMMAND} ${AWK}/${AWK_REVARCH_FACTURA} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_1}|awk '{printf("%d",$1)}') ${OUT_FILE}
done
print "COMMIT WORK;\n QUIT;" >> ${DAT}/${CICLFACT}/${SQL_FACTURAS_ERR}.sql
#
PrintLog Bajar Totales de Facturas/Boletas a Archivo Plano FACTURAS.dat

${SQLPLUS} ${USERID} @${SQL}/${SQL_GENERA_DATA_FACTURA} ${iNumSecuInfo_1} > ${FACTURAS_DAT} 

PrintLog Comparando Archivos de Totales de Facturas
PrintLog ${AWK_COMMAND} ${AWK}/${AWK_REVARCH_CMPDATAFACT} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_1}) ${FACTURAS_TOT} ${FACTURAS_DAT}
${AWK_COMMAND} ${AWK}/${AWK_REVARCH_CMPDATAFACT} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_1}) ${FACTURAS_TOT} ${FACTURAS_DAT}

PrintLog Marcando Errores en Base Datos de Totales
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_ACT_FACTURAS}
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_INS_FACTURAS}
PrintLog Levantando Archivo de Errores Facturas/Boletas
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_FACTURAS_ERR}

${SORT} ${FACTURAS_CLI} -o ${FACTURAS_CLI}
${SORT} ${FACTURAS_DIR} -o ${FACTURAS_DIR}

#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
#Revisa Archivos de Detalle Pago/Resumen Consumo    COD_TIPIMPRE = 2
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
${RM} ${RESUMEN_CLI}
${RM} ${RESUMEN_TOT}
${RM} ${RESUMEN_DAT}
${RM} ${RESUMEN_DIR}
#
print "SET FEEDBACK OFF " > ${DAT}/${CICLFACT}/${SQL_RESUMEN_ERR}.sql
print "DELETE FAD_CTLERRIMPRE WHERE NUM_SECUINFO= " ${iNumSecuInfo_2} ";" >> ${DAT}/${CICLFACT}/${SQL_RESUMEN_ERR}.sql
print "UPDATE FAD_CTLIMPRES SET COD_ESTADO=0 WHERE NUM_SECUINFO=" ${iNumSecuInfo_2} ";" >> ${DAT}/${CICLFACT}/${SQL_RESUMEN_ERR}.sql
#
PrintLog Ejecuta Validador de Detalle de Pago/Resumen Consumo
set -A OUT_ARR_FILE ${FILE_LIST_2}
for OUT_FILE in "${OUT_ARR_FILE[@]}"
do
    ${AWK_COMMAND} ${AWK}/${AWK_REVARCH_RESUMEN} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_2}|awk '{printf("%d",$1)}') ${OUT_FILE} 
done
print "COMMIT WORK;\n QUIT;" >> ${DAT}/${CICLFACT}/${SQL_RESUMEN_ERR}.sql

PrintLog Bajar Totales de Pago/Resumen Consumo a Archivo Plano
${SQLPLUS} ${USERID} @${SQL}/${SQL_GENERA_DATA_RESUMEN} ${iNumSecuInfo_2} > ${RESUMEN_DAT} 

PrintLog Comparando Archivos de Totales de Resumen de Consumo
#PrintLog ${AWK_COMMAND} ${AWK}/${AWK_REVARCH_CMPDATARESU} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_2}) ${RESUMEN_TOT} ${RESUMEN_DAT}
${AWK_COMMAND} ${AWK}/${AWK_REVARCH_CMPDATARESU} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_2}) ${RESUMEN_TOT} ${RESUMEN_DAT}

PrintLog Marcando Errores en Base Datos de totales
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_ACT_RESUMEN}
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_INS_RESUMEN}

PrintLog Levantando Archivo de Errores Resumenes
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_RESUMEN_ERR}

${SORT} ${RESUMEN_CLI} -o ${RESUMEN_CLI}
${SORT} ${RESUMEN_DIR} -o ${RESUMEN_DIR}
##################################################################################
# Validacion de direcciones de Facturas/Boletas y Detalle de pago por cliente

print "SET FEEDBACK OFF " > ${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES}.sql
print "UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO IN (${iNumSecuInfo_1} , ${iNumSecuInfo_2} );" >> ${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES}.sql
print "COMMIT WORK;" >> ${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES}.sql

PrintLog Diferencia Entre Archivos de Direcciones
Distintos="$(${DIFF} ${FACTURAS_DIR} ${RESUMEN_DIR}| head -1 | wc -l)"
PrintLog ${Distintos}
[ ${Distintos} -ne ${COD_COMP_ARCH_OK} ] &&
{ 
    # Creación de un archivo que levanta a BD los errores de Direcciones

    set -A OUT_ARR_FILE ${FILE_LIST_1}
    for OUT_FILE in "${OUT_ARR_FILE[@]}"
    do
      ELARCHIVO="$(${AWK_COMMAND} ${AWK}/${AWK_REVARCH_RECNOMFILE} ${OUT_FILE})"
      print "INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE) VALUES (" ${iNumSecuInfo_1} ",'" ${ELARCHIVO}.dat "','Los Archivos De Direcciones Son Identicos.',1,0);" >> ${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES}.sql
    done

    set -A OUT_ARR_FILE ${FILE_LIST_2}
    for OUT_FILE in "${OUT_ARR_FILE[@]}"
    do
      ELARCHIVO="$(${AWK_COMMAND} ${AWK}/${AWK_REVARCH_RECNOMFILE} ${OUT_FILE})"
      print "INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE)  VALUES (" ${iNumSecuInfo_2} ",'" ${ELARCHIVO}.dat "','Los Archivos De Direcciones Son Identicos.',1,0);" >> ${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES}.sql
    done
    print "COMMIT WORK;\n QUIT;" >> ${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES}.sql    

    ${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_COMP_DIRECCIONES} ${iNumSecuInfo_1} ${iNumSecuInfo_2} 
}

#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
#Revisa Archivos de Detalles de Llamadas            COD_TIPIMPRE = 3
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
${RM} ${LLAMADAS_TOT}
${RM} ${LLAMADAS_DAT}
#
print "SET FEEDBACK OFF " > ${DAT}/${CICLFACT}/${SQL_LLAMADAS_ERR}.sql
print "DELETE FAD_CTLERRIMPRE WHERE NUM_SECUINFO= " ${iNumSecuInfo_3} ";" >> ${DAT}/${CICLFACT}/${SQL_LLAMADAS_ERR}.sql
#
PrintLog Ejecuta Validador de Detalle de Llamadas

set -A OUT_ARR_FILE ${FILE_LIST_3}
for OUT_FILE in "${OUT_ARR_FILE[@]}"
do
    ${AWK_COMMAND} ${AWK}/${AWK_REVARCH_LLAMADA} -vszDirDat=${DAT}/${CICLFACT} -vNumSecuInfo=$(echo ${iNumSecuInfo_3}|awk '{printf("%d",$1)}') ${OUT_FILE} 
    ELARCHIVO="$(${AWK_COMMAND} ${AWK}/${AWK_REVARCH_RECNOMFILE} ${OUT_FILE})"
    PrintLog "Validando Cantidad de Registros Duplicados en :" ${ELARCHIVO}
    Duplicados="$(uniq -d ${OUT_FILE} | wc -l)"
    PrintLog "Registros Duplicados:" ${Duplicados}
    [ ${Duplicados} -ne ${CERO_DUPLICADOS} ] &&
    {  
      print "INSERT INTO FAD_CTLERRIMPRE (NUM_SECUINFO,NOM_ARCHIVO,GLS_ERROR,COD_TIPIMPRES,COD_CLIENTE,TOT_CORRECTO,TOT_ERRONEO) VALUES ("${iNumSecuInfo_3} ",'"${ELARCHIVO}.dat "','Existen Registros Duplicados.',3,0,0,0);" >> ${DAT}/${CICLFACT}/${SQL_LLAMADAS_ERR}.sql
      print "UPDATE FAD_CTLIMPRES SET COD_ESTADO=1 WHERE NUM_SECUINFO=" ${iNumSecuInfo_3} " AND NOM_ARCHIVO=" ${OUT_FILE}" ;" >> ${DAT}/${CICLFACT}/${SQL_LLAMADAS_ERR}.sql
    }
done
print "COMMIT WORK;\n QUIT;" >> ${DAT}/${CICLFACT}/${SQL_LLAMADAS_ERR}.sql

################################################################################3
#
#
################################################################################3
PrintLog Comparacion de Facturas/Resumen
#PrintLog ${AWK_COMMAND} ${AWK}/${AWK_REVARCH_CMP_FACTURA_RESUMEN} -vszDirDat=${DAT}/${CICLFACT} ${FACTURAS_CLI} ${RESUMEN_CLI}
${AWK_COMMAND} ${AWK}/${AWK_REVARCH_CMP_FACTURA_RESUMEN} -vszDirDat=${DAT}/${CICLFACT} ${FACTURAS_CLI} ${RESUMEN_CLI}

PrintLog Comparacion de Facturas/Resumen Marcando Errores en Base Datos
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_ACT_FACTURA_RESUMEN} 
${SQLPLUS} ${USERID} @${DAT}/${CICLFACT}/${SQL_INS_FACTURA_RESUMEN} 

#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
) | tee ${FILE_LOG_REVARCH}
PrintLog Fin de Proceso."\n\n"
#FIN
