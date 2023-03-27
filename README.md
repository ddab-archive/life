Game of Life by DelphiDabbler
=============================

Introduction
------------

This program simulates John Conway's Game of Life and other cellular automata.

It can be used as a portable application, so it can be run from any writable portable device and will not modify the system on which it is running.

Installing And Running
----------------------

_Game of Life_ is a 32 bit Windows application that is distributed in a zip file. There is no installer.

Simply create a folder for the program on your system and extract the all the contents of the zip file into it. To run the program just double click `Life.exe`.

> It is recommended that you **do not** install the program in your system's _Program Files_ or _Common Files_ folder(s).

The program is designed to be used as a portable application. By default it stores it's  configuration file in the same directory as the executable file. It does not write to the Windows registry.

However, if the program is stored in your system's _Program Files_ or _Common Files_ folders it will sense this and will store its data in you current user's application directory, specifically in the `%AppData%\DelphiDabbler\Life` directory. So, if you install it there it will **not** act as a portable application.

Source Code
-----------

The program's source code is available. See the program's web page at http://delphidabbler.com/software/life for details.

For information on how to compile the program from source see the file `BUILD.md` that is included in the source code download.

License
-------

DelphiDabbler _Game Of Life_ is copyright Peter D Johnson (http://delphidabbler.com) and is licensed under the MIT license. See the accompanying `LICENSE` file or go to http://delphidabbler.mit-license.org/1992-2015/

No Support
----------

This program is no longer being developed and so no support is available for it. Bug reports and feature requests are not being accepted.

A Little History
----------------

The program was originally written in 1992 as a DOS programming exercise using Turbo Pascal to enter into a programming competition. It didn't win :-(

In 1997 it was converted to a 16 bit Windows 3.1 application and compiled with Delphi 1, again as a programming exercise when learning OOP and Windows programming. It was used as a testbed for UI design ideas (and not very good ones at that!).

It remained as a 16 bit program until 2003, when it was converted to 32 bit using Delphi 4. Only the minimum of work was done to get it to compile. It still had a 16 bit Windows feel to it.

Finally in 2015 it was given an overhaul to give it a slightly more modern look. It was recompiled with Delphi XE and made to play nicely on modern Windows systems. It lost it's main menu and customisable tool bar, because both were overkill.

Underneath it's still very much a 1990s programming exercise that I'm rather ashamed of now. I've not spent any time refactoring the code, but it really does need it. The only reason it's not been thrown out is that it's my oldest surviving DOS/Windows program and as such I can't bring myself throw it away!

But this really is its final update. I'll let it speak for itself. Don't judge me too harshly!
