include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)His_Bajas

$(EXE)His_Bajas: $(O)His_Bajas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)His_Bajas $(O)His_Bajas.o

$(O)His_Bajas.o: $(PC)His_Bajas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_Bajas.pc oname=$(C)His_Bajas.c
	$(CC) -o $(O)His_Bajas.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_Bajas.c

clean:
	$(RMF) $(C)His_Bajas.c
	$(RMF) $(O)His_Bajas.o
	

cleanall: clean
	$(RMF) $(EXE)His_Bajas
