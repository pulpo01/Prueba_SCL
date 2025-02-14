
include $(COM_ENV_PRECOM)

#--------------------------------------------------------------------------------
# not predefined macros
#--------------------------------------------------------------------------------
RM=/usr/bin/rm -f
MV=/usr/bin/mv

EXE=$(XPCM_EXE)/
OBJ_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/utils.o $(XPCM_LIB)/GEN_biblioteca.o
#--------------------------------------------------------------------------------
all: $(EXE)Val_BonoCartera
#--------------------------------------------------------------------------------
$(EXE)Val_BonoCartera: $(O)Val_BonoCartera.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)Val_BonoCartera $(O)Val_BonoCartera.o $(OBJ_EXT) $(PROLDLIBS)

#--------------------------------------------------------------------------------
$(O)Val_BonoCartera.o: $(PC)Val_BonoCartera.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)Val_BonoCartera.pc
	$(MV) $(PC)*.c $(C)
	$(CC) -o $(O)Val_BonoCartera.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)Val_BonoCartera.c

#--------------------------------------------------------------------------------
#-- aditional tasks
clean:
	$(RM) $(C)Val_BonoCartera.c
	$(RM) $(O)Val_BonoCartera.o
	
cleanall: clean
	$(RM) $(EXE)Val_BonoCartera
