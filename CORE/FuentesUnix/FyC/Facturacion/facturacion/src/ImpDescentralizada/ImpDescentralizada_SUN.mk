include $(FA_ENV_PRECOM)

EXE=$(XPF_EXE)/
EJECUTABLE=$(EXE)fa_tcpcli
OBJETO=$(O)fa_tcpcli.o
FUENTE=$(C)fa_tcpcli.c

all: $(EJECUTABLE)

$(EJECUTABLE): $(OBJETO)
	$(CC) -o $(EJECUTABLE) $(OBJETO) -lsocket -lnsl

$(OBJETO) : $(FUENTE)
	$(CC) -o $(OBJETO) -c $(FUENTE) 

clean:
	$(RMF) $(O)fa_tcpcli.o

