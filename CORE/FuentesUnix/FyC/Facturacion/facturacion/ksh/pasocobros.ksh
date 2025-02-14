#########################################################
#
#          INTERCALACION DE DOCUMENTOS
#
# por Jreta
#
#  usa como parametros intercativo el tipo de documento
#
###########################################################
echo ' INGRESE TIPO DE DOCUMENTO A INTERCALAR '
echo ''
read docum
###########################
echo ' USTED INGRESO :'$docum
echo ' ESTA CORRECTO EL TIPO DE DOCUMENTO INGRESADO  ???? :(S/N)'
read resp
  [  $resp != 'S' -a  $resp != 's' ] &&
      { print CHAAAAOOOOOO
	    exit
		    }
			    echo ' OK,   ESPERE MIENTRAS PROCESO.'
				    sleep 5

pasocobros -u / -maxivo -d $docum  -l 6 > inter_$docum.out 2>&1
