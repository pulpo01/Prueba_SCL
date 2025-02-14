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
all: $(EXE)Ext_ListoPack
#--------------------------------------------------------------------------------
$(EXE)Ext_ListoPack: $(O)Ext_ListoPack.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Ext_ListoPack $(O)Ext_ListoPack.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Ext_ListoPack.o: $(PC)Ext_ListoPack.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Ext_ListoPack.pc oname=$(C)Ext_ListoPack.c
	$(CC) -o $(O)Ext_ListoPack.o $(COM_INCLUDE) $(CFLAGS) $(SQLPUBLIC) -c $(C)Ext_ListoPack.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Ext_ListoPack.c
	$(RM) $(O)Ext_ListoPack.o
	
cleanall: clean
	$(RM) $(EXE)Ext_ListoPack
