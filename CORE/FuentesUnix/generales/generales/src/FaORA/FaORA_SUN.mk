include $(ENV_PRECOMP)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(GE_INC_PATH)

PROFUENTES=FaORA.pc
FUENTES=FaORA.c
OBJETOS=FaORA.o
PROCFLAGS=ireclen=255 oreclen=255 include=$(H) include=$(GE_INC_PATH)

C=./c/
O=./o/
H=./h/
PC=./pc/

all: FaORA.o install 

FaORA.c: $(PC)FaORA.pc $(H)deftypes.h $(H)FaORA.h
	$(PROC) $(PROCFLAGS) code=ansi_c iname=$(PC)FaORA.pc oname=$(C)FaORA.c

FaORA.o: FaORA.c
	$(CC) $(CFLAGS) -c $(C)FaORA.c -o $(O)FaORA.o

clean:
	-rm $(C)FaORA.c
	-rm $(O)FaORA.o

install:
	cp $(H)FaORA.h    $(GE_INC_PATH)/FaORA.h
	cp $(O)FaORA.o    $(GE_LIB_PATH)/FaORA.o
	cp $(H)deftypes.h $(GE_INC_PATH)/deftypes.h

debug:
	cp ./*.pc ./../debug/
	cp ./*.c  ./../debug/
	cp ./*.h  ./../debug/
	cp ./*.o  ./../debug/
