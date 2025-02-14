include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Val_ConvenioPAC

$(EXE)Val_ConvenioPAC: $(O)Val_ConvenioPAC.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Val_ConvenioPAC $(O)Val_ConvenioPAC.o

$(O)Val_ConvenioPAC.o: $(PC)Val_ConvenioPAC.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_ConvenioPAC.pc oname=$(C)Val_ConvenioPAC.c
	$(CC) -o $(O)Val_ConvenioPAC.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Val_ConvenioPAC.c

clean:
	$(RMF) $(C)Val_ConvenioPAC.c
	$(RMF) $(O)Val_ConvenioPAC.o
	
cleanall: clean
	$(RMF) $(EXE)Val_ConvenioPAC
