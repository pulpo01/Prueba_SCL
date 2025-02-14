#Archivo makefile con configuracion para compilar en C
#Asigne el nombre de su aplicacion a la variable
#siguiente.

NOMBRE=rpt_reclamos_suptel

include $(ENV_PRECOMP)
USUARIO=$(PARAM)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(ORACLE_HOME)/precomp/public

OBJ_EXTERNO=$(GE_LIB_PATH)/geora.o 

##CFLAGS += -I$(H)
PROCFLAGS=ireclen=255 oreclen=255 include=$(H) \
	sqlcheck=full userid=$(USUARIO) SQLCHECK=SEMANTICS

RMF=rm -f
CC =cc

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=./

APLICACION=$(EXE)$(NOMBRE)
OBJETO_LOCAL=$(O)$(NOMBRE).o
INTERMEDIO_C=$(C)$(NOMBRE).c
FUENTE_PC=$(PC)$(NOMBRE).pc
#CABECERA_H=$(H)$(NOMBRE).h

all:$(APLICACION)

$(APLICACION):$(OBJETO_LOCAL) 
	$(CC) $(CFLAGS) -o $(APLICACION) $(OBJETO_LOCAL)  $(OBJ_EXTERNO) $(PROLDLIBS)
	echo "Fin Linking"

$(OBJETO_LOCAL):$(FUENTE_PC) 
	$(PROC) $(PROCFLAGS) iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)
	echo "Fin Proc"	
	$(CC) $(CFLAGS) -o $(OBJETO_LOCAL) -c $(INTERMEDIO_C)
	echo "Fin de Compilacion "

clean:
	$(RMF) $(INTERMEDIO_C)
	$(RMF) $(OBJETO_LOCAL)

cleanall: clean
	$(RMF) $(APLICACION)


