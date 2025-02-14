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
all: $(EXE)Val_Permanencia
#--------------------------------------------------------------------------------
$(EXE)Val_Permanencia: $(O)Val_Permanencia.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Val_Permanencia $(O)Val_Permanencia.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Val_Permanencia.o: $(PC)Val_Permanencia.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_Permanencia.pc oname=$(C)Val_Permanencia.c
	$(CC) -o $(O)Val_Permanencia.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Val_Permanencia.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Val_Permanencia.c
	$(RM) $(O)Val_Permanencia.o
	
cleanall: clean
	$(RM) $(EXE)Val_Permanencia
