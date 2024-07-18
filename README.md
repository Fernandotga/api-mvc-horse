# API-HORSE

Api feita em Delphi utilizando framework[Horse](https://github.com/HashLoad/horse):

### Instalar as dependências com [boss](https://github.com/HashLoad/boss):
``` sh
$ boss install 
```
## API
A aplicação será iniciada e um servidor estará rodando e acessivel no endereço:
``` sh
localhost:9000
```
### A API possui os endpoints:
``` sh
/cliente       --> GET clientes: para pegar todos os clientes.
/cliente/{ID}  --> GET cliente por ID: para pegar um cliente com base no seu id.
/cliente       --> POST cliente para cadastrar um cliente novo.
/cliente/{ID}  --> PUT atualiza cliente já cadastrado previamente.
/cliente/{ID}  --> DELETE cliente por ID para deletar um cliente por ID.
```
Exemplo:
``` sh
http://localhost:9000/cliente
Retorna lista de clientes cadastrados
```
Baixe a coleção do POSTMAN que possui os requests (métodos HTTP) que exercitam essa API [aqui](https://github.com/Fernandotga/api-mvc-horse/tree/main/Postman):

O corpo do método POST é um JSON e deve conter:
``` sh
{
    "codigo": 1,
    "nome": "Fred",
    "endereco": "Av. Brasil, 0000",
    "bairro": "Centro",
    "complemento": "CJ 120",
    "cidade": "São Paulo",
    "uf": "SP"
}
```


