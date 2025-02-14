include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Comisiones

$(EXE)Comisiones: $(O)Comisiones.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Comisiones $(O)Comisiones.o

$(O)Comisiones.o: $(PC)Comisiones.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Comisiones.pc oname=$(C)Comisiones.c
	$(CC) -o $(O)Comisiones.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Comisiones.c

clean:
	$(RMF) $(C)Comisiones.c
	$(RMF) $(O)Comisiones.o
