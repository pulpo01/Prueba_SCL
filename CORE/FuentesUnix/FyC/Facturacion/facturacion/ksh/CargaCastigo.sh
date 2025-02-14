#==========================================================================#
# Script: para proceso masivo de Carga Tabla FA_CASTIGO                    # 
#==========================================================================#

#---------------------------------------------------------------------------#
# Hard information                                                          #
#---------------------------------------------------------------------------#
GLOSA_PROG="CargaCastigo"
USERID=/

#---------------------------------------------------------------------------#
# Defines & Macros                                                          #
#---------------------------------------------------------------------------#
SQLLOAD="sqlload"
NIVLOG=3

#---------------------------------------------------------------------------#
# Environment                                                               #
#---------------------------------------------------------------------------#
KSH=${XPF_KSH}  
CTL=${XPF_CTL}
DAT=${XPF_DAT}
LOG=${XPF_LOG}
#---------------------------------------------------------------------------#
# Machine detection                                                         #
#---------------------------------------------------------------------------#
MACHINE="$(uname -n)"

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
print "MAQUINA     : " ${MACHINE}
print "FECHA       : " "$(date +'%d-%B-%Y')"
print "HORA        : " "$(date +'%X')"
print "======================================================================"

#---------------------------------------------------------------------------#
# Main                                                                      #
#---------------------------------------------------------------------------#

print
PrintLog "  ==>  Comienzo del Proceso de Carga Tabla FA_CASTIGOS ......"        
print

${SQLLOAD} ${USERID} control=${XPF_CTL}/castigos.ctl data=${XPF_DAT}/castigos/castigos.txt errors=999 log=${XPF_LOG}/castigos/castigos.log bad=${XPF_DAT}/castigos/castigos.bad   

RET=$? 
print "SQLLOAD de baja retorna: " ${RET}

[ ${RET} -ne 0 ] &&
{
    print
    print "Proceso CargaCastigo termino con problemas."
    print "Valor de retorno:" ${RET}
    print Se cancela ejecucion del script.
    print
    exit 1
}

print
PrintLog "  ==>    Proceso Finalizado OK."
print






