NOMBRE=DobleCuenta

include $(FA_ENV_PRECOM)

OBJ_EXTERNO=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/GenFA.o $(GE_LIB_PATH)/errores.o $(GE_LIB_PATH)/ORAcarga.o $(GE_LIB_PATH)/trazafact.o $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/New_Interfact.o

APLICACION=$(XPF_EXE)/$(NOMBRE)
CABECERA_H=$(H)$(NOMBRE).h

FUENTES_PC=$(PC)$(NOMBRE).pc $(PC)$(NOMBRE)Fnc.pc
FUENTES_C=$(C)$(NOMBRE).c $(C)$(NOMBRE)Fnc.c
OBJETOS=$(O)$(NOMBRE).o $(O)$(NOMBRE)Fnc.o 

all: $(APLICACION)

$(APLICACION) : $(OBJETOS) $(OBJ_EXTERNO)
	$(CC) $(CFLAGS) -o $(APLICACION) $(OBJETOS) $(OBJ_EXTERNO) $(PROLDLIBS)

$(OBJETOS) : $(FUENTES_C)
	$(CC) -o $(O)$(NOMBRE).o $(CFLAGS) $(FA_INCLUDE) -c $(C)$(NOMBRE).c
	$(CC) -o $(O)$(NOMBRE)Fnc.o $(CFLAGS) $(FA_INCLUDE) -c $(C)$(NOMBRE)Fnc.c
	@echo

$(FUENTES_C) : $(FUENTES_PC)
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)$(NOMBRE).pc oname=$(C)$(NOMBRE).c
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)$(NOMBRE)Fnc.pc oname=$(C)$(NOMBRE)Fnc.c
	@echo

clean:
	$(RMF) $(FUENTES_C)
	$(RMF) $(OBJETOS)

cleanall: clean
	$(RMF) $(APLICACION)

