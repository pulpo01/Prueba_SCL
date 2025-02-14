include $(ENV_PRECOMP)

AUTO_CONNECT=YES
NLS_LOCAL=YES

all: $(O)rutinasgen.o

$(O)rutinasgen.o: $(PC)rutinasgen.pc
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)rutinasgen.pc oname=$(C)rutinasgen.c
	$(CC) -o $(GE_LIB_PATH)/rutinasgen.o $(CFLAGS) -c $(C)rutinasgen.c
	@cp -f $(H)rutinasgen.h $(GE_INC_PATH)
	
clean:
	$(RMF) $(C)rutinasgen.c
	$(RMF) $(O)rutinasgen.o 

