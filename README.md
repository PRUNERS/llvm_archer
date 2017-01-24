<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgb79d706">1. License</a></li>
<li><a href="#org1b50543">2. Introduction</a></li>
<li><a href="#org277ee2b">3. Prerequisites</a></li>
<li><a href="#org8a4a69a">4. Installation</a>
<ul>
<li><a href="#org01198b9">4.1. Manual Building</a></li>
<li><a href="#orgdb9ae9a">4.2. Automatic Building</a></li>
<li><a href="#org06199b9">4.3. Options</a></li>
</ul>
</li>
<li><a href="#org9223ec1">5. Publications</a></li>
<li><a href="#org52c6092">6. Contacts and Support</a></li>
<li><a href="#orgc5ab3e1">7. Sponsors</a></li>
</ul>
</div>
</div>


<a id="orgb79d706"></a>

# License

Please see LICENSE for usage terms.


<a id="org1b50543"></a>

# Introduction

<img src="resources/images/archer_logo.png" hspace="5" vspace="5" height="45%" width="45%" alt="ARCHER Logo" title="ARCHER" align="right" />

**ARCHER** is a data race detector for OpenMP programs.

ARCHER combines static and dynamic techniques to identify data races
in large OpenMP applications, leading to low runtime and memory
overheads, while still offering high accuracy and precision. It builds
on open-source tools infrastructure such as LLVM, ThreadSanitizer, and
OMPT to provide portability.


<a id="org277ee2b"></a>

# Prerequisites

To compile ARCHER you need an host Clang/LLVM version >= 3.9, a
CMake version >= 3.4.3.

Ninja build system is preferred. For more information how to obtain
Ninja visit <https://martine.github.io/ninja>.

ARCHER has been tested with the LLVM OpenMP Runtime version >= 3.9,
and with the LLVM OpenMP Runtime with OMPT support currently under
development at <https://github.com/OpenMPToolsInterface/LLVM-openmp>
(under the branch "align-to-tr").


<a id="org8a4a69a"></a>

# Installation

ARCHER has been developed under LLVM 3.9 (for more information visit
<http://llvm.org>).


<a id="org01198b9"></a>

## Manual Building

For a manual building please visit the GitHub page
<https://github.com/PRUNERS/ARCHER>.


<a id="orgdb9ae9a"></a>

## Automatic Building

ARCHER comes both as standalone and LLVM tool.

In order to obtain and automatically build Clang/LLVM with ARCHER
support execute the following commands in your command-line
(instructions are based on bash shell, GCC-4.9.3 version and Ninja
build system).

Build Clang/LLVM 3.9 with ARCHER support by running `install.sh`:

    export LLVM_INSTALL=$HOME/usr
    ./install.sh <path-to-installation-folder>

The installation script will create a folder called *LLVM* at the same
level of the *llvm\_archer* directory and install LLVM into
*LLVM\_INSTALL*. By default the script will try to install the software
under "/usr".

Once the installation completes, you need to setup your environement
to allow ARCHER to work correctly.

Please set the following path variables:

    export PATH=${LLVM_INSTALL}/bin:${PATH}"
    export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${LD_LIBRARY_PATH}"

To make the environment permanent add the previous lines or
equivalents to your shell start-up script such as "~/.bashrc".


<a id="org06199b9"></a>

## Options

Running the command:

    ./install --help

shows the options available for building and installing Clang/LLVM
with ARCHER support.

    Usage

      ./install.sh [options]

    Options
      --prefix=<value>             = Specify an installation path.
      --build-system=<value>       = Specify a build system generator. Please run
                                     'man cmake-generators' for a list of generators
                                     available for this platform. Default is Ninja.
      --release=<value>            = Specify the release version of Clang/LLVM that
                                     will be installed (>= 39). Default is 3.9.
      --http                       = Enables GitHub web url in case SSH key and
                                     passphrase are not set in the GitHub account.
      --llvm-only                  = Build and install only Clang/LLVM without
                                     ARCHER support and OpenMP runtime.
      --update                     = Update previous building. Default is SSH.
      --omp-tsan-support           = Enabled ThreadSanitizer support in official
                                     LLVM OpenMP runtime. Default is an LLVM OpenMP
                                     Runtime with OMPT support.
      --build-type=<value>         = Specify the type of build. Accepted values
                                     are Release (default), Debug or RelWithDebInfo.
      --gcc-toolchain-path=<value> = Specify the GCC toolchain path.


<a id="org9223ec1"></a>

# Publications

-   S. Atzeni, G. Gopalakrishnan, Z. Rakamaric, D. H. Ahn, I. Laguna,
    M. Schulz, G. L. Lee, J. Protze, and M. S. Müller. 2016. "ARCHER:
    Effectively Spotting Data Races in Large Openmp Applications." In
    2016 IEEE International Parallel and Distributed Processing
    Symposium (IPDPS),
    53–62. <http://ieeexplore.ieee.org/document/7516001/>
-   J. Protze, S. Atzeni, D. H. Ahn, M. Schulz, G.  Gopalakrishnan,
    M. S. Müller, I. Laguna, Z.  Rakamarić, and
    G. L. Lee. 2014. "Towards Providing Low-Overhead Data Race Detection
    for Large Openmp Applications." In Proceedings of the 2014 LLVM
    Compiler Infrastructure in HPC,
    40–47. <http://dl.acm.org/citation.cfm?id=2688369>


<a id="org52c6092"></a>

# Contacts and Support

-   [Google group](https://groups.google.com/forum/#!forum/archer-pruner)
-   [Slack Channel](https://pruner.slack.com/shared_invite/MTIzNzExNzg4ODgxLTE0ODM3MzE2NTctNmRjNmM0NDYwNA)
-   E-Mail Contacts:

    <ul style="list-style-type:circle"> <li> <a href="mailto:simone@cs.utah.edu?Subject=[archer-dev]%20" target="_top">Simone Atzeni</a> </li> <li> <a href="mailto:protze@itc.rwth-aachen.de?Subject=[archer-dev]%20" target="_top">Joachim Protze</a> </li> </ul>


<a id="orgc5ab3e1"></a>

# Sponsors

<img src="resources/images/uofu_logo.png" hspace="15" vspace="5" height="23%" width="23%" alt="UofU Logo" title="University of Utah" style="float:left" /> <img src="resources/images/llnl_logo.png" hspace="70" vspace="5" height="30%" width="30%" alt="LLNL Logo" title="Lawrence Livermore National Laboratory" style="float:center" /> <img src="resources/images/rwthaachen_logo.png" hspace="15" vspace="5" height="23%" width="23%" alt="RWTH AACHEN Logo" title="RWTH AACHEN University" style="float:left" />
