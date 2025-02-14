
# @(#) $Revision: 74.2 $    

# Default (example of) system-wide profile file (/usr/bin/sh initialization).
# This should be kept to the bare minimum every user needs.

# Ignore HUP, INT, QUIT now.

        trap "" 1 2 3                           
        
# Set the default paths - Do NOT modify these.
# Modify the variables through /etc/PATH and /etc/MANPATH 

        PATH=/usr/bin:/usr/ccs/bin:/usr/contrib/bin:/opt/SUNWspro/bin:/usr/ucb:/usr/local/bin
        MANPATH=/usr/share/man:/usr/contrib/man:/usr/local/man:/opt/SUNWspro/man

# Insure PATH contains either /usr/bin or /sbin (if /usr/bin is not available).

        if [ ! -d /usr/sbin ]
        then
                PATH=$PATH:/sbin

        else    if [ -r /etc/PATH ]
                then

                # Insure that $PATH includes /usr/bin .  If /usr/bin is 
                # present in /etc/PATH then $PATH is set to the contents 
                # of /etc/PATH.  Otherwise, add the contents of /etc/PATH 
                # to the end of the default $PATH definition above.

                        grep -q -e "^/usr/bin$" -e "^/usr/bin:" -e ":/usr/bin:"\
                                -e ":/usr/bin$" /etc/PATH
                        if [ $? -eq 0 ]
                        then
                                PATH=`cat /etc/PATH`
                        else
                                PATH=$PATH:`cat /etc/PATH`
                        fi
                fi
        fi

        # Los directorios de oraenv de la Ultra y la HP
        PATH=$PATH:/opt/bin:/usr/local/bin
        export PATH

# Set MANPATH to the contents of /etc/MANPATH, if it exists.

        if [ -r /etc/MANPATH ]
        then
                MANPATH=`cat /etc/MANPATH`
        fi

        export MANPATH

# Set the TIMEZONE      

        if [ -r /etc/TIMEZONE ]
        then
           . /etc/TIMEZONE      
        else
            TZ=MST7MDT               # change this for local time.  
            export TZ
        fi

# Be sure that VUE does not invoke tty commands

   if [ ! "$VUE" ]; then
        stty erase "^?" kill "^U" intr "^C" eof "^D"
        stty hupcl ixon ixoff
        tabs
        echo
        TERM=vt100
        export TERM
        echo "Value of TERM has been set to \"$TERM\". "

        EDITOR=vi
        export EDITOR

   # Set up shell environment:

        trap "echo logout" 0

   # This is to meet legal requirements...

#       cat /etc/copyright

   # Message of the day

        if [ -r /etc/motd ]
        then
                cat /etc/motd
        fi

   # Notify if there is mail

        if [ -f /usr/bin/mail ]
        then
                if mail -e
                then    echo "You have mail."
                fi
        fi

   # Notify if there is news

        if [ -f /usr/bin/news ]
        then news -n
        fi

   # Change the backup tape

#       if [ -r /tmp/changetape ]
#       then    echo "\007\nYou are the first to log in since backup:"
#               echo "Please change the backup tape.\n"
#               rm -f /tmp/changetape
#       fi

   fi                                           # if !VUE

# Leave defaults in user environment.

   trap 1 2 3                   
#
#
export CLASSPATH=/app/oracle/OraHome1/JRE/lib/rt.jar
export DBT_MOUNT0=/app
export ORACLE_BASE=$DBT_MOUNT0/oracle
export ORACLE_HOME=$ORACLE_BASE/OraHome1
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH:$PATH
export NLS_LANG=AMERICAN_AMERICA.WE8DEC
export ORA_NLS=$ORACLE_HOME/ocommon/nls/admin/data
export ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
export TNS_ADMIN=$ORACLE_HOME/network/admin
export TERM=vt100
export COLUMNS=132
umask 022

export PATH=/usr/bin:/etc:/usr/openwin/bin:/usr/ccs/bin:$ORACLE_HOME/bin:/opt/SUNWspro/bin:/usr/ucb:/usr/local/bin:.

PS1='$PWD$PS2'
unset ORACLE_SID
unset TWO_TASK

################################################################################
 
export COMP_HOME=/usr05/PVCS
################################################################################
# Variables de Entorno para la Aplicacion Siscel

GE_HOME=$COMP_HOME/dsgeneral; export GE_HOME

# General

export GE_INC_PATH=$GE_HOME/generales/generales/inc
export GE_BIN_PATH=$GE_HOME/generales/generales/bin
export GE_LIB_PATH=$GE_HOME/generales/generales/lib
export GE_CFG_PATH=$GE_HOME/generales/generales/cfg

export PATH=$PATH:$GE_BIN_PATH
 
export ORACLE_SID=HELENA
export TWO_TASK=HELENA
#export ORACLE_SID=DEIMOS
#

#----------------------------------------------------------------#
#  Para indicar si se desea trabajar con 32 o 64 bits            #
#----------------------------------------------------------------#
export ENV_PRECOMP=${GE_CFG_PATH}/env_precomp_Ora_64.mk

stty erase ^H
alias ll='ls -l'

