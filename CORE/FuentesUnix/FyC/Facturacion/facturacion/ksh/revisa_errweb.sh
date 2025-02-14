#=============================================================================#
# Script: revisa_errweb.ksh                                                   #                                                                                                       
#                                                                             #  
# Eliminación de tabla al_errorres_web                                        #
#                                                                             #
# Sin parametro de entrada                                                    #
#-----------------------------------------------------------------------------#
# Version 1  - Revision 00                                                   #
# Abril del 2006.                                                             #
#                                                                             #
#-----------------------------------------------------------------------------#


sqlplus -s /> /dev/null <<EOF
set lines 200
set head off
set echo off
set pages 0
set feedback off
spool revisa_errweb.lst
select count(*) from al_errores_web;
spool off
/
EOF

STATUS1=`cat revisa_errweb.lst  | grep -v SQL | head -1 | awk {'print $1'}`
        if [ $STATUS1 = 0 ]
                then
                echo
                echo "Siendo las `date +%T` sigo durmiendo, todo ok..." >> salida.txt
                echo
                exit 1
        fi

echo Siendo `date +%d` de `date +%m` de 20`date +%y` a las `date +%T` estoy borrando `cat revisa_errweb.lst | grep -v SQL | head -1 |
awk {'print $1'}` >> salida.txt
sqlplus -s / > /dev/null <<EOF
update npt_pedido set ind_proc = 0 where cod_pedido in (select cod_pedido from al_errores_web);
delete from al_errores_web;
/
EOF
