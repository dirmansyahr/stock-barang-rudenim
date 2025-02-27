unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, Vcl.ExtCtrls,
  Vcl.Menus;

type
  TFBarangmasuk = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDQuery1kode_barang: TStringField;
    FDQuery1nama_barang: TStringField;
    FDQuery1jmlh_stock: TIntegerField;
    DBGrid1: TDBGrid;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    BarangMasuk1: TMenuItem;
    BarangMasuk2: TMenuItem;
    Laporan1: TMenuItem;
    Laporan2: TMenuItem;
    BarangKeluar1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Laporan2Click(Sender: TObject);
    procedure BarangKeluar1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure BarangMasuk2Click(Sender: TObject);

  private
    { Private declarations }
    AddAttemptCounter: Integer;
  public
    { Public declarations }
  end;

var
  FBarangmasuk: TFBarangmasuk;

implementation

{$R *.dfm}

uses Unit3, Unit4, Unit5;

procedure TFBarangmasuk.BarangKeluar1Click(Sender: TObject);
begin
  FLaporankeluar.Show;
end;

procedure TFBarangmasuk.BarangMasuk2Click(Sender: TObject);
begin
  FBarangkeluar.Show;
  Hide;
end;

procedure TFBarangmasuk.Button1Click(Sender: TObject);
var
JumlahStock : Integer;
begin
  if Edit1.Text = '' then
begin
  MessageDlg('Kode Barang Tidak Boleh Kosong', mtInformation, [mbOK], 0);
  Edit1.SetFocus;
end else
if Edit2.Text = '' then
begin
  MessageDlg('Nama Barang Tidak Boleh Kosong', mtInformation, [mbOK], 0);
  Edit2.SetFocus;
end else
if Edit3.Text = '' then
begin
  MessageDlg('Jumlah Barang Tidak Boleh Kosong', mtInformation, [mbOK], 0);
  Edit3.SetFocus;
end else
begin
  if not TryStrToInt(Edit3.Text, JumlahStock) then
  begin
    MessageDlg('Jumlah Barang Harus Dalam Bentuk Angka', mtWarning, [mbOK], 0);
    Edit3.SetFocus;
  end else
begin
try
if FDQuery1.Locate('kode_barang', Edit1.Text, []) then
begin
  Inc(AddAttemptCounter);
  if AddAttemptCounter >=3 then
  begin
    MessageDlg('Jika Ingin Memperbarui Data, Silahkan Klik Tombol Perbarui', mtWarning, [mbOK], 0);
    AddAttemptCounter:=0;
    Exit;
  end else
  begin
    MessageDlg('Kode Barang Sudah Ada', mtError, [mbOK], 0);
    FDQuery1.Cancel;
    Edit1.SetFocus;
    Exit;
  end;
  end;
    FDQuery1.Append;
    FDQuery1.FieldByName('kode_barang') .AsString:=Edit1.Text;
    FDQuery1.FieldByName('nama_barang') .AsString:= Edit2.Text;
    FDQuery1.FieldByName('jmlh_stock') .AsInteger := JumlahStock;
    FDQuery1.Post;

    MessageDlg('Data Berhasil Disimpan', mtInformation, [mbOK], 0);
    Edit1.Text:='';
    Edit2.Text:='';
    Edit3.Text:='';
    Edit1.SetFocus;

    AddAttemptCounter := 0;
  Except
  on E: EDatabaseError do
  begin
    MessageDlg('Kode Barang Sudah Ada', mtError, [mbOK], 0);
    FDQuery1.Cancel;
    Edit1.SetFocus;
    end;
  end;
end;
end;
end;

procedure TFBarangmasuk.Button2Click(Sender: TObject);
var
JumlahStock : Integer;
begin
  if Edit1.Text = '' then
begin
  MessageDlg('Kode Barang Tidak Boleh Kosong', mtInformation, [mbOK], 0);
  Edit1.SetFocus;
end else
if Edit2.Text = '' then
begin
  MessageDlg('Nama Barang Tidak Boleh Kosong', mtInformation, [mbOK], 0);
  Edit2.SetFocus;
end else
if Edit3.Text = '' then
begin
  MessageDlg('Jumlah Barang Tidak Boleh Kosong', mtInformation, [mbOK], 0);
  Edit3.SetFocus;
end else
if not TryStrToInt(Edit3.Text, JumlahStock) then
begin
  MessageDlg('Silahkan Memasukkan Angka!', mtWarning, [mbOK], 0);
  Edit3.SetFocus;
end else
begin
    FDQuery1.Edit;
    FDQuery1.FieldByName('kode_barang') .AsString:=Edit1.Text;
    FDQuery1.FieldByName('nama_barang') .AsString:= Edit2.Text;
    FDQuery1.FieldByName('jmlh_stock') .AsInteger := StrToInt(Edit3.Text);
    FDQuery1.Post;
    MessageDlg('Data Berhasil Diperbarui', mtInformation, [mbOK], 0);
    Edit1.Text:='';
    Edit2.Text:='';
    Edit3.Text:='';
    Edit1.SetFocus;
  end;
end;

procedure TFBarangmasuk.Button3Click(Sender: TObject);
var
  Confirmation : Boolean;
begin
  if FDQuery1.RecordCount <=0 then
  MessageDlg('Pilih Data Terlebih Dahulu', mtWarning, [mbOK], 0) else
begin
  Confirmation := MessageDlg('Apakah Anda Yakin Ingin Menghapus data ?', mtConfirmation, mbYesNo, 0) = mrYes;
  if Confirmation then
begin
  FDQuery1.Delete;
  MessageDlg('Data Berhasil Dihapus', mtInformation, [mbOK], 0);
  Edit1.Text:='';
  Edit2.Text:='';
  Edit3.Text:='';
  Edit1.SetFocus;
end;
end;
end;

procedure TFBarangmasuk.DBGrid1CellClick(Column: TColumn);
begin
if not FDQuery1.IsEmpty then
begin
  Edit1.Text := FDQuery1.FieldByName('kode_barang').AsString;
  Edit2.Text := FDQuery1.FieldByName('nama_barang').AsString;
  Edit3.Text := IntToStr(FDQuery1.FieldByName('jmlh_stock').AsInteger);
end;
end;

procedure TFBarangmasuk.FormClose(Sender: TObject; var Action: TCloseAction);
var
  myYes, myNo: TMsgDlgBtn;
  myButs: TMsgDlgButtons;
begin
  myYes:= mbOK;
  myNo:= mbCancel;
  myButs:= [myYes, myNo];
  if MessageDlg('Anda Yakin Ingin Keluar ?', TMsgDlgType.mtWarning,
    myButs, 0) = mrOk then
    Action := caFree
  else
    Action := caNone;
end;

procedure TFBarangmasuk.FormCreate(Sender: TObject);
begin
AddAttemptCounter := 0;
end;

procedure TFBarangmasuk.Laporan2Click(Sender: TObject);
begin
  FLaporanmasuk.Show;
end;

procedure TFBarangmasuk.Timer1Timer(Sender: TObject);
begin
  Label6.Caption:= TimeToStr(now);
  Label7.Caption:= DateToStr(now);
end;

end.
