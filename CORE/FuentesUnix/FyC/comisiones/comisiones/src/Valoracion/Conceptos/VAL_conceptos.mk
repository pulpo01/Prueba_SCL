include $(COM_ENV_PRECOM)

#--------------------------------------------------------------------------------
# not predefined macros
#--------------------------------------------------------------------------------
RM=/usr/bin/rm -f
MV=/usr/bin/mv

#--------------------------------------------------------------------------------
EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o 
#
#--------------------------------------------------------------------------------
all: $(EXE)VAL_conceptos
#--------------------------------------------------------------------------------
$(EXE)VAL_conceptos: $(O)VAL_conceptos.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)VAL_conceptos $(O)VAL_conceptos.o $(OBJ_EXT) $(COM_INCLUDE) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)VAL_conceptos.o: $(PC)VAL_conceptos.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)VAL_conceptos.pc oname=$(C)VAL_conceptos.c
	$(CC) -o $(O)VAL_conceptos.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)VAL_conceptos.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)VAL_conceptos.c
	$(RM) $(O)VAL_conceptos.o
