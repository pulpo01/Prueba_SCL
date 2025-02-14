include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)His_Ventas

$(EXE)His_Ventas: $(O)His_Ventas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)His_Ventas $(O)His_Ventas.o

$(O)His_Ventas.o: $(PC)His_Ventas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_Ventas.pc oname=$(C)His_Ventas.c
	$(CC) -o $(O)His_Ventas.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_Ventas.c

clean:
	$(RMF) $(C)His_Ventas.c
	$(RMF) $(O)His_Ventas.o
	

cleanall: clean
	$(RMF) $(EXE)His_Ventas
