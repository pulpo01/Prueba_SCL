#
# Makefile original: makefile.old
# Fecha y hora de generacion: 2002-05-20 18:04:28
#
NOMBRE=CtaFinal

include $(ENV_PRECOMP)
include $(XPC_CFG)/env_morosos.cal

C=./c/
O=./o/
H=./h/
PC=./pc/

OBJETO_LOCAL=$(O)$(NOMBRE).o
INTERMEDIO_C=$(C)$(NOMBRE).c
FUENTE_PC=$(PC)$(NOMBRE).pc
CABECERA_H=$(H)$(NOMBRE).h

PROCINCLUDE=include=$(H) include=$(XPC_INC)
PROCFLAGS=ireclen=255 oreclen=255 sqlcheck=full  SQLCHECK=SEMANTICS THREADS=YES code=ansi_c
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(XPC_INC)
LIB_PROC=$(LIB_PRO) $(LIB_GEN)

all: clean compila addlib 

compila:
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) mode=Oracle iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)
	$(CCc) $(CFLAGS) -o $(OBJETO_LOCAL) $(LIB_PROC) -c $(INTERMEDIO_C)

addlib :
	$(CPF) $(OBJETO_LOCAL) $(XPC_LIB)
	$(RMF) $(OBJETO_LOCAL)
	$(RMF) $(LIB_DINAMICA)

clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)
