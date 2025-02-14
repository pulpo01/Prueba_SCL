PROGS = General Reversa PasoHistorico Seleccion Valoracion Acumulacion Cierre Liquidacion  Extractores

all:
	@for i in $(PROGS); \
	  do  \
		echo; \
		echo; \
		echo Compilando $$i;\
		echo; \
		cd $$i;\
		make -f $$i.mk all; \
		cd ..;\
	done; 

clean:
	@for i in $(PROGS); \
	  do  \
		echo; \
		echo; \
		echo Borrando $$i;\
		echo; \
		cd $$i;\
		make -f $$i.mk clean; \
		cd ..;\
	done; 

install:
	@for i in $(PROGS); \
	  do  \
		echo; \
		echo; \
		echo Instalando $$i;\
		echo; \
		cd $$i;\
		make -f $$i.mk install; \
		cd ..;\
	done; 
