include $(ENV_PRECOMP)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(GE_INC_PATH)

PROFUENTES=EncriptaSha1.pc
FUENTES=EncriptaSha1.c
OBJETOS=EncriptaSha1.o
PROCFLAGS=ireclen=255 oreclen=255 include=$(H) include=$(GE_INC_PATH)

C=./c/
O=$(GE_LIB_PATH)/
PC=./pc/

all: EncriptaSha1.o install
EncriptaSha1.c: $(PC)EncriptaSha1.pc $(H)/EncriptaSha1.h
	@echo **************
	@echo $(H)
	$(PROC) -g $(PROCFLAGS) code=ansi_c iname=$(PC)EncriptaSha1.pc oname=$(C)EncriptaSha1.c

EncriptaSha1.o: EncriptaSha1.c
	@echo **************
	@echo $(H)
	$(CC) $(CFLAGS) -m64 -c $(C)EncriptaSha1.c -o $(O)EncriptaSha1.o

clean:
	-rm $(C)EncriptaSha1.c
	-rm $(O)EncriptaSha1.o

install:
	cp $(H)EncriptaSha1.h    $(GE_INC_PATH)/EncriptaSha1.h


