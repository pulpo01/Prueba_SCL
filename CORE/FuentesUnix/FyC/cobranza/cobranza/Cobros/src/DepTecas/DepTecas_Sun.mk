NOMBRE=DepTecas

include $(ENV_PRECOMP)
include $(XCC_CFG)/env_unix.cal

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=./

PROCINCLUDE=include=$(H) include=$(XCC_INC) include=$(GE_INC_PATH)
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(XCC_INC) $(I_SYM)$(GE_INC_PATH)
OBJETOS_EXT=$(GE_LIB_PATH)/genco.o $(GE_LIB_PATH)/geora.o 

all: $(EXE)$(NOMBRE) clean

$(EXE)$(NOMBRE): $(O)$(NOMBRE).o 
	@echo "\nGenerando => " $(NOMBRE)
	$(CC) $(CFLAGS) -o $(EXE)$(NOMBRE) $(O)$(NOMBRE).o $(OBJETOS_EXT) $(PROLDLIBS)

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c
	@echo "\nGenerando => " $(NOMBRE).o
	$(CC) $(CFLAGS) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c:
	@echo "\nGenerando => " $(NOMBRE).c
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c

clean:
	$(RMF) $(C)$(NOMBRE).c 
	$(RMF) $(O)$(NOMBRE).o 

cleanall: clean
	$(RMF) $(EXE)$(NOMBRE)

install:
	$(CPF) $(NOMBRE)			$(XCC_BIN)
