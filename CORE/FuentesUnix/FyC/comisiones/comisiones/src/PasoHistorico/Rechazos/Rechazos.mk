include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)His_Rechazos

$(EXE)His_Rechazos: $(O)His_Rechazos.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)His_Rechazos $(O)His_Rechazos.o

$(O)His_Rechazos.o: $(PC)His_Rechazos.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_Rechazos.pc oname=$(C)His_Rechazos.c
	$(CC) -o $(O)His_Rechazos.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_Rechazos.c

clean:
	$(RMF) $(C)His_Rechazos.c
	$(RMF) $(O)His_Rechazos.o
	

cleanall: clean
	$(RMF) $(EXE)His_Rechazos
