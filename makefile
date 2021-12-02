test_hashtable:
	c3c compile tests/hash_table.c3 lib/std/*.c3 lib/std/*/*.c3 lib/hashtable.c3
	clear
	./a.out
	rm *.o
	rm a.out

day1_c3:
	c3c compile day1/*.c3 lib/std/*.c3 lib/std/*/*.c3 lib/hashtable.c3 lib/libadvent.c3
	clear
	./a.out
	rm *.o
	rm a.out

day2_c3:
	c3c compile day2/*.c3 lib/std/*.c3 lib/std/*/*.c3 lib/hashtable.c3 lib/libadvent.c3
	clear
	./a.out
	rm *.o
	rm a.out
