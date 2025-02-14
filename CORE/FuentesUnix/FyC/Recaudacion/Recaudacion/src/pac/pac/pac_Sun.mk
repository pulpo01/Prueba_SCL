#makefile Sun 64b
include $(ENV_PRECOMP)
include $(REC_CFG)/env_recauda.cal
 
RMF=rm -f
EXE=./

PROCINCLUDE=include=$(H) include=$(GE_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/New_Interfact.o
OBJETOS=$(O)pac.o

all: clean $(EXE)new_pac install

$(EXE)new_pac:$(O)pac.o $(OBJETOS_EXT)
	@echo "Generando new_pac..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)new_pac $(PROLDLIBS) 
	@echo "\n"

$(O)pac.o: $(C)pac.c $(H)pac.h
	@echo "Generando pac.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)pac.o -c $(C)pac.c

$(C)pac.c: $(PC)pac.pc $(H)pac.h
	@echo "Generando pac.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)pac.pc oname=$(C)pac.c code=ansi_c

clean:
	$(RMF) $(C)pac.c 
	$(RMF) $(O)pac.o 
	$(RMF) $(EXE)new_pac

install:
	$(CPF) new_pac $(HOME)/EXE/Recaudacion

