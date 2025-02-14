include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Rev_Acumulacion

$(EXE)Rev_Acumulacion: $(O)Rev_Acumulacion.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Rev_Acumulacion $(O)Rev_Acumulacion.o

$(O)Rev_Acumulacion.o: $(PC)Rev_Acumulacion.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Rev_Acumulacion.pc oname=$(C)Rev_Acumulacion.c
	$(CC) -o $(O)Rev_Acumulacion.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Rev_Acumulacion.c

clean:
	$(RMF) $(C)Rev_Acumulacion.c
	$(RMF) $(O)Rev_Acumulacion.o
cleanall: clean
	$(RMF) $(EXE)Rev_Acumulacion
