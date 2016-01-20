#!/bin/bash

# This script attempts to build absolutely everything in the stable
#  section of the project.

RTEMS_VERSION="4.12"
#RTEMS_TARGETS="arm i386 mips powerpc sparc"
RTEMS_TARGETS="sparc"
export PREFIX=$HOME/development/rtems/${RTEMS_VERSION}
export PATH=$PREFIX/bin:$PATH

cd rtems-source-builder/rtems/
../source-builder/sb-set-builder \
  --log=sb-set-builder.log \
  --prefix="${PREFIX}" \
  "${RTEMS_VERSION}/rtems-all.bset"

cd ../../rtems/
./bootstrap
cd ..; mkdir rtems-build; cd rtems-build

for target in $RTEMS_TARGETS; do
    ../rtems/configure --enable-tests --target=${target}-rtems${RTEMS_VERSION}
    make all
done

