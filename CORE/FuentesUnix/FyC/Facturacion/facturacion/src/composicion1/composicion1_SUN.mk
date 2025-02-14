include $(FA_ENV_PRECOM)

OBJETOS=compos.o $(FA_LIB_PATH)/PlanVcto.o 

EXE=$(XPF_EXE)/

all: $(OBJETOS) install

compos.c: $(PC)compos.pc $(FA_INC_PATH)/compos.h 
	$(PROC)  $(FA_PROCFLAGS) code=ansi_c userid=$(USERPASS) iname=$(PC)compos.pc oname=$(C)compos.c

compos.o: compos.c $(FA_INC_PATH)/compos.h 
	$(CC)  $(CFLAGS) $(FA_INCLUDE) -m64 -c $(C)compos.c -o $(FA_LIB_PATH)/compos.o

install: 
clean: 
debug:
	cp ./*.pc ./../debug/
	cp ./*.c  ./../debug/
	cp ./*.o  ./../debug/
	cp ./*.h  ./../debug/
