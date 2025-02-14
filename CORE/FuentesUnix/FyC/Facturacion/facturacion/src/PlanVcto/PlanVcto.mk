#
# Makefile original: PlanVcto.mk.old
# Fecha y hora de generacion: 2002-05-06 18:31:03
#
#include $(GE_CFG_PATH)/env_precomp.mk
include $(FA_ENV_PRECOM)

PROCFLAGS  = ireclen=255 oreclen=255 include=$(H) include=$(FA_INC_PATH) 
INCLUDE=$(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(H) $(I_SYM)$(FA_INC_PATH) 

MODULO=PlanVcto

CPF=cp -f
RCP=@echo rcp -p

C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=$(XPF_EXE)/

FUENTE_PROC = $(PC)$(MODULO).pc
FUENTE_INTERMEDIO = $(C)$(MODULO).c
FUENTE_DEFINE = $(H)$(MODULO).h
OBJETO = $(O)$(MODULO).o

all:$(OBJETO) install

$(FUENTE_INTERMEDIO): $(FUENTE_PROC)
	$(PROC) MODE=ORACLE $(FA_PROCFLAGS) iname=$(FUENTE_PROC) oname=$(FUENTE_INTERMEDIO)

$(OBJETO): $(FUENTE_INTERMEDIO) $(FUENTE_DEFINE)
	$(CC) $(CFLAGS) -c  $(FUENTE_INTERMEDIO) -o $(OBJETO)

install:
	-cp $(OBJETO) $(FA_LIB_PATH)
	-cp $(FUENTE_DEFINE) $(FA_INC_PATH)

clean: 
	-rm $(OBJETO) $(FUENTE_INTERMEDIO)

startel1:
	-$(RCP) $(FUENTE_PROC)			startel1:facturacion/src/PlanVcto/pc
	-$(RCP) $(FUENTE_DEFINE)		startel1:facturacion/src/PlanVcto/h
