# This makefile builds the sample programs in $(ORACLE_HOME)/precomp/demo/proc
# and can serve as a template for linking customer applications.
#
# demo_proc64.mk is similar to demo_proc.mk, but is used to build 64-bit client
# executables.

include $(ORACLE_HOME)/precomp/lib/env_precomp.mk
##########################################
#RAO20030131
##########################################
PROCFLAGS=sqlcheck=full SQLCHECK=SEMANTIC ireclen=255 oreclen=255 include=$(H) include=$(GE_INC_PATH)

C=./c/
O=./o/
H=./h/
PC=./pc/

LIBDIR=$(LIBDIR64)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) $(I_SYM)$(ORACLE_HOME)/precomp/public
#INCLUDE=$(I_SYM). $(I_SYM)$(PRECOMPHOME)public $(I_SYM)$(RDBMSHOME)public $(I_SYM)$(RDBMSHOME)demo $(I_SYM)$(PLSQLHOME)public $(I_SYM)$(NETWORKHOME)public

##########################################
