include $(ENV_PRECOMP)

AUTO_CONNECT=YES
NLS_LOCAL=YES

all: $(O)trazafact.o

$(O)trazafact.o: $(PC)trazafact.pc
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)trazafact.pc
	$(MV) $(PC)trazafact.c $(C)
	$(CC) -o $(O)trazafact.o $(CFLAGS) -c $(C)trazafact.c -o $(GE_LIB_PATH)/trazafact.o
	@cp -f $(H)trazafact.h $(GE_INC_PATH)
	
clean:
	$(RMF) $(C)trazafact.c
	$(RMF) $(O)trazafact.o 

