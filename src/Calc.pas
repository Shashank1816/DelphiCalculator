program Calculator32;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  TCalculator = class
  private
    FOperand1, FOperand2: Integer; // 32-bit integers
    FBuffer: Pointer; // Memory allocation buffer
  public
    constructor Create(AOperand1, AOperand2: Integer);
    destructor Destroy; override;
    function Add: Integer;
    function Subtract: Integer;
    function Multiply: Integer;
    function Divide: Integer;
    procedure AllocateBuffer(Size: Integer);
    procedure DisplayBuffer;
  end;

constructor TCalculator.Create(AOperand1, AOperand2: Integer);
begin
  FOperand1 := AOperand1;
  FOperand2 := AOperand2;
  FBuffer := nil;
end;

destructor TCalculator.Destroy;
begin
  if FBuffer <> nil then
    FreeMem(FBuffer);
  inherited Destroy;
end;

function TCalculator.Add: Integer;
begin
  Result := FOperand1 + FOperand2;
end;

function TCalculator.Subtract: Integer;
begin
  Result := FOperand1 - FOperand2;
end;

function TCalculator.Multiply: Integer;
begin
  Result := FOperand1 * FOperand2;
end;

function TCalculator.Divide: Integer;
begin
  if FOperand2 = 0 then
    raise Exception.Create('Division by zero is not allowed');
  Result := FOperand1 div FOperand2;
end;

procedure TCalculator.AllocateBuffer(Size: Integer);
begin
  GetMem(FBuffer, Size);
  FillChar(FBuffer^, Size, 0);
end;

procedure TCalculator.DisplayBuffer;
begin
  if FBuffer = nil then
    Writeln('Buffer is not allocated.')
  else
    Writeln('Buffer allocated and filled with zeros.');
end;

var
  Calculator: TCalculator;
begin
  try
    Calculator := TCalculator.Create(10, 5);
    try
      Writeln('Addition: ', Calculator.Add);
      Writeln('Subtraction: ', Calculator.Subtract);
      Writeln('Multiplication: ', Calculator.Multiply);
      Writeln('Division: ', Calculator.Divide);

      Calculator.AllocateBuffer(1024); // Allocate 1KB buffer
      Calculator.DisplayBuffer;
    finally
      Calculator.Free;
    end;
  except
    on E: Exception do
      Writeln('Error: ', E.Message);
  end;
end.
