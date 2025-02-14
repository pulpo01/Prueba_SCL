include $(ENV_PRECOMP)
INCLUDE=$(I_SYM)$(H) $(I_SYM)$(ORACLE_HOME)/precomp/public $(I_SYM)$(GE_INC_PATH)

PROFUENTES=GenFA.pc
FUENTES=GenFA.c
OBJETOS=GenFA.o
#PROCFLAGS=ireclen=255 oreclen=255 include=$(H) include=$(GE_INC_PATH)

C=./c/
O=./o/
H=./h/
PC=./pc/

all: GenFA.o install 

GenFA.c: $(PC)GenFA.pc $(H)StFactur.h $(H)GenFA.h
	$(PROC) $(PROCFLAGS) userid=$(USERPASS) code=ansi_c iname=$(PC)GenFA.pc oname=$(C)GenFA.c

GenFA.o: GenFA.c
	$(CC) $(CFLAGS) -c $(C)GenFA.c -o $(O)GenFA.o

clean:
	-rm $(C)GenFA.c
	-rm $(O)GenFA.o

install:
	cp $(H)GenFA.h    $(GE_INC_PATH)/GenFA.h
	cp $(O)GenFA.o    $(GE_LIB_PATH)/GenFA.o
	cp $(H)StFactur.h $(GE_INC_PATH)/StFactur.h
