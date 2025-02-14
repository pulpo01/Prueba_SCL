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
all: $(EXE)SEL_rechazos
#--------------------------------------------------------------------------------
$(EXE)SEL_rechazos: $(O)SEL_rechazos.o $(OBJ_EXT)
	$(CC) $(CFLAGS) -o $(EXE)SEL_rechazos $(O)SEL_rechazos.o $(OBJ_EXT) $(COM_INCLUDE) $(PROLDLIBS)
#--------------------------------------------------------------------------------
$(O)SEL_rechazos.o: $(PC)SEL_rechazos.pc
	$(PROC) $(COM_PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) MODE=ANSI iname=$(PC)SEL_rechazos.pc oname=$(C)SEL_rechazos.c
	$(CC) -o $(O)SEL_rechazos.o $(CFLAGS) $(COM_INCLUDE) $(SQLPUBLIC) -c $(C)SEL_rechazos.c
#--------------------------------------------------------------------------------
clean:
	$(RM) $(C)SEL_rechazos.c
	$(RM) $(O)SEL_rechazos.o
