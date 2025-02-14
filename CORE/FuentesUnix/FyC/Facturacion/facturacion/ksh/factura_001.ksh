typeset -i iCont
param1=$1
iCont=1
while :
do
    print $(date) "Ejecutando shell factura_001.ksh [" $param1 "] ==> "  $iCont
    iCont=$iCont+1
    sleep 1
    if [ $iCont -gt 20 ]
    then
        exit 0
    fi
done
