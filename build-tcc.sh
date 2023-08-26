# Setup the build paths
RAYLIB_PATH=./
TCC_PATH=../tinycc
SOURCE=$RAYLIB_PATH/src
OUTPUT=$RAYLIB_PATH/build

# Setup the build options
INCLUDE="-I.
  -I$SOURCE/external/glfw/include
  -I$SOURCE/external/glfw/deps/mingw
  -I$TCC_PATH/include
"

PLATFORM="-D_GNU_SOURCE -DPLATFORM_DESKTOP -DGRAPHICS_API_OPENGL_33"
FLAGS="-Wall -Wno-missing-braces -Werror=pointer-arith -fno-strict-aliasing -std=c99 -fPIC -O1 -Werror=implicit-function-declaration"

OPTIONS="$PLATFORM $FLAGS $INCLUDE"

# Build the project files
# COMPILER=gcc
COMPILER=$TCC_PATH/tcc
$COMPILER -v

$COMPILER -c $SOURCE/rcore.c $OPTIONS -o $OUTPUT/rcore.o
$COMPILER -c $SOURCE/rshapes.c $OPTIONS -o $OUTPUT/rshapes.o
$COMPILER -c $SOURCE/rtextures.c $OPTIONS -o $OUTPUT/rtextures.o
$COMPILER -c $SOURCE/rtext.c $OPTIONS -o $OUTPUT/rtext.o
$COMPILER -c $SOURCE/utils.c $OPTIONS -o $OUTPUT/utils.o
$COMPILER -c $SOURCE/rglfw.c $OPTIONS -o $OUTPUT/rglfw.o
$COMPILER -c $SOURCE/rmodels.c $OPTIONS -o $OUTPUT/rmodels.o
$COMPILER -c $SOURCE/raudio.c $OPTIONS -o $OUTPUT/raudio.o

# Use GCC archiver to pack library
ar rcs $OUTPUT/libraylib.a $OUTPUT/rcore.o $OUTPUT/rshapes.o $OUTPUT/rtextures.o $OUTPUT/rtext.o $OUTPUT/utils.o $OUTPUT/rglfw.o $OUTPUT/rmodels.o $OUTPUT/raudio.o
