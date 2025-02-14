include $(FA_ENV_PRECOM)

CPF=cp -f
RCP=@echo rcp -p

EXE=$(XPF_EXE)/

AUTO_CONNECT=YES
NLS_LOCAL=YES

OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)infctlfactur.o

all: $(EXE)infctlfactur 

$(EXE)infctlfactur:$(O)infctlfactur.o $(OBJETOS_EXT)
	@echo "Generando infctlfactur..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)infctlfactur $(O)infctlfactur.o $(PROLDLIBS)

$(O)infctlfactur.o: $(C)infctlfactur.c $(H)infctlfactur.h
	@echo "Generando infctlfactur.o..\n"
	$(CC) $(CFLAGS) $(FA_INCLUDE) -o $(O)infctlfactur.o -c $(C)infctlfactur.c

$(C)infctlfactur.c: $(PC)infctlfactur.pc $(H)infctlfactur.h
	@echo "Generando infctlfactur.c..\n"
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(PC)infctlfactur.pc oname=$(C)infctlfactur.c

clean:
	$(RMF) $(C)infctlfactur.c 
	$(RMF) $(O)infctlfactur.o 

cleanall: clean
	$(RMF) $(EXE)infctlfactur

