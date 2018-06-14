DIABLO_SRC=$(wildcard Source/*.cpp)
DIABLO_OBJ=$(DIABLO_SRC:.cpp=.o)

PKWARE_SRC=$(wildcard 3rdParty/PKWare/*.cpp)
PKWARE_OBJ=$(PKWARE_SRC:.cpp=.o)

all: devilution.exe

devilution.exe: $(DIABLO_OBJ) $(PKWARE_OBJ) DiabloUI.lib Storm.lib
	i686-w64-mingw32-gcc -L./ -o $@ $^ -lgdi32 -lversion -ldiabloui -lstorm

%.o: %.cpp
	i686-w64-mingw32-gcc -c -fpermissive -o $@ $<

DiabloUI.lib: DiabloUI.dll DiabloUI/diabloui_gcc.def
	i686-w64-mingw32-dlltool -d DiabloUI/diabloui_gcc.def -D DiabloUI.dll -l DiabloUI.lib

DiabloUI.dll:
	echo "Please copy DiabloUI.dll (version 1.09b) here."
	exit 1

Storm.lib: Storm.dll 3rdParty/Storm/Source/storm_gcc.def
	i686-w64-mingw32-dlltool -d 3rdParty/Storm/Source/storm_gcc.def -D Storm.dll -l Storm.lib

Storm.dll:
	echo "Please copy Storm.dll (version 1.09b) here."
	exit 1

clean:
	rm -f $(DIABLO_OBJ) $(PKWARE_OBJ)

.PHONY: clean all
