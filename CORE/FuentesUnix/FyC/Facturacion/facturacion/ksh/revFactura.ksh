archivo=$1
#exten=$(echo $archivo | cut -b14-)
exten=$archivo
awk -f $XPF_AWK/revFactura.awk $archivo 	> revisa_$exten
#grep Error revisa_Factura$exten      	> errors_$exten
