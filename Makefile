all:
	mruby/bin/mrbc -B test_mrp -o testrb.h test.rb
	gcc -c mtest.c -Imruby/include
	gcc -o mtest mtest.o -lmruby -Lmruby/build/host/lib

clean:
	rm -f mtest mtest.o testrb.h
