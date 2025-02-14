include $(FA_ENV_PRECOM)

MODULO=PlanDcto

EXE=$(XPF_EXE)/

FUENTE_PROC = $(PC)$(MODULO).pc
FUENTE_INTERMEDIO = $(C)$(MODULO).c
FUENTE_DEFINE = $(H)$(MODULO).h
OBJETO = $(O)$(MODULO).o

all:$(OBJETO) install

$(FUENTE_INTERMEDIO): $(FUENTE_PROC)
	$(PROC) MODE=ORACLE $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(FUENTE_PROC) oname=$(FUENTE_INTERMEDIO)

$(OBJETO): $(FUENTE_INTERMEDIO) $(FUENTE_DEFINE)
	$(CC) $(CFLAGS) -c  $(FUENTE_INTERMEDIO) -o $(OBJETO)

install:
	-cp $(OBJETO) $(FA_LIB_PATH)
	-cp $(FUENTE_DEFINE) $(FA_INC_PATH)

clean: 
	-rm $(OBJETO) $(FUENTE_INTERMEDIO)

startel1:
	-$(RCP) $(FUENTE_PROC)		startel1:facturacion/src/PlanDcto/pc
	-$(RCP) $(FUENTE_DEFINE)	startel1:facturacion/src/PlanDcto/h
