all:
	@echo; \
	echo; \
	echo Compilando PrintQueue;\
	echo; \
	make -f PrintQueue_SUN.mk all;\
	echo; \
	echo; \
	echo Compilando impresion_new;\
	echo; \
	make -f impresion_new_SUN.mk all;
#carrier 
