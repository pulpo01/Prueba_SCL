echo 'GENERACION DE REPORTES LEGALES'
echo 'INGRESE PERIODO DESEADO'
echo 'MES : ' 
read mes
echo 'AÑO : ' 
read ano
echo 'USTED INGRESO MES/AÑO ' $mes/$ano
echo ''
echo 'ESTA CORRECTO DICHO PERIODO? :(S/N)'
read resp
  [  $resp != 'S' -a  $resp != 's' ] &&
          { print ADIOS
	    exit
          }
echo 'OK'
echo ''
echo ''
echo 'INICIO EJECUCION DE EXTRACCION DE DATA NO CICLO'
sleep 5

Proc_ExtracNOCICLO -u / -m$mes -a$ano -l5

echo 'INICIO EJECUCION DE GENERADOR DE REPORTES LEGALES'
sleep 5

Proc_GenrepECU -u / -m$mes -a$ano -l5


