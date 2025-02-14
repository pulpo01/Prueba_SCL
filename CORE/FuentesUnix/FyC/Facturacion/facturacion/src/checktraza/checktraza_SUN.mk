include $(FA_ENV_PRECOM)

all: $(O)checktraza.o

$(O)checktraza.o: $(PC)checktraza.pc 
	$(PROC) $(FA_PROCFLAGS) userid=$(USERPASS) iname=$(PC)checktraza.pc oname=$(C)checktraza.c
	$(CC) -o $(FA_LIB_PATH)/checktraza.o $(CFLAGS) $(FA_INCLUDE) -c $(C)checktraza.c
clean:
	$(RMF) $(C)checktraza.c
	$(RMF) $(O)checktraza.o
