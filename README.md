<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. License</a></li>
<li><a href="#sec-2">2. Introduction</a></li>
<li><a href="#sec-3">3. Prerequisites</a></li>
<li><a href="#sec-4">4. Installation</a>
<ul>
<li><a href="#sec-4-1">4.1. Manual Building</a></li>
<li><a href="#sec-4-2">4.2. Automatic Building</a></li>
<li><a href="#sec-4-3">4.3. Options</a></li>
</ul>
</li>
<li><a href="#sec-5">5. Contacts and Support</a></li>
<li><a href="#sec-6">6. Sponsors</a></li>
</ul>
</div>
</div>


# License<a id="sec-1" name="sec-1"></a>

Please see LICENSE for usage terms.

# Introduction<a id="sec-2" name="sec-2"></a>

<img src="resources/images/archer_logo.png" hspace="5" vspace="5" height="45%" width="45%" alt="ARCHER Logo" title="ARCHER" align="right" />

**ARCHER** is a data race detector for OpenMP programs.


ARCHER combines static and dynamic techniques to identify data races
in large OpenMP applications, leading to low runtime and memory
overheads, while still offering high accuracy and precision. It builds
on open-source tools infrastructure such as LLVM, ThreadSanitizer, and
OMPT to provide portability.

# Prerequisites<a id="sec-3" name="sec-3"></a>

To compile ARCHER you need an host Clang/LLVM version >= 3.9, a
CMake version >= 3.4.3.

Ninja build system is preferred. For more information how to obtain
Ninja visit <https://martine.github.io/ninja>.

ARCHER has been tested with the LLVM OpenMP Runtime version >= 3.9,
and with the LLVM OpenMP Runtime with OMPT support currently under
development at <https://github.com/OpenMPToolsInterface/LLVM-openmp>
(under the branch "align-to-tr").

# Installation<a id="sec-4" name="sec-4"></a>

ARCHER has been developed under LLVM 3.9 (for more information visit
<http://llvm.org>).

## Manual Building<a id="sec-4-1" name="sec-4-1"></a>

For a manual building please visit the GitHub page
<https://github.com/PRUNER/archer>.

## Automatic Building<a id="sec-4-2" name="sec-4-2"></a>

ARCHER comes both as standalone and LLVM tool.

In order to obtain and automatically build Clang/LLVM with ARCHER
support execute the following commands in your command-line
(instructions are based on bash shell, GCC-4.9.3 version and Ninja
build system).

Build Clang/LLVM 3.9 with ARCHER support by running `install.sh`:

    export LLVM_INSTALL=$HOME/usr
    ./install.sh --prefix=$LLVM_INSTALL [default: --prefix=/usr]

The installation script will create a folder called *LLVM* at the same
level of the *llvm\\\_archer* directory and install LLVM into
*LLVM\\\_INSTALL*.

In case your GCC is not installed in a standard path you need to
specify the GCC toolchain path for LLVM/Clang using the flag
*&#x2013;gcc-toolchain-path*:

    ./install.sh --prefix=$LLVM_INSTALL --gcc-toolchain-path=gcc_toolchain_path

Once the installation completes, you need to setup your environement
to allow ARCHER to work correctly.

Please set the following path variables:

    export PATH=${LLVM_INSTALL}/bin:${PATH}"
    export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${LD_LIBRARY_PATH}"

To make the environment permanent add the previous lines or
equivalents to your shell start-up script such as "~/.bashrc".

## Options<a id="sec-4-3" name="sec-4-3"></a>

# Contacts and Support<a id="sec-5" name="sec-5"></a>

-   [Google group](https://groups.google.com/forum/#!forum/archer-pruner)
-   [Slack Channel](https://pruner.slack.com/shared_invite/MTIzNzExNzg4ODgxLTE0ODM3MzE2NTctNmRjNmM0NDYwNA)
-   E-Mail Contacts:

    <ul style="list-style-type:circle"> <li> <a href="mailto:simone@cs.utah.edu?Subject=[archer-dev]%20" target="_top">Simone Atzeni</a> </li> <li> <a href="mailto:protze@itc.rwth-aachen.de?Subject=[archer-dev]%20" target="_top">Joachim Protze</a> </li> </ul>

# Sponsors<a id="sec-6" name="sec-6"></a>

<img src="resources/images/uofu_logo.png" hspace="15" vspace="5" height="23%" width="23%" alt="UofU Logo" title="University of Utah" style="float:left" /> <img src="resources/images/llnl_logo.png" hspace="70" vspace="5" height="30%" width="30%" alt="LLNL Logo" title="Lawrence Livermore National Laboratory" style="float:center" /> <img src="resources/images/rwthaachen_logo.png" hspace="15" vspace="5" height="23%" width="23%" alt="RWTH AACHEN Logo" title="RWTH AACHEN University" style="float:left" />