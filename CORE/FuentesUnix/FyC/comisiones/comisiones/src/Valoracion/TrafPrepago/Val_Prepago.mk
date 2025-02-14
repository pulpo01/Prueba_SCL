include $(COM_ENV_PRECOM)

#--------------------------------------------------------------------------------
# not predefined macros
#--------------------------------------------------------------------------------
RM=/usr/bin/rm -f
MV=/usr/bin/mv

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o 
#--------------------------------------------------------------------------------
all: $(EXE)Val_Prepago
#--------------------------------------------------------------------------------
$(EXE)Val_Prepago: $(O)Val_Prepago.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Val_Prepago $(O)Val_Prepago.o $(OBJ_EXT) $(COM_INCLUDE) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Val_Prepago.o: $(PC)Val_Prepago.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS)  MODE=ANSI iname=$(PC)Val_Prepago.pc oname=$(C)Val_Prepago.c
	$(CC) -o $(O)Val_Prepago.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Val_Prepago.c
#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Val_Prepago.c
	$(RM) $(O)Val_Prepago.o
	
cleanall: clean
	$(RM) $(EXE)Val_Prepago
