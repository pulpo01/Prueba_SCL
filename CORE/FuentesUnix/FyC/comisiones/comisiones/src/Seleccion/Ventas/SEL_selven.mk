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
all: $(EXE)SEL_selven
#--------------------------------------------------------------------------------
$(EXE)SEL_selven: $(O)SEL_selven.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)SEL_selven $(O)SEL_selven.o $(OBJ_EXT) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)SEL_selven.o: $(PC)SEL_selven.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)SEL_selven.pc oname=$(C)SEL_selven.c
	$(CC) -o $(O)SEL_selven.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)SEL_selven.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)SEL_selven.c
	$(RM) $(O)SEL_selven.o
