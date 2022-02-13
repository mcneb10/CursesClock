#clock makefile
.PHONY: all
all: clockc clockcobol

%c: %.c
	cc $^ -lncurses -o $@

%cobol: %.cbl
	cobc $^ -lncurses -x -o $@

clean:
	find . -regex '\.|makefile' -delete
