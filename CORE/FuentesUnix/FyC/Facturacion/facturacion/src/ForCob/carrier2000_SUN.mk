include $(FA_ENV_PRECOM)

OBJ_EXTERNOS= $(GE_LIB_PATH)/GenORA.o $(GE_LIB_PATH)/genco.o  $(GE_LIB_PATH)/geora.o

EXE=$(XPF_EXE)/

CPF=cp -f
RCP=@echo rcp -p

all: CarrierOL

CarrierOL: carrier.c carrier.o
	$(CC)  $(CFLAGS) $(FA_INCLUDE) -o $(EXE)carrier2000 $(O)carrier.o $(OBJ_EXTERNOS) $(PROLDLIBS)

carrier.c: $(PC)carrier.pc
	$(PROC) $(PROCFLAGS) userid=$(USERPASS) iname=$(PC)carrier.pc oname=$(C)carrier.c

carrier.o: $(C)carrier.c
	$(CC) $(CFLAGS) $(FA_INCLUDE) -c $(C)carrier.c -o $(O)carrier.o

clean:
	rm $(O)*.o
	rm $(C)*.c

install:
	mv $(EXE)carrier2000 $(XPF_EXE)/bin 
	mv $(O)*.o $(FA_LIB_PATH)
	mv $(H)*.h $(FA_INC_PATH)

