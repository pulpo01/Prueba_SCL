
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
all: $(EXE)Val_Churn
#--------------------------------------------------------------------------------
$(EXE)Val_Churn: $(O)Val_Churn.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Val_Churn $(O)Val_Churn.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Val_Churn.o: $(PC)Val_Churn.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_Churn.pc oname=$(C)Val_Churn.c
	$(CC) -o $(O)Val_Churn.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Val_Churn.c
#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Val_Churn.c
	$(RM) $(O)Val_Churn.o
	
cleanall: clean
	$(RM) $(EXE)Val_Churn
