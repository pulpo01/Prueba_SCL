# Shell para ejecutar procesos correo_pac.
# Mayo del 2009
# H.Q.R.   
# Modificado 29/05/2009

EXE=${HOME}/EXE/Recaudacion

echo '\n'
echo '  *****  ENVIO DE CORREOS POR PAGOS AUTOMATICOS DE CUENTAS  *****\n ' 


# CODIGO DEL BANCO A PROCESAR #
echo '  Ingrese Codigo del Banco a Procesar'
read cod_banco

BANCO=$(sqlplus -s / @$HOME/SQL/Recaudacion/Valida_Banco.sql $cod_banco )

    if [ $BANCO != '1' ]
    then
        echo ' Codigo de Banco ['$cod_banco'] es Invalido...!!!\n\n'
        exit
    fi
echo '  OK. Codigo de Banco : '$cod_banco'\n'

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

echo '  EJECUTANDO PROCESO [ correo_pac ] \n ' 
${EXE}/correo_pac -u / -l $nivel -c $cod_banco  
RET=$?
echo '  Resultado correo_pac: '$RET'\n'

if [ $RET != '0' ] 
then
  echo ' ERROR AL EJECUTAR PROCESO. \n\n '
fi

#FIN