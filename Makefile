BINS = simplest simple_module simple_class class_under_module
MRB_HEADERS = simplest_mrb.h simple_module_mrb.h simple_class_mrb.h class_under_module_mrb.h
MRB_SAMPLES = simplest_mrb.rb simple_module_mrb.rb simple_class_mrb.rb class_under_module_mrb.rb

all: $(BINS)

$(MRB_HEADERS): $(MRB_SAMPLES) mruby/bin/mrbc
	mruby/bin/mrbc -B $* -o $*.h $*.rb

simplest: simplest.c simplest_mrb.h mruby/build/host/lib/libmruby.a mruby/bin/mrbc
	gcc -c simplest.c -Imruby/include
	gcc -o simplest simplest.o -lmruby -lm -Lmruby/build/host/lib

simple_module: simple_module.c simple_module_mrb.h mruby/build/host/lib/libmruby.a mruby/bin/mrbc
	gcc -c simple_module.c -Imruby/include
	gcc -o simple_module simple_module.o -lmruby -lm -Lmruby/build/host/lib

simple_class: simple_class.c simple_class_mrb.h mruby/build/host/lib/libmruby.a mruby/bin/mrbc
	gcc -c simple_class.c -Imruby/include
	gcc -o simple_class simple_class.o -lmruby -lm -Lmruby/build/host/lib

class_under_module: class_under_module.c class_under_module_mrb.h mruby/build/host/lib/libmruby.a mruby/bin/mrbc
	gcc -c class_under_module.c -Imruby/include
	gcc -o class_under_module class_under_module.o -lmruby -lm -Lmruby/build/host/lib

mruby/build/host/lib/libmruby.a:
	cd mruby; rake

mruby/bin/mrbc:
	cd mruby; rake

clean:
	rm -f $(BINS)
	rm -f *.o
	rm -f $(MRB_HEADERS)

test: $(BINS)
	./simplest
	./simple_module
	./simple_class
	./class_under_module
