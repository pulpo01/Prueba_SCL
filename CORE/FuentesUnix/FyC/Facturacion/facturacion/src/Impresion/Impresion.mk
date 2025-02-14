all:
	@echo; \
	echo; \
	echo Compilando Carga_inicial_ImpSCL;\
	echo; \
	cd Carga_inicial_ImpSCL;\
	make -f carga_inicial_ImpScl.mk all;\
	cd ..;\
	echo; \
	echo; \
	echo Compilando Concatenador;\
	echo; \
	cd Concatenador;\
	make -f concatenador_ImpScl.mk all;\
	cd ..;\
	echo; \
	echo; \
	echo Compilando ImpresionSCL;\
	echo; \
	cd ImpresionSCL;\
	make -f ImpresionScl_SUN.mk all;\
	cd ..;
clean:
	@echo; \
	echo; \
	echo Borrando Carga_inicial_ImpSCL;\
	echo; \
	cd Carga_inicial_ImpSCL;\
	make -f carga_inicial_ImpScl.mk clean;\
	cd ..;\
	echo; \
	echo; \
	echo Borrando Concatenador;\
	echo; \
	cd Concatenador;\
	make -f concatenador_ImpScl.mk clean;\
	cd ..;\
	echo; \
	echo; \
	echo Borrando ImpresionSCL;\
	echo; \
	cd ImpresionSCL;\
	make -f ImpresionScl_SUN.mk clean;\
	cd ..;
#Impresion 
