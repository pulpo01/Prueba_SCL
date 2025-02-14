
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
all: $(EXE)Sel_Churn
#--------------------------------------------------------------------------------
$(EXE)Sel_Churn: $(O)Sel_Churn.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Sel_Churn $(O)Sel_Churn.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_Churn.o: $(PC)Sel_Churn.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Sel_Churn.pc oname=$(C)Sel_Churn.c
	$(CC) -o $(O)Sel_Churn.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Sel_Churn.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_Churn.c
	$(RM) $(O)Sel_Churn.o
	
cleanall: clean
	$(RM) $(EXE)Sel_Churn
