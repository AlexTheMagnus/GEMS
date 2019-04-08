FILE:= GEMS.clp

.PHONY: target
target:
	printf "(load $(FILE))\n(reset)\n(run)\n" | clips
