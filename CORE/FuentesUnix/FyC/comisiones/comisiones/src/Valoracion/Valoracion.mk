PROGS = Bajas Campana Cartera Churn Conceptos ConvenioPAC Documentacion Evaluaciones HabilPrepago Permanencia Recargas TrafPrepago

all:
	@for i in $(PROGS); \
	  do  \
		echo; \
		echo; \
		echo Compilando $$i;\
		echo; \
		cd $$i;\
		make  all; \
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
		make clean; \
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
		make install; \
		cd ..;\
	done; 
