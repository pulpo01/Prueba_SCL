##########################################################################################
#
#       Autor    :  Mauricio Villagra V.
#       Fecha    :  03 de Agosto de 1999.
#     
##########################################################################################
#
set +x
mflag=$1 
aflag=$2
auxFile=$3
NumProcUnix=$$
#NumProcUnix=1111
#
###########################################################################
#
if [ "$mflag" = "" ]  ||  [ "$aflag" = "" ]
then
    print -u2  "Error : Usar ConcFactCobr.ksh MM AAAA ";
    exit 1;
fi
#
###########################################################################
#
if [ $mflag -lt 1 ]  ||  [ $mflag -gt 12 ]
then
    print -u2 "Error de Parametro : Mes de Proceso [ 1 .. 12 ]";
    exit 1;
fi
#
###########################################################################
#
if [ $aflag -lt 1999 ] || [ $aflag -gt 2002 ]
then
    print -u2 "Error de Parametro : Ano de Proceso [ 1999 .. 2002  ]"
    exit 1
fi
#
###########################################################################
fec_desde="01"$mflag$aflag
###########################################################################
typeset -i mes_fin
typeset -i ano_fin
mes_fin=$mflag+1
ano_fin=$aflag
nombre_salida="FactCobr_"${aflag}${mflag}
###########################################################################
if [ "$mflag" = "12" ]
then
    mes_fin=1
    ano_fin=$aflag+1
fi
fec_hasta=$(echo $mes_fin $ano_fin | awk '{printf("01%02d%04d\n",$1,$2)}')
#
###########################################################################
#  CREA TABLA TEMPORAL DE FACTURAS Y ACTUALIZA NOTAS DE CREDITO
###########################################################################
#
printf "\n%s ==> Generando Tablas Temporales y Listado de Documentos Emitidos desde %s hasta %s .... \n\n" "$(date)" $fec_desde  $fec_hasta | tee -a ${nombre_salida}.log
###########################################################################
#
sqlplus -s / @${XPF_SQL}/cr_factmensual.sql $fec_desde $fec_hasta | tee -a ${nombre_salida}.log 
#
#
###########################################################################
#  RECUPERA CODIGOS DE CICLO DE FACTURACION DE FACTURAS DEL MES
###########################################################################
#
printf "\n%s ==> Recuperando Codigos de Ciclos de Facturacion \n\n" "$(date)" | tee -a ${nombre_salida}.log 
###########################################################################
#
sqlplus -s / @${XPF_SQL}/sel_codciclfact.sql ${NumProcUnix} | tee -a ${nombre_salida}.log
#
Tot_Ciclos=$(wc -l ciclfact_${NumProcUnix}.dat)
#
if [ "$Tot_Ciclos" = "0" ]
then
    exit 0;
fi
#
###########################################################################
#  RECORRE ARCHIVO DE CICLOS Y GENERA UN ARCHIVO POR CADA CICLOFACT
###########################################################################
#
cat ciclfact_${NumProcUnix}.dat | 
        while read p1 p2 p3 p4 p5
        do  
            ##########################################################################################
            printf "\n%s ==> Parametros de Ciclos...\n\n" "$(date)" | tee -a ${nombre_salida}.log 
            printf "\t\t\t\t\t ==> CiclFact             %ld \n" $p1 | tee -a ${nombre_salida}.log 
            printf "\t\t\t\t\t ==> Abonados Celular     %s  \n" $p2 | tee -a ${nombre_salida}.log 
            printf "\t\t\t\t\t ==> Abonados Beeper      %s  \n" $p3 | tee -a ${nombre_salida}.log 
            printf "\t\t\t\t\t ==> Facturas             %s  \n" $p4 | tee -a ${nombre_salida}.log 
            printf "\t\t\t\t\t ==> Conceptos            %s  \n" $p5 | tee -a ${nombre_salida}.log 
            ##########################################################################################
            printf "\n%s ==> Carga de Detalle del Ciclo .... \n\n" "$(date)" | tee -a ${nombre_salida}.log 
            ##########################################################################################
            if [ "$p5" = "FA_HISTCONC" ]
            then
                sqlplus -s / @${XPF_SQL}/cr_detmensual_old.sql $p1 
            else
                sqlplus -s / @${XPF_SQL}/cr_detmensual.sql $p1 $p5 $p2 $p3
            fi                                                                
            ##########################################################################################
            printf "\n%s ==> Inicio del Proceso Generacion %s ..... \n\n" "$(date)" ${nombre_salida}_$p1.txt  | tee -a ${nombre_salida}.log 
            ##########################################################################################
            #
            sqlplus -s / @$XPF_SQL/gen_concfactcobr.sql > ${nombre_salida}_$p1.txt
            #
            ##########################################################################################
            printf "\n%s ==> Termino del Proceso Generacion %s ..... \n\n" "$(date)" ${nombre_salida}_$p1.txt | tee -a ${nombre_salida}.log 
            ##########################################################################################
        done
        
#
rm -f ciclfact_${NumProcUnix}.dat
#        
##########################################################################################
#
print $(date) "==> Termino del Proceso OK \n" | tee -a ${nombre_salida}.log 
##########################################################################################
#
