#
# Makefile original: CO_oracle.mk.old
# Fecha y hora de generacion: 2002-05-13 17:43:35
#

NOMBRE=CO_oracle
MODO=Oracle

include $(ENV_PRECOMP)
include $(XPC_CFG)/env_morosos.cal

C=./c
O=./o
H=./h
PC=./pc

OBJETO_LOCAL=$(O)/$(NOMBRE).o
INTERMEDIO_C=$(C)/$(NOMBRE).c
FUENTE_PC=$(PC)/$(NOMBRE).pc

PROCINCLUDE=include=$(XPC_INC)
PROCFLAGS=ireclen=255 oreclen=255 sqlcheck=full SQLCHECK=SEMANTICS  code=ansi_c
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(ORACLE_HOME)/sqllib/public $(I_SYM)$(XPC_INC)

all: clean compila addlib

compila:
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) mode=$(MODO) iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)
	$(CCc) $(CFLAGS) $(INTERMEDIO_C) -o $(OBJETO_LOCAL)

addlib:
	$(AR) $(XPC_LIB)/libGenerales.a $(OBJETO_LOCAL)
	$(RMF) $(OBJETO_LOCAL)

clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)
