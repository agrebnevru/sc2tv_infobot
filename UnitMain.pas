unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, jpeg, ComCtrls, NativeXML, StdCtrls, RxRichEd;

type
  TFormMain = class(TForm)
    TI: TTrayIcon;
    PMTray: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Image1: TImage;
    Panel2: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  XMLDoc: TNativeXml;       //объект XML-документа
  NodeList: TXmlNodeList;   //список узлов

implementation

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
var
i, t: integer;
LabelTitle: array [0..4] of TLabel;
LabelTeaser: array [0..4] of TLabel;
LabelLink: array [0..4] of TLinkLabel;
begin
  XMLDoc:= TNativeXml.Create;        //создаем экземпляр класса
  XMLDoc.LoadFromFile('api.xml');    //загружаем данные из файлика
  if XMLDoc.IsEmpty then
    raise Exception.Create('Пустой XML! Работа прервана!');
  NodeList:= TXmlNodeList.Create;
  XMLDoc.Root.FindNodes('item', NodeList);//получаем список узлов Item
  {парсим каждый узел news -> Item}
  for I := 0 to NodeList.Count - 1 do
  begin
     with NodeList.Items[i] do
     begin
         LabelTitle[i]:= TLabel.Create(nil);
         LabelTitle[i].Caption:= NodeByName('title').ValueAsString + ' (' + NodeByName('date').ValueAsString + ')';
         LabelTitle[i].Align:= alTop;
          for t := 0 to i do
         LabelTitle[i].Height:= LabelTitle[i].Height + LabelTitle[t].Height;
         LabelTitle[i].Parent:= TabSheet4;

           {LabelTeaser[i]:= TLabel.Create(nil);
           LabelTeaser[i].WordWrap:= true;
           LabelTeaser[i].Caption:= NodeByName('teaser').ValueAsString;
           LabelTeaser[i].Align:= alTop;
           LabelTeaser[i].Parent:= TabSheet4;
             LabelLink[i]:= TLinkLabel.Create(nil);
             LabelLink[i].Caption:= NodeByName('teaser').ValueAsString;
             LabelLink[i].Align:= alTop;
             LabelLink[i].Parent:= TabSheet4;}

     end;
  end;
end;

procedure TFormMain.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
sc_dragmove = $f012;
begin
releasecapture;
Perform(wm_syscommand, sc_dragmove, 0);
end;

procedure TFormMain.N1Click(Sender: TObject);
begin
Close;
end;

end.
