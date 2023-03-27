{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit SystemFolders;

interface

uses
  ShlObj;

type
  TSystemFolders = class(TObject)
  strict protected
    class procedure FreePIDL(PIDL: PItemIDList);
      {Uses to shell allocator to free the memory used by a PIDL.
        @param PIDL [in] PIDL that is to be freed.
      }
    class function PIDLToFolderPath(PIDL: PItemIDList): string;
      {Returns the full path to a file system folder described by a PIDL.
        @param PIDL [in] PIDL describing folder.
        @return Full path to folder described by PIDL or '' if PIDL refers to
          virtual folder.
      }
    class function SpecialFolderPath(CSIDL: Integer): string;
      {Returns the full path to a special file system folder.
        @param CSIDL [in] Constant specifying the special folder.
        @return Folder path or '' if the special folder is virtual or CSIDL not
          supported on the OS.
      }
    class function GetCurrentVersionRegStr(ValName: string): string;
      {Gets string info for given value from Windows current version key in
      registry.
        @param ValName [in] Name of value to be read.
        @return Required value or empty string if value does not exist.
      }
  public
    constructor Create;
      {Constructor override that prevents the class from being instantiated.
      Raises an ENoConstructException if called.
      }
    class function PerUserAppDataDir: string;
      {Gets the current user's application data directory.
        @return Required directory.
      }
    class function ProgramFilesDir: string;
      {Gets the fully qualified name of the Program Files folder.
        @return Required directory name.
      }
    class function ProgramFilesX86Dir: string;
      {Gets the fully qualified name of the Program Files x86 folder, if
      present.
        @return Required directory name on 64 bit Windows or empty string on 32
         bit Windows.
      }
    class function CommonFilesDir: string;
      {Gets the fully qualified name of the Common Files folder.
        @return Required directory name.
      }
    class function CommonFilesX86Dir: string;
      {Gets the fully qualified name of the Common Files x86 folder, if present.
        @return Required directory name on 64 bit Windows or empty string on 32
         bit Windows.
      }
  end;

implementation

uses
  SysUtils, ActiveX, Registry, Windows;

{ TSystemFolders }

class function TSystemFolders.CommonFilesDir: string;
begin
  Result :=  ExcludeTrailingPathDelimiter(
    GetCurrentVersionRegStr('CommonFilesDir')
  );
end;

class function TSystemFolders.CommonFilesX86Dir: string;
begin
  Result :=  ExcludeTrailingPathDelimiter(
    GetCurrentVersionRegStr('CommonFilesDir (x86)')
  );
end;

constructor TSystemFolders.Create;
begin
  raise ENoConstructException.Create(
    ClassName + '.Create: Constructor can''t be called'
  );
end;

class procedure TSystemFolders.FreePIDL(PIDL: PItemIDList);
var
  Malloc: IMalloc;  // shell's allocator
begin
  if Succeeded(SHGetMalloc(Malloc)) then
    Malloc.Free(PIDL);
end;

class function TSystemFolders.GetCurrentVersionRegStr(ValName: string): string;

  function IsWin2000OrEarlier: Boolean;
  begin
    // NOTE 1: all Win9x OSs have InternalMajorVersion < 5, so we don't need to
    // check platform.
    // NOTE 2: actually OS can't be earlier than Windows 2000 because Delphi XE
    // doesn't support earlier OSs
    Result := (Win32MajorVersion < 5) or
      ((Win32MajorVersion = 5) and (Win32MinorVersion = 0));
  end;

  function RegCreateReadOnly: TRegistry;
    {Creates a read only TRegistry instance. On OSs that don't support passing
    access flags to TRegistry constructor, registry is opened normally for
    read/write access.
      @return Required registry instance. Caller must free.
    }
  begin
    if IsWin2000OrEarlier then
      Result := TRegistry.Create
    else
      Result := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  end;

  function RegOpenKeyReadOnly(const Reg: TRegistry; const Key: string): Boolean;
    {Opens a registry key for reading only.
      @param Reg [in] A registry object that must have been created with
        (KEY_READ or KEY_WOW64_64KEY) access flags on XP and later.
      @param Key [in] Key to be opened.
      @return True if key opened successfully, False if not.
    }
  begin
    if IsWin2000OrEarlier then
      Result := Reg.OpenKeyReadOnly(Key)
    else
      Result := Reg.OpenKey(Key, False);
  end;

var
  Reg: TRegistry;          // registry access object
  ValueInfo: TRegDataInfo; // info about registry value
const
  CurrentVerSubKey = '\Software\Microsoft\Windows\CurrentVersion';
begin
  Result := '';
  // Open registry at required root key
  Reg := RegCreateReadOnly;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    // Open registry key and check value exists
    if RegOpenKeyReadOnly(Reg, CurrentVerSubKey)
      and Reg.ValueExists(ValName) then
    begin
      // Check if registry value is string or integer
      Reg.GetDataInfo(ValName, ValueInfo);
      case ValueInfo.RegData of
        rdString, rdExpandString:
          // string value: just return it
          Result := Reg.ReadString(ValName);
        rdInteger:
          // integer value: convert to string
          Result := IntToStr(Reg.ReadInteger(ValName));
        else
          // unsupported value: raise exception
          raise Exception.Create('Unknown registry data type');
      end;
    end;
  finally
    // Close registry
    Reg.CloseKey;
    Reg.Free;
  end;end;

class function TSystemFolders.PerUserAppDataDir: string;
begin
  Result := SpecialFolderPath(CSIDL_APPDATA);
end;

class function TSystemFolders.PIDLToFolderPath(PIDL: PItemIDList): string;
begin
  SetLength(Result, MAX_PATH);
  if SHGetPathFromIDList(PIDL, PChar(Result)) then
    Result := PChar(Result)
  else
    Result := '';
end;

class function TSystemFolders.ProgramFilesDir: string;
begin
  Result :=  ExcludeTrailingPathDelimiter(
    GetCurrentVersionRegStr('ProgramFilesDir')
  );
end;

class function TSystemFolders.ProgramFilesX86Dir: string;
begin
  Result :=  ExcludeTrailingPathDelimiter(
    GetCurrentVersionRegStr('ProgramFilesDir (x86)')
  );
end;

class function TSystemFolders.SpecialFolderPath(CSIDL: Integer): string;
var
  PIDL: PItemIDList;  // PIDL of the special folder
begin
  Result := '';
  if Succeeded(SHGetSpecialFolderLocation(0, CSIDL, PIDL)) then
  begin
    try
      Result := ExcludeTrailingPathDelimiter(PIDLToFolderPath(PIDL));
    finally
      FreePIDL(PIDL);
    end;
  end
end;

end.
