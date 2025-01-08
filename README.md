# 1. Motivação

No semestre 2023.2, fiz a disciplina HACB12 - Laboratório de Arte e Interfaces. Nela, eu criei um pequeno projeto para
gerar artes utilizando a geolocalização do usuário e uma paleta de cores. O projeto consiste em pegar uma imagem
estática utilizando a API do [Mapbox](https://www.mapbox.com/) e então manipular os pixels da imagem utilizando o [Processing](https://processing.org/).
Entretanto, esse projeto foi feito inicialmente para funcionar em um browser e depois fiz um aplicativo android que funciona totalmente com um banco de dados local.
Meu objetivo, é criar um sistema completo e open source para esse projeto, onde as pessoas poderão, além de criar artes nos seus celulares android, interagir com as artes de outras pessoas.

# 2. Requisitos Funcionais

### RF1 -  Cadastro de usuário

 Uma pessoa deve conseguir se cadastrar no sistema utilizando um e-mail e senha, onde esse e-mail será único por usuário.
 Além do e-mail e senha, o usuário deve também fornecer um nome para finalizar o cadastro.
 
### RF2 - Login de usuário

Um usuário já cadastrado no sistema, deve conseguir acessar sua conta utilizando seu e-mail e sua senha informados no
momento do cadastro.

### RF3 - Criar uma paleta de cores

Um usuário logado no sistema, poderá criar paletas de cores para utilizar nas suas artes. Essa paleta deve possuir 3 cores, um nome e também
poderão ser utilizadas por outros usuários.

### RF4 - Criar uma arte de mapa

Um usuário logado no sistema deve conseguir criar uma nova arte. Para isso, ele precisa fornecer sua localização atual,
que será coletada utilizando o SDK do Android. Com a latitude e longitude do usuário, faremos uma busca na API do Mapbox e então
manipularemos os pixels da imagem do mapa com base em uma paleta de cores escolhida pelo usuário. Utilizaremos algum serviço em nuvem
para armazenamento das imagens criadas pelo usuário, esse serviço retornará a URL da imagem criada pelo usuário, que será salva no banco de dados
juntamente com outras informações relativas a imagem, como tamanho e a localidade.

### RF5 - Deletar uma arte de mapa

O usuário também poderá deletar uma arte que já foi criada, caso ele não goste da paleta de cores que utilizou ou simplesmente não queira mais
ter aquela arte no seu perfil.

### RF6 - Perfil de usuário

Todo usuário vai possuir um perfil próprio. Esse perfil vai listar todas as paletas de cores criadas pelo usuário e também
todas as artes criadas por esse usuário.

### RF7 - Buscar um perfil de usuário

Todo usuário vai poder buscar o perfil de um outro usuário e visualizar suas paletas ou artes criadas.

### RF8 - Curtir uma arte de mapa

Todo usuário poderá curtir uma arte de mapa criada por outro usuário.

### RF9 - Comentar uma arte de mapa

Todo usuário poderá comentar uma arte de mapa criada por outro usuário.

### RF10 - Favoritar uma arte de mapa

Todo usuário poderá favoritar artes criadas criadas por outro usuário.

### RF11 - Listar artes favoritas

O usuário terá uma tela onde ele poderá ver uma listagem de todas as suas artes de mapa favoritadas.

### RF12 - Ver detalhes de uma arte de mapa

O usuário terá a possibilidade de clicar em uma arte de mapa e ver todas as suas informações desde o nome do usuário que criou, a contagem total de curtidas e todos os seus comentários.

### RF13 - Criar uma arte de mapa e uma nova paleta de cores ao mesmo tempo.

O usuário pode criar uma arte de mapa escolhendo três cores novas sem a necessidade de criar uma paleta com essas cores antes. Ao criar uma arte dessa forma, automaticamente será criada uma paleta de cores com essas 3 cores escolhidas.

# 3. Delimitação do Minimundo para o Banco de dados:

### Usuários (_users_)

- **id** [uuid, primary key, not null]: Identificador único de um usuário.
- **email** [string, 50 caracteres]: Email único de um usuário.
- **password** [string, 128 caracteres]: Senha criptografada de um usuário.
- **name** [string, 60 caracteres]: Nome de um usuário.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)

