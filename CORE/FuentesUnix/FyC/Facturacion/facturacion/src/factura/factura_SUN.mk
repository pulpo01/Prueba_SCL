include $(FA_ENV_PRECOM)

FUENTES=facturaC.c facturAux.c
OBJETOS=facturaC.o facturAux.o 

OBJETOS_EXT=$(FA_LIB_PATH)/prebilling.o $(FA_LIB_PATH)/prebilext.o $(FA_LIB_PATH)/prebilcic.o $(FA_LIB_PATH)/prebilbaj.o $(FA_LIB_PATH)/prebilnot.o $(FA_LIB_PATH)/prebilco.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/EncriptaSha1.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/errores.o $(FA_LIB_PATH)/preabo.o $(FA_LIB_PATH)/preser.o $(FA_LIB_PATH)/prenot.o $(FA_LIB_PATH)/pretar.o $(FA_LIB_PATH)/presac.o $(FA_LIB_PATH)/preext.o $(FA_LIB_PATH)/imptoiva.o $(FA_LIB_PATH)/composi.o $(FA_LIB_PATH)/comora.o $(FA_LIB_PATH)/precuo.o $(FA_LIB_PATH)/compos.o $(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/trazafact.o  $(GE_LIB_PATH)/New_Interfact.o $(FA_LIB_PATH)/PlanDcto.o $(FA_LIB_PATH)/PlanVcto.o $(FA_LIB_PATH)/MtoMinFact.o $(FA_LIB_PATH)/mem_shared.o $(FA_LIB_PATH)/semap.o $(FA_LIB_PATH)/shared.o $(FA_LIB_PATH)/tablas.o $(FA_LIB_PATH)/tablasora.o $(FA_LIB_PATH)/general.o $(FA_LIB_PATH)/precar.o

PROJECTO=facturaC  


all: $(PROJECTO) install copia
$(PROJECTO): $(OBJETOS) $(OBJETOS_EXT)
	@echo -------------------------------------------------------
	@echo                  Compilando EXE
	@echo -------------------------------------------------------	
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  $(O)facturaC.o $(O)facturAux.o  $(OBJETOS_EXT) -o $(XPF_EXE)/$(PROJECTO) $(PROLDLIBS) 


facturaC.o: facturaC.c
	@echo -------------------------------------------------------
	@echo                  Compilando facturaC
	@echo -------------------------------------------------------
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)facturaC.c -o $(O)facturaC.o

facturAux.o: facturAux.c
	@echo -------------------------------------------------------
	@echo                 Compilando facturAux
	@echo -------------------------------------------------------
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)facturAux.c -o $(O)facturAux.o

facturaC.c:
	@echo -------------------------------------------------------
	@echo               Precompilando facturaC
	@echo -------------------------------------------------------
	$(PROC) $(PROCFLAGS) MODE=ORACLE code=ansi_c userid=$(USERPASS) include=$(FA_INC_PATH) iname=$(PC)facturaC.pc oname=$(C)facturaC.c

facturAux.c:
	@echo -------------------------------------------------------
	@echo               Precompilando facturAux
	@echo -------------------------------------------------------
	$(PROC) $(PROCFLAGS) MODE=ORACLE code=ansi_c userid=$(USERPASS) include=$(FA_INC_PATH) iname=$(PC)facturAux.pc oname=$(C)facturAux.c
	

install:

clean:
	@echo =======================================================
	@echo Compiacion de facturaC
	@echo =======================================================
	@echo 
	@echo -------------------------------------------------------
	@echo             Borrando objetos intermedios
	@echo -------------------------------------------------------
	-rm $(C)facturaC.c
	-rm $(O)facturaC.o
	-rm $(O)facturAux.o

copia:
	@echo -------------------------------------------------------
	@echo            Copiando ejecutable a XPFACTUR
	@echo -------------------------------------------------------
	#-cp  $(XPF_EXE)/$(PROJECTO) $(EXPLOTACION)
	@echo =======================================================
	
