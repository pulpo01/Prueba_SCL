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
all: $(EXE)Sel_Prepago
#--------------------------------------------------------------------------------
$(EXE)Sel_Prepago: $(O)Sel_Prepago.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Sel_Prepago $(O)Sel_Prepago.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_Prepago.o: $(PC)Sel_Prepago.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Sel_Prepago.pc oname=$(C)Sel_Prepago.c
	$(CC) -o $(O)Sel_Prepago.o $(COM_INCLUDE) $(CFLAGS) $(SQLPUBLIC) -c $(C)Sel_Prepago.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_Prepago.c
	$(RM) $(O)Sel_Prepago.o
	
cleanall: clean
	$(RM) $(EXE)Sel_Prepago
