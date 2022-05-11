SUBDIRS= Debian Ubuntu Fedora
all:
	@for dir in $(SUBDIRS); do $(MAKE) -C "$$dir"; done
