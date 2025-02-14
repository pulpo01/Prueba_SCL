# Definicion del fichero de historico
PATH=/usr/bin:/usr/ucb:/etc:.
TTY=`tty`; export TTY
TTY=`basename $TTY`
#HISTFILE=${FA_HOME}/tmp/.hist_${TTY}; export HISTFILE
EDITOR=vi; export EDITOR
export COLUMNS=132
ulimit -s 16000

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

export ORACLE_SID=CERCOL
export TWO_TASK=CERCOL
export ORAUSER=ds_comision
export ORAPASS=telefonica

alias ll='ls -ls'

export COMP_HOME=/desarrollo/FuentesUnix
export      HOME=/desarrollo/FuentesUnix/FyC/comisiones

cd $HOME

# Variables de Entorno para la Aplicacion Siscel

AL_HOME=$COMP_HOME/almacen/unix; export AL_HOME
GA_HOME=$COMP_HOME/xpabonad/unix; export GA_HOME
CA_HOME=$COMP_HOME/sac/unix; export CA_HOME
IC_HOME=$COMP_HOME/xpcentra/unix; export IC_HOME
GE_HOME=$COMP_HOME/siscel/general; export GE_HOME
TA_HOME=$COMP_HOME/xptarifi/ccscl; export TA_HOME
CO_HOME=$COMP_HOME/xpcobros/unix; export CO_HOME
VE_HOME=$COMP_HOME/ventas/unix; export VE_HOME
MI_HOME=$COMP_HOME/migracion/unix; export MI_HOME
CE_HOME=$COMP_HOME/e-commer; export CE_HOME

FA_HOME=$COMP_HOME/FyC/facturacion; export FA_HOME
CM_HOME=$COMP_HOME/FyC/comisiones; export CM_HOME

# Comisiones

export XPCOMIS_PROC=${HOME}/comisiones

export XPCM_KSH=${XPCOMIS_PROC}/ksh
export XPCM_EXE=${XPCOMIS_PROC}/exe
export XPCM_CTL=${XPCOMIS_PROC}/ctl
export XPCM_TMP=${XPCOMIS_PROC}/tmp
export XPCM_SQL=${XPCOMIS_PROC}/sql
export XPCM_CFG=${XPCOMIS_PROC}/cfg
export XPCM_AWK=${XPCOMIS_PROC}/awk
export XPCM_DAT=${XPCOMIS_PROC}/dat
export XPCM_LOG=${XPCOMIS_PROC}/log
export XPCM_LST=${XPCOMIS_PROC}/lst
export XPCM_LIB=${XPCOMIS_PROC}/lib
export XPCM_INC=${XPCOMIS_PROC}/inc


export XPCM_INSTALL=${XPCOMIS_PROC}/install

#--------------------------------------------------------#
# Para compatibilidad con sistemas antiguos              #
#--------------------------------------------------------#
export XPCOMISI_LOG=${XPCM_LOG}
export XPCOMISI_DAT=${XPCM_DAT}
export XPCOMISI_LST=${XPCM_LST}
#--------------------------------------------------------#

export PATH=$PATH:${XPCM_KSH}:${XPCM_EXE}:${XPCM_AWK}:${XPCM_INSTALL}:${XPCM_INC}:${XPCM_LIB}

# Comisiones

export CM_CFG_PATH=$CM_HOME/cfg
export CM_INC_PATH=$CM_HOME/inc
export CM_BIN_PATH=$CM_HOME/exe
export CM_LIB_PATH=$CM_HOME/lib

# Facturacion
export FA_CFG_PATH=$FA_HOME/facturacion/cfg
export FA_INC_PATH=$FA_HOME/facturacion/inc
export FA_BIN_PATH=$FA_HOME/facturacion/exe
export FA_LIB_PATH=$FA_HOME/facturacion/lib


# Ventas

export VE_INC_PATH=$VE_HOME/include
export VE_BIN_PATH=$VE_HOME/bin
export VE_LIB_PATH=$VE_HOME/lib

# Cobros

export CO_INC_PATH=$CO_HOME/include
export CO_BIN_PATH=$CO_HOME/bin
export CO_LIB_PATH=$CO_HOME/lib

# Tarificacion

export TA_SRC_CELULAR=$TA_HOME/src/celular
export TA_SRC_BEEPER=$TA_HOME/src/beeper
export TA_SRC_TREK=$TA_HOME/src/trek
export TA_SRC_TRUNKING=$TA_HOME/src/trunking
export TA_INC_PATH=$TA_HOME/include
export TA_BIN_PATH=$TA_HOME/bin
export TA_LIB_PATH=$TA_HOME/lib
export TA_ALTER_FICH=.

