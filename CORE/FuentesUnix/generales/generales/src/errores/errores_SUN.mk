include $(ENV_PRECOMP) 

PROFUENTES=errores.pc 
OBJETOS=errores.o

all: errores.o install

errores.c: $(PC)errores.pc
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)errores.pc oname=$(C)errores.c

errores.o: errores.c $(H)errores.h
	$(CC) $(CFLAGS) -c $(C)errores.c -o $(O)errores.o

install: 
	-cp $(O)errores.o $(GE_LIB_PATH)/errores.o
	-cp $(H)errores.h $(GE_INC_PATH)/errores.h

clean:
	-rm $(O)errores.o $(C)errores.c

debug:
	cp ./*.pc ./../debug/
	cp ./*.c  ./../debug/
	cp ./*.o  ./../debug/
	cp ./*.h  ./../debug/
