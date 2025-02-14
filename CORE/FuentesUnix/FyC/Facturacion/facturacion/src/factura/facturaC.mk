#
# Makefile original: facturaC.mk.old
# Fecha y hora de generacion: 2002-05-07 11:10:55
#
include $(ENV_PRECOMP)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(FA_INC_PATH) $(I_SYM)$(ORACLE_HOME)/precomp/public

FUENTES=facturaC.c facturAux.c
OBJETOS=facturaC.o facturAux.o 

OBJETOS_EXT=$(FA_LIB_PATH)/genco.o $(FA_LIB_PATH)/recargos.o $(FA_LIB_PATH)/prebilling.o $(FA_LIB_PATH)/prebilext.o $(FA_LIB_PATH)/prebilcic.o $(FA_LIB_PATH)/prebilbaj.o $(FA_LIB_PATH)/prebilnot.o $(FA_LIB_PATH)/prebilext.o $(FA_LIB_PATH)/prebilco.o $(FA_LIB_PATH)/GenFA.o $(FA_LIB_PATH)/FaORA.o $(FA_LIB_PATH)/ORAcarga.o $(FA_LIB_PATH)/errores.o $(FA_LIB_PATH)/preabo.o $(FA_LIB_PATH)/preser.o $(FA_LIB_PATH)/prenot.o $(FA_LIB_PATH)/pretar.o $(FA_LIB_PATH)/presac.o $(FA_LIB_PATH)/preext.o $(FA_LIB_PATH)/imptoiva.o $(FA_LIB_PATH)/composi.o $(FA_LIB_PATH)/comora.o $(FA_LIB_PATH)/precuo.o $(FA_LIB_PATH)/compos.o $(FA_LIB_PATH)/precob.o $(FA_LIB_PATH)/geora.o $(FA_LIB_PATH)/rutinasgen.o $(FA_LIB_PATH)/trazafact.o  $(FA_LIB_PATH)/New_Interfact.o $(FA_LIB_PATH)/PlanDcto.o $(FA_LIB_PATH)/PlanVcto.o $(FA_LIB_PATH)/MtoMinFact.o 

#$(FA_LIB_PATH)/fac.o
#$(FA_LIB_PATH)/recargos.o 

EXE=$(XPF_EXE)/

PROJECTO=facturaC  

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=$(XPF_EXE)/

all: $(PROJECTO) install
$(PROJECTO): $(OBJETOS) $(OBJETOS_EXT)
	@cp $(H)factura.h $(FA_INC_PATH)/factura.h
	$(CC) $(CFLAGS) $(O)facturaC.o $(O)facturAux.o  $(OBJETOS_EXT) -o $(EXE)$(PROJECTO) $(PROLDLIBS) 

facturaC.o: $(C)facturaC.c 
	$(CC) $(CFLAGS) -c $(C)facturaC.c -o $(O)facturaC.o

facturAux.o: $(C)facturAux.c
	$(CC) $(CFLAGS) -c $(C)facturAux.c -o $(O)facturAux.o

install:
	
	
	

clean:
	-rm $(O)facturaC.o
	-rm $(O)facturAux.o
	-rm $(EXE)facturaD 
