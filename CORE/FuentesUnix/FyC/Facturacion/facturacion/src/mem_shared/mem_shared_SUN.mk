include $(FA_ENV_PRECOM)

THREADS=YES
#USERPASS=OPS\$$XPFACTUR/xpfactur
#USERPASS=factura/factura

SRCPC 		= tablasora.pc
SRCS1 		= tablasora.c
SRCC2 		= shared.c tablas.c mem_shared.c
SRCC4  		= shared.c tablas.c lector.c
INCS  		= $(FA_INC_PATH)/tablas.h $(FA_INC_PATH)/shared.h /usr/include/pthread.h $(FA_INC_PATH)/semap.h
INCX  		= $(GE_INC_PATH)/GenORA.h
#----------------
PROJ1  		= carga_inicial
PROJ3  		= limpiar_shared
PROJ4		= lector

OBJS1 		= carga_inicial.o tablas.o general.o shared.o semap.o tablasora.o $(GE_LIB_PATH)/GenORA.o
OBJS4   	= tablasora.o tablas.o shared.o semap.o general.o lector.o
OBJS3   	= limpiar_shared.o shared.o general.o
OBJETOS_EXT1    =$(FA_LIB_PATH)/carga_inicial.o $(FA_LIB_PATH)/tablas.o $(FA_LIB_PATH)/general.o $(FA_LIB_PATH)/shared.o $(FA_LIB_PATH)/semap.o $(FA_LIB_PATH)/tablasora.o $(GE_LIB_PATH)/GenORA.o $(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/trazafact.o
OBJETOS_EXT3    =$(FA_LIB_PATH)/limpiar_shared.o $(FA_LIB_PATH)/general.o $(FA_LIB_PATH)/shared.o
OBJETOS_EXT4    =$(FA_LIB_PATH)/lector.o $(FA_LIB_PATH)/tablas.o $(FA_LIB_PATH)/general.o $(FA_LIB_PATH)/shared.o $(FA_LIB_PATH)/semap.o $(FA_LIB_PATH)/tablasora.o $(GE_LIB_PATH)/GenORA.o
#----------------
OBJS2 		= tablasora.o tablas.o shared.o semap.o general.o mem_shared.o
OBJX  		= $(GE_LIB_PATH)/GenORA.o $(FA_HOME)/generales/src/ORAcarga/o/ORAcarga.o /usr/lib/libposix4.so
LIBX  		= -L$(FA_HOME)/lib
OBJETOS_EXT2    = $(FA_LIB_PATH)/mem_shared.o $(FA_LIB_PATH)/tablas.o $(FA_LIB_PATH)/general.o $(FA_LIB_PATH)/shared.o $(FA_LIB_PATH)/semap.o $(FA_LIB_PATH)/tablasora.o $(GE_LIB_PATH)/GenORA.o

all: $(OBJS2) $(PROJ1) $(PROJ3) $(PROJ4) install copia 

#----------------
$(PROJ1): $(OBJS1)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -g -o $(PROJ1) $(OBJETOS_EXT1) $(PROLDLIBS) -lthread
$(PROJ3): $(OBJS3)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -g -o $(PROJ3) $(OBJETOS_EXT3) $(PROLDLIBS) -lthread
$(PROJ4): $(OBJS4)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -g -o $(PROJ4) $(OBJETOS_EXT4) $(PROLDLIBS) -lthread
#----------------
semap.o: $(C)semap.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)semap.c -g -o $(FA_LIB_PATH)/semap.o
general.o: $(C)general.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)general.c -g -o $(FA_LIB_PATH)/general.o
tablasora.c: $(PC)tablasora.pc $(INCS) $(INCX)
	@echo $(FA_PROCFLAGS)
	$(PROC) $(FA_PROCFLAGS) threads=yes code=ansi_c userid=$(USERPASS) iname=$(PC)tablasora.pc oname=$(C)tablasora.c
tablasora.o: tablasora.c $(INCS) $(INCX) 
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -c $(C)tablasora.c -g -o $(FA_LIB_PATH)/tablasora.o 
tablas.o: $(C)tablas.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -c $(C)tablas.c -g -o $(FA_LIB_PATH)/tablas.o
 shared.o: $(C)shared.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -c $(C)shared.c -g -o $(FA_LIB_PATH)/shared.o
mem_shared.o: $(C)mem_shared.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)mem_shared.c -g -o $(FA_LIB_PATH)/mem_shared.o
carga_inicial.o: $(C)carga_inicial.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)carga_inicial.c -g -o $(FA_LIB_PATH)/carga_inicial.o
limpiar_shared.o: $(C)limpiar_shared.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -c $(C)limpiar_shared.c -g -o $(FA_LIB_PATH)/limpiar_shared.o
lector.o: $(C)lector.c $(INCS) $(INCX)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)lector.c -g -o $(FA_LIB_PATH)/lector.o

clean:

install:
	#-cp $(FA_LIB_PATH)/general.o	$(FA_LIB_PATH)/general.o	
	#-cp $(FA_LIB_PATH)/semap.o	$(FA_LIB_PATH)/semap.o
	#-cp $(FA_LIB_PATH)/shared.o	$(FA_LIB_PATH)/shared.o
	#-cp $(FA_LIB_PATH)/tablas.o	$(FA_LIB_PATH)/tablas.o
	#-cp $(FA_LIB_PATH)/tablasora.o	$(FA_LIB_PATH)/tablasora.o
	#-cp $(FA_LIB_PATH)/mem_shared.o	$(FA_LIB_PATH)/mem_shared.o
	
copia:
	@echo -------------------------------------------------------
	@echo            Copiando ejecutable a XPFACTUR
	@echo -------------------------------------------------------
	-mv carga_inicial $(XPF_EXE)
	-mv limpiar_shared $(XPF_EXE)
	-mv lector $(XPF_EXE)
	#-cp shell/coordinador_MC $(XPF_EXE)
	-cp shell/datos.txt $(XPF_CFG)
	chmod 775 $(XPF_CFG)/datos.txt
	#-cp $(XPF_EXE)/carga_inicial $(HOME)/facturacion/exe/
	#-cp $(XPF_EXE)/limpiar_shared $(HOME)/facturacion/exe/
	#-cp $(XPF_EXE)/lector $(HOME)/facturacion/exe/
	#-cp $(XPF_EXE)/coordinador_MC $(HOME)/facturacion/exe/
	@echo =======================================================

	
