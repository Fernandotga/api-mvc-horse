unit UnitDatabase;

interface
uses
  UnitConnection.Model.Interfaces,
  UnitFactory.Connection.Firedac;
type
  TDatabase = class
    class function Query: iQuery;
  end;

implementation

{ TDatabase }

class function TDatabase.Query: iQuery;
begin
  Result := TFactoryConnectionFiredac.New('../../Database/banco.fdb').Query;
end;

end.
