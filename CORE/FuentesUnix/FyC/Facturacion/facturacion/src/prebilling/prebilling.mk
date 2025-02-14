include $(FA_ENV_PRECOM)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(FA_INC_PATH) $(I_SYM)$(ORACLE_HOME)/precomp/public

PROFUENTES = prebilling.pc prebilcic.pc prebilco.pc prebilext.pc prebilbaj.pc prebilnot.pc
FUENTES    = prebilling.c  prebilcic.c  prebilco.c  prebilext.c  prebilbaj.c  prebilnot.c 
OBJETOS    = prebilling.o  prebilcic.o  prebilco.o  prebilext.o  prebilbaj.o  prebilnot.o

PROCFLAGS=ireclen=255 oreclen=255 include=$(H) include=$(FA_INC_PATH) 
#--------------------------------------------------------------------------------
C=./c/
O=./o/
H=./h/
PC=./pc/
EXE=$(XPF_EXE)/
#--------------------------------------------------------------------------------

all: $(OBJETOS) install

prebilling.c: $(PC)prebilling.pc $(H)prebilling.h 
	$(PROC) $(FA_PROCFLAGS) iname=$(PC)prebilling.pc oname=$(C)prebilling.c

prebilling.o: prebilling.c
	$(CC) $(CFLAGS) -c $(C)prebilling.c -o $(O)prebilling.o

prebilco.c: $(PC)prebilco.pc $(H)prebilling.h $(H)prebilco.h
	$(PROC) $(FA_PROCFLAGS) iname=$(PC)prebilco.pc oname=$(C)prebilco.c

prebilco.o: prebilco.c
	$(CC) $(CFLAGS) -c $(C)prebilco.c -o $(O)prebilco.o

prebilcic.c: $(PC)prebilcic.pc $(H)prebilcic.h
	$(PROC) $(FA_PROCFLAGS) iname=$(PC)prebilcic.pc oname=$(C)prebilcic.c

prebilcic.o: prebilcic.c
	$(CC) $(CFLAGS) -c $(C)prebilcic.c -o $(O)prebilcic.o

prebilext.c: $(PC)prebilext.pc $(H)prebilext.h
	$(PROC) $(FA_PROCFLAGS) iname=$(PC)prebilext.pc oname=$(C)prebilext.c
prebilext.o: prebilext.c 
	$(CC) $(CFLAGS) -c $(C)prebilext.c -o $(O)prebilext.o

prebilbaj.c: $(PC)prebilbaj.pc $(H)prebilbaj.h
	$(PROC) $(FA_PROCFLAGS) iname=$(PC)prebilbaj.pc oname=$(C)prebilbaj.c
prebilbaj.o: prebilbaj.c 
	$(CC) $(CFLAGS) -c $(C)prebilbaj.c -o $(O)prebilbaj.o

prebilnot.c: $(PC)prebilnot.pc $(H)prebilnot.h
	$(PROC) $(FA_PROCFLAGS) iname=$(PC)prebilnot.pc oname=$(C)prebilnot.c
prebilnot.o: $(H)prebilnot.h
	$(CC) $(CFLAGS) -c $(C)prebilnot.c -o $(O)prebilnot.o
install:
	-cp $(H)prebilling.h  $(FA_INC_PATH)/prebilling.h
	-cp $(H)prebilco.h    $(FA_INC_PATH)/prebilco.h
	-cp $(H)prebilnot.h   $(FA_INC_PATH)/prebilnot.h
	-cp $(H)prebilcic.h   $(FA_INC_PATH)/prebilcic.h
	-cp $(H)prebilext.h   $(FA_INC_PATH)/prebilext.h
	-cp $(H)prebilbaj.h   $(FA_INC_PATH)/prebilbaj.h
	-cp $(O)prebilling.o  $(FA_LIB_PATH)/prebilling.o
	-cp $(O)prebilco.o    $(FA_LIB_PATH)/prebilco.o
	-cp $(O)prebilcic.o   $(FA_LIB_PATH)/prebilcic.o
	-cp $(O)prebilext.o   $(FA_LIB_PATH)/prebilext.o
	-cp $(O)prebilbaj.o   $(FA_LIB_PATH)/prebilbaj.o
	-cp $(O)prebilnot.o   $(FA_LIB_PATH)/prebilnot.o
clean:
	-rm $(O)prebilling.o  $(C)prebilling.c
	-rm $(O)prebilco.o    $(C)prebilco.c
	-rm $(O)prebilcic.o   $(C)prebilcic.c
	-rm $(O)prebilext.o   $(C)prebilext.c
	-rm $(O)prebilbaj.o   $(C)prebilbaj.c
	-rm $(O)prebilnot.o   $(C)prebilnot.c
debug:
	cp  *.pc $(DEBUG)
	cp  *.c  $(DEBUG)
	cp  *.h  $(DEBUG)
	cp  *.o  $(DEBUG)
