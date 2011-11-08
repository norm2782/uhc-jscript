# FLAGS = -tjscript --dump-core-stages=1 --dump-grin-stages=1 -O1,2 --gen-trace=1 --import-path=../../../uhc-jscript/src
FLAGS = -tjscript --dump-core-stages=1 --dump-grin-stages=1 --gen-trace=1 --import-path=../../../uhc-jscript/src --no-hi-check

ifndef PROJECT
  PROJECT = $(patsubst %.hs, %, $(wildcard *.hs))
endif

default: $(PROJECT).js

$(PROJECT).js: $(PROJECT).hs
	$(UHC) $(PROJECT).hs $(FLAGS)

clean:
	rm *.core* *.full.core *.hi $(PROJECT).js $(PROJECT).html *.mjs

.PHONY : clean strip
