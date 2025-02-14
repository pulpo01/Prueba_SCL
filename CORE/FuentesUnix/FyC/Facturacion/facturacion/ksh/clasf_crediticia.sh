# Shell para ejecutar proceso de actualizaci�n crediticia.


echo '\n'
echo '  *****  EJECUTA ACTUALIZACION CREDITICIA DE LOS CLIENTES  *****\n ' 


# CODIGO DEL BANCO A PROCESAR #
echo '  Ingrese tipo de ejecuci�n'
echo '  0--> Todos los clientes'
echo '  1--> Cliente unico'
echo '  2--> Rango de Clientes'
cod_tipo=$1
echo $cod_tipo
	if [ $cod_tipo == '0' ] 
	then
		echo ' -----> Proceso se ejecutar� para todos los clientes'
		cliente_ini=$1
		cliente_fin=$1
	fi
	if [ $cod_tipo == 1 ] 
	then
		echo ' -----> Ingrese c�digo de cliente'
		read cliente_ini
		let VAL=$(echo $cliente_ini|awk '{print length($cliente_ini)}')
		if [ $VAL -lt 0 ] 
		then
			echo 'Debe Ingresar c�digo de cliente.'
			exit
		fi
		cliente_fin=$1
	fi
	if [ $cod_tipo == 2 ] 
	then
		echo ' -----> Ingrese c�digo de cliente inicio'
		read cliente_ini
		let VAL=$(echo $cliente_ini|awk '{print length($cliente_ini)}')
		if [ $VAL -lt 0 ] 
		then
			echo 'Debe Ingresar c�digo de cliente inicio.'
			exit
		fi

		echo ' -----> Ingrese c�digo de cliente fin'
		read cliente_fin
		let VAL=$(echo $cliente_fin|awk '{print length($cliente_fin)}')
		if [ $VAL -lt 0 ] 
		then
			echo 'Debe Ingresar c�digo de cliente fin.'
			exit
		fi
	fi
	RESULTADO=$(sqlplus -s / @${XPF_SQL}/clasf_crediticia.sql $cod_tipo $cliente_ini $cliente_fin )
	echo 'SALIDA: [' $RESULTADO ']'
#FIN
