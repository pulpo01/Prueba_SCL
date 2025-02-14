include $(COM_ENV_PRECOM)

#-------------------------------------------------------------------------------
# not predefined macros
#-------------------------------------------------------------------------------
RM=/usr/bin/rm -f
MV=/usr/bin/mv

CP=cp

#-------------------------------------------------------------------------------
all: $(O)GEN_biblioteca.o
#-------------------------------------------------------------------------------
$(O)GEN_biblioteca.o: $(PC)GEN_biblioteca.pc 
	$(PROC) $(PROCFLAGS) userid=$(ORAUSER)/$(ORAPASS) iname=$(PC)GEN_biblioteca.pc oname=$(C)GEN_biblioteca.c
	$(CC) -o $(O)GEN_biblioteca.o $(CFLAGS) $(SQLPUBLIC) -c $(C)GEN_biblioteca.c
	$(CP) $(O)GEN_biblioteca.o $(XPCM_LIB)
	$(CP) $(H)GEN_biblioteca.h $(XPCM_INC)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
clean:
	$(RM) $(C)GEN_biblioteca.c
	$(RM) $(O)GEN_biblioteca.o
