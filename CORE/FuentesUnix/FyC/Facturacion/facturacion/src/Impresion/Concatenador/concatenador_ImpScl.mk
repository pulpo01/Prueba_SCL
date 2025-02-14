####include $(FA_ENV_PRECOM)
INC_ORA=-I$(ORACLE_HOME)/rdbms/demo -I$(ORACLE_HOME)/rdbms/public -I$(FA_INC_PATH)
ORA_NEEDS=$(INC_ORA) -L$(ORACLE_HOME)/lib64 -lclntsh

INC_OTL=/usr/include/
EXE=$(XPF_EXE)/

all: INICIO concatenador
	@echo ""
	@echo "Compilacion de concatenador"
	@echo ""

INICIO:
	@echo ""
	@echo "-----------> COMPILACION DE concatenador <------------"
	@echo ""

concatenador: cpp/concatenador.cpp h/concatenador.h 
	g++ -m64 $(DEBUG) -g -Wno-deprecated -o $(EXE)concatenador $(ORA_NEEDS) \
		-I$(INC_OTL) \
		-I./h \
		-I../Carga_inicial_ImpSCL/h \
		cpp/concatenador.cpp 

cleanall:
	rm -f concatenador

clean:
	touch cpp/concatenador.cpp
