#makefile Sun 64b
include $(ENV_PRECOMP)
include $(RE_ENV_PRECOM)
include $(REC_CFG)/env_recauda.cal
NOMBRE=Cierre_caja

OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o
OBJETOS=$(O)$(NOMBRE).o

all: clean $(EXE)$(NOMBRE) 

$(EXE)$(NOMBRE):$(O)$(NOMBRE).o $(OBJETOS_EXT)
	@echo "Generando Cierre_caja..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)$(NOMBRE) $(O)$(NOMBRE).o $(PROLDLIBS)
	@echo "\n"

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c $(H)$(NOMBRE).h
	@echo "Generando Cierre_caja.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc $(H)$(NOMBRE).h
	@echo "Generando Cierre_caja.c..\n"
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) mode=$(MODO) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c

clean:
	$(RMF) $(C)$(NOMBRE).c 
	$(RMF) $(O)$(NOMBRE).o 
	$(RMF) $(EXE)$(NOMBRE)
