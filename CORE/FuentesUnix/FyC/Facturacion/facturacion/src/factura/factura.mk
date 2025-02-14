include $(FA_CFG_PATH)/env_precomp.mk
INCLUDE=$(I_SYM)$(FA_INC_PATH) $(I_SYM)$(FA_INC_PATH) $(I_SYM)$(ORACLE_HOME)/precomp/public

FUENTES=factura.c facturAux.c
OBJETOS=factura.o facturAux.o 

OBJETOS_EXT= $(FA_LIB_PATH)/prebilling.o $(FA_LIB_PATH)/prebilext.o $(FA_LIB_PATH)/prebilcic.o $(FA_LIB_PATH)/prebilco.o $(FA_LIB_PATH)/prebilbaj.o $(FA_LIB_PATH)/prebilnot.o $(FA_LIB_PATH)/GenFA.o $(FA_LIB_PATH)/FaORA.o $(FA_LIB_PATH)/ORAcarga.o $(FA_LIB_PATH)/errores.o $(FA_LIB_PATH)/preabo.o $(FA_LIB_PATH)/preser.o $(FA_LIB_PATH)/pretar.o $(FA_LIB_PATH)/preext.o $(FA_LIB_PATH)/presac.o $(FA_LIB_PATH)/prenot.o $(FA_LIB_PATH)/imptoiva.o $(FA_LIB_PATH)/composi.o $(FA_LIB_PATH)/comora.o $(FA_LIB_PATH)/descuentos.o $(FA_LIB_PATH)/precuo.o $(FA_LIB_PATH)/precob.o $(FA_LIB_PATH)/compos.o $(FA_LIB_PATH)/geora.o $(FA_LIB_PATH)/rutinasgen.o $(FA_LIB_PATH)/trazafact.o  $(FA_LIB_PATH)/New_Interfact.o $(FA_LIB_PATH)/recargos.o  $(FA_LIB_PATH)/PlanDcto.o $(FA_LIB_PATH)/PlanVcto.o 
EXE=$(XPF_EXE)/

PROJECTO=factura

all: $(PROJECTO) install
$(PROJECTO): $(OBJETOS) $(OBJETOS_EXT)
	@cp factura.h $(FA_INC_PATH)/factura.h
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(EXE)$(PROJECTO) \
                                            -L$(ORACLE_HOME)/lib \
                                            -L$(ORACLE_HOME)/network/lib \
                                            -L$(ORACLE_HOME)/rdbms/lib \
                                             $(PROLDLIBS) 

factura.o: factura.c 
	$(CC) $(CFLAGS) -c factura.c
facturAux.o: facturAux.c
	$(CC) $(CFLAGS) -c facturAux.c

install:
	cp factura.h $(FA_INC_PATH)/factura.h
	cp factura   $(FA_BIN_PATH)/factura
	cp facturAux.o $(FA_LIB_PATH)/facturAux.o

clean:
	-rm factura.o
	-rm facturAux.o
	-rm factura 
debug:
	cp ./*.c     ./../debug/
	cp ./*.h     ./../debug/
	cp ./*.o     ./../debug/
	cp ./factura ./../debug/
