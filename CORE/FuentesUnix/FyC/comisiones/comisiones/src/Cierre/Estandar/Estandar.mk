include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)CIE_Estandar

$(EXE)CIE_Estandar: $(O)CIE_estandar.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)CIE_Estandar $(O)CIE_estandar.o

$(O)CIE_estandar.o: $(PC)CIE_estandar.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)CIE_estandar.pc oname=$(C)CIE_estandar.c
	$(CC) -o $(O)CIE_estandar.o $(CFLAGS) $(COM_INCLUDE) -c $(C)CIE_estandar.c

clean:
	$(RMF) $(C)CIE_estandar.c
	$(RMF) $(O)CIE_estandar.o
