include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Val_HabilPrepago

$(EXE)Val_HabilPrepago: $(O)Val_HabilPrepago.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Val_HabilPrepago $(O)Val_HabilPrepago.o

$(O)Val_HabilPrepago.o: $(PC)Val_HabilPrepago.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_HabilPrepago.pc oname=$(C)Val_HabilPrepago.c
	$(CC) -o $(O)Val_HabilPrepago.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Val_HabilPrepago.c

clean:
	$(RMF) $(C)Val_HabilPrepago.c
	$(RMF) $(O)Val_HabilPrepago.o
	
cleanall: clean
	$(RMF) $(EXE)Val_HabilPrepago
