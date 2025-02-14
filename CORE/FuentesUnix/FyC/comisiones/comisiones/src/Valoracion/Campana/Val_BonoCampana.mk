include $(COM_ENV_PRECOM)

EXE=$(XPCM_EXE)/

OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o

all: $(EXE)Val_BonoCampana

$(EXE)Val_BonoCampana: $(O)Val_BonoCampana.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Val_BonoCampana $(O)Val_BonoCampana.o $(COM_INCLUDE) $(OBJ_EXT) $(PROLDLIBS)

$(O)Val_BonoCampana.o: $(PC)Val_BonoCampana.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_BonoCampana.pc oname=$(C)Val_BonoCampana.c
	$(CC) -o $(O)Val_BonoCampana.o $(COM_INCLUDE) $(CFLAGS) -c $(C)Val_BonoCampana.c

clean:
	$(RMF) $(C)Val_BonoCampana.c
	$(RMF) $(O)Val_BonoCampana.o
	

cleanall: clean
	$(RMF) $(EXE)Val_BonoCampana
