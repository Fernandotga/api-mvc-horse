unit UnitCliente.Controller;

interface

uses
  System.Generics.Collections,
  Horse,
  Horse.Commons,
  Classes,
  SysUtils,
  System.Json,
  UnitConnection.Model.Interfaces;

type
  TClienteController = class
    class procedure Registry;
    class procedure GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure GetOne(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Put(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

uses UnitClientes.Model;

class procedure TClienteController.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  id: Integer;
  Cliente: TclienteModel;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id não encontrado');
  id := Req.Params.Items['id'].ToInteger();
  Cliente := TclienteModel.find(id);
  if Assigned(Cliente) then
  begin
    Cliente.Delete;
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message','Cliente deletado com sucesso'))
       .Status(THTTPStatus.OK);
  end else
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message','Cliente não encontrado'))
       .Status(THTTPStatus.NotFound);
end;

class procedure TClienteController.GetAll(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  Clientes: TList<TClienteModel>;
  Cliente: TClienteModel;
  aJSon: TJSONArray;
  oJSon: TJSONObject;
begin
  Clientes := TClienteModel.findAll;
  aJSon := TJSONArray.Create;
  for Cliente in Clientes do
  begin
    ojson := TJSONObject.Create;
    ojson.AddPair('codigo', TJSONNumber.Create(Cliente.codigo));
    ojson.AddPair('nome', Cliente.nome);
    ojson.AddPair('endereco', Cliente.endereco);
    ojson.AddPair('bairro', Cliente.bairro);
    ojson.AddPair('complemento', Cliente.complemento);
    ojson.AddPair('cidade', Cliente.cidade);
    ojson.AddPair('uf', Cliente.uf);
    aJSon.AddElement(ojson);
  end;
  Res.Send<TJSONArray>(aJSon);
end;

class procedure TClienteController.GetOne(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  Cliente: TClienteModel;
  oJSon: TJSONObject;
  id : Integer;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id não encontrado');
  id := Req.Params.Items['id'].ToInteger();

  Cliente := TClienteModel.find(id);
  if Assigned(Cliente) then
  begin
    ojson := TJSONObject.Create;
    ojson.AddPair('codigo', TJSONNumber.Create(Cliente.codigo));
    ojson.AddPair('nome', Cliente.nome);
    ojson.AddPair('endereco', Cliente.endereco);
    ojson.AddPair('bairro', Cliente.bairro);
    ojson.AddPair('complemento', Cliente.complemento);
    ojson.AddPair('cidade', Cliente.cidade);
    ojson.AddPair('uf', Cliente.uf);
    Res.Send<TJSONObject>(oJSon).Status(THTTPStatus.OK);
  end else
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message',
                        'Cliente não encontrado')).Status(THTTPStatus.NotFound);
end;

class procedure TClienteController.Post(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ojson: TJSONObject;
  Cliente: TclienteModel;
begin
  if Req.Body.IsEmpty then
    raise Exception.Create('Dados cliente não informado');
  ojson := Req.Body<TJSONObject>;
  Cliente := TClienteModel.Create;
  try
    Cliente.codigo      := ojson.GetValue<Integer>('codigo');
    Cliente.nome        := ojson.GetValue<string>('nome');
    Cliente.endereco    := ojson.GetValue<string>('endereco');
    Cliente.bairro      := ojson.GetValue<string>('bairro');
    Cliente.complemento := ojson.GetValue<string>('complemento');
    Cliente.cidade      := ojson.GetValue<string>('cidade');
    Cliente.uf          := ojson.GetValue<string>('uf');
    Cliente.Insert;
    Res.Send<TJSONObject>(ojson).Status(THTTPStatus.Created);
  finally
    Cliente.Free;
  end;
end;

class procedure TClienteController.Put(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ojson: TJSONObject;
  Cliente: TclienteModel;
  id : Integer;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id não encontrado');
  id := Req.Params.Items['id'].ToInteger();
  ojson := Req.Body<TJSONObject>;
  Cliente := TClienteModel.find(id);

  if Assigned(Cliente) then
  begin
    Cliente.codigo      := id;
    Cliente.nome        := ojson.GetValue<string>('nome');
    Cliente.endereco    := ojson.GetValue<string>('endereco');
    Cliente.bairro      := ojson.GetValue<string>('bairro');
    Cliente.complemento := ojson.GetValue<string>('complemento');
    Cliente.cidade      := ojson.GetValue<string>('cidade');
    Cliente.uf          := ojson.GetValue<string>('uf');
    Cliente.Update;

    Res.Send<TJSONObject>(oJSon).Status(THTTPStatus.OK);
  end else
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message',
                        'Cliente não encontrado')).Status(THTTPStatus.NotFound);
end;

class procedure TClienteController.Registry;
begin
  THorse.Get('/cliente',GetAll)
        .Get('/cliente/:id', GetOne)
        .Post('/cliente', Post)
        .Put('/cliente/:id', Put)
        .Delete('/cliente/:id', Delete);
end;

end.
