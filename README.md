# API para integração com o GitHub - busca de repositórios

Esse projeto tem como objetivo a construção de uma api simples para realizar consultas de repositórios no GitHub

## Proposta de solução

O projeto foi arquitetado seguindo alguns princípios do Domain Driven Design. Procurei separar toda a logica específica do negócio em objetos simples Ruby, com o objeto de modularizar a aplicação, facilitar a modelagem das funcionalidades especificas do negócio, diminuir o acoplamento entre a lógica de negócios e o framework em si e com isso facilitar uma possivel extração do módulo para outro serviço, caso seja pertinente, com uma relativa facilidade.

Também procurei seguir o modelo de arquitetura de portas e adaptadores, onde as interações entre as camadas de infraestutura e aplicação com a lógica de negócio ficam restrita a portas e adaptadores específicos como os casos de uso.

No fundo esse aplicativo é uma camada de abstração para a API do Github, portanto acabei utilizando o padrão de recursos da API do GitHub e o sistema de paginação dela.

Para o sistema de paginação da API, eu me aproveitei da própria API do Github que fornece os links direto no header das respostas, dentro da chave `links`, portanto continuei enviando nos headers os links para as próximas páginas mas também envio no corpo da requisição para ter uma visualização mais fácil.

Fiz o deploy desse projeto para o heroku que está no endereço:
```
https://young-earth-01234.herokuapp.com
```

Para a listagem dos repositórios públicos, utilizo o recurso da API do Github, porém na resposta os repositórios vem sem o número de `stars` ou de `forks`, portanto nesse endpoint de listagem de todas os repositórios públicos, tanto a chave `stars` como `forks` virão com um valor nulo. Para os outros endpoints a API do Github retornna os dados mais completos dos repositórios, portanto eles vem com todas as informações.

Agora vendo vejo que esqueci de definir a linguagem padrão como `ruby` no endpoint de busca de repositórios utilizando busca livre, porém o recurso aceita as query params que são enviadas.

## Pré-requesitos

O projeto foi construido utilizando a versao `ruby 2.6.6` e `Rails 6.0.3`. O banco de dados escolhido foi o PostgreSQL. Para testar a API utilzei o Postman como meio de emitir os requests.

## Instalação

Depois instalar o ruby, o rails e o postgresql e de clonar o repositório deve-se adicionar um novo token de acesso pessoal da API do GitHub, apesar da API ser aberta, sem um token existem limitações tanto quanto ao número de requests por hora quanto pelo limite de resultados que a API retorna. Para isso utilizo uma variável de ambiente chamda `GITHUB_API_KEY` que pode ser sobreescrita no arquivo `.env.example` colocando uma chave válida no lugar e renomeando o arquivo para `.env`, assim utilizando a gem `dotenv` a váriavel de ambiente é automaticamente criada no ambiente de desenvolvimento. Depois de setar a variável de ambiente e instalar as dependências, pode-se iniciar o serviço rodando os seguintes comandos:
```
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s
```
Assim o servidor comecara a expor a API no localhost na porta 3000.

### Testes

Construí tanto testes unitários para os objetos `ruby` puros quanto testes de integração para checar o funcionamento dos endpoints e controllers.

Utilizei o `rspec` para fazer os testes junto da gem `vcr` para salvar os requests feitos à API externa, e gem `guard` para pode fazer uma testagem rápida, ele roda os testes a cada alteração nos arquivos que estão sendo testados. Os testes estão todos localizados dentro da pasta `/spec` na raiz do projeto é só chamar o comando:
```
$ guard
```
E apertar a tecla `Enter` que os testes rodarão automaticamente.

Ou então pode-se chamar o comando `rspec` direto na raiz do projeto.

## Autenticação
A API utiliza o padrão JWT para realizar a autenticação de usuários, portanto precisa-se estar em posse de um token válido para todos os request (exceto os de criar usuário e login), o token deve ser passado no header das requisições no seguinte formato
```
Authorization:JSON_WEB_TOKEN_HASH
```
## TO DO
- Melhorar a cobertura dos testes, principalmente nos casos de exceções de integração mas também cobrindo todos os objetos Ruby puros com testes unitários.
- Dockerizar o projeto

## Documentacao da API

**Create User**
----
 Cria um usuario novo
* **URL**
  /api/v1/user
* **Method:**
  `POST`
*  **Body**
    ```
    {
      "user": {
        "name": "Luiz Neiva",
        "username": "sou eu",
        "email": "luizgzn@gmail.com",
        "password": "123456"
      }
    }
    ```
