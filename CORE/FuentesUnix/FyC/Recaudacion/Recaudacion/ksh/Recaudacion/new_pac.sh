# Shell para ejecutar procesos new_universo y new_pac.
# Abril del 2003 
# G.A.C.   
# Modificado 19-05-2005 GAC

EXE=${HOME}/EXE/Recaudacion

echo '\n'
echo '  *****  PAGOS AUTOMATICOS DE CUENTAS  *****\n ' 


# CODIGO DEL BANCO A PROCESAR #
echo '  Ingrese Codigo del Banco a Procesar [9999=Genera Todos los Bancos]'
read cod_banco

BANCO=$(sqlplus -s / @$HOME/SQL/Recaudacion/Valida_Banco.sql $cod_banco )

    if [ $cod_banco != '9999' -a $BANCO != '1' ]
    then
        echo ' Codigo de Banco ['$cod_banco'] es Invalido...!!!\n\n'
        exit
    fi
echo '  OK. Codigo de Banco : '$cod_banco'\n'


# CODIGO DE CICLO DE FACTURACION #
echo '  Ingrese Codigo de Ciclo de Facturacion '
read ciclo_fac

CICLFACT=$(sqlplus -s / @$HOME/SQL/Recaudacion/Valida_CicloFact.sql $ciclo_fac )

    if [ $CICLFACT != '1' ] 
    then
        echo ' Ciclo ['$ciclo_fac'] es Invalido...!!!\n\n'
        exit
    fi   
echo '  OK. Ciclo de Facturacion : '$ciclo_fac'\n'


# NIVEL DE LOG DESEADO #
echo '  Ingrese Nivel de Log que Desea (3,4,.....9) ' 
read nivel
echo ''

let NIV=$(echo $nivel|awk '{printf("%d",$nivel)}')

    if [ $NIV -lt 3 -o $NIV -gt 9 ]  
    then 
    echo 'DEBE INGRESAR UN NIVEL DE LOG ENTRE 3 Y 9....!!!!\n\n' 
    exit  
    fi

echo '  EJECUTANDO PROCESO [ new_pac ] \n ' 
${EXE}/new_pac -u / -l $nivel  -c $cod_banco -f $ciclo_fac 
RET=$?
echo '  Resultado new_pac : '$RET'\n'

if [ $RET != '0' ] 
then
  echo ' ERROR AL EJECUTAR PROCESO. \n\n '
fi

#FIN