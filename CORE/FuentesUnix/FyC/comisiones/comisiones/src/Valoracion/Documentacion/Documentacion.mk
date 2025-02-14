include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Val_Documentacion

$(EXE)Val_Documentacion: $(O)Val_Documentacion.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Val_Documentacion $(O)Val_Documentacion.o

$(O)Val_Documentacion.o: $(PC)Val_Documentacion.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_Documentacion.pc oname=$(C)Val_Documentacion.c
	$(CC) -o $(O)Val_Documentacion.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Val_Documentacion.c

clean:
	$(RMF) $(C)Val_Documentacion.c
	$(RMF) $(O)Val_Documentacion.o
	
cleanall: clean
	$(RMF) $(EXE)Val_Documentacion
