################################################################################
# 
export HOME=/desarrollo/FuentesUnix/FyC/scheduler
export COMP_HOME_LOCAL=/desarrollo/FuentesUnix
export COMP_HOME=/desarrollo/FuentesUnix
. $COMP_HOME/generales/.profile
################################################################################
################################################################################

export PATH=/usr/bin:/etc:/usr/openwin/bin:/usr/ccs/bin:bin:/opt/SUNWspro/bin:/usr/ucb:/usr/local/bin:.

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

umask 022
alias las='ls -las'
alias dir='ls -las'
alias cls='clear'
alias l='ls -ltr'

PS1='DsScheduler > '

#--------------------------------------------------
# Creacion de ambiente - VARIABLES S_C_H
#--------------------------------------------------
AMBIENTE=/desarrollo/FuentesUnix/FyC/scheduler
export SCH_PRO=$AMBIENTE/scheduler/exe
export TOL_PRO=/desarrollo/FuentesUnix/tol/tel/tasacion
export PRO_PRO=/desarrollo/FuentesUnix/tol/propagacion
. $COMP_HOME/FyC/roaming/.xpvarcib
. $COMP_HOME/FyC/roaming/.xpvartap
export COD_USUARIOSCH=scheduler
export PAS_USUARIOSCH=scheduler
