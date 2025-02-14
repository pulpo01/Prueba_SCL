################################################################################
export HOME=/desarrollo/FuentesUnix/FyC/recaudacion
export COMP_HOME_LOCAL=/desarrollo/FuentesUnix/FyC
export COMP_HOME=/desarrollo/FuentesUnix
. $COMP_HOME/generales/.profile
################################################################################

RE_HOME=$COMP_HOME_LOCAL/recaudacion/recaudacion; export RE_HOME 
export RE_CFG_PATH=$RE_HOME/cfg                                                                                               
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
export RE_ENV_PRECOM=$RE_CFG_PATH/env_recauda.mk

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
PS2='> '
PS1='DsRecauda > '
# Variables de usuario
PATH=$PATH:$FA_BIN_PATH:$GE_BIN_PATH:$ALIAS_NM:
#
################################################################################
# Alias
################################################################################

alias cls="clear"
alias dir='ls -la'
alias ll='ls -l'
alias v=gvim

export REC_CFG=$RE_HOME/cfg
export REC_EXE=$HOME/EXE

export src='cd ./recaudacion/src'


##############################################################################
