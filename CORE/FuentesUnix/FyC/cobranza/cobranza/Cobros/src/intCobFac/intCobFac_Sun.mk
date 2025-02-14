NOMBRE=intCobFac

include $(ENV_PRECOMP)
include $(XCC_CFG)/env_unix.cal

C=./c/
O=./o/
H=./h/
PC=./pc/

INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(XCC_INC) $(I_SYM)$(GE_INC_PATH)
PROCINCLUDE=include=$(H) include=$(XCC_INC) include=$(GE_INC_PATH)
OBJ_EXTERNOS=$(GE_LIB_PATH)/genco.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/GenORA.o

all: $(O)$(NOMBRE).o install

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c
	$(CCc) -o $(O)$(NOMBRE).o $(CFLAGS) $(OBJ_EXTERNOS) -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c code=ansi_c
			
clean:
	$(RMF) $(O)$(NOMBRE).o
	$(RMF) $(C)$(NOMBRE).c
				
install:
	$(CPF) $(O)$(NOMBRE).o $(XCC_LIB)/
