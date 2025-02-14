#--------------------------------------------------------------------
# Inclusion de funcion para imprimir mensajes en pantalla
#--------------------------------------------------------------------
PrintErr()
{
     print "+--------------------------------------------+"
     print "| Mensaje error script :"$cod_proc
     print "+--------------------------------------------+"
     print "| "$@" | "
     print "| Fecha Error : "$(date)" |"
     print "+--------------------------------------------+"
     print "| Fin Mensaje error script :"$cod_proc
     print "+--------------------------------------------+"
}

PrintLog()
{
     print "Script LOG --> "$@
}
