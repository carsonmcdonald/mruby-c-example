BINS = simplest simple_module simple_class class_under_module
SRC = simplest.c simple_module.c simple_class.c class_under_module.c
OBJS = simplest.o simple_module.o simple_class.o class_under_module.o
MRB_HEADERS = simplest_mrb.h simple_module_mrb.h simple_class_mrb.h class_under_module_mrb.h
MRB_SAMPLES = simplest_mrb.rb simple_module_mrb.rb simple_class_mrb.rb class_under_module_mrb.rb

all: $(BINS)

$(MRB_HEADERS): $(MRB_SAMPLES) mruby/bin/mrbc
	mruby/bin/mrbc -B $* -o $*.h $*.rb

$(OBJS): $(MRB_HEADERS) $(SRC)
	gcc -c $*.c -o $@ -Imruby/include

$(BINS): $(OBJS) mruby/build/host/lib/libmruby.a
	gcc -o $@ $@.o -lmruby -lm -Lmruby/build/host/lib

mruby/build/host/lib/libmruby.a:
	cd mruby; rake

mruby/bin/mrbc:
	cd mruby; rake

clean:
	rm -f $(BINS)
	rm -f *.o
	rm -f $(MRB_HEADERS)

clean_all: clean
	cd mruby; rake clean

test: $(BINS)
	./simplest
	./simple_module
	./simple_class
	./class_under_module
