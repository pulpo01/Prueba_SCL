Maquina=$(uname -n)
XPC_KSH="/users1/proyectos/siscel/startel/factura/facturacion/ksh"
if test "${Maquina}" = "startel1"
then
   DESTINO=$1
   ASUNTO=$2
   MENSAJE=$3

   if test "$DESTINO" = "todos" -o "$DESTINO" = "TODOS"
   then
      for DESTINO in $(cat ${XPC_KSH}/DestinatarioCorreo.txt) 
      do
#         print "Enviando Mail a : " $DESTINO " Asunto : " $ASUNTO " Mensaje : " $MENSAJE
          ${XPC_KSH}/mailmsg.sh $DESTINO "$ASUNTO" "$MENSAJE"
      done
   else
#      print "Enviando Mail a : " $DESTINO " Asunto : " $ASUNTO " Mensaje : " $MENSAJE
       ${XPC_KSH}/mailmsg.sh $DESTINO "$ASUNTO" "$MENSAJE"
   fi
fi
