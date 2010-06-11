{
  Syntax highlighter for SynEdit. Highlighting a general purpose configuration
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
  Graphics, SynEditHighlighter, SynEditHighlighterFoldBase, SynEditTypes,
  SynEditStrConst, SysUtils, Classes;

type

  TtkTokenKind = (
    tkNil,   tkUnknown, tkSpace,   tkName,
    tkEqual, tkValue,   tkComment, tkList,
    tkString
  );

  { TSynBasicConfig }

  TSynBasicConfig = class(TSynCustomHighlighter)
  private
    fCommentAttri,
    fEqualAttri,
    fListAttri,
    fNameAttri,
    fSpaceAttri,
    fStringAttri,
    fUnknownAttri,
    fValueAttri    : TSynHighlighterAttributes;
    fTokenID       : TtkTokenKind;
  public
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function  GetTokenAttribute: TSynHighlighterAttributes; override;
    function  GetTokenKind: integer; override;
    function  GetTokenPos: Integer; override;
    function  GetTokenID: TtkTokenKind;

    function GetEol: Boolean; override;


  published
    property UnknownAttri : TSynHighlighterAttributes read fUnknownAttri
                                                            write fUnknownAttri;
    property SpaceAttri   : TSynHighlighterAttributes read fSpaceAttri
                                                              write fSpaceAttri;
    property NameAttri    : TSynHighlighterAttributes read fNameAttri
                                                               write fNameAttri;
    property EqualAttri   : TSynHighlighterAttributes read fEqualAttri
                                                              write fEqualAttri;
    property ValueAttri   : TSynHighlighterAttributes read fValueAttri
                                                              write fValueAttri;
    property CommentAttri : TSynHighlighterAttributes read fCommentAttri
                                                            write fCommentAttri;
    property ListAttri    : TSynHighlighterAttributes read fListAttri
                                                               write fListAttri;
    property StringAttri  : TSynHighlighterAttributes read fStringAttri
                                                             write fStringAttri;
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

  fCommentAttri       := TSynHighlighterAttributes.Create(SYNS_AttrComment,
                                                          SYNS_XML_AttrComment);
  fCommentAttri.Style := [fsItalic];
  AddAttribute(fCommentAttri);

  fEqualAttri         := TSynHighlighterAttributes.Create(SYNS_AttrCondition,
                                                          SYNS_XML_AttrOperator);
  AddAttribute(fEqualAttri);

  fListAttri          := TSynHighlighterAttributes.Create(SYNS_AttrListOfValues,
                                                          SYNS_XML_ListOfValues);
  AddAttribute(fListAttri);

  fNameAttri          := TSynHighlighterAttributes.Create(SYNS_AttrKey,
                                                          SYNS_XML_AttrKey);
  fNameAttri.Style    := [fsBold];
  AddAttribute(fNameAttri);

  fSpaceAttri         := TSynHighlighterAttributes.Create(SYNS_AttrSpace,
                                                          SYNS_XML_AttrSpace);
  AddAttribute(fSpaceAttri);

  fStringAttri        := TSynHighlighterAttributes.Create(SYNS_AttrString,
                                                          SYNS_XML_AttrString);
  AddAttribute(fStringAttri);

  fUnknownAttri       := TSynHighlighterAttributes.Create(SYNS_AttrUnknownWord,
                                                          SYNS_XML_AttrUnknownWord);
  fUnknownAttri.Style := [fsItalic];
  AddAttribute(fUnknownAttri);

  fValueAttri         := TSynHighlighterAttributes.Create(SYNS_AttrValue,
                                                          SYNS_XML_AttrValue);
  AddAttribute(fValueAttri);
end;

destructor TSynBasicConfig.Destroy;
begin
  inherited Destroy;
end;

function TSynBasicConfig.GetTokenAttribute : TSynHighlighterAttributes;
begin
  case fTokenID of
    tkNil,
    tkUnknown : result := fUnknownAttri;
    tkSpace   : result := fSpaceAttri;
    tkName    : result := fNameAttri;
    tkEqual   : result := fEqualAttri;
    tkValue   : result := fValueAttri;
    tkComment : result := fCommentAttri;
    tkList    : result := fListAttri;
    tkString  : result := fSpaceAttri;
    else        result := nil;
  end;
end;

function TSynBasicConfig.GetTokenKind : integer;
begin
  Result := Ord(fTokenID);
end;

function TSynBasicConfig.GetTokenPos : Integer;
begin
  Result := fTokenPos;
end;

function TSynBasicConfig.GetTokenID : TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynBasicConfig.GetEol : Boolean;
begin
  Result := fTokenId = tkNull;
end;

{$IFNDEF SYN_CPPB_1}
initialization
  RegisterPlaceableHighlighter(TSynBasicConfig);
{$ENDIF}
end.

