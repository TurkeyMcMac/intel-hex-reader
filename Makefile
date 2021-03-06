header = ihr.h
source = ihr.c
object = ihr.o

test-header = test.h
test-source = test.c
test-object = test.o
tests = $(patsubst %.c, %.o, $(wildcard tests/*.c))

all: $(object)

ihr.o: $(source) $(header)
	$(CC) -O3 -ansi -Wall -Wextra -Wpedantic $(CFLAGS) -c -o $@ $<

run-tests: $(tests)
	sh run-tests.sh

tests/%.o: tests/%.c $(header) $(object) $(test-object)
	$(CC) $(CFLAGS) -c -o $@.tmp $< \
	&& $(CC) -o $@ $@.tmp $(object) $(test-object) \
	&& $(RM) $@.tmp

$(test-object): $(test-source) $(test-header)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	$(RM) $(object) $(test-object) $(tests)


.PHONY: all run-tests clean
