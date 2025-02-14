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
all: $(EXE)Ext_Bajas
#--------------------------------------------------------------------------------
$(EXE)Ext_Bajas: $(O)Ext_Bajas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Ext_Bajas $(O)Ext_Bajas.o $(OBJ_EXT) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)Ext_Bajas.o: $(PC)Ext_Bajas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Ext_Bajas.pc oname=$(C)Ext_Bajas.c
	$(CC) -g -o $(O)Ext_Bajas.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Ext_Bajas.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)Ext_Bajas.c
	$(RM) $(O)Ext_Bajas.o

