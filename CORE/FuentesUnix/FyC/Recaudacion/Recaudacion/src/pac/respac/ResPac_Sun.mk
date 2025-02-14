#makefile Sun 64b
include $(ENV_PRECOMP)
include $(REC_CFG)/env_recauda.cal

NOMBRE=ResPac
RMF=rm -f
EXE=./

PROCINCLUDE=include=$(H) include=$(GE_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/New_Interfact.o
OBJETOS=$(O)$(NOMBRE).o

all: clean $(EXE)$(NOMBRE) install

$(EXE)$(NOMBRE):$(O)$(NOMBRE).o $(OBJETOS_EXT)
	@echo "Generando ResPac....\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)$(NOMBRE) $(PROLDLIBS)
	@echo "\n"

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c $(H)$(NOMBRE).h
	@echo "Generando ResPac.o....\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc $(H)$(NOMBRE).h
	@echo "Generando ResPac.c....\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c code=ansi_c

clean:
	$(RMF) $(C)$(NOMBRE).c 
	$(RMF) $(O)$(NOMBRE).o 
	$(RMF) $(EXE)$(NOMBRE)

install:
	$(CPF) $(NOMBRE) $(HOME)/EXE/Recaudacion

