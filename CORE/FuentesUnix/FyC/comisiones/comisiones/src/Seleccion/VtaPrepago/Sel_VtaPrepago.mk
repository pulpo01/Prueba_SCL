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
all: $(EXE)Sel_VtaPrepago
#--------------------------------------------------------------------------------
$(EXE)Sel_VtaPrepago: $(O)Sel_VtaPrepago.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Sel_VtaPrepago $(O)Sel_VtaPrepago.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_VtaPrepago.o: $(PC)Sel_VtaPrepago.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Sel_VtaPrepago.pc oname=$(C)Sel_VtaPrepago.c
	$(CC) -o $(O)Sel_VtaPrepago.o $(COM_INCLUDE) $(CFLAGS) $(SQLPUBLIC) -c $(C)Sel_VtaPrepago.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_VtaPrepago.c
	$(RM) $(O)Sel_VtaPrepago.o
	
cleanall: clean
	$(RM) $(EXE)Sel_VtaPrepago
