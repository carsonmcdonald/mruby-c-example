all:
	mruby/bin/mrbc -B simplest_mrb -o simplest_mrb.h simplest.rb
	gcc -c simplest.c -Imruby/include
	gcc -o simplest simplest.o -lmruby -lm -Lmruby/build/host/lib
	mruby/bin/mrbc -B simple_module_mrb -o simple_module_mrb.h simple_module.rb
	gcc -c simple_module.c -Imruby/include
	gcc -o simple_module simple_module.o -lmruby -lm -Lmruby/build/host/lib

clean:
	rm -f simplest simplest.o simplest_mrb.h
	rm -f simple_module simple_module.o simple_module_mrb.h
