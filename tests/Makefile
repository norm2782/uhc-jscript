UHC = ~/src/EHC/build/uhc

default: fold.js

%.js: %.hs
	$(UHC) $< -tjscript --dump-core-stages=1 --dump-grin-stages=1 -O1,2 --gen-trace=1
