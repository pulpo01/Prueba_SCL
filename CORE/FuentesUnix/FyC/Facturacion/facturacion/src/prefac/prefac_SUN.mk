#
# Makefile original: makefile.old
# Fecha y hora de generacion: 2002-05-07 10:42:21
#

include $(FA_ENV_PRECOM)

PROCFLAGS=ireclen=255 oreclen=255 include=$(GE_INC_PATH) include=$(H)
INCLUDE=$(I_SYM)$(GE_INC_PATH) $(I_SYM)$(ORACLE_HOME)/precomp/public  $(I_SYM)$(H)

C=./c/
O=./o/
OEXT=$(GE_LIB_PATH)/
H=./h/
PC=./pc/
EXE=$(XPF_EXE)/

all: $(EXE)check_empresas $(EXE)check_interfaz $(EXE)check_supertel

$(EXE)check_supertel: $(O)check_supertel.o $(OEXT)geora.o
	$(CC) $(CFLAGS) -o $(EXE)check_supertel $(O)check_supertel.o $(OEXT)utils.o $(OEXT)geora.o $(PROLDLIBS)

$(EXE)check_empresas: $(O)check_empresas.o $(OEXT)geora.o
	$(CC) $(CFLAGS) -o $(EXE)check_empresas $(O)check_empresas.o $(OEXT)utils.o $(OEXT)geora.o $(PROLDLIBS)

$(EXE)check_interfaz: $(O)check_interfaz.o $(OEXT)utils.o $(OEXT)geora.o
	$(CC) $(CFLAGS) -o $(EXE)check_interfaz $(O)check_interfaz.o $(OEXT)utils.o $(OEXT)geora.o $(PROLDLIBS)

$(O)check_supertel.o: $(PC)check_supertel.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c iname=$(PC)check_supertel.pc
	$(MV) $(PC)*.c $(C)
	$(CC) -o $(O)check_supertel.o $(CFLAGS) $(FA_INCLUDE) -c $(C)check_supertel.c
 
$(O)check_empresas.o: $(PC)check_empresas.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c iname=$(PC)check_empresas.pc
	$(MV) $(PC)*.c $(C)
	$(CC) -o $(O)check_empresas.o $(CFLAGS) $(FA_INCLUDE) -c $(C)check_empresas.c

$(O)check_interfaz.o: $(PC)check_interfaz.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c iname=$(PC)check_interfaz.pc
	$(MV) $(PC)*.c $(C)
	$(CC) -o $(O)check_interfaz.o $(CFLAGS) $(FA_INCLUDE) -c $(C)check_interfaz.c

clean:
	$(RMF) $(C)check_empresas.c $(C)check_interfaz.c $(C)check_supertel.c
	$(RMF) $(O)check_empresas.o $(O)check_interfaz.o $(O)check_supertel.o

cleanall: clean
	$(RMF) $(EXE)check_interfaz $(EXE)check_empresas $(EXE)check_supertel
