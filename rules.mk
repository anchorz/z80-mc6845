LINK    = sdldz80
AS      = sdasz80
OBJCOPY = sdobjcopy

SDAS_OPT=-plowgff
SDLD_OPT=-mwxiu

all: obj/z1013 obj/z1013/$(OUT).bin

obj/z1013:
	mkdir -p "$@"
	
obj/z1013/$(OUT).bin: $(addsuffix .rel,$(addprefix obj/z1013/,$(OBJECTS)))
	$(LINK) $(SDLD_OPT) -b _CODE=0xf800 -i $(@:bin=ihx) $^
	$(OBJCOPY) -Iihex -Obinary $(@:bin=ihx) $(@)

obj/z1013/$(OUT).z80: obj/z1013/crt0_z1013.rel $(addsuffix .rel,$(addprefix obj/z1013/,$(OBJECTS)))
	$(LINK) $(SDLD_OPT) -b _HEADER=0x00e0 -b _CODE=0x0100 -i $(@:z80=ihx) $^
	$(OBJCOPY) -Iihex -Obinary $(@:z80=ihx) $(@:z80=out)
	dd if=$(@:z80=out) of=$@ bs=32 conv=sync
	java -jar jar/tape-writer.jar -s 300 -t Z1013Header "$@"
	
play: obj/z1013/$(OUT).z80
	playsound $(^:z80=z1013header.wav) 
	
obj/z1013/%.rel:src/%.s
	$(AS) -plosgff -Iinclude "$@" "$<"

clean:
	rm -rf obj
