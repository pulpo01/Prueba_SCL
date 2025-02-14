NOMBRE=recargos
include $(FA_ENV_PRECOM)

OBJ_EXTERNOS=$(GE_LIB_PATH)/GenORA.o $(GE_LIB_PATH)/genco.o $(GE_LIB_PATH)/geora.o 

all: clean $(O)$(NOMBRE).o install

$(O)$(NOMBRE).o: $(C)$(NOMBRE).c
	$(CC) -c $(CFLAGS) $(FA_INCLUDE) -o $(O)recargos.o -c $(C)recargos.c

$(C)$(NOMBRE).c: $(PC)$(NOMBRE).pc
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(PC)recargos.pc oname=$(C)recargos.c
			
clean:
	$(RMF) $(O)$(NOMBRE).o
	$(RMF) $(C)$(NOMBRE).c
				
install:
	@cp -f $(O)$(NOMBRE).o $(FA_LIB_PATH)/
	@cp -f $(H)$(NOMBRE).h $(FA_INC_PATH)/
