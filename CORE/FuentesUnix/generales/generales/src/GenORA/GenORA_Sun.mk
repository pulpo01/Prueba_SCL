NOMBRE=GenORA

include $(ENV_PRECOMP)

USUARIO=cobranza/cobranza
RMF=rm -f
CPF=cp -f
CCc=cc -c

C=./c/
O=./o/
H=./h/
PC=./pc/

INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(GE_INC_PATH) 
PROCINCLUDE=include=$(H) include=$(GE_INC_PATH)
OBJ_EXTERNOS=$(GE_LIB_PATH)/geora.o

all: $(O)$(NOMBRE).o install

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c
	$(CCc) -o $(O)$(NOMBRE).o $(CFLAGS) $(OBJ_EXTERNOS) -c $(C)$(NOMBRE).c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c
			
clean:
	$(RMF) $(O)$(NOMBRE).o
	$(RMF) $(C)$(NOMBRE).c
				
install:
	$(CPF) $(O)$(NOMBRE).o $(GE_LIB_PATH)/
	$(CPF) $(H)$(NOMBRE).h $(GE_INC_PATH)/
