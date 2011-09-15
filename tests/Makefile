UHC   = ~/Documents/UU/XP/EHC/install/99/bin/ehc
FLAGS = -tjscript --dump-core-stages=1 --dump-grin-stages=1 -O1,2 --gen-trace=1

ifndef PROJECT
  PROJECT = $(patsubst %.hs, %, $(wildcard *.hs))
endif

default: $(PROJECT).js

%.js: %.hs
	$(UHC) $< $(FLAGS)

clean:
	rm $(PROJECT).core* $(PROJECT).full.core $(PROJECT).hi $(PROJECT).js $(PROJECT).html $(PROJECT).mjs

strip:
	find . -iname "*.core*" | xargs gsed -i 's/$$UHC$$\.Base$$\.//g';
	find . -iname "*.core*" | xargs gsed -i 's/UHC\.Base\.//g';
	find . -iname "*.core*" | xargs gsed -i 's/$$UHC$$\.Run$$\.//g';
	find . -iname "*.core*" | xargs gsed -i 's/$$UHC$$\.OldIO$$\.//g';
	perl -pi -w -e 's/(_\d+)*_\$@\d[A-Z]+_\$@(\d+(_\d+)*)//g;' *.core*

.PHONY : clean strip tst

tst:
	echo $(patsubst %.hs, %, $(PROJECTh
