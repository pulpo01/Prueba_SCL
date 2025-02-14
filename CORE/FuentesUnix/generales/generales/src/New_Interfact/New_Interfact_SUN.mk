include $(ENV_PRECOMP)

AUTO_CONNECT=YES
NLS_LOCAL=YES

all: $(O)New_Interfact.o install

$(O)New_Interfact.o: $(PC)New_Interfact.pc $(H)New_Interfact.h
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)New_Interfact.pc oname=$(C)New_Interfact.c
	$(CC) -o $(O)New_Interfact.o $(CFLAGS) -c $(C)New_Interfact.c
clean:
	$(RMF) $(C)New_Interfact.c
	$(RMF) $(O)New_Interfact.o 
	
install:
	cp $(H)New_Interfact.h    $(GE_INC_PATH)/New_Interfact.h
	cp $(O)New_Interfact.o    $(GE_LIB_PATH)/New_Interfact.o
