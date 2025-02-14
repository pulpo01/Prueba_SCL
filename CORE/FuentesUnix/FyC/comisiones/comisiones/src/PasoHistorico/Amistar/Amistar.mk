include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)His_Prepago

$(EXE)His_Prepago: $(O)His_Prepago.o $(OOB_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)His_Prepago $(O)His_Prepago.o

$(O)His_Prepago.o: $(PC)His_Prepago.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_Prepago.pc oname=$(C)His_Prepago.c
	$(CC) -o $(O)His_Prepago.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_Prepago.c

clean:
	$(RMF) $(C)His_Prepago.c
	$(RMF) $(O)His_Prepago.o
	

cleanall: clean
	$(RMF) $(EXE)His_Prepago
