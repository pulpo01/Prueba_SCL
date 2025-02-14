# Shell para ejecutar proceso Respac (Respuesta de Banco para Pac)
# Febrero del 2003
# G.A.C.   

FILES=${HOME}/FILES/Recaudacion
EXE=${HOME}/EXE/Recaudacion

echo ''
echo '  *****  Pago Automatico Cuenta ***** '

# NOMBRE DEL ARCHIVO A PROCESAR #
echo ''
echo '  Ingrese Nombre del Archivo a Procesar  '
read archivo
echo ''
let ARC=$(echo $archivo|awk '{print length($archivo)}')

    if [ $ARC -lt 1 ] 
    then 
    echo 'LARGO DE ARCHIVO ['$ARC'] DEBE SER MAYOR QUE 1.....!!!!\n\n' 
    exit  
    fi

# CODIGO DE BANCO #
echo ''
echo '  Ingrese Codigo de Banco  '
read banco
echo ''
let BAN=$(echo $banco|awk '{print length($banco)}')

    if [ $BAN -lt 1 ] 
    then 
    echo 'LARGO DEL CODIGO ['$BAN'] DEBE SER MAYOR QUE 1.....!!!!\n\n' 
    exit  
    fi

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


${EXE}/ResPac -u / -l $NIV -f ${FILES}/$archivo -c $banco 
echo '  ARCHIVO DE LOG GENERADO EN : ${HOME}/LOG/Recaudacion/Respac/yyyymmdd\n\n ' 

#FIN
