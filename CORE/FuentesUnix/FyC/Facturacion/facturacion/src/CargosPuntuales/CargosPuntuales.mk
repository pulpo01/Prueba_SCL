#-xO4 
FLAGS_CC32=-xO4 -xarch=v8plus -library=stlport4 -staticlib=stlport4 -D_ENABLE_UPDATE_INSERT
FLAGS_CC64=-xO4 -xarch=v9 -library=stlport4 -staticlib=stlport4 -D_ENABLE_UPDATE_INSERT
#FLAGS_MTCC=-mt -D_REENTRANT 

COMP_CC_MT32=CC $(FLAGS_CC32) 
COMP_CC32=CC $(FLAGS_CC32)
COMP_CC_MT64=CC $(FLAGS_CC64) 
COMP_CC64=CC $(FLAGS_CC64)

COMP32=$(COMP_CC_MT32)
COMP64=$(COMP_CC_MT64)

ORA=$(ORACLE_HOME)

LIBS_32=-lrt -lnsl
#LIBMT_32=-L/usr/lib/lwp -lthread

LIB_ORACLE_32=-L$(ORA)/lib -lclntsh
INC_ORA=-I$(ORA)/rdbms/demo -I$(ORA)/rdbms/public

GEN=$(HOME)/rao/sharedCpp/
LIB_GEN=$(GEN)lib/
INC_GEN=$(GEN)include/

INC_H_TMP=-I$(INC_GEN)

INC_H=$(INC_H_TMP) -I./src/h

OBJ_01=$(LIB_GEN)genFact.o
OBJ_02=$(LIB_GEN)HostId.o
OBJ_03=$(LIB_GEN)data_service.o
OBJ_04=$(LIB_GEN)LogBuffer.o
OBJ_05=$(LIB_GEN)maps_tables.o
OBJ_07=$(LIB_GEN)process_controler.o

OBJ=$(OBJ_01) $(OBJ_02) $(OBJ_03) $(OBJ_04) $(OBJ_05) $(OBJ_07) 

BIN=$(XPF_EXE)/

all: 64

32:
	$(COMP32) ./cpp/CargosPuntuales.cpp -o $(BIN)CargosPuntuales  $(OBJ) $(INC_H) $(INC_ORA) $(LIBS_32) $(LIB_ORACLE_32)

64:
	$(COMP64) ./cpp/CargosPuntuales.cpp -o $(BIN)CargosPuntuales $(OBJ) $(INC_H) $(INC_ORA) $(LIBS_32) $(LIB_ORACLE_32)

clean:
	rm -f $(BIN)CargosPuntuales
	clear
