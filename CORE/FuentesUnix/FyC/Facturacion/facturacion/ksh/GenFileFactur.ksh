##########################################################################################
#           GenFileFactur : Generador de Archivos de Facturacion.
#                           Entregar a Area de Facturacion Sr. Luis Rojas.
###########################################################################################
#       Autor    :  Mauricio Villagra V.
#       Fecha    :  16 Marzo de 1999
##########################################################################################
#     10-Oct-1999  Modificacion de Archivos de Conceptos en Uno fa_factconc_ciclo
##########################################################################################
#     13-01-2000   Proyecto Boleta, considerar tipos de Documentos Boletas y Facturas
#                   Afectas y Exentas.
##########################################################################################
#  Nombre de tabla de Conceptos
#
TABLA="FA_FACTCONC_"$1
TABLA1="FA_FACTDOCU_"$1
###########################################################################################
function Glosa_Err {
   print -u2 "Uso : GenFileFactur";
   print -u2 "\t Cod_CiclFact (DDMMAA) ==> Codigo de Ciclo de Facturacion ";
   print -u2 "\nFalta Parametros de Entrada: ==> " $1 " <=="
   return 0;
}
#     
ERR001="Codigo de Ciclo "
##########################################################################################
#
if [ "$ORACLE_SID" = "" ];then printf "\nBase de Datos Utilizada   ==> %s\n\n"  $TWO_TASK;fi;
if [ "$TWO_TASK" = "" ];then printf "\nBase de Datos Utilizada   ==> %s\n\n"  $ORACLE_SID;fi;
#
###########################################################################################
#
Cod_CiclFact=$1
if [ "$Cod_CiclFact" = "" ];then Glosa_Err "$ERR001"; exit 1; fi
#
###########################################################################################
#
echo "Creando Directorio de Reportes de Ciclo en xpfactur"
#
DIR_XPFACTUR=~xpfactur
DIR_REVISION=~xpfactur/Claudio/revision
DIR_REPORTES=${DIR_XPFACTUR}/informes/factura
DIR_CICLO=$(echo ${DIR_REPORTES}/$Cod_CiclFact
# | awk '{printf("%s_%06d/\n",$1,$2)}')
#
if [ ! -d ${DIR_CICLO} ]
then
   mkdir ${DIR_CICLO}
fi
#
DIR_SRFACTUR=~srfactur
DIR_REPORTES_M=${DIR_SRFACTUR}/reportes
DIR_CICLO_M=$(echo ${DIR_REPORTES_M}/C$Cod_CiclFact 
# | awk '{printf("%s_%06d/\n",$1,$2)}')
#
if [ ! -d ${DIR_CICLO_M} ]
then
    mkdir ${DIR_CICLO_M}
fi
#
###########################################################################################
#
cd ${DIR_CICLO}
#
Nom_Tabla=${TABLA}
nombre_salida=$(echo CO${Cod_CiclFact} 
#| awk '{printf("%s_%06d\n",$1,$2)}')
echo "Generando Archivo " ${nombre_salida}".lst"
sqlplus -s / @${XPF_SQL}/GenConceptos.sql ${Cod_CiclFact} ${Nom_Tabla}  > ${nombre_salida}.lst
#
echo "Copiando " ${nombre_salida}.lst " a "  ${DIR_CICLO_M}
#
cp ${nombre_salida}.lst ${DIR_CICLO_M}
#
###########################################################################################
#
nombre_salida1=$(echo DO${Cod_CiclFact} 
#| awk '{printf("%s_%06d\n",$1,$2)}')
echo "Generando Archivo " ${nombre_salida1}".lst"
sqlplus -s / @${XPF_SQL}/GenFacturas.sql ${Cod_CiclFact}  > ${nombre_salida1}.lst
#
echo "Copiando " ${nombre_salida1}.lst " a "  ${DIR_CICLO_M}
#
cp  ${nombre_salida1}.lst  ${DIR_CICLO_M}
#
###########################################################################################
#
print $(date) "  ==>  Termino del Proceso de Generacion de Archivos......"
#
###########################################################################################
