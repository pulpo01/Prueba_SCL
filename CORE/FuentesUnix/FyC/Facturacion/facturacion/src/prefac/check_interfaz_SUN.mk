include $(FA_ENV_PRECOM)

OEXT=$(GE_LIB_PATH)/
EXE=$(XPF_EXE)/

all: $(EXE)check_interfaz

$(EXE)check_interfaz: $(O)check_interfaz.o $(OEXT)utils.o $(OEXT)geora.o
	$(CC) $(CFLAGS) -o $(EXE)check_interfaz $(O)check_interfaz.o $(OEXT)utils.o $(OEXT)geora.o $(PROLDLIBS)

$(O)check_interfaz.o: $(PC)check_interfaz.pc
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(PC)check_interfaz.pc oname=$(C)check_interfaz.c
	$(CC) -o $(O)check_interfaz.o $(CFLAGS) $(FA_INCLUDE) -c $(C)check_interfaz.c

clean:
	$(RMF) $(C)check_interfaz.c
	$(RMF) $(O)check_interfaz.o

cleanall: clean
	$(RMF) $(EXE)check_interfaz
