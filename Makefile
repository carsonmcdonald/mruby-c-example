BINS = simplest simple_module simple_class class_under_module

SRC := $(BINS:%=%.c)
OBJS := $(BINS:%=%.o)
MRB_HEADERS := $(BINS:%=%_mrb.h)
MRB_SAMPLES := $(BINS:%=%_mrb.rb)

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
	./run_tests.sh $(BINS)
