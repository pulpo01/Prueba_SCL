#-xO4 
FLAGS_CC32=-xO4 -xarch=v8plus -library=stlport4 -staticlib=stlport4 -D_ENABLE_UPDATE_INSERT
FLAGS_CC64=-xO4 -xarch=v9 -library=stlport4 -staticlib=stlport4 -D_ENABLE_UPDATE_INSERT
FLAGS_MTCC=-mt -D_REENTRANT 

COMP_CC_MT32=CC $(FLAGS_CC32) $(FLAGS_MTCC)
COMP_CC32=CC $(FLAGS_CC32)
COMP_CC_MT64=CC $(FLAGS_CC64) $(FLAGS_MTCC)
COMP_CC64=CC $(FLAGS_CC64)

COMP32=$(COMP_CC_MT32)
COMP64=$(COMP_CC_MT64)

ORA=$(ORACLE_HOME)

LIBS_32=-lrt -lnsl
LIBMT_32=-L/usr/lib/lwp -lthread

LIB_ORACLE_32=-L$(ORA)/lib -lclntsh
INC_ORA=-I$(ORA)/rdbms/demo -I$(ORA)/rdbms/public

INC_H_01=-I./librerias/cliente_locutorio/h
INC_H_02=-I./librerias/cliente_locutorio_factory/h
INC_H_03=-I./librerias/data_service/h
INC_H_04=-I./librerias/eval_discount_matrix/h
INC_H_05=-I./librerias/hr_time_clock/h
INC_H_06=-I./librerias/LogBuffer/h
INC_H_07=-I./librerias/maps_tables/h
INC_H_08=-I./librerias/Mutex/h
INC_H_09=-I./librerias/myString/h
INC_H_10=-I./librerias/ora_oci_number/h
INC_H_11=-I./librerias/otl/h
INC_H_12=-I./librerias/plan_discount/h
INC_H_13=-I./librerias/process_clock/h
INC_H_14=-I./librerias/process_controler/h
INC_H_15=-I./librerias/process_core/h
INC_H_16=-I./librerias/process_core_exception/h
INC_H_17=-I./librerias/process_thread/h
INC_H_18=-I./librerias/range_map/h
INC_H_19=-I./librerias/record_fetcher/h
INC_H_20=-I./librerias/shared_tables/h
INC_H_21=-I./librerias/simple_container_interface/h
INC_H_22=-I./librerias/Thread/h
INC_H_23=-I./src/h

INC_H_32=-I./include/ $(INC_H_01) $(INC_H_02) $(INC_H_03) $(INC_H_04) $(INC_H_05) $(INC_H_06) $(INC_H_07) $(INC_H_08) $(INC_H_09) $(INC_H_10) $(INC_H_11) $(INC_H_12) $(INC_H_13) $(INC_H_14) $(INC_H_15) $(INC_H_16) $(INC_H_17) $(INC_H_18) $(INC_H_19) $(INC_H_20) $(INC_H_21) $(INC_H_22) $(INC_H_23)


OBJ_01=./librerias/cliente_locutorio_factory/o/cliente_locutorio_factory.o
OBJ_02=./librerias/data_service/o/data_service.o
OBJ_03=./librerias/eval_discount_matrix/o/eval_discount_matrix.o
OBJ_04=./librerias/LogBuffer/o/LogBuffer.o
OBJ_05=./librerias/maps_tables/o/maps_tables.o
OBJ_06=./librerias/Mutex/o/Mutex.o
OBJ_07=./librerias/process_controler/o/process_controler.o
OBJ_08=./librerias/process_core/o/process_core.o
OBJ_09=./librerias/record_fetcher/o/record_fetcher.o
OBJ_10=./librerias/shared_tables/o/shared_tables.o
OBJ_11=./librerias/Thread/o/Thread.o

OBJ_32=$(OBJ_01) $(OBJ_02) $(OBJ_03) $(OBJ_04) $(OBJ_05) $(OBJ_06) $(OBJ_07) $(OBJ_08) $(OBJ_09) $(OBJ_10) $(OBJ_11)

