include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Val_Evaluaciones

$(EXE)Val_Evaluaciones: $(O)Val_Evaluaciones.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Val_Evaluaciones $(O)Val_Evaluaciones.o

$(O)Val_Evaluaciones.o: $(PC)Val_Evaluaciones.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_Evaluaciones.pc oname=$(C)Val_Evaluaciones.c
	$(CC) -o $(O)Val_Evaluaciones.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Val_Evaluaciones.c

clean:
	$(RMF) $(C)Val_Evaluaciones.c
	$(RMF) $(O)Val_Evaluaciones.o
	
cleanall: clean
	$(RMF) $(EXE)Val_Evaluaciones
