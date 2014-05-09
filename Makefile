all: mruby/build/host/lib/libmruby.a mruby/bin/mrbc
	mruby/bin/mrbc -B simplest_mrb -o simplest_mrb.h simplest.rb
	gcc -c simplest.c -Imruby/include
	gcc -o simplest simplest.o -lmruby -lm -Lmruby/build/host/lib
	mruby/bin/mrbc -B simple_module_mrb -o simple_module_mrb.h simple_module.rb
	gcc -c simple_module.c -Imruby/include
	gcc -o simple_module simple_module.o -lmruby -lm -Lmruby/build/host/lib
	mruby/bin/mrbc -B simple_class_mrb -o simple_class_mrb.h simple_class.rb
	gcc -c simple_class.c -Imruby/include
	gcc -o simple_class simple_class.o -lmruby -lm -Lmruby/build/host/lib
	mruby/bin/mrbc -B class_under_module_mrb -o class_under_module_mrb.h class_under_module.rb
	gcc -c class_under_module.c -Imruby/include
	gcc -o class_under_module class_under_module.o -lmruby -lm -Lmruby/build/host/lib

mruby/build/host/lib/libmruby.a:
	cd mruby; rake

mruby/bin/mrbc:
	cd mruby; rake

clean:
	rm -f simplest simplest.o simplest_mrb.h
	rm -f simple_module simple_module.o simple_module_mrb.h
	rm -f simple_class simple_class.o simple_class_mrb.h
	rm -f class_under_module class_under_module.o class_under_module_mrb.h
