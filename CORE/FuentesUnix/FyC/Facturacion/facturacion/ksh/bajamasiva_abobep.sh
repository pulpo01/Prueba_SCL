#==========================================================================#
# Script: para proceso masivo de baja de abonados bepeers                  # 
#==========================================================================#

#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
GLOSA_PROG="GE_BAJA_MASBEP"
USERID=/
#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
RCMD=remsh 
CREATEDIR="mkdir -p"
RM="rm -fr"
SQLPLUS="sqlplus -s"
SQLLOAD="sqlload"
NIVLOG=3

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}  
SQL=${XPF_SQL}
#---------------------------------------------------------------------------#
# Environment Functions                                                     #
#---------------------------------------------------------------------------#
PrintLog()
{
   print "\n$(date +'[%d-%m-%Y][%H:%M:%S]') $@"
}
#---------------------------------------------------------------------------#
# Header                                                                    #
#---------------------------------------------------------------------------#
print
print "======================================================================"
print "DESCRIPCION : " ${GLOSA_PROG} 
print "FECHA       : " "$(date +'%d-%B-%Y')"
print "HORA        : " "$(date +'%X')"
print "======================================================================"

#---------------------------------------------------------------------------#
# Main                                                                      #
#---------------------------------------------------------------------------#

print
PrintLog "  ==>  Comienzo del Proceso de Baja de Abonados Bepeers ......"        
print

${SQLPLUS} -s / @${SQL}/GE_BAJA_MASBEP.sql

RET=$? 
print "SQL de baja retorna: " ${RET}

[ ${RET} -ne 0 ] &&
{
    print
    print "Proceso GE_BAJA_MASBEP.sql termino con problemas."
    print "Valor de retorno:" ${RET}
    print Se cancela ejecucion del script.
    print
    exit 1
}

print
PrintLog "  ==>    Proceso Finalizado OK."
print






