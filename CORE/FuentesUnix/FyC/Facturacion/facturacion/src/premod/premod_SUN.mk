include $(FA_ENV_PRECOM)

PROFUENTES=preabo.pc preser.pc pretar.pc precuo.pc presac.pc precob.pc prenot.pc preext.pc precar.pc
FUENTES=preabo.c preser.c pretar.c precuo.c presac.c precob.c prenot.c preext.c precar.c
OBJETOS=preabo.o preser.o pretar.o precuo.o presac.o precob.o prenot.o preext.o precar.o

all: $(OBJETOS) install
pretar.c: $(PC)pretar.pc $(FA_INC_PATH)/pretar.h 
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)pretar.pc oname=$(C)pretar.c

pretar.o: pretar.c $(FA_INC_PATH)/pretar.h 
	$(CC) $(CFLAGS) $(FA_INCLUDE)  -m64  -c $(C)pretar.c -o $(FA_LIB_PATH)/pretar.o

presac.c: $(PC)presac.pc $(FA_INC_PATH)/presac.h 
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)presac.pc oname=$(C)presac.c

presac.o: presac.c  $(FA_INC_PATH)/presac.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)presac.c -o $(FA_LIB_PATH)/presac.o

preser.c: $(PC)preser.pc $(FA_INC_PATH)/preser.h 
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)preser.pc oname=$(C)preser.c 

preser.o: preser.c  $(FA_INC_PATH)/preser.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)preser.c -o $(FA_LIB_PATH)/preser.o

preabo.c: $(PC)preabo.pc $(FA_INC_PATH)/preabo.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)preabo.pc oname=$(C)preabo.c

preabo.o: preabo.c $(FA_INC_PATH)/preabo.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)preabo.c -o $(FA_LIB_PATH)/preabo.o

precuo.c: $(PC)precuo.pc $(FA_INC_PATH)/precuo.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)precuo.pc oname=$(C)precuo.c

precuo.o: precuo.c $(FA_INC_PATH)/precuo.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)precuo.c -o $(FA_LIB_PATH)/precuo.o

preext.c: $(PC)preext.pc $(FA_INC_PATH)/preext.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)preext.pc oname=$(C)preext.c

preext.o: preext.c $(FA_INC_PATH)/preext.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)preext.c -o $(FA_LIB_PATH)/preext.o

precob.c: $(PC)precob.pc $(FA_INC_PATH)/precob.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)precob.pc oname=$(C)precob.c

precob.o: precob.c 
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)precob.c -o $(FA_LIB_PATH)/precob.o

prenot.c: $(PC)prenot.pc $(FA_INC_PATH)/prenot.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)prenot.pc oname=$(C)prenot.c

prenot.o: prenot.c 
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -c $(C)prenot.c -o $(FA_LIB_PATH)/prenot.o
	
precar.c: $(PC)precar.pc $(FA_INC_PATH)/precar.h
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)precar.pc oname=$(C)precar.c

precar.o: precar.c 
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64  -c $(C)precar.c -o $(FA_LIB_PATH)/precar.o	
	
install:

clean:

debug:
	cp *.pc  $(DEBUG)
	cp *.c   $(DEBUG)
	cp *.h   $(DEBUG)
	cp *.o   $(DEBUG)
