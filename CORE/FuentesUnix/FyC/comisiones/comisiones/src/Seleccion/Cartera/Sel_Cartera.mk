
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
all: $(EXE)Sel_Cartera
#--------------------------------------------------------------------------------
$(EXE)Sel_Cartera: $(O)Sel_Cartera.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Sel_Cartera $(O)Sel_Cartera.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Sel_Cartera.o: $(PC)Sel_Cartera.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS)  MODE=ANSI iname=$(PC)Sel_Cartera.pc oname=$(C)Sel_Cartera.c
	$(CC) -o $(O)Sel_Cartera.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Sel_Cartera.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Sel_Cartera.c
	$(RM) $(O)Sel_Cartera.o
cleanall: clean
	$(RM) $(EXE)Sel_Cartera
