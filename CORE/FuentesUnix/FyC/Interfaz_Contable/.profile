# 
export HOME=/desarrollo/FuentesUnix/FyC/InterfazContable
export COMP_HOME_LOCAL=/desarrollo/FuentesUnix/FyC/
export COMP_HOME=/desarrollo/FuentesUnix
. $COMP_HOME/generales/.profile
################################################################################

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
#
################################################################################
# Definicion del fichero de historico
################################################################################
#
TTY=`tty`; export TTY
TTY=`basename $TTY`
#HISTFILE=${FA_HOME}/tmp/.hist_${TTY}; export HISTFILE
EDITOR=vi; export EDITOR
export COLUMNS=132
export ENV_PRECOMP=$COMP_HOME/generales/generales/cfg/env_precomp_Ora_64.mk
# Informacion del Prompt
PS2='> '
PS1='DsContable > '
# Variables de usuario
#PATH=$PATH:$FA_BIN_PATH:$GE_BIN_PATH/opt/SUNWspro/bin:/opt/SUNWSpro/SW3.1/bin:/usr/ucblib:.
PATH=$PATH:$FA_BIN_PATH:$GE_BIN_PATH:$ALIAS_NM:
#
################################################################################
# Alias
################################################################################
#
alias nm='cd /usr01/desarrollo/factura/nmiranda/shell'
alias cls="clear"
alias dir='ls -la'
alias ll='ls -l'
alias v=gvim

#. $HOME/InterfazContable/pfile/.interfaz

export XPFACTUR_LOG=$COMP_HOME/cobranza/facturacion/log 

