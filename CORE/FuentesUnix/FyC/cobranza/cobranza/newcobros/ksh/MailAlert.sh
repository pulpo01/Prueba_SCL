#!/bin/ksh
if test "${Maquina}" = "sclbatch" 
then
   DESTINO=$1
   ASUNTO=$2
   MENSAJE="$3. Avisar a la Brevedad a 55-5805-0217"
   MENSAJECEL="$3"
   echo $MENSAJE
   $XPC_KSH/callxlmens.sh $DESTINO "$MENSAJECEL"
fi

