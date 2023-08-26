# Setup the build paths
RAYLIB_PATH=./
TCC_PATH=../tinycc
SOURCE=$RAYLIB_PATH/examples
OUTPUT=$RAYLIB_PATH/build
TARGET=core/core_basic_window

# Setup the build options
FLAGS="
  -Wall
  -std=c99
  -Wno-missing-braces
  -Wunused-result
  -O2
  -D_DEFAULT_SOURCE
  -DPLATFORM_DESKTOP
"

INCLUDE="-I.
  -I$RAYLIB_PATH/src
  -I$RAYLIB_PATH/src/external
  -I$TCC_PATH/include
  -I/usr/local/include
"

# NOTE: If -latomic is not found due to using tcc
# run the command: locate libatomic.so
# Look for the one used by gcc
#   example: ATOMIC_LIBRARY_PATH="/usr/lib/gcc/x86_64-linux-gnu/7"

ATOMIC_LIBRARY_PATH="/usr/lib/gcc/x86_64-linux-gnu/7"

LIBRARY_PATHS="-L.
  -L$OUTPUT
  -L$TCC_PATH
  -L$ATOMIC_LIBRARY_PATH
  -L/usr/local/lib
"

LIBRARY="
  $LIBRARY_PATHS
  -lraylib
  -lGL
  -lm
  -lpthread
  -ldl
  -lrt
  -lX11
  -latomic
"

OPTIONS="$FLAGS $INCLUDE $LIBRARY"

# Build the app
# COMPILER=gcc
COMPILER=$TCC_PATH/tcc
$COMPILER -v
$COMPILER $SOURCE/$TARGET.c $OPTIONS -o $OUTPUT/$TARGET.app
