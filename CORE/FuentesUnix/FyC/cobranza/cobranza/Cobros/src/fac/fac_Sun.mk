NOMBRE=fac

include $(ENV_PRECOMP)
include $(XCC_CFG)/env_unix.cal

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=./

PROCINCLUDE=include=$(H) include=$(XCC_INC) include=$(GE_INC_PATH)
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(XCC_INC) $(I_SYM)$(GE_INC_PATH)
OBJETOS_EXT=$(GE_LIB_PATH)/GenORA.o $(GE_LIB_PATH)/genco.o $(GE_LIB_PATH)/geora.o

all: $(O)$(NOMBRE).o install

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c
	@echo "\nGenerando => " $(NOMBRE).o 
	$(CC) $(CFLAGS) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: 
	@echo "\nGenerando => " $(C)$(NOMBRE).c
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c code=ansi_c

install:
	$(CPF) $(O)$(NOMBRE).o		$(XCC_LIB)

clean:
	$(RMF) $(C)$(NOMBRE).c 
	$(RMF) $(O)$(NOMBRE).o 
