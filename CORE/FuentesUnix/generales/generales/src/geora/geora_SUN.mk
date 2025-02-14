include $(ENV_PRECOMP)

AUTO_CONNECT=YES
NLS_LOCAL=YES

OBJETOS_EXT=
OBJETOS=$(O)geora.o

all: $(O)geora.o  install 

$(O)geora.o: $(C)geora.c $(GE_INC_PATH)/geora.h
	@echo "Generando geora.o..\n"
	$(CC) $(CFLAGS)  -o $(GE_LIB_PATH)/geora.o -c $(C)geora.c

$(C)geora.c: $(PC)geora.pc $(GE_INC_PATH)/geora.h
	@echo "Generando geora.c..\n"
	$(PROC) $(PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)geora.pc oname=$(C)geora.c
clean:
	$(RMF) $(C)geora.c 
	$(RMF) $(O)geora.o

install:
	-cp $(H)geora.h    $(GE_INC_PATH)/geora.h
	 
