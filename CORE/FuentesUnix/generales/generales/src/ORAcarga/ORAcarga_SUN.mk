include $(ENV_PRECOMP)

PROFUENTES=ORAcarga.pc
FUENTES=ORAcarga.c
OBJETOS=ORAcarga.o

all: $(OBJETOS) install 

ORAcarga.c: $(PC)ORAcarga.pc $(H)ORAcarga.h
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)ORAcarga.pc oname=$(C)ORAcarga.c

ORAcarga.o: ORAcarga.c $(H)ORAcarga.h 
	$(CC) $(CFLAGS) $(INCLUDE) -c -Ae $(C)ORAcarga.c -o $(O)ORAcarga.o

install:
	-cp $(O)ORAcarga.o $(GE_LIB_PATH)/ORAcarga.o
	-cp $(H)ORAcarga.h $(GE_INC_PATH)/ORAcarga.h

clean: 
	-rm $(O)ORAcarga.o
	-rm $(C)ORAcarga.c

debug:
	cp ./*.pc ./../debug/
	cp ./*.c  ./../debug/


