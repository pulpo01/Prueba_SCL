#makefile Sun 64b
include $(FA_ENV_PRECOM)

RMF=rm -f
EXE=./
O=./o/
C=./c/
H=./h/
PC=./pc/
EXE=$(XPF_EXE)/

OBJETOS_EXT=$(GE_LIB_PATH)/geora.o $(GE_LIB_PATH)/rutinasgen.o $(GE_LIB_PATH)/errores.o  $(GE_LIB_PATH)/FaORA.o $(GE_LIB_PATH)/trazafact.o 

OBJETOS=$(O)loadtrafico.o

all: $(EXE)loadtrafico 

$(EXE)loadtrafico:$(O)loadtrafico.o $(OBJETOS_EXT)
	@echo "Generando loadtrafico..\n"
	$(CC) $(CFLAGS) $(OBJETOS) $(OBJETOS_EXT) -g -o $(EXE)loadtrafico $(PROLDLIBS) 
	@echo "\n"

$(O)loadtrafico.o:$(C)loadtrafico.c $(H)loadtrafico.h
	@echo "Generando loadtrafico.o..\n"
	$(CC) $(CFLAGS) $(INCLUDE) -g -o $(O)loadtrafico.o -c $(C)loadtrafico.c

$(C)loadtrafico.c:$(PC)loadtrafico.pc $(H)loadtrafico.h
	@echo "Generando loadtrafico.c..\n"
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS)  iname=$(PC)loadtrafico.pc oname=$(C)loadtrafico.c

clean:
	$(RMF) $(C)loadtrafico.c 
	$(RMF) $(O)loadtrafico.o 
	#$(RMF) $(EXE)loadtrafico
