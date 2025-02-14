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
all: $(EXE)SEL_bontraf
#--------------------------------------------------------------------------------
$(EXE)SEL_bontraf: $(O)SEL_bontraf.o $(OBJ_EXT)
	$(CC) $(CFLAGS) $(COM_INCLUDE) -o $(EXE)SEL_bontraf $(O)SEL_bontraf.o $(OBJ_EXT) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)SEL_bontraf.o: $(PC)SEL_bontraf.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)SEL_bontraf.pc oname=$(C)SEL_bontraf.c
	$(CC) -o $(O)SEL_bontraf.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)SEL_bontraf.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)SEL_bontraf.c
	$(RM) $(O)SEL_bontraf.o
