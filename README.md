# SurveyAPI

## 🖥 Projeto
  ## Descrição
  A SurveyAPI é uma API desenvolvida para fins de teste de seleção de estágio. Ela oferece suporte a diferentes tipos de usuários e permite a criação e manipulação de pesquisas.
### Tecnologias usadas

- [Ruby-on-Rails](https://rubyonrails.org/)
- [Ruby](https://www.ruby-lang.org/pt/)
- [bcrypt](https://rubygems.org/gems/bcrypt/versions/3.1.11?locale=pt-BR)
- [jwt](https://rubygems.org/gems/jwt/versions/1.5.4?locale=pt-BR)

## Executar O Projeto

- Clone o repositório em sua máquina:
  ```bash
  $ git clone https://github.com/franciscocolatino/quadro-tarefas.git](https://github.com/franciscocolatino/SurveyAPI
  ```
- Acesse o repositório usando:
  ```bash
  $ cd SurveyAPI
  ```
- Instalando as dependências:
  ```bash
  $ bundle install
  ```
- Crie o banco de dados:
  ```bash
  $ rails db:create
  ```
- Executando a migration:
  ```bash
  $ rails db:migrate
  ```
- Iniciando API:
  ```bash
  $ rails s
  ```
## Tipos de Usuários

A API oferece suporte a dois tipos de usuários: 'user' (usuário padrão) e 'adm' (Administradores de Pesquisa). Essa distinção é importante para controlar o acesso e as permissões dentro da api.

  ### Usuário 'user'

  Os usuários 'user' são os participantes normais do sistema e têm permissões padrão. Eles podem:

  - Acessar e responder a pesquisas.
  - Visualizar os resultados das pesquisas.

  ### Usuário 'adm' (Administrador de Pesquisa)

  Os usuários 'adm' são os Coordenadores de Pesquisa e possuem permissões extras para a criação e manipulação de pesquisas. Eles têm as seguintes permissões adicionais:

  - Criar novas pesquisas.
  - Editar e atualizar pesquisas existentes.

Certifique-se de conceder o tipo de usuário 'adm' apenas a indivíduos autorizados, pois eles têm acesso privilegiado às funcionalidades da API.
A authenticação na API foi feita usando JWT(JSON WEB TOKEN)

## ROTAS
  * Na raiz do projeto existe um arquivo chamado insomnia_2023-10-26.json contendo as principais rotas e algumas informações referentes a cada rota. Obs: esse arquivo deve ser importado no Insomnia.
