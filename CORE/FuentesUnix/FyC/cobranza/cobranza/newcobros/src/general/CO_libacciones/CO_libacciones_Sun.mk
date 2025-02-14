# Fecha y hora de generacion: 2004-10-15 09:30:00
# GAC
# Modificado el 07-02-2006 capc Incidencia RA-200512190339 Soporte RyC

NOMBRE=CO_libacciones
MODO=Oracle

include $(ENV_PRECOMP)
include $(XPC_CFG)/env_morosos.cal

C=./c
O=./o
H=./h
PC=./pc

OBJ_EXTERNOS=$(XPC_LIB)/AsigCobExt.o $(XPC_LIB)/AsigCobJud.o $(XPC_LIB)/AsigDicom.o $(XPC_LIB)/AsigEJecCobCen.o \
			 $(XPC_LIB)/AsigEJecCobSuc.o $(XPC_LIB)/AsigEjecPerfil.o $(XPC_LIB)/Baja.o $(XPC_LIB)/Bloquea.o \
			 $(XPC_LIB)/camnum.o $(XPC_LIB)/CartaCob.o $(XPC_LIB)/CtaFinal.o $(XPC_LIB)/DesAsigCobExt.o \
			 $(XPC_LIB)/DesAsigDicom.o $(XPC_LIB)/DesBloquea.o $(XPC_LIB)/DesEnrutamiento.o $(XPC_LIB)/Enrutamiento.o \
			 $(XPC_LIB)/MensAviso.o $(XPC_LIB)/MensCorta.o $(XPC_LIB)/MensFact.o $(XPC_LIB)/NewMensCorta.o \
			 $(XPC_LIB)/OutBound.o $(XPC_LIB)/PreBaja.o $(XPC_LIB)/RepBi.o $(XPC_LIB)/Repone.o $(XPC_LIB)/RevBaja.o \
			 $(XPC_LIB)/SuspBeep.o $(XPC_LIB)/SuspeTot.o $(XPC_LIB)/SuspeUni.o

LIB_DINAMICA=libAcciones.so
OBJETO_LOCAL=$(O)/$(NOMBRE).o
INTERMEDIO_C=$(C)/$(NOMBRE).c
FUENTE_PC=$(PC)/$(NOMBRE).pc

PROCINCLUDE=include=$(XPC_INC)
PROCFLAGS=ireclen=255 oreclen=255 sqlcheck=full  SQLCHECK=SEMANTICS  THREADS=YES code=ansi_c
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(ORACLE_HOME)/sqllib/public $(I_SYM)$(XPC_INC)

all: clean compila addlib

compila:
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) mode=$(MODO) iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)
	$(CCc) $(CFLAGS) $(INTERMEDIO_C) -o $(OBJETO_LOCAL) $(LIB_GEN)

	$(CCc) $(CFLAGS) -o $(OBJETO_LOCAL) $(LIB_GEN) -c $(INTERMEDIO_C)
	$(CC) -G -o $(LIB_DINAMICA) $(OBJETO_LOCAL) $(OBJ_EXTERNOS) $(LDSTRING) $(CFLAGS) $(CFLAGSX) $(LIB_PROC)

addlib:
	$(CPF) $(LIB_DINAMICA) $(XPC_LIB)
	$(RMF) $(OBJETO_LOCAL)

clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)

