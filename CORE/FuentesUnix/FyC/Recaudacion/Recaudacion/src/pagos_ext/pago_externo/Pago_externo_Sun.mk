#makefile Sun 64b
include $(ENV_PRECOMP)
include $(RE_ENV_PRECOM)
include $(REC_CFG)/env_recauda.cal

RMF=rm -f
EXE=./

OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)Pago_Externo.o

all: clean $(EXE)Pago_Externo 

$(EXE)Pago_Externo:$(O)Pago_Externo.o $(OBJETOS_EXT)
	@echo "Generando Pago_Externo..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)Pago_Externo $(O)Pago_Externo.o $(PROLDLIBS)
	@echo "\n"

$(O)Pago_Externo.o: $(C)Pago_Externo.c $(H)Pago_Externo.h
	@echo "Generando Pago_Externo.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)Pago_Externo.o -c $(C)Pago_Externo.c

$(C)Pago_Externo.c: $(PC)Pago_Externo.pc $(H)Pago_Externo.h
	@echo "Generando Pago_Externo.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)Pago_Externo.pc oname=$(C)Pago_Externo.c

clean:
	$(RMF) $(C)Pago_Externo.c 
	$(RMF) $(O)Pago_Externo.o 
	$(RMF) $(EXE)Pago_Externo

