#makefile Sun 64b
include $(ENV_PRECOMP)
include $(REC_CFG)/env_recauda.cal
 
RMF=rm -f
EXE=./

PROCINCLUDE=include=$(H) include=$(GE_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/New_Interfact.o
OBJETOS=$(O)correo_pac.o

all: clean $(EXE)correo_pac install

$(EXE)correo_pac:$(O)correo_pac.o $(OBJETOS_EXT)
	@echo "Generando correo_pac..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)correo_pac $(PROLDLIBS) 
	@echo "\n"

$(O)correo_pac.o: $(C)correo_pac.c $(H)correo_pac.h
	@echo "Generando correo_pac.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)correo_pac.o -c $(C)correo_pac.c

$(C)correo_pac.c: $(PC)correo_pac.pc $(H)correo_pac.h
	@echo "Generando correo_pac.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) iname=$(PC)correo_pac.pc oname=$(C)correo_pac.c code=ansi_c

clean:
	$(RMF) $(C)correo_pac.c 
	$(RMF) $(O)correo_pac.o 
	$(RMF) $(EXE)correo_pac

install:
	$(CPF) correo_pac $(HOME)/EXE/Recaudacion
