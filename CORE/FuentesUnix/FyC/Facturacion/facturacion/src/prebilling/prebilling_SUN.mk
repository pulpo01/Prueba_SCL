include $(FA_ENV_PRECOM)

PROFUENTES = prebilling.pc prebilcic.pc prebilco.pc prebilext.pc prebilbaj.pc prebilnot.pc
FUENTES    = prebilling.c  prebilcic.c  prebilco.c  prebilext.c  prebilbaj.c  prebilnot.c 
OBJETOS    = prebilling.o  prebilcic.o  prebilco.o  prebilext.o  prebilbaj.o  prebilnot.o

EXE=$(XPF_EXE)/

all: $(OBJETOS) install

prebilling.c: $(PC)prebilling.pc $(FA_INC_PATH)/prebilling.h 
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prebilling.pc oname=$(C)prebilling.c

prebilling.o: prebilling.c
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)prebilling.c -o $(FA_LIB_PATH)/prebilling.o

prebilco.c: $(PC)prebilco.pc $(FA_INC_PATH)/prebilling.h $(FA_INC_PATH)/prebilco.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prebilco.pc oname=$(C)prebilco.c

prebilco.o: prebilco.c
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)prebilco.c -o $(FA_LIB_PATH)/prebilco.o

prebilcic.c: $(PC)prebilcic.pc $(FA_INC_PATH)/prebilcic.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prebilcic.pc oname=$(C)prebilcic.c

prebilcic.o: prebilcic.c
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)prebilcic.c -o $(FA_LIB_PATH)/prebilcic.o

prebilext.c: $(PC)prebilext.pc $(FA_INC_PATH)/prebilext.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prebilext.pc oname=$(C)prebilext.c
prebilext.o: prebilext.c 
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)prebilext.c -o $(FA_LIB_PATH)/prebilext.o

prebilbaj.c: $(PC)prebilbaj.pc $(FA_INC_PATH)/prebilbaj.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prebilbaj.pc oname=$(C)prebilbaj.c

prebilbaj.o: prebilbaj.c 
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)prebilbaj.c -o $(FA_LIB_PATH)/prebilbaj.o

prebilnot.c: $(PC)prebilnot.pc $(FA_INC_PATH)/prebilnot.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prebilnot.pc oname=$(C)prebilnot.c

prebilnot.o: $(FA_INC_PATH)/prebilnot.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)prebilnot.c -o $(FA_LIB_PATH)/prebilnot.o
install:

clean:

debug:
	cp  *.pc $(DEBUG)
	cp  *.c  $(DEBUG)
	cp  *.h  $(DEBUG)
	cp  *.o  $(DEBUG)