export TA_ALTER_LOGERR=$TA_HOME/log/Tasador/celular
export PATH_TA_LOGERR=$TA_HOME/log/Tasador
export PATH_TA_CONFIG=$TA_HOME/cfg/Tasador
export TA_DATA=$PATH_TA_LOGERR/celular/data
export XPT_CFG=$TA_HOME/cfg/Tasador

# General
unset GE_HOME
export GE_HOME=/home_its/its_dsgeneral/generales/generales

export GE_INC_PATH=$GE_HOME/inc
export GE_BIN_PATH=$GE_HOME/bin
export GE_LIB_PATH=$GE_HOME/lib
export GE_CFG_PATH=$GE_HOME/cfg

# Sac

export CA_INC_PATH=$CA_HOME/include
export CA_BIN_PATH=$CA_HOME/bin
export CA_LIB_PATH=$CA_HOME/lib

# Abonados

export GA_INC_PATH=$GA_HOME/include
export GA_CFG_PATH=$GA_HOME/cfg
export GA_BIN_PATH=$GA_HOME/bin
export GA_LIB_PATH=$GA_HOME/lib
export CAMINO_FORMS_GA=$GA_HOME/forms/frm;
export CAMINO_FORMS_GE=$GA_HOME/forms/frm;

# Almacen

export AL_INC_PATH=$AL_HOME/include
export AL_BIN_PATH=$AL_HOME/bin
export AL_LIB_PATH=$AL_HOME/lib

# Centrales

export IC_INC_PATH=$IC_HOME/include
export IC_BIN_PATH=$IC_HOME/bin
export IC_LIB_PATH=$IC_HOME/lib
export IC_ENV_MK=$IC_HOME/cfg/hpux.mk

# Migracion

export MI_INC_PATH=$MI_HOME/include
export MI_BIN_PATH=$MI_HOME/bin
export MI_LIB_PATH=$MI_HOME/lib
#
export PATH=$PATH:$GE_BIN_PATH



# VARIABLES PRODUCCION
export XPCOMIS_PROC=${HOME}/comisiones
export XPCM_KSH=${XPCOMIS_PROC}/ksh
export XPCM_EXE=${XPCOMIS_PROC}/exe
export XPCM_CTL=${XPCOMIS_PROC}/ctl
export XPCM_TMP=${XPCOMIS_PROC}/tmp
export XPCM_SQL=${XPCOMIS_PROC}/sql
export XPCM_CFG=${XPCOMIS_PROC}/cfg
export XPCM_AWK=${XPCOMIS_PROC}/awk
#export TOOLS_AWK=${XPCOMIS_PROC}/awk
export XPCM_DAT=${XPCOMIS_PROC}/dat
export XPCM_LOG=${XPCOMIS_PROC}/log
export XPCM_LST=${XPCOMIS_PROC}/lst
export XPC_LOG=$COMP_HOME/xpcobros/beneficios/log
export XPCO_EXE=$COMP_HOME/xpcobros/EXE/Interfaz_Contable
export XPC_KSH=$COMP_HOME/xpcobros/newcobros/ksh
######
export XPV_KSH=$COMP_HOME/xpabonad/ventas/ksh
export XPV_CFG=$COMP_HOME/xpabonad/ventas/cfg
#--------------------------------------------------------#
# Para compatibilidad con sistemas antiguos              #
#--------------------------------------------------------#
export XPCOMISI_LOG=${XPCM_LOG}
export XPCOMISI_DAT=${XPCM_DAT}
export XPCOMISI_LST=${XPCM_LST}
#--------------------------------------------------------#
export PATH=$PATH:${XPC_KSH}:${XPCM_KSH}:${XPCM_EXE}:${XPCO_EXE}:${XPCM_AWK}:${XPCM_INSTALL}
stty erase
#----------------------------------------------------------------#
#  Para indicar si se desea trabajar con 32 o 64 bits            #
#----------------------------------------------------------------#
export ENV_PRECOMP=${GE_CFG_PATH}/env_precomp_Ora_64.mk
stty erase ^H

# Informacion del Prompt

PS2='> '
PS1='ds_comision$PWD$PS2 '
cd $HOME
alias psx='ps -fea | grep xpcomisi'
alias psz='ps -u xpcomisi'
alias dir='ls -ll'

#unset ORACLE_SID
#unset TWO_TASK
#unset USERPASS


export CM_CFG_PATH=$CM_HOME/comisiones/cfg
export CM_INC_PATH=$CM_HOME/comisiones/inc
export CM_BIN_PATH=$CM_HOME/comisiones/exe
export CM_LIB_PATH=$CM_HOME/comisiones/lib
#
export COM_ENV_PRECOM=$CM_CFG_PATH/env_comision.mk
#

alias mm='make clean; make all'

