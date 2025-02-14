NOMBRE=ImpresionScl

include $(FA_ENV_PRECOM)
MODULOS=$(O)/ImpSclFnc.o $(O)/ImpSclA.o $(O)/ImpSclD.o $(O)/ImpSclB.o $(O)/memory_shared.o
OBJ_EXTERNO=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/New_Interfact.o $(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/utils.o 

RCP=@echo rcp -p

APLICACION=$(XPF_EXE)/$(NOMBRE)
#APLICACION=./exe/$(NOMBRE)
OBJETO_LOCAL=$(O)$(NOMBRE).o
INTERMEDIO_C=$(C)$(NOMBRE).c
FUENTE_PC=$(PC)$(NOMBRE).pc
CABECERA_H=$(H)$(NOMBRE).h

all: $(APLICACION) 

$(APLICACION) : $(MODULOS) $(OBJETO_LOCAL) $(OBJ_EXTERNO) 
	$(CC) $(CFLAGS) -g -o $(APLICACION) $(MODULOS) $(OBJETO_LOCAL) $(OBJ_EXTERNO) $(PROLDLIBS)

$(OBJETO_LOCAL) : $(INTERMEDIO_C)
	$(CC) -o $(OBJETO_LOCAL) $(CFLAGS) -g $(FA_INCLUDE) -c $(INTERMEDIO_C)

$(INTERMEDIO_C)	: $(FUENTE_PC)
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(FUENTE_PC) oname=$(INTERMEDIO_C)

clean:
	$(RMF) $(C)I*.c
	$(RMF) $(O)*.o

cleanall: clean
	${RMF} ${APLICACION}

$(O)/ImpSclFnc.o: $(C)/ImpSclFnc.c $(H)ImpSclSt.h $(H)ImpSclFnc.h
	$(CC) $(CFLAGS) -g -c $(C)ImpSclFnc.c -o $(O)ImpSclFnc.o -I$(FA_INC_PATH)

$(O)/memory_shared.o: $(C)/memory_shared.c $(H)shared_memory.h $(H)ImpSclSt.h 
	$(CC) $(CFLAGS) -g -c $(C)memory_shared.c -o $(O)memory_shared.o -I$(H) -I$(FA_INC_PATH)


$(C)/ImpSclFnc.c: $(PC)ImpSclFnc.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)ImpSclFnc.pc oname=$(C)ImpSclFnc.c

$(O)/ImpSclA.o: $(C)/ImpSclA.c  $(H)ImpSclA.h $(O)/ImpSclFnc.o
	$(CC) $(CFLAGS) -g -c $(C)ImpSclA.c -o $(O)ImpSclA.o $(O)/ImpSclFnc.o -I$(FA_INC_PATH)
	
$(C)/ImpSclA.c: $(PC)ImpSclA.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)ImpSclA.pc oname=$(C)ImpSclA.c

$(O)/ImpSclD.o: $(C)/ImpSclD.c  $(H)ImpSclD.h $(O)/ImpSclFnc.o
	$(CC) $(CFLAGS) -g -c $(C)ImpSclD.c -o $(O)ImpSclD.o $(O)/ImpSclFnc.o -I$(FA_INC_PATH)

$(C)/ImpSclD.c: $(PC)ImpSclD.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)ImpSclD.pc oname=$(C)ImpSclD.c

$(O)/ImpSclB.o: $(C)/ImpSclB.c  $(H)ImpSclB.h $(O)/ImpSclFnc.o $(O)/ImpSclD.o
	$(CC) $(CFLAGS) -g -c $(C)ImpSclB.c -o $(O)ImpSclB.o $(O)/ImpSclFnc.o $(O)/ImpSclD.o -I$(FA_INC_PATH)

$(C)/ImpSclB.c: $(PC)ImpSclB.pc
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)ImpSclB.pc oname=$(C)ImpSclB.c
