#makefile Sun 64b
include $(ENV_PRECOMP)
include $(RE_ENV_PRECOM)
include $(REC_CFG)/env_recauda.cal

RMF=rm -f
EXE=./

OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)Traductor.o

all: clean $(EXE)Traductor 

$(EXE)Traductor:$(O)Traductor.o $(OBJETOS_EXT)
	@echo "Generando Traductor..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)Traductor $(O)Traductor.o $(PROLDLIBS)
	@echo "\n"

$(O)Traductor.o: $(C)Traductor.c $(H)Traductor.h
	@echo "Generando Traductor.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)Traductor.o -c $(C)Traductor.c

$(C)Traductor.c: $(PC)Traductor.pc $(H)Traductor.h
	@echo "Generando Traductor.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)Traductor.pc oname=$(C)Traductor.c

clean:
	$(RMF) $(C)Traductor.c 
	$(RMF) $(O)Traductor.o 
	$(RMF) $(EXE)Traductor
