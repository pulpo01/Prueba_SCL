PROGS = PlanVcto composicion composicion1 impuestos MtoMinFact PlanDcto prebilling premod mem_shared factura

all:
	@for i in $(PROGS); \
	  do  \
		echo; \
		echo; \
		echo Compilando $$i;\
		echo; \
		cd $$i;\
		make -f *SUN.mk all; \
		#make install; \
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

#install:
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
