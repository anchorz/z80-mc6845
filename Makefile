OBJECTS = mc6845
OUT=z1013_f800_extension

include rules.mk

dasm:
	../../sdcc-z1013-kc85/sdcc/sdcc/support/scripts/z80-disasm.pl obj/z1013/z1013_f800_extension.ihx \
	--map-file obj/z1013/z1013_f800_extension.map 
