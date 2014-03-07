all:
	mruby/bin/mrbc -B simplest_mrb -o simplest_mrb.h simplest.rb
	gcc -c simplest.c -Imruby/include
	gcc -o simplest simplest.o -lmruby -lm -Lmruby/build/host/lib

clean:
	rm -f simplest simplest.o simplest_mrb.h
