#!/bin/bash
set -e
#set -x
#
# Copyright (c) 2015, Lawrence Livermore National Security, LLC.
# 
# Produced at the Lawrence Livermore National Laboratory
# 
# Written by Simone Atzeni (simone@cs.utah.edu), Ganesh Gopalakrishnan,
# Zvonimir Rakamari\'c Dong H. Ahn, Ignacio Laguna, Martin Schulz, and
# Gregory L. Lee
# 
# LLNL-CODE-676696
# 
# All rights reserved.
# 
# This file is part of Archer. For details, see
# https://github.com/soarlab/Archer. Please also read Archer/LICENSE.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# Redistributions of source code must retain the above copyright notice,
# this list of conditions and the disclaimer below.
# 
# Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the disclaimer (as noted below) in
# the documentation and/or other materials provided with the
# distribution.
# 
# Neither the name of the LLNS/LLNL nor the names of its contributors
# may be used to endorse or promote products derived from this software
# without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL LAWRENCE
# LIVERMORE NATIONAL SECURITY, LLC, THE U.S. DEPARTMENT OF ENERGY OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

if [ "$(uname)" == "Linux" ]; then
    ESCAPE="\e"
else
    ESCAPE="\x1B"
fi

RED=$ESCAPE'[0;31m'
GREEN=$ESCAPE'[0;32m'
NC=$ESCAPE'[0m'
echoc() { echo -e "${RED}$@${NC}"; }
echook() { echo -e "${GREEN}$@${NC}"; }

git_clone_or_pull() # $1 = url, $2 = target directory
{
if [ "$1" = "-b" ]
then
	local CLONE_BRANCH="-b $2"
	local PUSH_BRANCH=$2
	shift;shift;
fi

if [ ! -d ${LLVMRT_SRC} ]
then
        git clone $CLONE_BRANCH $1 $2
else
        cd $2
        if [ -n "$PUSH_BRANCH" ]
        then
        	git checkout $PUSH_BRANCH
        fi
	if [ "$UPDATE" == "false" ]
	then
		return
	fi
        git pull $1 $PUSH_BRANCH
fi
}

# Check requirements
myerrors=0
if mygit=$(which git) >/dev/null 2>&1
then
      echook Found git at $mygit [OK]
else
      echoc Cannot find git. Necessary for building ARCHER. [ERROR]
      myerrors=1
fi

if mycmake=$(which cmake) >/dev/null 2>&1
then
      mycmakeversion=$($mycmake --version | head -n1 | sed -e 's/(.*)//' -e 's/\[.*\]//' -e 's/  */ /g')
      echook Found cmake at $mycmake version $mycmakeversion [OK]
else
      echoc Cannot find cmake. Necessary for building ARCHER. [ERROR]
      myerrors=1
fi

mycmakeversion=$($mycmake --version | head -n1 | sed -e 's/(.*)//' -e 's/\[.*\]//' -e 's/  */ /g')

if mygcc=$(which gcc) >/dev/null 2>&1
then
      mygccversion=$($mygcc --version | head -n1 | sed -e 's/(.*)//' -e 's/\[.*\]//' -e 's/  */ /g')
      echook Found gcc at $mygcc version $mygccversion [OK]
else
      echoc Cannot find gcc. Necessary for building ARCHER. [ERROR]
      myerrors=1
fi

if [ $myerrors -gt 0 ]
then
      echoc Stop building ARCHER for missing requirements.
      exit 1
fi

LLVM_INSTALL=/usr
HTTP=false
UPDATE=false
GCC_TOOLCHAIN_PATH=
BUILD_CMD=ninja
BUILD_SYSTEM="Ninja"
if ! command_loc="$(type -p "$BUILD_CMD")" || [  -z "$command_loc" ]; then
    BUILD_CMD=make
    BUILD_SYSTEM="Unix Makefiles"
fi

# CC and CXX
for i in "$@"
do
    case $i in
	--prefix=*)
	    LLVM_INSTALL="${i#*=}"
	    shift
	    ;;
	--build-system=*)
	    BUILD_SYSTEM="${i#*=}"
	    shift
	    ;;
	--http)
	    HTTP=true
	    shift
	    ;;
	--update)
	    UPDATE=true
	    shift
	    ;;
	--gcc-toolchain-path=*)
	    GCC_TOOLCHAIN_PATH="-D GCC_INSTALL_PREFIX=${i#*=}"
	    shift
	    ;;
	*)
	    echo "Usage: ./install.sh [--prefix=PREFIX[/usr] [--http (to use HTTP git url)]"
	    exit
	    ;;
    esac
done

echo
echoc "LLVM will be installed at [${LLVM_INSTALL}]"

# Saving installation patch
echo ${LLVM_INSTALL} > .install_path

# Get the number of cores to speed up make process
if [ "$(uname)" == "Darwin" ]; then
    PROCS=$(sysctl -a | grep machdep.cpu | grep core_count | awk -F " " '{ print $2 }')
else
    if ! type "nproc" > /dev/null; then
	PROCS=$(nprocs)
    else
	PROCS=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | tail -1)
	PROCS=`expr $PROCS + 1`    
    fi
fi

echo
echoc "Installing LLVM/Clang..."

