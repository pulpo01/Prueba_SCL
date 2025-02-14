include $(FA_ENV_PRECOM)

OEXT=$(GE_LIB_PATH)/
EXE=$(XPF_EXE)/

all: $(EXE)check_supertel

$(EXE)check_supertel: $(O)check_supertel.o $(OEXT)geora.o
	$(CC) $(CFLAGS) -o $(EXE)check_supertel $(O)check_supertel.o $(OEXT)geora.o $(OEXT)utils.o $(PROLDLIBS)

$(O)check_supertel.o: $(PC)check_supertel.pc
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(PC)check_supertel.pc oname=$(C)check_supertel.c
	$(CC) -o $(O)check_supertel.o $(CFLAGS) $(FA_INCLUDE) -c $(C)check_supertel.c
 
clean:
	$(RMF) $(C)check_supertel.c
	$(RMF) $(O)check_supertel.o

cleanall: clean
	$(RMF) $(EXE)check_supertel
