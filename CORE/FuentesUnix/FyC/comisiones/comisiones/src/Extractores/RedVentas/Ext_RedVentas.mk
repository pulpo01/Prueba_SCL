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
all: $(EXE)Ext_RedVentas
#--------------------------------------------------------------------------------
$(EXE)Ext_RedVentas: $(O)Ext_RedVentas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Ext_RedVentas $(O)Ext_RedVentas.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Ext_RedVentas.o: $(PC)Ext_RedVentas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Ext_RedVentas.pc oname=$(C)Ext_RedVentas.c
	$(CC) -o $(O)Ext_RedVentas.o $(COM_INCLUDE) $(CFLAGS) $(SQLPUBLIC) -c $(C)Ext_RedVentas.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Ext_RedVentas.c
	$(RM) $(O)Ext_RedVentas.o
	
cleanall: clean
	$(RM) $(EXE)Ext_RedVentas
