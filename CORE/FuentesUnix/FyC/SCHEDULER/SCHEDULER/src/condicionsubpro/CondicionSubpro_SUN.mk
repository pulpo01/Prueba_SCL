#
# Makefile original: makefile.old
# Fecha y hora de generacion: 2002-05-13 11:50:37
#
NOMBRE=CondicionSubpro
#MODO=ANSI
MODO=ORACLE

#include $(GE_CFG_PATH)/env_precomp_Ora_64.mk
include $(INCLUDE_64)

C  =./c/
O  =./o/
H  =../h/
PC =./pc/
EXE=../exe/

CPF=cp -f
RMF=rm -f
AR +=-c -r
CC =cc

APLICACION=$(EXE)$(NOMBRE)
OBJETO_LOCAL=$(O)$(NOMBRE).o
INTERMEDIO_C=$(C)$(NOMBRE).c
FUENTE_PC=$(PC)$(NOMBRE).pc
CABECERA_H=$(H)$(NOMBRE).h

USUARIO=scheduler/scheduler
#USUARIO=ds_schedul/telefonica
#USUARIO=scheduler/scheduler@tol_deimos
INCLUDE=$(I_SYM)$(ORACLE_HOME)/sqllib/public $(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H)
PROCFLAGS=ireclen=255 oreclen=255 sqlcheck=full userid=$(USUARIO) SQLCHECK=SEMANTICS
PROCINCLUDE=include=$(H) 


all: $(APLICACION)


$(APLICACION): $(OBJETO_LOCAL)
	@echo "Generando :" $(APLICACION)
	$(CC) -o $(APLICACION)  $(CFLAGS) $(OBJETO_LOCAL) \
		-L$(ORACLE_HOME)/lib \
		-L$(ORACLE_HOME)/network/lib \
		-L$(ORACLE_HOME)/rdbms/lib $(PROLDLIBS)

$(OBJETO_LOCAL): $(INTERMEDIO_C)
	@echo "Generando : " $(OBJETO_LOCAL)
	$(CC) -o $(OBJETO_LOCAL) $(CFLAGS) \
		$(INCLUDE) $(SQLPUBLIC) -c $(INTERMEDIO_C)

$(INTERMEDIO_C):
	@echo "Generando : " $(INTERMEDIO_C)
	$(PROC) $(PROCFLAGS) $(PROCINCLUDE) mode=$(MODO) \
		iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)

clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)

install:
	cp -f $(APLICACION) $(SCH_PRO)/
