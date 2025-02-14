# Shell para ejecutar proceso Traductor de Archivos de Recaudacion Externa
# Julio del 2002
# G.A.C.   (ELCR)
# Ultima Modificacion 08-08-2005 XO-200508040290 Soporte RyC capc

FILES=${HOME}/FILES/Recaudacion
EXE=${HOME}/EXE/Recaudacion
SQL=${HOME}/SQL/Recaudacion

echo ''
echo '  *****  RECAUDACION EXTERNA ***** '

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

# NOMBRE DE LA EMPRESA A PROCESAR #
echo '  Ingrese Nombre de la Empresa a Procesar (largo max. 5) '
read empre

empresa=$(sqlplus -s / @${SQL}/Valida_empresa.sql $empre )
echo '\t\tNOMBRE EMPRESA : '$empresa'\n'

let EMP=$(echo $empresa|awk '{print length($empresa)}')

    if [ $EMP -gt 15 -o $EMP -lt 1 ] 
    then 
    echo 'LARGO DE EMPRESA ['$EMP'] DEBE TENER UN RANGO ENTRE 1 Y 15.....!!!!\n\n' 
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

${EXE}/Traductor -u / -l $NIV -f ${FILES}/$archivo -e $empresa
#echo '  ARCHIVO DE LOG GENERADO EN : /usr01/desarrollo/xpcobros/LOG/Recaudacion/Traductor/yyyymmdd\n\n ' 08-08-2005 XO-200508040290 Soporte RyC capc
echo '  ARCHIVO DE LOG GENERADO EN : /produccion/explotacion/xpcobros/LOG/Recaudacion/Traductor/yyyymmdd\n\n '

${EXE}/Pago_Externo -u / -l $NIV -f ${FILES}/$archivo 
#echo '  ARCHIVO DE LOG GENERADO EN : /usr01/desarrollo/xpcobros/LOG/Recaudacion/Pagos_Ext/yyyymmdd\n\n ' 08-08-2005 XO-200508040290 Soporte RyC capc
echo '  ARCHIVO DE LOG GENERADO EN : /produccion/explotacion/xpcobros/LOG/Recaudacion/Pago_Externo/yyyymmdd\n\n '

#FIN