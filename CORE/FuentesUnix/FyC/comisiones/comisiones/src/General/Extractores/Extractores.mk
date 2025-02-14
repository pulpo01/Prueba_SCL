include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Extractores

$(EXE)Extractores: $(O)Extractores.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Extractores $(O)Extractores.o

$(O)Extractores.o: $(PC)Extractores.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Extractores.pc oname=$(C)Extractores.c
	$(CC) -g -o $(O)Extractores.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Extractores.c

clean:
	$(RMF) $(C)Extractores.c
	$(RMF) $(O)Extractores.o
