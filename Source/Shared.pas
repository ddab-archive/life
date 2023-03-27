{
  Distributed under the MIT license.
  See the accompanying LICENSE file or go to
  http://delphidabbler.mit-license.org/1992-2015/
}

unit Shared;

interface

uses
  Graphics;

type
  {The grid elements}
  TGridElement = (geBackground, geGridLine, geLifeForm, geHighlight);

const
  {Default grid colours}
  CBackgroundColour = clWhite;                {Default background colour}
  CGridLineColour = clSilver;                 {Default grid line colour}
  CLifeFormColour = clNavy;                   {Default lifeform colour}
  CHighlightColour = clBlack;                 {Default highlight colour}
  {Default rule name}
  CDefRuleName = 'Game of Life';

implementation

end.
