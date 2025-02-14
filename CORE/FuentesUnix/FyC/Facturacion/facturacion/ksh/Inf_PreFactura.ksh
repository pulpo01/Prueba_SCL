########################################
# Ciclo de Facturacion
########################################
Cod_CiclFact=${1:?Cod_CiclFact}
#
CP="cp -p"
#
sqlplus /  @${XPF_SQL}/cargos_clientes   $1;
sqlplus /  @${XPF_SQL}/trafico_total     $1;
#
facclifac02 -u / -c ${Cod_CiclFact}
#
########################################
# Validar Directorio de Destino srfactur
########################################
DIR_SRFACTUR=~srfactur
DIR_REPORTES_REV=${DIR_SRFACTUR}/reportes
DIR_CICLO_REV=${DIR_REPORTES_REV}/C${Cod_CiclFact}
#
########################################
# Validar Directorio de Destino xpfactur
########################################
DIR_REPORTES_XPF=${XPF_DAT}/Inf_PreFactura
DIR_CICLO_XPF=${DIR_REPORTES_XPF}/ciclo/${Cod_CiclFact}
#
########################################
# Reportes
Reporte1=facprecargos_${Cod_CiclFact}.lst
Reporte2=facpremovim_${Cod_CiclFact}.lst
Reporte3=facpretrafic_${Cod_CiclFact}.lst
########################################
#
mkdir -p ${DIR_CICLO_REV}
mkdir -p ${DIR_CICLO_XPF}
#
########################################
${CP} ${Reporte1} ${DIR_CICLO_REV}
${CP} ${Reporte2} ${DIR_CICLO_REV}
${CP} ${Reporte3} ${DIR_CICLO_REV}
########################################
${CP} ${Reporte1} ${DIR_CICLO_XPF}
${CP} ${Reporte2} ${DIR_CICLO_XPF}
${CP} ${Reporte3} ${DIR_CICLO_XPF}
########################################
