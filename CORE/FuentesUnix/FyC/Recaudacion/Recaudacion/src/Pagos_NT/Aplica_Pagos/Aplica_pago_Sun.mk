#makefile Sun 64b
include $(ENV_PRECOMP)
include $(RE_ENV_PRECOM)
include $(REC_CFG)/env_recauda.cal

RMF=rm -f
EXE=./

OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)Aplica_pago.o

all: clean $(EXE)Aplica_pago 

$(EXE)Aplica_pago:$(O)Aplica_pago.o $(OBJETOS_EXT)
	@echo "Generando Aplica_pago..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)Aplica_pago $(O)Aplica_pago.o $(PROLDLIBS)
	@echo "\n"

$(O)Aplica_pago.o: $(C)Aplica_pago.c $(H)Aplica_pago.h
	@echo "Generando Aplica_pago.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)Aplica_pago.o -c $(C)Aplica_pago.c

$(C)Aplica_pago.c: $(PC)Aplica_pago.pc $(H)Aplica_pago.h
	@echo "Generando Aplica_pago.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)Aplica_pago.pc oname=$(C)Aplica_pago.c

clean:
	$(RMF) $(C)Aplica_pago.c 
	$(RMF) $(O)Aplica_pago.o 
	$(RMF) $(EXE)Aplica_pago
