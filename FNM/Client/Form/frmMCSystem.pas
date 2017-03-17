unit frmMCSystem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  TfrmMC = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMC: TfrmMC;

implementation

{$R *.dfm}

procedure TfrmMC.FormCreate(Sender: TObject);
begin
  WebBrowser1.Navigate('http://192.168.22.125/KingViewWeb/Default.htm');
end;

end.
