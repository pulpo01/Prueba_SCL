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
all: $(EXE)Val_Recargas
#--------------------------------------------------------------------------------
$(EXE)Val_Recargas: $(O)Val_Recargas.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)Val_Recargas $(O)Val_Recargas.o $(OBJ_EXT) $(COM_INCLUDE) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Val_Recargas.o: $(PC)Val_Recargas.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_Recargas.pc oname=$(C)Val_Recargas.c
	$(CC) -o $(O)Val_Recargas.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Val_Recargas.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Val_Recargas.c
	$(RM) $(O)Val_Recargas.o
	
cleanall: clean
	$(RM) $(EXE)Val_Recargas
