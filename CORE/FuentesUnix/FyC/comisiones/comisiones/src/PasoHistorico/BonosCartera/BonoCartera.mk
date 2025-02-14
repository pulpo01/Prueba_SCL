include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o 

all: $(EXE)His_BonoCartera

$(EXE)His_BonoCartera: $(O)His_BonoCartera.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)His_BonoCartera $(O)His_BonoCartera.o $(OBJ_EXT) $(COM_INCLUDE) $(PROLDLIBS)

$(O)His_BonoCartera.o: $(PC)His_BonoCartera.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)His_BonoCartera.pc oname=$(C)His_BonoCartera.c
	$(CC) -o $(O)His_BonoCartera.o $(CFLAGS) $(COM_INCLUDE) -c $(C)His_BonoCartera.c

clean:
	$(RMF) $(C)His_BonoCartera.c
	$(RMF) $(O)His_BonoCartera.o
	

cleanall: clean
	$(RMF) $(EXE)His_BonoCartera
