include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)Rev_Valoracion

$(EXE)Rev_Valoracion: $(O)Rev_Valoracion.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)Rev_Valoracion $(O)Rev_Valoracion.o

$(O)Rev_Valoracion.o: $(PC)Rev_Valoracion.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Rev_Valoracion.pc oname=$(C)Rev_Valoracion.c
	$(CC) -o $(O)Rev_Valoracion.o $(CFLAGS) $(COM_INCLUDE) -c $(C)Rev_Valoracion.c

clean:
	$(RMF) $(C)Rev_Valoracion.c
	$(RMF) $(O)Rev_Valoracion.o
cleanall: clean
	$(RMF) $(EXE)Rev_Valoracion