### Paletas de cores (_color_palletes_)

- **id** [uuid, primary key, not null]: Identificador único de uma paleta de cores.
- **userId** [uuid, foreign key, not null]: Identificador do usuário criador dessa paleta de cores.
- **primaryColor** [string, 6 caracteres]: Código hexadecimal da cor primária.
- **secondaryColor** [string, 6 caracteres]: Código hexadecimal da cor secundária.
- **thirdColor** [string, 6 caracteres]: Código hexadecimal da cor terciária.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)  

### Artes de Mapa (_map_arts_)

- **id** [uuid, primary key, not null]: Identificador único de uma paleta de cores.
- **userId** [uuid, foreign key, not null]: Identificador do usuário criador dessa paleta de cores.
- **colorPalleteId** [uuid, foreign key, not null]: Identificador da paleta de cores utilizada na arte.
- **title** [string, 50 caracteres, not null]: Título da arte.
- **description** [string, 100 caracteres]: Título da arte.
- **url** [string, 512 caracteres, not null]: URL para acessar a arte de mapa em uma cloud.
- **latitude** [decimal(8, 6)]: Latitude da localização do usuário quando a arte foi criada.
- **longitude** [decimal(9, 6)]: Longitude da localização do usuário quando a arte foi criada.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)  

### Comentários de usuários em Artes de Mapa (_users_comments_map_arts_)

- **id** [uuid, primary key, not null]: Identificador único da tabela.
- **mapArtCommentedId** [uuid, foreign key, not null]: Identificador da arte de mapa que está sendo comentada.
- **userWhoCommentedId** [uuid, foreign key, not null]: Usuário que fez o comentário.
- **comment** [string, 256 caracteres]: O texto do comentário.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)

### Curtidas de usuários em Artes de Mapa (_users_likes_map_arts_)

- **id** [uuid, primary key, not null]: Identificador único da tabela.
- **postLikedId** [uuid, foreign key, not null]: Identificador da arte de mapa que está sendo curtida.
- **userWhoLikedId** [uuid, foreign key, not null]: Identificador do usuário que curtiu.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)

### Usuários que seguem outros usuários (_users_follows_users_)

- **id** [uuid, primary key, not null]: Identificador único da tabela.
- **followingUserId** [uuid, foreign key, not null]: Identificador do usuário que está seguindo.
- **followedUserId** [uuid, foreign key, not null]: Identificador do usuário que está sendo seguido.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)

### Usuários que favoritam posts (_users_favorites_posts_)

- **id** [uuid, primary key, not null]: Identificador único da tabela.
- **userId** [uuid, foreign key, not null]: Identificador do usuário que está favoritando um post.
- **postId** [uuid, foreign key, not null]: Identificador do post que está sendo favoritado.
- **updatedAt** [timestamp]: Indicador de tempo para sempre que uma entrada sofre alteração.
- **createdAt** [timestamp, not null]: Indicador de quando a entrada foi criada.
- **deletedAt** [timestamp, default: null]: Indicador de quando o soft-delete da entrada foi realizado.
- **isDeleted** [bool, default: false]: Indicador de deleção de uma entrada (soft-delete)

# 4. Modelo Conceitual

