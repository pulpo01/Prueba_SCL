include $(ENV_PRECOMP)

CC = cc
RMF= rm -f 

all: $(O)utils.o

$(O)utils.o: $(C)utils.c 
	$(CC) -o $(GE_LIB_PATH)/utils.o $(CFLAGS) -c $(C)utils.c code=ansi_c
	cp $(H)utils.h $(GE_INC_PATH)

clean:
	$(RMF) $(O)utils.o

