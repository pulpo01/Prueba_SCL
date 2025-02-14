include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Rev_Seleccion

$(EXE)Rev_Seleccion: $(O)Rev_Seleccion.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Rev_Seleccion $(O)Rev_Seleccion.o

$(O)Rev_Seleccion.o: $(PC)Rev_Seleccion.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Rev_Seleccion.pc oname=$(C)Rev_Seleccion.c
	$(CC) -o $(O)Rev_Seleccion.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Rev_Seleccion.c

clean:
	$(RMF) $(C)Rev_Seleccion.c
	$(RMF) $(O)Rev_Seleccion.o
cleanall: clean
	$(RMF) $(EXE)Rev_Seleccion
