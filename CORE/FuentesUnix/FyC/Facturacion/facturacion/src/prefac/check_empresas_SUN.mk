include $(FA_ENV_PRECOM)

OEXT=$(GE_LIB_PATH)/
EXE=$(XPF_EXE)/

all: $(EXE)check_empresas 

$(EXE)check_empresas: $(O)check_empresas.o $(OEXT)geora.o $(OEXT)utils.o
	$(CC) $(CFLAGS) -o $(EXE)check_empresas $(O)check_empresas.o $(OEXT)geora.o $(OEXT)utils.o $(PROLDLIBS)

$(O)check_empresas.o: $(PC)check_empresas.pc
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(PC)check_empresas.pc oname=$(C)check_empresas.c
	$(CC) -o $(O)check_empresas.o $(CFLAGS) $(FA_INCLUDE) -c $(C)check_empresas.c

clean:
	$(RMF) $(C)check_empresas.c 
	$(RMF) $(O)check_empresas.o 

cleanall: clean
	$(RMF) $(EXE)check_empresas
	
