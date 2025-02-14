#makefile Sun 64b
include $(ENV_PRECOMP)
include $(REC_CFG)/env_recauda.cal
 
NOMBRE=co_cierre_web
RMF=rm -f
EXE=./
#GE_INC_PATH=$(REC_INC)
#GE_LIB_PATH=$(REC_LIB)

PROCINCLUDE=include=$(H) include=$(GE_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)$(NOMBRE).o

all: clean $(EXE)$(NOMBRE) 

$(EXE)$(NOMBRE):$(O)$(NOMBRE).o $(OBJETOS_EXT)
	@echo "Generando co_cierre_web..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)$(NOMBRE) $(O)$(NOMBRE).o $(PROLDLIBS) 
	@echo "\n"

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c $(H)$(NOMBRE).h
	@echo "Generando co_cierre_web.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc $(H)$(NOMBRE).h
	@echo "Generando co_cierre_web.c..\n"
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USUARIO) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c

clean:
	$(RMF) $(C)$(NOMBRE).c 
	$(RMF) $(O)$(NOMBRE).o 
	$(RMF) $(EXE)$(NOMBRE)


