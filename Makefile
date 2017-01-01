include config.mk

HDR = util.h randr.h
SRC = lsd.c dattr.c pfd.c ppd.c phd.c

OBJ = $(SRC:.c=.o)
BIN = $(SRC:.c=)

.POSIX:

all: binutils

binutils: $(BIN)

manpages:
	cd man; $(MAKE) $(MFLAGS)

$(OBJ): $(HDR) util.o randr.o

.o:
	@echo "LD $@"
	@$(LD) $< -o $@ $(LDFLAGS) util.o randr.o

.c.o:
	@echo "CC $<"
	@$(CC) -c $< -o $@ $(CFLAGS)

install: $(BIN)
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
	cp -f $(BIN) $(DESTDIR)$(PREFIX)/bin/
	cd man; $(MAKE) $(MFLAGS) install

uninstall:
	@echo "uninstalling binaries"
	@for util in $(BIN); do \
		rm -f $(DESTDIR)$(PREFIX)/bin/$$util; \
	done
	cd man; $(MAKE) $(MFLAGS) uninstall

clean:
	rm -f $(OBJ) $(BIN) util.o randr.o
