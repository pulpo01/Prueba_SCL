
include $(COM_ENV_PRECOM)

#--------------------------------------------------------------------------------
# not predefined macros
#--------------------------------------------------------------------------------
RM=/usr/bin/rm -f
MV=/usr/bin/mv

#--------------------------------------------------------------------------------
EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o
#--------------------------------------------------------------------------------
all: $(EXE)Sel_Convenios
#--------------------------------------------------------------------------------
$(EXE)Sel_Convenios: $(O)Sel_Convenios.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Sel_Convenios $(O)Sel_Convenios.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_Convenios.o: $(PC)Sel_Convenios.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Sel_Convenios.pc oname=$(C)Sel_Convenios.c
	$(CC) -o $(O)Sel_Convenios.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Sel_Convenios.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_Convenios.c
	$(RM) $(O)Sel_Convenios.o
	
cleanall: clean
	$(RM) $(EXE)Sel_Convenios
