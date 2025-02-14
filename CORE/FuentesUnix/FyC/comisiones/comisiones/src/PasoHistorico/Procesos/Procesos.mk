include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)His_Procesos

$(EXE)His_Procesos: $(O)His_Procesos.o $(OBJEXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)His_Procesos $(O)His_Procesos.o

$(O)His_Procesos.o: $(PC)His_Procesos.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_Procesos.pc oname=$(C)His_Procesos.c
	$(CC) -o $(O)His_Procesos.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_Procesos.c

clean:
	$(RMF) $(C)His_Procesos.c
	$(RMF) $(O)His_Procesos.o
	

cleanall: clean
	$(RMF) $(EXE)His_Procesos
