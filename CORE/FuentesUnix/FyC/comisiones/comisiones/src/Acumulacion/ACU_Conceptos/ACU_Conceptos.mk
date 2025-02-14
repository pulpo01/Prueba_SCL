include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o


all: $(EXE)ACU_Conceptos

$(EXE)ACU_Conceptos: $(O)ACU_Conceptos.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS) -o $(EXE)ACU_Conceptos $(O)ACU_Conceptos.o

$(O)ACU_Conceptos.o: $(PC)ACU_Conceptos.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)ACU_Conceptos.pc oname=$(C)ACU_Conceptos.c
	$(CC) -o $(O)ACU_Conceptos.o $(CFLAGS) $(COM_INCLUDE) -c $(C)ACU_Conceptos.c

clean:
	$(RMF) $(C)ACU_Conceptos.c
	$(RMF) $(O)ACU_Conceptos.o
	
cleanall: clean
	$(RMF) $(EXE)ACU_Conceptos
