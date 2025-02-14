Maquina=`uname -n`
if test "${Maquina}" = "startel1"
then
   RECEPTOR=$1
   MENSAJE=$2
        cat $XPC_KSH/DestinatarioCelular    |
        while read USUARIO DESTINO MODULO 
        do       
   	       case "$RECEPTOR" in
               todos | TODOS )
                              if test "$MODULO" = "TODOS"
                              then
		                 echo "Enviando Mensaje a Celular : " $DESTINO "Mensaje :" $MENSAJE "Usuario :" $USUARIO
		                 $XPC_KSH/xlmens.sh $DESTINO "$MENSAJE"
                              fi;;
                  BENEFICIOS )	
                              if test "$MODULO" = "BENEFICIOS"
                              then
		                 echo "Enviando Mensaje a Celular : " $DESTINO "Mensaje :" $MENSAJE "Usuario :" $USUARIO
		                $XPC_KSH/xlmens.sh $DESTINO "$MENSAJE"
                              fi;;

		           * ) 	if test "$USUARIO" = "$RECEPTOR" 
	        		then
				   echo "Enviando Mensaje a Celular : " $DESTINO "Mensaje :" $MENSAJE "Usuario :" $USUARIO
                                   $XPC_KSH/xlmens.sh $DESTINO "$MENSAJE"
			           break
			        fi	
               esac
	done
fi
