#makefile Sun 64b
include $(ENV_PRECOMP)
include $(REC_CFG)/env_recauda.cal
 
RMF=rm -f
EXE=./

PROCINCLUDE=include=$(H) include=$(GE_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/New_Interfact.o
OBJETOS=$(O)sms_pac.o

all: clean $(EXE)sms_pac install

$(EXE)sms_pac:$(O)sms_pac.o $(OBJETOS_EXT)
	@echo "Generando sms_pac..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)sms_pac $(PROLDLIBS) 
	@echo "\n"

$(O)sms_pac.o: $(C)sms_pac.c $(H)sms_pac.h
	@echo "Generando sms_pac.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)sms_pac.o -c $(C)sms_pac.c

$(C)sms_pac.c: $(PC)sms_pac.pc $(H)sms_pac.h
	@echo "Generando sms_pac.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)sms_pac.pc oname=$(C)sms_pac.c code=ansi_c

clean:
	$(RMF) $(C)sms_pac.c 
	$(RMF) $(O)sms_pac.o 
	$(RMF) $(EXE)sms_pac

install:
	$(CPF) sms_pac $(HOME)/EXE/Recaudacion
