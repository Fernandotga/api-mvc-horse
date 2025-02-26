unit UnitClientes.Model;

interface
uses
  System.Generics.Collections,
  UnitConnection.Model.Interfaces;

type
  TClienteModel = class
  private
    Fbairro: string;
    Fuf: string;
    Fcodigo: integer;
    Fcomplemento: string;
    Fnome: string;
    Fcidade: string;
    Fendereco: string;
  public
    property codigo: integer read Fcodigo write Fcodigo;
    property nome: string read Fnome write Fnome;
    property endereco: string read Fendereco write Fendereco;
    property complemento: string read Fcomplemento write Fcomplemento;
    property bairro: string read Fbairro write Fbairro;
    property cidade: string read Fcidade write Fcidade;
    property uf: string read Fuf write Fuf;
    class function findAll: TList<TClienteModel>;
    class function find(id: integer): TClienteModel;
    procedure Insert;
    procedure Update;
    procedure Delete;
  end;

implementation

{ TClienteModel }

uses UnitDatabase;

procedure TClienteModel.Delete;
var
  Query: iQuery;
begin
  Query := TDatabase.Query;
  Query.Add('DELETE FROM CLIENTE WHERE ID_CLIENTE = :CODIGO');
  Query.AddParam('CODIGO',codigo);
  Query.ExecSQL;
end;

class function TClienteModel.find(id: integer): TClienteModel;
var
  Query: iQuery;
begin
  Query := TDatabase.Query;
  Query.Add('SELECT ID_CLIENTE, NOME, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF FROM CLIENTE');
  Query.Add('WHERE ID_CLIENTE = :CODIGO');
  Query.AddParam('CODIGO',id);
  Query.Open();

  If not Query.DataSet.IsEmpty then
  begin
    Result := TClienteModel.Create;
    Result.codigo      := Query.DataSet.FieldByName('ID_CLIENTE').AsInteger;
    Result.nome        := Query.DataSet.FieldByName('NOME').AsString;
    Result.endereco    := Query.DataSet.FieldByName('ENDERECO').AsString;
    result.bairro      := Query.DataSet.FieldByName('BAIRRO').AsString;
    result.complemento := Query.DataSet.FieldByName('COMPLEMENTO').AsString;
    result.cidade      := Query.DataSet.FieldByName('CIDADE').AsString;
    result.uf          := Query.DataSet.FieldByName('UF').AsString;
  end;
end;

class function TClienteModel.findAll: Tlist<TClienteModel>;
var
  Query: iQuery;
  Cliente : TClienteModel;
begin
  Result := TList<TClienteModel>.Create;
  Query := TDatabase.Query;
  Query.Open('SELECT ID_CLIENTE, NOME, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF FROM CLIENTE');
  Query.DataSet.First;
  while not Query.DataSet.Eof do
  begin
    Cliente := TClienteModel.Create;
    Cliente.codigo   := Query.DataSet.FieldByName('ID_CLIENTE').AsInteger;
    Cliente.nome     := Query.DataSet.FieldByName('NOME').AsString;
    Cliente.endereco := Query.DataSet.FieldByName('ENDERECO').AsString;
    Cliente.bairro   := Query.DataSet.FieldByName('BAIRRO').AsString;
    Cliente.complemento   := Query.DataSet.FieldByName('COMPLEMENTO').AsString;
    Cliente.cidade   := Query.DataSet.FieldByName('CIDADE').AsString;
    Cliente.uf       := Query.DataSet.FieldByName('UF').AsString;
    Result.Add(Cliente);
    Query.DataSet.Next;
  end;
end;

procedure TClienteModel.Insert;
var
  Query: iQuery;
begin
  Query := TDatabase.Query;
  Query.Add('INSERT INTO CLIENTE (ID_CLIENTE, NOME, ENDERECO, COMPLEMENTO, BAIRRO, CIDADE, UF)');
  Query.Add('VALUES (:ID_CLIENTE, :NOME, :ENDERECO, :COMPLEMENTO, :BAIRRO, :CIDADE, :UF)');
  Query.AddParam('ID_CLIENTE',codigo);
  Query.AddParam('NOME',nome);
  Query.AddParam('ENDERECO',endereco);
  Query.AddParam('COMPLEMENTO',complemento);
  Query.AddParam('BAIRRO',bairro);
  Query.AddParam('CIDADE',cidade);
  Query.AddParam('UF',uf);
  Query.ExecSQL;
end;

procedure TClienteModel.Update;
var
  Query: iQuery;
begin
  Query := TDatabase.Query;
  Query.Add('UPDATE CLIENTE');
  Query.Add('SET NOME = :NOME, ENDERECO = :ENDERECO, COMPLEMENTO = :COMPLEMENTO,');
  Query.Add('    BAIRRO = :BAIRRO, CIDADE = :CIDADE, UF = :UF');
  Query.Add('WHERE ID_CLIENTE = :ID_CLIENTE');
  Query.AddParam('ID_CLIENTE',codigo);
  Query.AddParam('NOME',nome);
  Query.AddParam('ENDERECO',endereco);
  Query.AddParam('COMPLEMENTO',complemento);
  Query.AddParam('BAIRRO',bairro);
  Query.AddParam('CIDADE',cidade);
  Query.AddParam('UF',uf);
  Query.ExecSQL;
end;

end.
