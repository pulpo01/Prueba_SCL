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
all: $(EXE)Ext_Ventas
#--------------------------------------------------------------------------------
$(EXE)Ext_Ventas: $(O)Ext_Ventas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Ext_Ventas $(O)Ext_Ventas.o $(OBJ_EXT) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)Ext_Ventas.o: $(PC)Ext_Ventas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Ext_Ventas.pc oname=$(C)Ext_Ventas.c
	$(CC) -o $(O)Ext_Ventas.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Ext_Ventas.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)Ext_Ventas.c
	$(RM) $(O)Ext_Ventas.o
