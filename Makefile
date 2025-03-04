#Archivo de configuracion de la utilidad make.
#Author: Erwin Meza Vega
#/** @verbatim */

BOOTSECTOR_DIR = bootsect

DOXYGEN=doxygen
DOCFILES = $(wildcard dox/*.dox) $(wildcard dox/*.md)

#Detectar el tipo de sistema
arch := $(shell uname -s)
machine := $(shell uname -m)
x86found := false
os := $(shell uname -o)

BOCHSDBG := bochsdbg

BOCHSDISPLAY := x
ifeq "$(os)" "Msys"
	BOCHSDISPLAY := win32
endif

ifeq "$(os)" "Cygwin"
	BOCHSDISPLAY := win32
endif

all: 
	@cd $(BOOTSECTOR_DIR);make
	@cp -f $(BOOTSECTOR_DIR)/build/bootsect build/floppy.img

bochs: all
	-bochs -q 'boot:a' \
	'floppya: 1_44=build/floppy.img, status=inserted' 'megs:32'
	
bochsdbg: all
	-$(BOCHSDBG) -q 'boot:a' \
	'floppya: 1_44=build/floppy.img, status=inserted' 'megs:32' \
	'display_library:$(BOCHSDISPLAY), options="gui_debug"'
	
qemu: all
	qemu -fda build/floppy.img -boot a

vbox: all
	-VBoxManage unregistervm  "lso-gB-t03-g5" --delete
	VBoxManage createvm --name="lso-gB-t03-g5" --basefolder="./build" --default --register
	VBoxManage modifyvm "lso-gB-t03-g5"  --memory=128 --cpus=1 --firmware=bios --vram 128
	VBoxManage storagectl "lso-gB-t03-g5" --name "Floppy" --add floppy --controller I82078
	VBoxManage storageattach "lso-gB-t03-g5" --storagectl "Floppy" --port 0 --device 0 --type fdd --medium build/floppy.img
	VBoxManage startvm "lso-gB-t03-g5" --type=gui

docs: $(DOCFILES)
	$(DOXYGEN) dox/Doxyfile

clean:
	@cd $(BOOTSECTOR_DIR);make clean
	@rm -f build/floppy.img
	@-rm -rf docs
	@-VBoxManage unregistervm  "lso-gB-t03-g5" --delete

#/** @endverbatim */
