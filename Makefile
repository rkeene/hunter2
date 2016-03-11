PREFIX = /usr/local
prefix = $(PREFIX)
bindir = $(prefix)/bin
libdir = $(prefix)/lib

all: hunter2

install: hunter2 lib
	mkdir -p '$(DESTDIR)$(bindir)' '$(DESTDIR)$(libdir)/hunter2'
	cp -rp lib/* '$(DESTDIR)$(libdir)/hunter2/'
	sed 's@\[file dirname \[info script\]\] lib@"$(libdir)/hunter2"@' hunter2 > '$(DESTDIR)$(bindir)/hunter2'
	chmod 755 '$(DESTDIR)$(bindir)/hunter2'

clean:
	@echo 'All clean!'

distclean:
	@echo 'All clean!'

.PHONY: all install clean distclean
