#!/bin/sh

VERSION=3.5.2
RVERSION=R-$VERSION
TARBALL=$RVERSION.tar.gz

INCLUDES=/appl/R/$VERSION/include
LIBS=/appl/R/$VERSION/lib

## Load modules (sets MKLROOT etc)
module load intel/2017.4.196.mkl
## module load gcc/6.3.0

wget https://cloud.r-project.org/src/base/R-3/$TARBALL
tar zxf $TARBALL

## Patch R wrapper script:
head -n 3 $RVERSION/src/scripts/R.sh.in > tmp_file
echo "module load intel/2017.4.196.mkl" >> tmp_file
echo "module load gcc/6.3.0" >> tmp_file
echo >> tmp_file
tail -n +3 $RVERSION/src/scripts/R.sh.in >> tmp_file
mv tmp_file $RVERSION/src/scripts/R.sh.in

MKL="-fopenmp -m64 -I$MKLROOT/include -L$MKLROOT/lib/intel64 -lmkl_gf_lp64 -lmkl_gnu_thread -lmkl_core -lpthread -lm"

mkdir -p build

cd build
../$RVERSION/configure CPPFLAGS="-I$INCLUDES -I/usr/local/include" LDFLAGS="-L$LIBS -L/usr/local/lib64" --with-blas="$MKL" --with-lapack

make
