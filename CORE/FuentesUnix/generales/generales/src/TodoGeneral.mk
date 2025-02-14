PROGS = utils GenORA genco FaORA errores trazafact rutinasgen New_Interfact geora GenFA ORAcarga EncriptaSha1
 
all:
	@for i in $(PROGS); \
	  do  \
		echo; \
		echo; \
		echo Compilando $$i;\
		echo; \
		cd $$i;\
		make -f *.mk all; \
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
		make -f *.mk clean; \
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
		make -f *.mk install; \
		cd ..;\
	done; 

#carrier 
 
