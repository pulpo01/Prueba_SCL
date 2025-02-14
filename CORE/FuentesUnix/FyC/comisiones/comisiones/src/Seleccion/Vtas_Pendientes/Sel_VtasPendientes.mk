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
all: $(EXE)Sel_VtasPendientes
#--------------------------------------------------------------------------------
$(EXE)Sel_VtasPendientes: $(O)Sel_VtasPendientes.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Sel_VtasPendientes $(O)Sel_VtasPendientes.o $(OBJ_EXT) $(COM_INCLUDE) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_VtasPendientes.o: $(PC)Sel_VtasPendientes.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Sel_VtasPendientes.pc oname=$(C)Sel_VtasPendientes.c
	$(CC) -o $(O)Sel_VtasPendientes.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Sel_VtasPendientes.c
#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_VtasPendientes.c
	$(RM) $(O)Sel_VtasPendientes.o
	
cleanall: clean
	$(RM) $(EXE)Sel_VtasPendientes
