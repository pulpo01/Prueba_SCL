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

INC_H_TMP=-I./include 

INC_H=-I./include/ $(INC_H_TMP) -I./src/h

OBJ_01=./lib/genFact.o
OBJ_02=./lib/HostId.o
OBJ_03=./lib/data_service.o
OBJ_04=./lib/LogBuffer.o
OBJ_05=./lib/maps_tables.o
OBJ_07=./lib/process_controler.o

OBJ=$(OBJ_01) $(OBJ_02) $(OBJ_03) $(OBJ_04) $(OBJ_05) $(OBJ_07) 

BIN=./src/exe/

all: 64


32:
	$(COMP32) -o ./lib/genFact.o -c ./src/genFact/cpp/genFact.cpp $(INC_H) $(INC_ORA)
	$(COMP32) -o ./lib/HostId.o -c ./src/HostId/cpp/HostId.cpp $(INC_H) $(INC_ORA)
	$(COMP32) -o ./lib/process_controler.o -c ./src/process_controler/cpp/process_controler.cpp $(INC_H) $(INC_ORA)

	$(COMP32) -o ./lib/data_service.o -c ./src/data_service/cpp/data_service.cpp $(INC_H)  $(INC_ORA)
	$(COMP32) -o ./lib/LogBuffer.o -c ./src/LogBuffer/cpp/LogBuffer.cpp $(INC_H) $(INC_ORA)
	$(COMP32) -o ./lib/maps_tables.o -c ./src/maps_tables/cpp/maps_tables.cpp $(INC_H) $(INC_ORA)

	$(COMP32) ./src/cpp/CargosPuntuales.cpp -o $(BIN)CargosPuntuales  $(OBJ) $(INC_H) $(INC_ORA) $(LIBS_32) $(LIB_ORACLE_32)

64:
	$(COMP64) -o ./lib/genFact.o -c ./src/genFact/cpp/genFact.cpp $(INC_H) $(INC_ORA)
	$(COMP64) -o ./lib/HostId.o -c ./src/HostId/cpp/HostId.cpp $(INC_H) $(INC_ORA)
	$(COMP64) -o ./lib/process_controler.o -c ./src/process_controler/cpp/process_controler.cpp $(INC_H) $(INC_ORA)

	$(COMP64) -o ./lib/data_service.o -c ./src/data_service/cpp/data_service.cpp $(INC_H)  $(INC_ORA)
	$(COMP64) -o ./lib/LogBuffer.o -c ./src/LogBuffer/cpp/LogBuffer.cpp $(INC_H) $(INC_ORA)
	$(COMP64) -o ./lib/maps_tables.o -c ./src/maps_tables/cpp/maps_tables.cpp $(INC_H) $(INC_ORA)

clean:
	rm -f $(OBJ)
	clear
