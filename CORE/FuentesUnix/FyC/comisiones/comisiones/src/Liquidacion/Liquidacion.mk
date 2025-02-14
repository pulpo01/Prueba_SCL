include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Liq_Comisiones

$(EXE)Liq_Comisiones: $(O)Liq_Comisiones.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Liq_Comisiones $(O)Liq_Comisiones.o

$(O)Liq_Comisiones.o: $(PC)Liq_Comisiones.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Liq_Comisiones.pc oname=$(C)Liq_Comisiones.c
	$(CC) -o $(O)Liq_Comisiones.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Liq_Comisiones.c

clean:
	$(RMF) $(C)Liq_Comisiones.c
	$(RMF) $(O)Liq_Comisiones.o
	

cleanall: clean
	$(RMF) $(EXE)Liq_Comisiones
