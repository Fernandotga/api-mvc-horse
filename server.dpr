program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  UnitDatabase in 'Database\UnitDatabase.pas',
  UnitClientes.Model in 'Model\UnitClientes.Model.pas',
  UnitCliente.Controller in 'Controller\UnitCliente.Controller.pas';

begin
  THorse.Use(Jhonson);
  TClienteController.Registry;

  Thorse.Listen(9000);
  
end.
