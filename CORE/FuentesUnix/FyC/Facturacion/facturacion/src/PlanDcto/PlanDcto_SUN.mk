include $(FA_ENV_PRECOM)

MODULO=PlanDcto

EXE=$(XPF_EXE)/

FUENTE_PROC = $(PC)$(MODULO).pc
FUENTE_INTERMEDIO = $(C)$(MODULO).c
FUENTE_DEFINE = $(FA_INC_PATH)/$(MODULO).h
OBJETO = $(FA_LIB_PATH)/$(MODULO).o

all:$(OBJETO) install

$(FUENTE_INTERMEDIO): $(FUENTE_PROC)
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(FUENTE_PROC) oname=$(FUENTE_INTERMEDIO)

$(OBJETO): $(FUENTE_INTERMEDIO) $(FUENTE_DEFINE)
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c  $(FUENTE_INTERMEDIO) -o $(OBJETO)

install:

clean: 
	$(RMF) $(FUENTE_INTERMEDIO)
	$(RMF) $(OBJETO)

startel1:
	-$(RCP) $(FUENTE_PROC)		startel1:facturacion/src/PlanDcto/pc
	-$(RCP) $(FUENTE_DEFINE)	startel1:facturacion/src/PlanDcto/h