* **Success Response:**
  * **Code:** 200
    **Content:** `{"message": "User luizgzn@gmail.com created."}`
* **Error Response:**
  * **Code:** 400 BAD REQUEST
    **Content:** `{ error : "Validation error" }`

**Sign In User**
----
 Authenticate user
* **URL**
  /api/v1/auth/login
* **Method:**
  `POST`
*  **Body**
    ```
    {
      "email": "luizgzn@gmail.com",
      "password": "123456"
    }
    ```
* **Success Response:**
  * **Code:** 200
    **Content:** `{"token":"token hash","username":"sou eu"}`
* **Error Response:**
  * **Code:** 401 UNAUTHORIZED

**Public repositories**
----
 Mostra os repositórios públicos
* **URL**
  api/v1/repositories
  api/v1/repositories?since=369
* **Method:**
  `GET`
*  **Headers**
  `Authorization:JsonWebtokenHash`
* **Success Response:**
  * **Code:** 200
    **Content:**
    ```
    {
      "metadata": {
          "next": "/api/v1/repositories?since=369",
          "first": "/api/v1/repositories{?since}",
          "repositories_counter": 100
      },
      "repositories": [
          {
              "full_name": "mojombo/grit",
              "description": "**Grit is no longer maintained. Check out libgit2/rugged.** Grit gives you object oriented read/write access to Git repositories via Ruby.",
              "stars": null,
              "forks": null,
              "author": "mojombo"
          },
          ...
    }
    ```
* **Error Response:**
  * **Code:** 401 UNAUTHORIZED

**User repositories**
----
 Mostra os repositórios de um usuário
* **URL**
  api/v1/user/gustavoneiva/repos
  api/v1/user/12118557/repos?page=2
* **Method:**
  `GET`
*  **Headers**
  `Authorization:JsonWebtokenHash`
* **Success Response:**
  * **Code:** 200
    **Content:**
    ```
    {
        "metadata": {
            "next": "/api/v1/user/12118557/repos?page=2",
            "last": "/api/v1/user/12118557/repos?page=2",
            "repositories_counter": 30
        },
        "repositories": [
            {
                "full_name": "gustavoneiva/99bottles",
                "description": null,
                "stars": 0,
                "forks": 0,
                "author": "gustavoneiva"
            },
            ...
    }
    ```
* **Error Response:**
  * **Code:** 401 UNAUTHORIZED
* **Error Response:**
  * **Code:** 404 NOT FOUND
    **Content:** `{ "error": "Exceptions::NotFoundException", "message": "Not found"  }`

**Search repositories**
----
 Mostra os repositórios de um usuário
* **URL**
  api/v1/search/repositories?q=farming
  api/v1/search/repositories?q=farming+language:ruby&sort=stars&order=desc&page=2&per_page=30
* **Parameters**

| Nome     	| Tipo    	| Descrição                                                                                                            	|
|----------	|---------	|----------------------------------------------------------------------------------------------------------------------	|
| q        	| string  	| Texto a ser pesquisado. Pode-se adicionionar qualificadores como a linguagem concatenando +language:ruby por exemplo 	|
| sort     	| string  	| Ordena a resposta a partir de um parâmetro como stars, forks                                                         	|
| order    	| string  	| Ordena a resposta como ascendente ou descendente                                                                     	|
| per_page 	| integer 	| Número de resposta por página (máximo de 100)                                                                        	|
| page     	| integer 	| Número da página a ser acessada                                                                                      	|
* **Method:**
  `GET`
*  **Headers**
  `Authorization:JsonWebtokenHash`
* **Success Response:**
  * **Code:** 200
    **Content:**
    ```
    {
        "metadata": {
            "next": "/api/v1/search/repositories?q=farming&page=2",
            "last": "/api/v1/search/repositories?q=farming&page=34",
            "total_count": 3294,
            "incomplete_results": false,
            "repositories_counter": 30
        },
        "repositories": [
            {
                "full_name": "davidgohel/flextable",
                "description": "table farming",
                "stars": 220,
                "forks": 40,
                "author": "davidgohel"
            },
            ...
        ]
    }
    ```
* **Error Response:**
  * **Code:** 401 UNAUTHORIZED
* **Error Response:**
  * **Code:** 404 NOT FOUND
    **Content:** `{ "error": "Exceptions::NotFoundException", "message": "Not found"  }`