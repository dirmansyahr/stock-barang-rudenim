unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    kodebarang: TEdit;
    namabarang: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    jumlahambil: TEdit;
    penerima: TEdit;
    Grid1: TGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  label3.Text:=formatdatetime('dddd, dd mmmm yyyy',date());
  label4.Text:=formatdatetime('hh:mm',now());
end;

end.
