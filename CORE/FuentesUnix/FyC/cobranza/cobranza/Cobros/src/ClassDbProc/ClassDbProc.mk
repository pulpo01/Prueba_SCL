#ifndef NO_INDENT
#ident "@(#)$RCSfile: ClassDbProc.mk,v $ $Revision: 1.5 $ $Date: 2008/06/19 19:12:01 $"
#endif


NOMBRE=ClassDbProc

include $(ENV_PRECOMP)
include $(XCC_CFG)/env_unix.cal

#CC=CC -xO4 -xarch=v9
CC=CC -xO4 -xarch=sparc -m64

C=./c/
O=./o/
H=./h/
PC=./pc/
CPP=./cpp/

INCLUDE=-I$(ORACLE_HOME)/precomp/public -I$(H) -I$(XCC_INC) -I$(GE_INC_PATH)
PROCINCLUDE=include=$(H) include=$(XCC_INC) include=$(GE_INC_PATH)
PROCFLAGS=sqlcheck=full SQLCHECK=SEMANTIC ireclen=255 oreclen=255 define=PROC code=cpp

all: $(O)$(NOMBRE).o install

$(O)$(NOMBRE).o: $(C)$(NOMBRE).cpp
	$(CC) $(INCLUDE) -o $(O)$(NOMBRE).o -c $(CPP)$(NOMBRE).cpp

$(C)$(NOMBRE).cpp: $(PC)$(NOMBRE).pc
	$(PROC) $(PROCFLAGS) userid=$(USUARIO) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc oname=$(CPP)$(NOMBRE).cpp
			
clean:
	$(RMF) $(O)$(NOMBRE).o
	$(RMF) $(CPP)$(NOMBRE).cpp
				
install:
	$(CPF) $(O)$(NOMBRE).o $(XCC_LIB)/