BIN=../../exe/

all: 64

32:
	$(COMP32) -o ./librerias/cliente_locutorio_factory/o/cliente_locutorio_factory.o -c ./librerias/cliente_locutorio_factory/cpp/cliente_locutorio_factory.cpp $(INC_H_32)  $(INC_ORA)
	$(COMP32) -o ./librerias/data_service/o/data_service.o -c ./librerias/data_service/cpp/data_service.cpp $(INC_H_32)  $(INC_ORA)
	$(COMP32) -o ./librerias/eval_discount_matrix/o/eval_discount_matrix.o -c ./librerias/eval_discount_matrix/cpp/eval_discount_matrix.cpp $(INC_H_32)  $(INC_ORA)
	$(COMP32) -o ./librerias/LogBuffer/o/LogBuffer.o -c ./librerias/LogBuffer/cpp/LogBuffer.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/maps_tables/o/maps_tables.o -c ./librerias/maps_tables/cpp/maps_tables.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/Mutex/o/Mutex.o -c ./librerias/Mutex/cpp/Mutex.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/process_controler/o/process_controler.o -c ./librerias/process_controler/cpp/process_controler.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/process_core/o/process_core.o -c ./librerias/process_core/cpp/process_core.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/record_fetcher/o/record_fetcher.o -c ./librerias/record_fetcher/cpp/record_fetcher.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/shared_tables/o/shared_tables.o -c ./librerias/shared_tables/cpp/shared_tables.cpp $(INC_H_32) $(INC_ORA)
	$(COMP32) -o ./librerias/Thread/o/Thread.o -c ./librerias/Thread/cpp/Thread.cpp $(INC_H_32) $(INC_ORA)

	$(COMP32) ./src/cpp/dctosLoc.cpp -o $(BIN)dctosLoc  $(OBJ_32) $(INC_H_32) $(INC_ORA) $(LIBS_32) $(LIBMT_32) $(LIB_ORACLE_32)

64:
	$(COMP64) -o ./librerias/cliente_locutorio_factory/o/cliente_locutorio_factory.o -c ./librerias/cliente_locutorio_factory/cpp/cliente_locutorio_factory.cpp $(INC_H_32)  $(INC_ORA)
	$(COMP64) -o ./librerias/data_service/o/data_service.o -c ./librerias/data_service/cpp/data_service.cpp $(INC_H_32)  $(INC_ORA)
	$(COMP64) -o ./librerias/eval_discount_matrix/o/eval_discount_matrix.o -c ./librerias/eval_discount_matrix/cpp/eval_discount_matrix.cpp $(INC_H_32)  $(INC_ORA)
	$(COMP64) -o ./librerias/LogBuffer/o/LogBuffer.o -c ./librerias/LogBuffer/cpp/LogBuffer.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/maps_tables/o/maps_tables.o -c ./librerias/maps_tables/cpp/maps_tables.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/Mutex/o/Mutex.o -c ./librerias/Mutex/cpp/Mutex.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/process_controler/o/process_controler.o -c ./librerias/process_controler/cpp/process_controler.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/process_core/o/process_core.o -c ./librerias/process_core/cpp/process_core.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/record_fetcher/o/record_fetcher.o -c ./librerias/record_fetcher/cpp/record_fetcher.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/shared_tables/o/shared_tables.o -c ./librerias/shared_tables/cpp/shared_tables.cpp $(INC_H_32) $(INC_ORA)
	$(COMP64) -o ./librerias/Thread/o/Thread.o -c ./librerias/Thread/cpp/Thread.cpp $(INC_H_32) $(INC_ORA)

	$(COMP64) ./src/cpp/dctosLoc.cpp -o $(BIN)dctosLoc $(OBJ_32) $(INC_H_32) $(INC_ORA) $(LIBS_32) $(LIBMT_32) $(LIB_ORACLE_32)

clean:
	rm -f $(OBJ_32)
	rm -f $(BIN)dctosLoc
	clear
