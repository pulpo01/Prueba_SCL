include $(FA_ENV_PRECOM)

EXE=$(XPF_EXE)/

AUTO_CONNECT=YES
NLS_LOCAL=YES

OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/New_Interfact.o
OBJETOS=$(O)infctlpreciclo.o

all: $(EXE)infctlpreciclo 

$(EXE)infctlpreciclo:$(O)infctlpreciclo.o $(OBJETOS_EXT)
	@echo "Generando infctlpreciclo..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)infctlpreciclo $(PROLDLIBS) -g 

$(O)infctlpreciclo.o: $(C)infctlpreciclo.c $(H)infctlpreciclo.h
	@echo "Generando infctlpreciclo.o..\n"
	$(CC) $(CFLAGS) $(FA_INCLUDE) -o $(O)infctlpreciclo.o -c $(C)infctlpreciclo.c -g 

$(C)infctlpreciclo.c: $(PC)infctlpreciclo.pc $(H)infctlpreciclo.h
	@echo "Generando infctlpreciclo.c..\n"
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)infctlpreciclo.pc oname=$(C)infctlpreciclo.c

clean:
	$(RMF) $(C)infctlpreciclo.c 
	$(RMF) $(O)infctlpreciclo.o 

cleanall: clean
	$(RMF) $(EXE)infctlpreciclo

startel1:
	$(RCP) $(PC)infctlpreciclo.pc    factura@startel1:facturacion/src/informes/pc/
	$(RCP) $(H)infctlpreciclo.h      factura@startel1:facturacion/src/informes/h/
