program MatrixOperations32;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  TMatrix32 = class
  private
    FData: array of array of Integer; // 32-bit integers
    FRows, FCols: Integer;
  public
    constructor Create(Rows, Cols: Integer);
    procedure FillRandom;
    procedure Display;
    function Add(Other: TMatrix32): TMatrix32;
    function Multiply(Other: TMatrix32): TMatrix32;
  end;

constructor TMatrix32.Create(Rows, Cols: Integer);
begin
  FRows := Rows;
  FCols := Cols;
  SetLength(FData, Rows, Cols);
end;

procedure TMatrix32.FillRandom;
var
  I, J: Integer;
begin
  Randomize;
  for I := 0 to FRows - 1 do
    for J := 0 to FCols - 1 do
      FData[I][J] := Random(100); // Fill with random 32-bit integers
end;

procedure TMatrix32.Display;
var
  I, J: Integer;
begin
  for I := 0 to FRows - 1 do
  begin
    for J := 0 to FCols - 1 do
      Write(FData[I][J]:4);
    Writeln;
  end;
end;

function TMatrix32.Add(Other: TMatrix32): TMatrix32;
var
  I, J: Integer;
begin
  if (FRows <> Other.FRows) or (FCols <> Other.FCols) then
    raise Exception.Create('Matrix dimensions do not match for addition.');

  Result := TMatrix32.Create(FRows, FCols);
  for I := 0 to FRows - 1 do
    for J := 0 to FCols - 1 do
      Result.FData[I][J] := FData[I][J] + Other.FData[I][J];
end;

function TMatrix32.Multiply(Other: TMatrix32): TMatrix32;
var
  I, J, K: Integer;
begin
  if FCols <> Other.FRows then
    raise Exception.Create('Matrix dimensions do not match for multiplication.');

  Result := TMatrix32.Create(FRows, Other.FCols);
  for I := 0 to FRows - 1 do
    for J := 0 to Other.FCols - 1 do
    begin
      Result.FData[I][J] := 0;
      for K := 0 to FCols - 1 do
        Result.FData[I][J] := Result.FData[I][J] + FData[I][K] * Other.FData[K][J];
    end;
end;

var
  A, B, C: TMatrix32;
begin
  try
    A := TMatrix32.Create(2, 3);
    B := TMatrix32.Create(3, 2);

    A.FillRandom;
    B.FillRandom;

    Writeln('Matrix A:');
    A.Display;

    Writeln('Matrix B:');
    B.Display;

    Writeln('Matrix A * B:');
    C := A.Multiply(B);
    C.Display;
    C.Free;

    A.Free;
    B.Free;
  except
    on E: Exception do
      Writeln('Error: ', E.Message);
  end;
end.
