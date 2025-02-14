#$(CC) $(INCLUDE) -o $(O)$(NOMBRE).o $(OBJ_EXTERNOS) -c $(C)$(NOMBRE).cpp
#ifndef NO_INDENT
#ident "@(#)$RCSfile: CicloCobro.mk,v $ $Revision: 1.2 $ $Date: 2008/06/19 19:01:12 $"
#endif


NOMBRE=CicloCobro

include $(ENV_PRECOMP)
include $(XCC_CFG)/env_unix.cal

#CC=CC -xO4 -xarch=v9
CC=CC -xO4 -xarch=sparc -m64

C=./cpp/
O=./o/
H=./h/
PC=./pc/

INCLUDE=-I$(ORACLE_HOME)/precomp/public -I$(H) -I$(XCC_INC) -I$(GE_INC_PATH)
PROCINCLUDE=include=$(H) include=$(XCC_INC) include=$(GE_INC_PATH)

all: $(O)$(NOMBRE).o install

$(O)$(NOMBRE).o: $(C)$(NOMBRE).cpp
	$(CC) $(INCLUDE) -o $(O)$(NOMBRE).o  -c $(C)$(NOMBRE).cpp

$(C)$(NOMBRE).cpp: $(PC)$(NOMBRE).pc
	$(PROC) $(PROCFLAGS) define=PROC userid=$(USUARIO) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc code=cpp oname=$(C)$(NOMBRE).cpp
			
clean:
	$(RMF) $(O)$(NOMBRE).o
	$(RMF) $(C)$(NOMBRE).cpp
				
install:
	$(CPF) $(O)$(NOMBRE).o $(XCC_LIB)/
