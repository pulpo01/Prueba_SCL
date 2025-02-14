
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
all: $(EXE)Val_Bajas
#--------------------------------------------------------------------------------
$(EXE)Val_Bajas: $(O)Val_Bajas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Val_Bajas $(O)Val_Bajas.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Val_Bajas.o: $(PC)Val_Bajas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_Bajas.pc oname=$(C)Val_Bajas.c
	$(CC) -o $(O)Val_Bajas.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Val_Bajas.c
#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Val_Bajas.c
	$(RM) $(O)Val_Bajas.o
	
cleanall: clean
	$(RM) $(EXE)Val_Bajas