O modelo conceitual do banco de dados foi criado utilizando a ferramenta [BrModelo](https://www.brmodeloweb.com/lang/pt-br/index.html).

![Modelo conceitual para o banco de dados do Martp](assets/modelo_conceitual.png)

# 5. Modelo Lógico

O modelo lógico do banco de dados foi criado utilizando a ferramenta [DBDiagram](https://dbdiagram.io/).

![Modelo lógico para o banco de dados do Martp](assets/modelo_logico.png)

# 5. Criação do banco de Dados

Para criar nosso banco de dados vamos utilizar a ferramenta [Docker](https://www.docker.com/) e seguir as seguintes
instruções:

### 5.1 Verificar se o docker está instalado na sua maquina.

Abra o seu terminal e digite o comando `docker --version`, caso você tenha o docker instalado e pronto para ser usado no
seu terminal, o comando irá retornar a sua versão instalada. Caso o comando não seja reconhecido, para prosseguir você
vai precisar fazer instalação do Docker [nesse link](https://www.docker.com/) de acordo com o seu sistema operacional.

### 5.2 Criar uma network no Docker para o seu banco de dados.

A network é importante para facilitar o manuseio do seu banco de dados posteriormente, pois é através dela que você vai conseguir  
conectar o seu banco à ferramentas como DBeaver ou DataGrip. Use o seguinte comando para criar a sua network:

```
docker network create martp
```

### 5.3 Criar uma pasta para ser usada de volume para o banco de dados.

Crie uma pasta onde preferir no seu computador para utilizar como volume do banco de dados. Isso vai ajudar para que no
futuro quando o banco estiver populado, os dados não sejam perdidos sempre que o container precisar parar e recomeçar.

### 5.4 Crie o container com uma imagem docker específica para utilização do PostgreSQL.

Dentro da pasta que você criou anteriormente, rode o seguinte comando para criar o container

```
docker run --name martp -p 5432:5432 --network=martp -v "$PWD:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=password -d postgres:alpine
```

Se o comando for bem sucedido, ele vai retornar o id alfa numérico do seu container. Para verificar os containers
rodando utilize o comando `docker ps`

### 5.5 Utilizando o arquivo .sql para criar o schema do banco de dados.

Primeiro, será necessario enviar os arquivos sql na pasta ./database_queries do projeto para dentro do container que
está rodando o nosso banco de dados. Para fazer isso vamos utilizar o seguinte comando:

```
docker cp map-arts/database_queries martp:/database_queries
```

Após rodar o comando, agora podemos executar os arquivos, primeiro vamos criar nosso schema.

```
docker exec -u postgres martp psql postgres -f /database_queries/1_create_database_schema.sql
```

E em seguida popular nosso banco de dados.

```
docker exec -u postgres martp psql postgres -f /database_queries/2_populate_database.sql
```

# 6. Plano de indexação do banco de dados 

As duas tabelas centrais do sistema são _users_ e _map_arts_. Pensando nisso, vamos criar indexes nessas tabelas.

### 6.1 Index na tabela _users_

Nesse modelo de negócio é bastante comum a busca por usuários utilizando seu nome, vamos criar um index no nome de usuário.

```
CREATE INDEX idx_users_name ON "users" ("name");
```

### 6.2 Index na tabela _map_arts_

Como as artes de mapas estão muito ligadas as suas localizações, deve ser comum procurar por elas com base nas suas latitude ou longitude.
Dessa forma, é interessante que esses atributos sejam indexados.

```
CREATE INDEX idx_map_arts_location ON "map_arts" ("latitude", "longitude");
```

# 7. Queries para atender os requisitos do sistema

### RF1 -  Cadastro de usuário

```
INSERT INTO "users" ("id", "email", "password", "name", "createdAt") 
VALUES (uuid, 'user@exemplo.com', 'password', 'User One', NOW());
```

### RF2 - Login de usuário

```
SELECT * FROM "users" WHERE "email" = 'user@exemplo.com' AND "password" = 'password';
```

### RF3 - Criar uma paleta de cores:

```
INSERT INTO "color_palettes" ("id", "userId", "primaryColor", "secondaryColor", "thirdColor", "createdAt")
VALUES ('uuid', (SELECT "id" FROM "users" WHERE "email" = 'user@exemplo.com'), 'FF0000', '00FF00', '0000FF', NOW());
```

### RF4 - Criar uma arte de mapa:

```
INSERT INTO "map_arts" ("id", "userId", "colorPaletteId", "title", "url", "latitude", "longitude", "createdAt")
VALUES ('uuid', 'userId',
        'colorPaletteId',
        'My First Art', 'https://example.com/image.jpg', -33.8688, 151.2093, NOW());
```

### RF5 - Deletar uma arte de mapa:

```
DELETE FROM "map_arts" WHERE "id" = 'uuid';
```

### RF6 - Perfil de usuário:

Para atender esse requisito, primeiro vamos criar uma materialized view chamada user_profile. Isso será eficiente na busca de usuário
já que um usuário pode passar dias ou muito tempo sem mudanças efetivas no seu perfil, então a busca utilizando uma materialized view pode ser mais rápida.

```
CREATE MATERIALIZED VIEW user_profile AS
SELECT
    u.*,
    jsonb_agg(jsonb_build_object(
        'id', a."id",
        'title', a."title",
        'url', a."url",
        'latitude', a."latitude",
        'longitude', a."longitude",
        'createdAt', a."createdAt"
    )) AS map_arts,
    jsonb_agg(jsonb_build_object(
        'id', cp."id",
        'primaryColor', cp."primaryColor",
        'secondaryColor', cp."secondaryColor",
        'thirdColor', cp."thirdColor"
    )) AS color_palettes
FROM
    "users" u
LEFT JOIN "map_arts" a ON u."id" = a."userId"
LEFT JOIN "color_palettes" cp ON u."id" = cp."userId"
GROUP BY u."id", u."email", u."name", u."createdAt", u."updatedAt", u."deletedAt", u."isDeleted";

CREATE INDEX ON user_profile ("id");
```

Agora podemos executar uma query simples nessa materialized view, usando o próprio userId do usuário:

```
SELECT * FROM user_profile WHERE "id" = '31193780-dd8a-4738-819a-eff52cbc043d';
```

Para manter essa materialized view atualizada, vamos criar a seguinte stored procedure:

```
CREATE OR REPLACE PROCEDURE sp_atualizar_user_profile()
    LANGUAGE plpgsql
AS
$$
BEGIN
    REFRESH MATERIALIZED VIEW user_profile;
END;
$$;
```

### RF7 - Buscar um perfil de usuário:

Para buscar um perfil de usuário, vamos usar a mesma materialized view que criarmos anteriormente, entretanto agora vamos usar o email do usuário na query:

```
SELECT * FROM user_profile WHERE "email" = 'user@exemplo.com';
```

### RF8 - Curtir uma arte de mapa:

```
INSERT INTO "users_likes_map_arts" ("id", "postLikedId", "userWhoLikedId", "createdAt") 
VALUES ('uuid', 'mapArtUuid', 
        'userId', NOW());
```

### RF9 - Comentar uma arte de mapa:

```
INSERT INTO "users_comments_map_arts" ("id", "mapArtCommentedId", "userWhoCommentedId", "comment", "createdAt") 
VALUES ('uuid', 'mapArtUuid', 
        'userId', 'Ficou difudeeeeeer', NOW());
```

### RF10 - Favoritar uma arte de mapa:

```
INSERT INTO "users_favorites_posts" ("id", "postId", "userId", "createdAt") 
VALUES ('uuid', 'mapArtUuid', 
        'userId', NOW());
```

### RF11 - Listar artes favoritas:

```
SELECT * FROM "map_arts" 
INNER JOIN "users_favorites_posts" ON "map_arts"."id" = "users_favorites_posts"."postId" 
WHERE "users_favorites_posts"."userId" = 'userId';
```

### RF12 - Ver detalhes de uma arte de mapa

Para atender esse requisito também vamos criar uma materialized view:

```
CREATE MATERIALIZED VIEW map_art_details AS
SELECT 
    a.id,
    a.title,
    a.url,
    a.latitude,
    a.longitude,
    a.createdAt,
    u.name AS user_name,
    COUNT(l.id) AS total_likes,
    jsonb_agg(jsonb_build_object('id', c.id, 'comment', c.comment, 'createdAt', c.createdAt)) AS comments
FROM 
    "map_arts" a
JOIN "users" u ON a.userId = u.id
LEFT JOIN "users_likes_map_arts" l ON a.id = l.postLikedId
LEFT JOIN "users_comments_map_arts" c ON a.id = c.mapArtCommentedId
GROUP BY a.id, u.name;
```

E então basta fazer uma query utilizando a materialized view que criamos:

```
select * from map_art_details where id = 'mapArtId';
```

Para manter essa materialized view atualizada, vamos criar a seguinte stored procedure:

```
CREATE OR REPLACE PROCEDURE sp_atualizar_map_art_details()
    LANGUAGE plpgsql
AS
$$
BEGIN
    REFRESH MATERIALIZED VIEW map_art_details;
END;
$$;
```

### RF13 - Criar uma arte de mapa e uma nova paleta de cores ao mesmo tempo.

Para atender esse requisito, vamos precisar fazer dois insertes no banco de dados, então vamos criar uma procedure para fazer essas ações:

```
CREATE OR REPLACE PROCEDURE create_map_art_with_palette(
    userId uuid,
    title TEXT,
    primaryColor varchar(6),
    secondaryColor varchar(6),
    thirdColor varchar(6)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insere uma nova paleta de cores
    INSERT INTO "color_palettes" ("id", "userId", "primaryColor", "secondaryColor", "thirdColor", "createdAt")
    VALUES ('6c482660-c3b6-427b-8b6a-3a1af01d34cc', userId, primaryColor, secondaryColor, thirdColor, NOW());

    -- Insere uma nova arte de mapa, associando à última paleta criada
    INSERT INTO "map_arts" ("id", "userId", "colorPaletteId", "title", "url", "latitude", "longitude", "createdAt")
VALUES ('c4960612-0fd7-41bf-be0a-70528a365c8f', userId,
        '6c482660-c3b6-427b-8b6a-3a1af01d34cc',
        title, 'https://example.com/image.jpg', -33.8688, 151.2093, NOW());
END;
$$;
```

Então sempre que fomos criar uma arte de mapa sem uma paleta de cores existente, basta utilizar essa procedure:

```
CALL create_map_art_with_palette('31193780-dd8a-4738-819a-eff52cbc043d', 'Meu Mapa', 'FF0000', '00FF00', '0000FF');
```

# 8. Backup do banco de dados

Para realizar o backup do nosso banco, vamos utilizar a ferramenta pg_dump e isso será feito via terminal.
Como nosso banco está rodando dentro de uma instância do docker primeiro precisamos acessar o terminal dentro do container com o seguinte comando:

```
docker exec -it ID_CONTAINER /bin/bash
```

Agora com acesso ao container para gerar o nosso dump, utilizaremos o seguinte comando:

```
pg_dump -U postgres -d postgres -f martp_backup.sql
```

Pronto, nosso dump de backup foi criado. Mas ele ainda está dentro do container, precisamos exportar isso para fora dele:

```
docker cp martp:/martp_backup.sql ~/Documents/
```

Isso vai copiar o seu backup para dentro da pasta documentos e agora você tem acesso ao backup do seu banco e também sabe como fazer isso antes de implementar qualquer tipo de backup automatizado.


> Para um sistema robusto e que tivesse um banco de dados rodando na nuvem por  exemplo, seria preciso uma estratégia de backup automatizada e mais bem elaborada.
> Por exemplo, no caso do Martp, por se tratar de um projeto que não envolve nenhum tipo de operação financeira ou dado sensível que não pode ser perdido poderíamos automatizar para efetuar um backup por semana.

# 9. Política de Privacidade

O martp é um sistema que precisa da localização exata ou aproximada (alguns Androids mais atuais já dão essa opção de escolha para o usuário) da pessoa para que ele funcione.
A localização também é o dado mais sensível do usuário que fica salvo no nosso banco de dados, além da sua senha que já é encriptada.  
Por conta disso, pode-se tornar necessária uma encriptação ao salvar os dados de localização do usuário, seguindo uma estratégia onde ninguém que tenha acesso ao nosso banco de dados possa ver os dados de localização de um usuário.

### Como executar essa estratégia de privacidade?

Visto que o Martp funcionará em dispositivos Android, todo dispositivo android tem um atributo único chamado de DEVICE_ID. Os dados de latitude e longitude serão enviados para o servidor encriptados e utilizando o DEVICE_ID como chave de encriptação.
Dessa forma, vamos conseguir garantir as seguintes medidas de segurança:

- Apenas o usuário no celular original onde foi criada a arte conseguirá saber onde exatamente ela foi criada.
- Caso o usuário perca o seu celular e precise logar em outro, ele vai conseguir recuperar suas artes, mas não conseguirá decriptar os dados de localização.
- Nenhuma pessoa que tenha acesso ao banco de dados do Martp poderá ver os dados de localização, uma vez que em nenhum momento o DEVICE_ID é salvo no banco.


# 10. Métricas relevantes do Projeto

O Martp é um projeto open source sem fins lucrativos, mas é necessário atrair contribuidores ou mesmo chamar atenção de algum grupo de pesquisa em uma universidade pública.
Para isso, o projeto possui algumas métricas que podem ser usadas para chamar atenção de outras pessoas através de relatórios e gráficos. Sendo elas:

### Número total de usuários.

Apenas uma visualização simples em forma de texto.

```
SELECT COUNT(*) FROM "users";
```

### Número total de artes criadas.

Apenas uma visualização simples em forma de texto.

```
SELECT COUNT(*) FROM "map_arts";
```

### Número total de comentários.

Apenas uma visualização simples em forma de texto.

```
SELECT COUNT(*) FROM "users_comments_map_arts";
```

### Número total de curtidas.

Apenas uma visualização simples em forma de texto.

```
SELECT COUNT(*) FROM "users_likes_map_arts";
```

### Média de artes criadas por usuário.

Pode ser utilizada em uma visualização de gráfico.

```
SELECT (SELECT COUNT(*) FROM "map_arts") / (SELECT COUNT(*) FROM "users") AS media;
```

### Usuários com mais artes criadas.

Pode ser utilizada em uma visualização de gráfico em barras do maior para o menor.

```
SELECT u."id", u."name", COUNT(ma."id") AS map_art_count
FROM "users" u
         JOIN "map_arts" ma ON u."id" = ma."userId"
GROUP BY u."id", u."name"
ORDER BY map_art_count DESC
LIMIT 5;
```

### Artes mais curtidas.

Pode ser utilizada em uma imagem em formato de pódio ou ranking.

```
SELECT ma."id", ma."title", COUNT(ulma."id") AS like_count
FROM "map_arts" ma
         JOIN "users_likes_map_arts" ulma ON ma."id" = ulma."postLikedId"
GROUP BY ma."id", ma."title"
ORDER BY like_count DESC
LIMIT 3;
```

### Artes mais comentadas.

Pode ser utilizada em uma imagem em formato de pódio ou ranking.

```
SELECT ma."id", ma."title", COUNT(ucma."id") AS comment_count
FROM "map_arts" ma
         JOIN "users_comments_map_arts" ucma ON ma."id" = ucma."mapArtCommentedId"
GROUP BY ma."id", ma."title"
ORDER BY comment_count DESC
LIMIT 3;
```

### Novos cadastrados de usuários por dia nos últimos 30 dias.

Pode ser utilizada em um gráfico mostrando como o número de cadastros tem mudado durante esse período.

```
SELECT date(u."createdAt") AS signup_date, COUNT(*) AS new_users
FROM "users" u
WHERE u."createdAt" >= NOW() - INTERVAL '30 days'
GROUP BY signup_date
ORDER BY signup_date;
```

### Novas artes criadas por dia nos últimos 30 dias.

Pode ser utilizada em um gráfico mostrando como o número de cadastros tem mudado durante esse período.

```
SELECT date(a."createdAt") AS creation_date, COUNT(*) AS new_map_arts
FROM "map_arts" a
WHERE a."createdAt" >= NOW() - INTERVAL '30 days'
GROUP BY creation_date
ORDER BY creation_date;
```

Esses dados em conjunto mostram um resumo do uso do Martp e podem ser visualizados de diferentes formas como text, dashboards e gráficos.



