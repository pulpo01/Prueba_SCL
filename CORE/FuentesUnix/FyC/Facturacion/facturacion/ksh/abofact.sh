echo ' INGRESE FECHA DE PROCESO formato DDMMAA'
read fecha
echo ' USTED INGRESO FECHA ' $fecha
echo ''
echo ' ESTA CORRECTA LA FECHA INGRESADA     ???? :(S/N)'
read resp
  [  $resp != 'S' -a  $resp != 's' ] &&
	  { print CHAAAAOOOOOO
			      exit
								      }
echo ' OK,   ESPERE MIENTRAS PROCESO.'
                     sleep 5

#
sqlplus / @  $HOME/facturacion/sql/antes_abofact.sql ${fecha}
#
abofact -u / -c $fecha -l 3
#
sqlplus / @ $HOME/facturacion/sql/despues_abofact.sql ${fecha}
