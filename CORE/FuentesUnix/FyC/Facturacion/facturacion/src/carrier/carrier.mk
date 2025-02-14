all:
	@echo; \
	echo; \
	echo Compilando forfac_2000;\
	echo; \
	cd forfac_2000;\
	make -f forfac_2000_SUN.mk all;\
	cd ..;\
	echo; \
	echo; \
	echo Compilando fortas_2000;\
	echo; \
	cd fortas_2000;\
	make -f fortas_2000_SUN.mk all;\
	cd ..;
clean:
	@echo; \
	echo; \
	echo Compilando forfac_2000;\
	echo; \
	cd forfac_2000;\
	make -f forfac_2000_SUN.mk clean;\
	cd ..;\
	echo; \
	echo; \
	echo Compilando fortas_2000;\
	echo; \
	cd fortas_2000;\
	make -f fortas_2000_SUN.mk clean;\
	cd ..;
#carrier 
