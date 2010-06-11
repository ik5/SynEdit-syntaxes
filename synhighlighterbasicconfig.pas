{ Syntax highlighter for SynEdit. Highlighting a general purpose configuration
  file in the corrent struture :

  ; one line comment
  name=value
  name =more value
  name = "some value"
  name =value,value,value ; comment


  Copyright (C) 2010 Ido Kanner idokan at@at gmail dot.dot com

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}
unit SynHighlighterBasicConfig;

{$I synedit.inc}

interface

uses
  {$IFDEF SYN_LAZARUS}
      LCLIntf, LCLType,
  {$ENDIF}
      Graphics, SynEditHighlighter, SynEditHighlighterFoldBase, SynEditTypes, SynEditStrConst,
      SysUtils, Classes;

type

  TtkTokenKind = (
    tkUnknown, tkSpace, tkName, tkEqual, tkValue, tkComment, tkList, tkString
  );

  { TSynBasicConfig }

  TSynBasicConfig = class(TSynCustomFoldHighlighter)
  public
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TSynBasicConfig }

class function TSynBasicConfig.GetLanguageName : string;
begin
  Result := SYNS_LangBasicConfig;
end;

constructor TSynBasicConfig.Create ( AOwner : TComponent ) ;
begin
  inherited Create ( AOwner ) ;
end;

destructor TSynBasicConfig.Destroy;
begin
  inherited Destroy;
end;

{$IFNDEF SYN_CPPB_1}
initialization
  RegisterPlaceableHighlighter(TSynBasicConfig);
{$ENDIF}
end.

