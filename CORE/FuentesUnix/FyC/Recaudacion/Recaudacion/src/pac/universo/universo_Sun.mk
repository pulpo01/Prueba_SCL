#makefile Sun 64b
include $(ENV_PRECOMP)
include $(REC_CFG)/env_recauda.cal

NOMBRE=universo
RMF=rm -f
EXE=./
#GE_INC_PATH=$(REC_INC)
#GE_LIB_PATH=$(REC_LIB)

PROCINCLUDE=include=$(H) include=$(GE_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)$(NOMBRE).o

all: clean $(EXE)new_universo 

$(EXE)new_universo:$(O)$(NOMBRE).o $(OBJETOS_EXT)
	@echo "Generando new_universo..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)new_universo $(O)$(NOMBRE).o $(PROLDLIBS)
	@echo "\n"

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c $(H)$(NOMBRE).h
	@echo "Generando universo.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc $(H)$(NOMBRE).h
	@echo "Generando universo.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c

clean:
	$(RMF) $(C)$(NOMBRE).c 
	$(RMF) $(O)$(NOMBRE).o 
	$(RMF) $(EXE)new_universo

