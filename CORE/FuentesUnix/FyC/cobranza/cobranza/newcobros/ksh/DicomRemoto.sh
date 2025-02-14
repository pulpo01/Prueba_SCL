szIP=$1
szPath=$2
szNumIdentAux=$3
szNumContrato=$4
x="$(remsh ${szIP} ${szPath} ${szNumIdentAux} ${szNumContrato})"
exit $x
