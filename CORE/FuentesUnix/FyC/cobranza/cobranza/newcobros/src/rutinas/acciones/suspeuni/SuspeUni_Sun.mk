#
# Makefile original: makefile.old
# Fecha y hora de generacion: 2002-05-20 18:04:28
#
NOMBRE=SuspeUni

include $(ENV_PRECOMP)
include $(XPC_CFG)/env_morosos.cal

C=./c/
O=./o/
H=./h/
PC=./pc/

LIB_DINAMICA=lib$(NOMBRE).so
OBJETO_LOCAL=$(O)$(NOMBRE).o
INTERMEDIO_C=$(C)$(NOMBRE).c
FUENTE_PC=$(PC)$(NOMBRE).pc
CABECERA_H=$(H)$(NOMBRE).h

PROCINCLUDE=include=$(H) include=$(XPC_INC)
PROCFLAGS=ireclen=255 oreclen=255 sqlcheck=full  SQLCHECK=SEMANTICS THREADS=YES
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(XPC_INC)
LIB_PROC=$(LIB_GEN) $(LIB_ACC)

all: clean compila addlib 

compila:
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) mode=Oracle code=ansi_c iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)
	$(CCc) $(CFLAGS) -o $(OBJETO_LOCAL) $(LIB_ACC) $(LIB_GEN) -c $(INTERMEDIO_C)
	$(CC) -G -o $(LIB_DINAMICA) $(OBJETO_LOCAL) $(LDSTRING) $(CFLAGS) $(CFLAGSX) $(LIB_PROC)

addlib :
	$(CPF) $(LIB_DINAMICA) $(XPC_LIB)
	$(RMF) $(OBJETO_LOCAL)
	$(RMF) $(LIB_DINAMICA)
 
clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)
	$(RMF) $(XPC_LIB)/$(LIB_DINAMICA)