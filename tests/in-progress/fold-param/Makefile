UHC   = ~/Documents/UU/XP/EHC/install/99/bin/ehc
FLAGS = -tjscript --dump-core-stages=1 --dump-grin-stages=1 -O1,2 --gen-trace=1

default: fold.js

%.js: %.hs
	$(UHC) $< $(FLAGS)
