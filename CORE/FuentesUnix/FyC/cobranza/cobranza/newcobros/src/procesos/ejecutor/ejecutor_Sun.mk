# Makefile original: makefile.old
# Fecha y hora de generacion: 2002-05-13 11:50:37
# Modificado el 18-10-2004 GAC
# Modificado el 07-02-2006 capc Incidencia RA-200512190339 Soporte RyC

NOMBRE=ejecutor
MODO=Oracle

include $(ENV_PRECOMP)
include $(XPC_CFG)/env_morosos.cal

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=./

LIB_DINA=-lAcciones

APLICACION=$(EXE)$(NOMBRE)
OBJETO_LOCAL=$(O)$(NOMBRE).o
INTERMEDIO_C=$(C)$(NOMBRE).c
FUENTE_PC=$(PC)$(NOMBRE).pc
CABECERA_H=$(H)$(NOMBRE).h

PROCINCLUDE=include=$(H) include=$(XPC_INC)
PROCFLAGS=ireclen=255 oreclen=255 sqlcheck=full  SQLCHECK=SEMANTICS THREADS=YES code=ansi_c
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(ORACLE_HOME)/sqllib/public $(I_SYM)$(H) $(I_SYM)$(XPC_INC)
LIB_PROC=$(LIB_GEN) $(LIB_PRO) 

all: clean $(APLICACION) install

$(APLICACION): $(OBJETO_LOCAL)
	$(CC) $(CFLAGS) -o $(APLICACION) $(OBJETO_LOCAL) $(LIB_PROC) -L$(XPC_LIB)/ $(PROLDLIBS) -lthread -D_REENTRANT -Dynamic $(LIB_DINA)

$(OBJETO_LOCAL): $(INTERMEDIO_C)
	$(CC) $(CFLAGS) -o $(OBJETO_LOCAL) -c $(INTERMEDIO_C)

$(INTERMEDIO_C):
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) mode=$(MODO) iname=$(FUENTE_PC) oname=$(INTERMEDIO_C) 

clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)
	$(RMF) $(APLICACION)

install: 
	$(CPF) $(APLICACION) $(XPC_EXE)
