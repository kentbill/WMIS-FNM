unit uRegex;

interface

function Eval(Formula: string;  ErrPos: Integer=1):Real;

implementation

{
  Simple recursive expression parser based on the TCALC example of TP3.
  Written by Lars Fosdal 1987
  Released to the public domain 1993
}

function Eval(Formula: string;  ErrPos: Integer):Real;
const
  Digit: set of Char = ['0'..'9'];
var
  Posn: Integer; { Current position in Formula}
  CurrChar: Char; { character at Posn in Formula }

  procedure ParseNext; { returnerer neste tegn i Formulaen  }
  begin
    repeat
      Posn := Posn + 1;
      if Posn <= Length(Formula) then CurrChar := Formula[Posn]
      else CurrChar := ^M;
    until CurrChar <> ' ';
  end { ParseNext };

  function add_subt: Real;
  var
    E: Real;
    Opr: Char;

    function mult_DIV: Real;
    var
      S: Real;
      Opr: Char;

      function Power: Real;
      var
        T: Real;

        function SignedOp: Real;
          function UnsignedOp: Real;
          type
            StdFunc = (fabs, fsqrt, fsqr, fsin, fcos,
              farctan, fln, flog, fexp, ffact);
            StdFuncList = array[StdFunc] of string[6];
          const
            StdFuncName: StdFuncList =
            ('ABS', 'SQRT', 'SQR', 'SIN', 'COS',
              'ARCTAN', 'LN', 'LOG', 'EXP', 'FACT');
          var
            E, L, Start: Integer;
            Funnet: Boolean;
            F: Real;
            Sf: StdFunc;

            function Fact(I: Integer): Real;
            begin
              if I > 0 then begin Fact := I * Fact(I - 1); end
              else Fact := 1;
            end { Fact };

          begin { FUNCTION UnsignedOp }
            if CurrChar in Digit then
            begin
              Start := Posn;
              repeat ParseNext until not (CurrChar in Digit);
                if CurrChar = '.' then repeat ParseNext until not (CurrChar in Digit);
              if CurrChar = 'E' then
              begin
                ParseNext;
                repeat ParseNext until not (CurrChar in Digit);
              end;
              Val(Copy(Formula, Start, Posn - Start), F, ErrPos);
            end else
              if CurrChar = '(' then
              begin
                ParseNext;
                F := add_subt;
                if CurrChar = ')' then ParseNext else ErrPos := Posn;
              end else
              begin
                Funnet := False;
                for sf := fabs to ffact do
                  if not Funnet then
                  begin
                    l := Length(StdFuncName[sf]);
                    if Copy(Formula, Posn, l) = StdFuncName[sf] then
                    begin
                      Posn := Posn + l - 1; ParseNext;
                      f := UnsignedOp;
                      case sf of
                        fabs: f := abs(f);
                        fsqrt: f := SqrT(f);
                        fsqr: f := Sqr(f);
                        fsin: f := Sin(f);
                        fcos: f := Cos(f);
                        farctan: f := ArcTan(f);
                        fln: f := LN(f);
                        flog: f := LN(f) / LN(10);
                        fexp: f := EXP(f);
                        ffact: f := fact(Trunc(f));
                      end;
                      Funnet := True;
                    end;
                  end;
                if not Funnet then
                begin
                  ErrPos := Posn;
                  f := 0;
                end;
              end;
            UnsignedOp := F;
          end { UnsignedOp};

        begin { SignedOp }
          if CurrChar = '-' then
          begin
            ParseNext; SignedOp := -UnsignedOp;
          end else SignedOp := UnsignedOp;
        end { SignedOp };

      begin { Power }
        T := SignedOp;
        while CurrChar = '^' do
        begin
          ParseNext;
          if t <> 0 then t := EXP(LN(abs(t)) * SignedOp) else t := 0;
        end;
        Power := t;
      end { Power };


    begin { mult_DIV }
      s := Power;
      while CurrChar in ['*', '/'] do
      begin
        Opr := CurrChar; ParseNext;
        case Opr of
          '*': s := s * Power;
          '/': s := s / Power;
        end;
      end;
      mult_DIV := s;
    end { mult_DIV };

  begin { add_subt }
    E := mult_DIV;
    while CurrChar in ['+', '-'] do
    begin
      Opr := CurrChar; ParseNext;
      case Opr of
        '+': e := e + mult_DIV;
        '-': e := e - mult_DIV;
      end;
    end;
    add_subt := E;
  end { add_subt };

begin {PROC Eval}
  if Formula[1] = '.'
    then Formula := '0' + Formula;
  if Formula[1] = '+'
    then Delete(Formula, 1, 1);
  for Posn := 1 to Length(Formula)
    do Formula[Posn] := Upcase(Formula[Posn]);
  Posn := 0;
  ParseNext;
  Result := add_subt;
  if CurrChar = ^M then ErrPos := 0 else ErrPos := Posn;
end {PROC Eval};
end.
 