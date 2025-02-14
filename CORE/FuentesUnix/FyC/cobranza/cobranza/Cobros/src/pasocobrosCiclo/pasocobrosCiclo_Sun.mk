#ifndef NO_INDENT
#ident "@(#)$RCSfile: pasocobrosCiclo_Sun.mk,v $ $Revision: 1.2 $ $Date: 2008/06/19 19:09:03 $"
#endif

NOMBRE=pasocobrosCiclo

include $(ENV_PRECOMP)
include $(XCC_CFG)/env_unix.cal

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=./

#CC=CC -xO4 -xarch=v9
CC=CC -xO4 -xarch=sparc -m64

#PROCINCLUDE=include=$(H) include=$(XCC_INC) include=$(GE_INC_PATH)
PROCINCLUDE=include=$(H) include=$(XCC_INC)
#INCLUDE=-I$(ORACLE_HOME)/precomp/public -I$(H) -I$(XCC_INC) -I$(GE_INC_PATH) -I../ClassDbProc/h -I../memoryCob/h
INCLUDE=-I$(ORACLE_HOME)/precomp/public -I$(H) -I$(XCC_INC) -I../ClassDbProc/h -I../memoryCob/h
#OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/geora.o  $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/GenFA.o  $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/rutinasgen.o $(XCC_LIB)/intCobFac.o $(GE_LIB_PATH)/genco.o $(XCC_LIB)/fac.o $(GE_LIB_PATH)/New_Interfact.o ../ClassDbProc/o/ClassDbProc.o ../memoryCob/o/memoryCob.o
#OBJETOS_EXT=$(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/trazafact.o $(XCC_LIB)/intCobFac.o $(GE_LIB_PATH)/genco.o $(XCC_LIB)/fac.o 
OBJETOS_EXT=../ClassDbProc/o/ClassDbProc.o ../memoryCob/o/memoryCob.o ../CicloCobro/o/CicloCobro.o

all: $(NOMBRE) clean install

$(EXE)$(NOMBRE): $(O)$(NOMBRE).o 
	@echo "\nGenerando => " $(NOMBRE)
	$(CC) $(INCLUDE) -o $(EXE)$(NOMBRE) $(O)$(NOMBRE).o $(OBJETOS_EXT) $(PROLDLIBS)

$(O)$(NOMBRE).o: $(C)$(NOMBRE).cpp
	@echo "\nGenerando => " $(NOMBRE).o
	$(CC) $(INCLUDE) -o $(O)$(NOMBRE).o -c $(C)$(NOMBRE).cpp

$(C)$(NOMBRE).cpp:
	@echo "\nGenerando => " $(NOMBRE).cpp
	$(PROC) $(PROCFLAGS) define=PROC userid=$(USUARIO) $(PROCINCLUDE) iname=$(PC)$(NOMBRE).pc code=cpp oname=$(C)$(NOMBRE).cpp HOLD_CURSOR=YES RELEASE_CURSOR=NO 

clean:
	$(RMF) $(C)$(NOMBRE).cpp
	$(RMF) $(O)$(NOMBRE).o 

cleanall: clean
	$(RMF) $(EXE)$(NOMBRE)

install:
	$(CPF) $(NOMBRE)	$(XPF_EXE) 
