<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org150c577">1. License</a></li>
<li><a href="#orgaade682">2. Introduction</a></li>
<li><a href="#org6ae3bc7">3. Prerequisites</a></li>
<li><a href="#org9b49216">4. Installation</a>
<ul>
<li><a href="#org5beeeba">4.1. Manual Building</a></li>
<li><a href="#orgc421146">4.2. Automatic Building</a></li>
<li><a href="#org2e1d8eb">4.3. Options</a></li>
</ul>
</li>
<li><a href="#orgb78012e">5. Publications</a></li>
<li><a href="#orgee8af32">6. Contacts and Support</a></li>
<li><a href="#org6bb216a">7. Sponsors</a></li>
</ul>
</div>
</div>


<a id="org150c577"></a>

# License

Please see LICENSE for usage terms.


<a id="orgaade682"></a>

# Introduction

<img src="resources/images/archer_logo.png" hspace="5" vspace="5" height="45%" width="45%" alt="ARCHER Logo" title="ARCHER" align="right" />

**ARCHER** is a data race detector for OpenMP programs.

ARCHER combines static and dynamic techniques to identify data races
in large OpenMP applications, leading to low runtime and memory
overheads, while still offering high accuracy and precision. It builds
on open-source tools infrastructure such as LLVM, ThreadSanitizer, and
OMPT to provide portability.


<a id="org6ae3bc7"></a>

# Prerequisites

To compile ARCHER you need an host Clang/LLVM version >= 3.9, a
CMake version >= 3.4.3.

Ninja build system is preferred. For more information how to obtain
Ninja visit <https://martine.github.io/ninja>.

ARCHER has been tested with the LLVM OpenMP Runtime version >= 3.9,
and with the LLVM OpenMP Runtime with OMPT support currently under
development at <https://github.com/OpenMPToolsInterface/LLVM-openmp>
(under the branch "align-to-tr").


<a id="org9b49216"></a>

# Installation

ARCHER has been developed under LLVM 3.9 (for more information visit
<http://llvm.org>).


<a id="org5beeeba"></a>

## Manual Building

For a manual building please visit the GitHub page
<https://github.com/PRUNER/archer>.


<a id="orgc421146"></a>

## Automatic Building

ARCHER comes both as standalone and LLVM tool.

In order to obtain and automatically build Clang/LLVM with ARCHER
support execute the following commands in your command-line
(instructions are based on bash shell, GCC-4.9.3 version and Ninja
build system).

Build Clang/LLVM 3.9 with ARCHER support by running `install.sh`:

    export LLVM_INSTALL=$HOME/usr
    ./install.sh --prefix=$LLVM_INSTALL [default: --prefix=/usr]

The installation script will create a folder called *LLVM* at the same
level of the *llvm\_archer* directory and install LLVM into
*LLVM\_INSTALL*.

Once the installation completes, you need to setup your environement
to allow ARCHER to work correctly.

Please set the following path variables:

    export PATH=${LLVM_INSTALL}/bin:${PATH}"
    export LD_LIBRARY_PATH=${LLVM_INSTALL}/lib:${LD_LIBRARY_PATH}"

To make the environment permanent add the previous lines or
equivalents to your shell start-up script such as "~/.bashrc".


<a id="org2e1d8eb"></a>

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
                                     available for this platform.
      --release=<value>            = Specify the release version of Clang/LLVM that
                                     will be installed (>= 39).
      --http                       = Enables GitHub web url in case SSH key and
                                     passphrase are not set in the GitHub account.
      --update                     = Update previous building.
      --omp-tsan-support           = Enabled ThreadSanitizer support in official
                                     LLVM OpenMP runtime, if not set an LLVM OpenMP
                                     Runtime with OMPT support will be used.
      --build-type=<value>         = Specify the type of build. Accepted values
                                     are Release (default), Debug or RelWithDebInfo.
      --gcc-toolchain-path=<value> = Specify the GCC toolchain path.


<a id="orgb78012e"></a>

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


<a id="orgee8af32"></a>

# Contacts and Support

-   [Google group](https://groups.google.com/forum/#!forum/archer-pruner)
-   [Slack Channel](https://pruner.slack.com/shared_invite/MTIzNzExNzg4ODgxLTE0ODM3MzE2NTctNmRjNmM0NDYwNA)
-   E-Mail Contacts:

    <ul style="list-style-type:circle"> <li> <a href="mailto:simone@cs.utah.edu?Subject=[archer-dev]%20" target="_top">Simone Atzeni</a> </li> <li> <a href="mailto:protze@itc.rwth-aachen.de?Subject=[archer-dev]%20" target="_top">Joachim Protze</a> </li> </ul>


<a id="org6bb216a"></a>

# Sponsors

<img src="resources/images/uofu_logo.png" hspace="15" vspace="5" height="23%" width="23%" alt="UofU Logo" title="University of Utah" style="float:left" /> <img src="resources/images/llnl_logo.png" hspace="70" vspace="5" height="30%" width="30%" alt="LLNL Logo" title="Lawrence Livermore National Laboratory" style="float:center" /> <img src="resources/images/rwthaachen_logo.png" hspace="15" vspace="5" height="23%" width="23%" alt="RWTH AACHEN Logo" title="RWTH AACHEN University" style="float:left" />