WORKING_DIR=`pwd`
cd ..
BASE=`pwd`/LLVM
mkdir -p ${BASE}
cd $BASE

# Software Repositories
LLVM_REPO=""
CLANG_REPO=""
LLVMRT_REPO=""
POLLY_REPO=""
LLVM_COMMIT=""
LLVMRT_COMMIT=""	 
CLANG_COMMIT=""
POLLY_COMMIT=""
if [ "$HTTP" == "true" ]; then
    LLVM_REPO="-b archer https://github.com/PRUNER/llvm.git"
    CLANG_REPO="-b archer https://github.com/PRUNER/clang.git"
    LLVMRT_REPO="https://github.com/PRUNER/compiler-rt.git"
    POLLY_REPO="https://github.com/llvm-mirror/polly.git"
    ARCHER_REPO="https://github.com/PRUNER/archer.git"
    OPENMPRT_REPO="-b annotations https://github.com/PRUNER/openmp.git"
else
    LLVM_REPO="-b archer git@github.com:PRUNER/llvm.git"
    CLANG_REPO="-b archer git@github.com:PRUNER/clang.git"
    LLVMRT_REPO="git@github.com:PRUNER/compiler-rt.git"
    POLLY_REPO="git@github.com:llvm-mirror/polly.git"
    ARCHER_REPO="git@github.com:PRUNER/archer.git"
    OPENMPRT_REPO="-b annotations git@github.com:PRUNER/openmp.git"
fi

# LLVM installation directory
LLVM_SRC=${BASE}/llvm_src
CLANG_SRC=${BASE}/llvm_src/tools/clang
LLVMRT_SRC=${BASE}/llvm_src/projects/compiler-rt
POLLY_SRC=${LLVM_SRC}/tools/polly
ARCHER_SRC=${BASE}/llvm_src/tools/archer
OPENMPRT_SRC=${BASE}/openmp-rt
LLVM_BUILD=${BASE}/llvm_build
mkdir -p ${LLVM_BUILD}

# Obtaining the sources

# LLVM Sources
echo
echoc "Obtaining LLVM OpenMP..."
git_clone_or_pull ${LLVM_REPO} ${LLVM_SRC}

# Runtime Sources
echo
echoc "Obtaining LLVM OpenMP Runtime..."
git_clone_or_pull ${LLVMRT_REPO} ${LLVMRT_SRC}

# Clang Sources
echo
echoc "Obtaining LLVM/Clang OpenMP..."
git_clone_or_pull ${CLANG_REPO} ${CLANG_SRC}

# Polly Sources
echo
echoc "Obtaining Polly..."
git_clone_or_pull ${POLLY_REPO} ${POLLY_SRC}

# Archer Sources
echo
echoc "Obtaining Archer..."
git_clone_or_pull ${ARCHER_REPO} ${ARCHER_SRC}

# OpenMP Runtime Sources
echo
echoc "Obtaining LLVM OpenMP Runtime..."
git_clone_or_pull ${OPENMPRT_REPO} ${OPENMPRT_SRC}

# Compiling and installing LLVM
echo
echoc "Building LLVM/Clang..."
cd ${LLVM_BUILD}
CC=$(which gcc) CXX=$(which g++) cmake -G "${BUILD_SYSTEM}" -D CMAKE_INSTALL_PREFIX:PATH=${LLVM_INSTALL} -D LINK_POLLY_INTO_TOOLS:Bool=ON -D CLANG_DEFAULT_OPENMP_RUNTIME:STRING=libomp ${LLVM_SRC}
${BUILD_CMD} -j${PROCS} -l${PROCS}
${BUILD_CMD} install

export PATH=${LLVM_INSTALL}/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${LD_LIBRARY_PATH}

# Compiling and installing Intel OpenMP Runtime
echoc "Building LLVM OpenMP Runtime..."
cd ${OPENMPRT_SRC}/runtime
mkdir -p build && cd build
# Compiling LLVM Intel OpenMP RT (without ThreadSanitizer Support)
CC=clang CXX=clang++ cmake -G "${BUILD_SYSTEM}" -D CMAKE_INSTALL_PREFIX:PATH=${LLVM_INSTALL} -D LIBOMP_TSAN_SUPPORT=FALSE ..
${BUILD_CMD} -j${PROCS} -l${PROCS}
${BUILD_CMD} install
rm -rf *
# Compiling LLVM Intel OpenMP RT (without ThreadSanitizer Support)
CC=clang CXX=clang++ cmake -G "${BUILD_SYSTEM}" -D CMAKE_INSTALL_PREFIX:PATH=${LLVM_INSTALL} -D LIBOMP_TSAN_SUPPORT=TRUE ..
${BUILD_CMD} -j${PROCS} -l${PROCS}
${BUILD_CMD} install

echo
echo "In order to use LLVM/Clang set the following path variables:"
echo
echoc "export PATH=${LLVM_INSTALL}/bin:${LLVM_INSTALL}/bin/archer:\${PATH}"
echoc "export LD_LIBRARY_PATH=${LLVM_INSTALL}/bin:\${LD_LIBRARY_PATH}"
echo
echo "or add the previous line to your"
echo "shell start-up script such as \"~/.bashrc\"".
echo
echo
echoc "LLVM installation completed."
echo
