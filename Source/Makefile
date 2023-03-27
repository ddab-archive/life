# Distributed under the MIT license.
# See the accompanying LICENSE file or go to
# http://delphidabbler.mit-license.org/1992-2015/


# Required macros
# ---------------
#
# The following macros are required. Make will fail if they are not set.
#
# DELPHIROOT
#   The full path of the installation directory of the required Delphi compiler
#  (Delphi XE as a minimum).
#
# DELPHIDABLIB
#    DELPHIDABLIB The full path of the directory where the DelphiDabbler library
#    components are installed for the required Delphi compiler.
#
# Optional macros
# ---------------
#
# These macros may be defined. Where they are not defined then the programs to
# which they refer must be on the system path.
#
# VIEDROOT
#   Full path where the DelphiDabbler Version Information Editor (VIEd) is
#   installed.
#
# ZIPROOT
#   Path where Zip.exe is installed.
#
# Supported Commands
# ------------------
#
# make config
#   Creates a Build directory with its required sub-directories.
#
# make resources
#   Compiles the resource files required to build the program. Files are placed
#   in the Build\Bin directory, which must exist.
#
# make pascal
#   Compiles the pascal source using the required version of Delphi. Required
#   resource files must be present in the Build\Bin directory. The executable
#   file is placed in the Build\Exe directory.
#
# make life
#   Compiles Life from source. Equivalent to "make resources" followed by "make
#   pascal".
#
# make release
#   Creates a zip file containing the required release files. The zip file is
#   placed in the Build\Release directory.
#
# make everything
#   This is the default option used when make is run with no targets. It
#   configures the source tree, builds the Life executable and the creates the
#   release zip file.
#
# make clean
#   Deletes unwanted and temporary files and directories. Does not delete the
#   Build directory and its contents.
#
# make deepclean
#   Deletes unwanted and temporary files and directories as "make clean" and
#   then removes the Build directories created by "make config".


# Set various paths

SOURCE = Source
DOCS = Docs
BUILD = Build
BIN = $(BUILD)\Bin
EXE = $(BUILD)\Exe
RELEASE = $(BUILD)\Release
RELEASEFILENAME = Life
OUTFILE = $(RELEASE)\$(RELEASEFILENAME).zip

# Check for required macros

!ifndef DELPHIROOT
!error DELPHIROOT environment variable required.
!endif

!ifndef DELPHIDABLIB
!error DELPHIDABLIB environment variable required.
!endif

# Define common macros that access required build tools

MAKE = "$(MAKEDIR)\Make.exe" -$(MAKEFLAGS)
DCC32 = "$(DELPHIROOT)\Bin\DCC32.exe"
RC = "$(DELPHIROOT)\Bin\RC.exe"
BRCC = "$(DELPHIROOT)\Bin\BRCC32.exe"

!ifdef VIEDROOT
VIED = "$(VIEDROOT)\VIEd.exe" -makerc
!else
VIED = VIEd.exe -makerc
!endif

!ifdef ZIPROOT
ZIP = "$(ZIPROOT)\Zip.exe"
!else
ZIP = Zip.exe
!endif

# Implicit rules

# Delphi projects are assumed to contain required output and search path
# locations in the project options .cfg file.
.dpr.exe:
  @echo +++ Compiling Delphi Project $< +++
  @$(DCC32) $< -B -U"$(DELPHIDABLIB)"

# Resource files are compiled to the Build\Bin directory using RC
.rc.res:
  @echo +++ Compiling Resource file $< to $(@F) +++
  @$(RC) -fo..\$(BIN)\$(@F) $<

# Temporary resource files with special extension .tmp-rcx are compiled to the
# Build\Bin directory using BRCC32
.tmp-rcx.res:
  @echo +++ Compiling Resource file $< to $(@F) +++
  @$(BRCC) -fo..\$(BIN)\$(@F) $<
  -@del $(<B).tmp-rcx

# Version info files are compiled by VIEd to a temporary .tmp-rcx resource file
.vi.tmp-rcx:
  @echo +++ Compiling Version Info file $< to $(@F) +++
  @$(VIED) .\$<
  -@ren $(@B).rc $(@F)

# Targets

# Default is to build everything and create release file
everything: config life release

# Build Life executable
life: resources pascal

# Configure build folders
config:
  @echo +++ Configuring Life build tree +++
  # Create empty build folders
  @cd ..
  @if exist $(BIN) rmdir /S /Q $(BIN)
  @if exist $(EXE) rmdir /S /Q $(EXE)
  @if exist $(RELEASE) rmdir /S /Q $(RELEASE)
  @if exist $(BUILD) rmdir /S /Q $(BUILD)
  @mkdir $(BUILD)
  @mkdir $(BIN)
  @mkdir $(EXE)
  @mkdir $(RELEASE)
  @cd $(SOURCE)

# Builds pascal files and links program
pascal: Life.exe

# Compiles the resources
resources: Resource.res Version.res

# Create release files (.zip)
release:
  @echo +++ Creating Release File $(OUTFILE) +++
  @cd ..
  -@if exist $(OUTFILE) del $(OUTFILE)
  @$(ZIP) -j -9 $(OUTFILE) $(EXE)\Life.exe
  @$(ZIP) -j -9 $(OUTFILE) README.md
  @$(ZIP) -j -9 $(OUTFILE) LICENSE
  @$(ZIP) -j -9 $(OUTFILE) $(DOCS)\ChangeLog.txt
  @$(ZIP) -j -9 $(OUTFILE) $(DOCS)\Manual.html
  @cd $(SOURCE)

# Clean up unwanted files
clean:
  @echo +++ Cleaning junk files +++
  @cd ..
  # remove unwanted files: temps (~ or .~*), .dsk, .local, .identcache
  -@del /S *.~* 2>nul
  -@del /S ~* 2>nul
  -@del /S *.dsk 2>nul
  -@del /S *.local 2>nul
  -@del /S *.identcache 2>nul
  -@del /S *.orig 2>nul
  # remove __history folders
  -@for /F "usebackq" %i in (`dir /S /B /A:D ..\__history`) do @rmdir /S /Q %i
  @cd $(SOURCE)

# Clean up unwanted files and remove the build directories
deepclean: clean
  @echo +++ Removing $(BUILD) and its subdirectories +++
  # remove build directories created by config
  @cd ..
  @if exist $(BIN) rmdir /S /Q $(BIN)
  @if exist $(EXE) rmdir /S /Q $(EXE)
  @if exist $(RELEASE) rmdir /S /Q $(RELEASE)
  @if exist $(BUILD) rmdir /S /Q $(BUILD)
  @cd $(SOURCE)
