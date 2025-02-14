include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Enl_Comisiones

$(EXE)Enl_Comisiones: $(O)Enl_Comisiones.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Enl_Comisiones $(O)Enl_Comisiones.o 

$(O)Enl_Comisiones.o: $(PC)Enl_Comisiones.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Enl_Comisiones.pc oname=$(C)Enl_Comisiones.c
	$(CC) -o $(O)Enl_Comisiones.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Enl_Comisiones.c

clean:
	$(RMF) $(C)Enl_Comisiones.c
	$(RMF) $(O)Enl_Comisiones.o
	

cleanall: clean
	$(RMF) $(EXE)Enl_Comisiones
