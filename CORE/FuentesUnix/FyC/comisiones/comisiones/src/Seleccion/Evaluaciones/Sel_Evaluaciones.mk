
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
all: $(EXE)Sel_Evaluaciones
#--------------------------------------------------------------------------------
$(EXE)Sel_Evaluaciones: $(O)Sel_Evaluaciones.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Sel_Evaluaciones $(COM_INCLUDE) $(O)Sel_Evaluaciones.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_Evaluaciones.o: $(PC)Sel_Evaluaciones.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Sel_Evaluaciones.pc oname=$(C)Sel_Evaluaciones.c
	$(CC) -o $(O)Sel_Evaluaciones.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Sel_Evaluaciones.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_Evaluaciones.c
	$(RM) $(O)Sel_Evaluaciones.o
	
cleanall: clean
	$(RM) $(EXE)Sel_Evaluaciones
