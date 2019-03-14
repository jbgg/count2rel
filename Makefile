
progC=progc
progS=progs

prog=$(progC) $(progS)

objs=start.o lib64.o

objsC=countfc.o

objsS=countfs.o

all : $(prog)


%.o : %.S
	gcc -c -nostdinc -Iinclude -o $@ $^

%.o : %.c
	gcc -c -nostdinc -O3 -Iinclude -o $@ $^

$(progC) : $(objs) $(objsC)
	gcc -static -nostdlib -o $(progC) $(objs) $(objsC)

$(progS) : $(objs) $(objsS)
	gcc -static -nostdlib -o $(progS) $(objs) $(objsS)

clean :
	rm -rf $(prog) $(objs) $(objsC) $(objsS)
	@rm -rf .*~ *~
	@cd include && rm -rf .*~ *~ && cd ..

