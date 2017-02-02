%.elc: %.el
	emacs -batch -f batch-byte-compile $<

IN = $(wildcard *.el)
DATA = $(IN:.el=.elc)

all: $(DATA)

clobber:
	-rm $(DATA)
