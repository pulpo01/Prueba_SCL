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
all: $(EXE)SEL_bajpre
#--------------------------------------------------------------------------------
$(EXE)SEL_bajpre: $(O)SEL_bajpre.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)SEL_bajpre $(O)SEL_bajpre.o $(OBJ_EXT) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)SEL_bajpre.o: $(PC)SEL_bajpre.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)SEL_bajpre.pc oname=$(C)SEL_bajpre.c
	$(CC) -o $(O)SEL_bajpre.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)SEL_bajpre.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)SEL_bajpre.c
	$(RM) $(O)SEL_bajpre.o
