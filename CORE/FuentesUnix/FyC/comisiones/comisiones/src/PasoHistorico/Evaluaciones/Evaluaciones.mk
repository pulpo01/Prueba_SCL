include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)His_Evaluaciones

$(EXE)His_Evaluaciones: $(O)His_Evaluaciones.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)His_Evaluaciones $(O)His_Evaluaciones.o

$(O)His_Evaluaciones.o: $(PC)His_Evaluaciones.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_Evaluaciones.pc oname=$(C)His_Evaluaciones.c
	$(CC) -o $(O)His_Evaluaciones.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_Evaluaciones.c

clean:
	$(RMF) $(C)His_Evaluaciones.c
	$(RMF) $(O)His_Evaluaciones.o
	

cleanall: clean
	$(RMF) $(EXE)His_Evaluaciones
