include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Rev_Liquidacion

$(EXE)Rev_Liquidacion: $(O)Rev_Liquidacion.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Rev_Liquidacion $(O)Rev_Liquidacion.o
#--------------------------------------------------------------------------------
$(O)Rev_Liquidacion.o: $(PC)Rev_Liquidacion.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Rev_Liquidacion.pc oname=$(C)Rev_Liquidacion.c
	$(CC) -o $(O)Rev_Liquidacion.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Rev_Liquidacion.c
#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RMF) $(C)Rev_Liquidacion.c
	$(RMF) $(O)Rev_Liquidacion.o
cleanall: clean
	$(RMF) $(EXE)Rev_Liquidacion
