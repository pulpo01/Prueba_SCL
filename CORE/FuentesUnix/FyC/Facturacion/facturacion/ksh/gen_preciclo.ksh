#############################################################################
#
#                       revArchImpre.ksh
#
#############################################################################
#   Genera Comando UNIX para ejecucion de proceso de PRE/POST FACTURACION 
#---------------------------------------------------------------------------#
#   Parametros :  Ciclo de Facturacion
#---------------------------------------------------------------------------#
#   Revisiones  :
#   01-11-2000  : Mauricio Villagra Villalobos
#                 Creacion de Shell
#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
VER=1
REV=00
GLOSA_PROG="GENERADOR PRE/POST CICLO"
USERID=/
BASE_REVARCH="informes/Ciclo/GenPreCiclo"
#
#---------------------------------------------------------------------------#
# Traza define's                                                            #
#---------------------------------------------------------------------------#
STAT_FAIL=2
STAT_OK=3
OBS_INI="Proceso de Pre/Post Ciclo en ejecucion"
OBS_FAIL="Proceso de Pre/Post Ciclo terminado anormalmente"
OBS_OK="Proceso de Pre/Post Ciclo finalizado normalmente"
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
AWK_COMMAND="awk -f "
CAT="cat"
SORT="sort"
DIFF="diff"
#
#---------------------------------------------------------------------------#
# SQL Scripts & Executable Progs & Shell Scripts                            #
#---------------------------------------------------------------------------#
#
SQL_SEL_CICLFACT=sel_codciclfadparam
EXE_PRECICLO=infctlpreciclo
PARAM_EXE='-u / -l3 -c'
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
#
#---------------------------------------------------------------------------#
# Output Environment Creation                                               #
#---------------------------------------------------------------------------#
set -A OUT_ARR ${DAT} ${LOG}
for OUT_DIR in "${OUT_ARR[@]}"
do
   ${CREATEDIR} ${OUT_DIR}
   [ $? -ne 0 ] &&
   {
     print [mkdir]: No fue posible crear directorio ${OUT_DIR}. Se cancela.
     exit 1
   }
done
#
#---------------------------------------------------------------------------#
# File Names                                                                #
#---------------------------------------------------------------------------#
FILE_LOG_REVARCH=${LOG}/gen_preciclo_$(date +'%Y%m%d_%H%M%S').log
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
status="$(${SQLPLUS} ${USERID} @${SQL}/${SQL_SEL_CICLFACT})"
[ "${status}" = "" ] &&
{
  status=0
}
PrintLog Ciclo Recuperado [${status}]...
[ ${status} -eq 0 ] &&
{
   print El Ciclo de Facturacion No es Valido 
   print Esta ejecucion se cancela.
   print
   exit 1
}
COD_CICLFACT=${status}
PrintLog Ejecuta Proceso de PRE/POST CICLO FACTURACION
PrintLog ${EXE_PRECICLO} ${PARAM_EXE} ${COD_CICLFACT}
${EXE_PRECICLO} ${PARAM_EXE} ${COD_CICLFACT}
[ ${status} != 0 ] &&
{
   print El Proceso Termino con Error
   print Esta ejecucion se cancela.
   print
   exit 1
}
#---------------------------------------------------------------------------#
#---------------------------------------------------------------------------#
) | tee ${FILE_LOG_REVARCH}
#FIN
