UHC   = ~/Documents/UU/XP/EHC/install/99/bin/ehc
FLAGS = -tjscript --dump-core-stages=1 --dump-grin-stages=1 -O1,2 --gen-trace=1

ifndef PROJECT
  PROJECT = $(patsubst %.hs, %, $(wildcard *.hs))
endif

default: $(PROJECT).js

%.js: %.hs
	$(UHC) $< $(FLAGS)

clean:
	rm *.core* *.hi *.js *.html *.mjs

tst:
	echo $(patsubst %.hs, %, $(PROJECT))
