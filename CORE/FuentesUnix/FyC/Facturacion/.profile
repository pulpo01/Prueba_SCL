################################################################################
# 
export HOME=/desarrollo/FuentesUnix/FyC/facturacion
export COMP_HOME_LOCAL=/desarrollo/FuentesUnix/FyC/facturacion
export COMP_HOME=/desarrollo/FuentesUnix 
. $COMP_HOME/generales/.profile
################################################################################
################################################################################
#                                                       
ulimit -s 32768
export IC_ENV_MK=$IC_HOME/cfg/hpux.mk
umask 022
stty erase ^H

export CLASSPATH=/app9/oracle/Product/9.2.0.1.0/JRE/lib/rt.jar
export DBT_MOUNT0=/app9
export ORACLE_BASE=$DBT_MOUNT0/oracle
export ORACLE_HOME=$ORACLE_BASE/Product/9.2.0.1.0
PATH=/usr/bin:/usr/ccs/bin:/usr/contrib/bin:/opt/SUNWspro/bin:/usr/ucb:/usr/local/bin:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib32:$PATH
export LD_LIBRARY_PATH_64=$ORACLE_HOME/lib:$PATH
export NLS_LANG=AMERICAN_AMERICA.WE8DEC
export ORA_NLS=$ORACLE_HOME/ocommon/nls/admin/data
export ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
export TNS_ADMIN=$ORACLE_HOME/network/admin
export TERM=vt100
export COLUMNS=132
umask 022
export ORACLE_SID=cercol
export TWO_TASK=cercol

ulimit -s 32768
export IC_ENV_MK=$IC_HOME/cfg/hpux.mk
umask 022
stty erase ^H
# Definicion del fichero de historico
TTY=`tty`; export TTY
TTY=`basename $TTY`
#HISTFILE=${FA_HOME}/tmp/.hist_${TTY}; export HISTFILE
EDITOR=vi; export EDITOR
export COLUMNS=132

# Informacion del Prompt
PS1='DsFactura > '
# Variables de usuario
PATH=$PATH:$FA_BIN_PATH:$GE_BIN_PATH:$ALIAS_NM:
#
################################################################################
# Alias
################################################################################

alias cls="clear"
alias dir='clear; ls -alrt; pwd'
alias ll='ls -l'
alias v=gvim
alias mm='make clean; make all'
export USERPASS=ds_factura/telefonica
cd $HOME
. /desarrollo/FuentesUnix/FyC/facturacion/facturacion/pfile/.xpfactur

