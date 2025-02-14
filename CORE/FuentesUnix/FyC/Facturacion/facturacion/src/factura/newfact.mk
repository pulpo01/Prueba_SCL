include $(FA_CFG_PATH)/env_precomp.mk
INCLUDE=$(I_SYM)$(FA_INC_PATH) $(I_SYM)$(XPF_INC) $(I_SYM)$(ORACLE_HOME)/precomp/public

FUENTES=facturaC.c facturAux.c
OBJETOS=facturaC.o facturAux.o 

OBJETOS_EXT= $(FA_LIB_PATH)/prebilling.o $(FA_LIB_PATH)/prebilext.o $(FA_LIB_PATH)/prebilcic.o $(FA_LIB_PATH)/prebilbaj.o $(FA_LIB_PATH)/prebilnot.o $(FA_LIB_PATH)/prebilext.o $(FA_LIB_PATH)/prebilco.o $(FA_LIB_PATH)/GenFA.o $(FA_LIB_PATH)/FaORA.o $(FA_LIB_PATH)/ORAcarga.o $(FA_LIB_PATH)/errores.o $(FA_LIB_PATH)/preabo.o $(FA_LIB_PATH)/preser.o $(FA_LIB_PATH)/prenot.o $(FA_LIB_PATH)/New_pretar.o $(FA_LIB_PATH)/presac.o $(FA_LIB_PATH)/preext.o $(FA_LIB_PATH)/imptoiva.o $(FA_LIB_PATH)/composi.o $(FA_LIB_PATH)/comora.o $(FA_LIB_PATH)/precuo.o $(FA_LIB_PATH)/compos.o $(FA_LIB_PATH)/precob.o $(FA_LIB_PATH)/recargos.o $(FA_LIB_PATH)/descuentos.o $(XPF_LIB)/geora.o $(XPF_LIB)/rutinasgen.o $(XPF_LIB)/trazafact.o $(XPF_LIB)/New_Interfact.o $(XPF_LIB)/PlanDcto.o $(XPF_LIB)/PlanVcto.o $(XPF_LIB)/MtoMinFact.o


PROJECTO=newfact

all: $(PROJECTO) install
$(PROJECTO): $(OBJETOS) $(OBJETOS_EXT)
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -o $(PROJECTO) \
                                            -L$(ORACLE_HOME)/lib \
                                            -L$(ORACLE_HOME)/network/lib \
                                            -L$(ORACLE_HOME)/rdbms/lib \
                                             $(PROLDLIBS) 
facturaC.o: facturaC.c 
	$(CC) $(CFLAGS) -c facturaC.c
facturAux.o: facturAux.c
	$(CC) $(CFLAGS) -c facturAux.c
install:
	cp newfact  $(FA_BIN_PATH)/newfact
clean:
	-rm facturaC.o
	-rm facturAux.o
