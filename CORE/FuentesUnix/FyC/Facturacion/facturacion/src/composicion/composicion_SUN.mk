include $(FA_ENV_PRECOM)

PROFUENTES=comora.pc
FUENTES=composi.c comora.c 
OBJETOS=composi.o comora.o

EXE=$(XPF_EXE)/

all: $(OBJETOS) install

composi.o: $(C)composi.c $(FA_INC_PATH)/composi.h $(FA_INC_PATH)/comora.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)composi.c -o $(FA_LIB_PATH)/composi.o

comora.c: $(PC)comora.pc $(FA_INC_PATH)/comora.h	
	$(PROC) $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)comora.pc oname=$(C)comora.c

comora.o: comora.c $(FA_INC_PATH)/comora.h
	$(CC) $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)comora.c -o $(FA_LIB_PATH)/comora.o

install:

clean:
	-rm $(C)comora.c

debug:
	-cp -R ./ ./../debug/
