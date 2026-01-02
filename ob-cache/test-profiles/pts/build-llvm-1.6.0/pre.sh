#!/bin/sh
rm -rf build
rm -rf llvm-21.1.0.src
mkdir build
tar -xf llvm-21.1.0.src.tar.xz
tar -xf cmake-21.1.0.src.tar.xz
tar -xf third-party-21.1.0.src.tar.xz
mv cmake-21.1.0.src cmake
mv third-party-21.1.0.src third-party
cd build
if [ "$1" = "Ninja" ]
then
	cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_BENCHMARKS=OFF -DLLVM_BUILD_TESTS=OFF -DLLVM_INCLUDE_TESTS=OFF -G Ninja ../llvm-21.1.0.src
else
	cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_INCLUDE_BENCHMARKS=OFF -DLLVM_BUILD_TESTS=OFF -DLLVM_INCLUDE_TESTS=OFF -G "Unix Makefiles" ../llvm-21.1.0.src
fi
