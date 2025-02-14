include $(FA_ENV_PRECOM)
INC_ORA=-I$(ORACLE_HOME)/rdbms/demo -I$(ORACLE_HOME)/rdbms/public -I$(FA_INC_PATH)
ORA_NEEDS=$(INC_ORA) -L$(ORACLE_HOME)/lib64 -lclntsh

INC_OTL=/usr/include/
EXE=$(XPF_EXE)/

all: INICIO carga_inicial_ImpScl
	@echo ""
	@echo "Compilacion de carga_inicial_ImpScl"
	@echo ""

INICIO:
	@echo ""
	@echo "-----------> COMPILACION DE carga_inicial_ImpScl <------------"
	@echo ""

carga_inicial_ImpScl: cpp/carga_inicial_ImpScl.cpp h/carga_inicial_ImpScl.h
	g++ -m64 $(DEBUG) -g -Wno-deprecated -o $(EXE)carga_inicial_ImpScl $(ORA_NEEDS) \
		-I$(INC_OTL) \
		-I./h \
		cpp/carga_inicial_ImpScl.cpp 

cleanall:
	rm -f carga_inicial_ImpScl

clean:
	touch cpp/carga_inicial_ImpScl.cpp
