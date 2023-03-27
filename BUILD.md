DelphiDabbler Game Of Life - Build Notes
========================================

Getting the source code
-----------------------

The program's [web page](http://delphidabbler.com/software/life) provides information on how to download the source code.

The download is in zip format. Create a new directory and extract the contents of the zip file into it, preserving the directory structure.

Dependencies
------------

The program depends on two _DelphiDabbler_ components. Both can be obtained from the DelphiDabbler website. They are:

* [Version Information Component](http://delphidabbler.com/software/verinfo)
* [About Box Component](http://delphidabbler.com/software/aboutbox)

The components must be installed into the _Delphi_ IDE and be compiled in the location specified by the `DELPHIDABLIB` environment variable.

Build tools
-----------

The following tools are required to build the program:

* _Delphi XE_.
The programs _RC_, _BRCC32_ and _MAKE_ that are installed with _Delphi XE_ are also needed.
> Later versions of Delphi may work, but have not been tested.
> Delphi starter editions are not suitable since they lack access to the command line compiler.
* The _[Info-ZIP](http://stahlforce.com/dev/index.php?tool=zipunzip)_ command line zip utility, v2.32 recommended.
* The _[VIEd](http://www.delphidabbler.com/software/vied)_ Version Information Editor, v2.13.1 or later.

Build environment
-----------------

Certain environment variables are required in order to configure the build tree and to compile the source.

These environment variables are listed, under the headings _Required macros_ and _Optional macros_, in the comment block at the top of the file `Makefile` in the `Source` directory.

Building the source
-------------------

Source code is configure and compiled using the _Make_ utility.

_Make_ must be run from a command prompt with current directory set to the `Source` directory.

> **Note:** It is important that the version of _Make_ that is run is the version can came with _Delphi_. You can ensure this by specifying the full path to _Make_ or by using `%DELPHIROOT%\Bin\Make`.

The syntax for _Make_ is `Make target` where `target` is one of several build targets supported by `Makefile`.

A list of supported targets can be found in the block of comments at top of `Makefile`, under the heading _Supported Commands_.

Using the Delphi IDE
--------------------

You can use the Delphi IDE to modify and compile the source code, providing you have first configured the build tree using `Make config` and have compiled the required resource files with `Make resources`.

> **Note:** If you change any of the project options using the IDE you must also update `Life.cfg` in the `Source` directory to reflect the changes. Failure to do so will mean that the changed options won't be recognised by the command line compiler.

Even if you do use the IDE to compile the Pascal code, it is recommended that the final build is done using _Make_ from the command line.


Output files
------------

All files generated as part of the build process are stored in a `Build` directory created in the root of the directory where you unzipped the source.

`Build` will have three sub-directories:

* `Bin` where all intermediate binaries files are written, such as `.dcu` and `.res` files.
* `Exe` where the program executable is written.
* `Release` where the release file is written. This is a zip file that contains the files included in the executable program release. This directory will only have content if the `release` target was made.

No support
----------

This program is no longer being developed so please don't ask any questions about compiling or using the program.

What you do with it is up to you!
