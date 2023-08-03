select * from musicas;

/* TEMPO MENOR QUE 199 */
select * from musicas where tempo < 199;

/* TEMPO MENOR QUE 199 */
select * from musicas where tempo > 199;

/* TEMPO IGUAL A 199 */
select * from musicas where tempo = 199;

/* TEMPO MAIOR A 199 */
select * from musicas where tempo > 199;

/* TEMPO MAIOR QUE 199 E TEMPO MENOR QUE 399 */
select * from musicas where tempo >= 199 AND tempo <= 399;

-- BETWEEN - aplica filtragem com base no critério de intervalo especificado
/* TEMPO ENTRE 199 E 399 */
select * from musicas where tempo between 199 AND 399;

/* TEMPO IGUAL A 199 OU TEMPO IGUAL A 399 */
select * from musicas where tempo = 199 or tempo = 399;

/* TEMPO NO INTERVALO ENTRE 6O A 120 OU TEMPO NO INTERVALO ENTRE 180 A 200
 * ORDENANDO POR TEMPO DE MANEIRA CRESCENTE
 */
select * from musicas where tempo between 60 and 120 or tempo between 180 and 200
order by tempo asc;

--limit - limitamos a quantidade de registros que serão retornados na consulta
-- offset - aplica paginacao baseando-se no critério informado para "fatiar" a partir
--do critério (onde começa a próxima página)

/* paginacao com limite de 10 registros para serem exibidos
   neste caso exibirá os registros que possuírem os 10 menores valores baseando-se pela coluna
   de chave primária (que geralmente é a coluna ID)
 */
select * from musicas;
select * from musicas limit 10 offset 0; --página 1

select * from musicas limit 10 offset 10; --página 2

select * from musicas limit 10 offset 20; --página 3

/* Ordenando os registros para serem exibidos em ordem alfabética ascendente (A-Z)
   baseando-se pela coluna compositor para aplicar ordenação
*/
select * from musicas order by compositor asc;

/* Ordenando os registros para serem exibidos em ordem alfabética descendente (Z-A)
   baseando-se pela coluna compositor para aplicar ordenação
*/
select * from musicas order by compositor desc;

/* Ordenando os registros para serem exibidos em ordem crescente 
    baseando-se pela coluna id para aplicar ordenção
*/
select * from musicas order by id asc;

/* Ordenando os registros para serem exibidos em ordem decrescente 
    baseando-se pela coluna id para aplicar ordenção
*/
select * from musicas order by id desc;

select * from musicas order by id asc;

/* LIKE - aplica filtragem baseado em um caracter ou conjunto de caracteres */
-- Podemos aplicar o LIKE com critério específico conforme ilustrado abaixo
select * from musicas where composicao like 'Violin Sonata No 1 in G minor';

-- Podemos aplicar o LIKE com caracter coringa '%' como nos casos abaixo

-- aplicado no início da expressão
-- note que pode existir um caracter ou conjunto de caracteres antecedendo a expressão 'in G minor'
select * from musicas where composicao like '%in G minor';

-- aplicado no fim da expressão
-- note que pode existir um caracter ou conjunto de caracteres precedendo a expressão 'Violin Sonata'
select * from musicas where composicao like 'Violin Sonata%';

-- aplicado no início e no fim da expressão
-- note que pode existir um caracter ou conjunto de caracteres antecedendo e/ou precendo a expressão 'Sonata'
select * from musicas where composicao like '%Sonata%';

-- Podemos aplicar o LIKE com caracter '_'
-- de certo modo, o caracter '_' equivale a um caracter que pode ser a-z|A-Z|1-9 como nos casos abaixo

-- nesse exemplo abaixo estamos representando três '_' no início da expressão e precedendo
-- temos a expressão 'no Sonata in A maj', mas, ainda no fim da expressão temos mais dois '__'
-- E que resulta em uma expressão que irá ignorar os três primeiros caracteres e os dois últimos
-- desde que contenha no "meio" da expressão a sequência de caracteres 'no Sonata in A maj'
select * from musicas where composicao like '___no Sonata in A maj__';

-- nesse exemplo abaixo estamos representando três '_' no início da expressão e precedendo
-- temos a expressão 'no Sonata', mas, no final indicamos um caracter coringa '%' o que representa que 
-- pode existir no fim da expressão um caracter ou uma sequência de caracteres
select * from musicas where composicao like '___no Sonata%';

-- ILIKE
-- O ilike possui as mesmas características do like,
-- porém não é case-sensitive, ou seja, não faz distinção entre maiúsculas e minusculas,
-- de modo que 'MARIA' é igual 'maria' para o ilike.

-- nesse exemplo abaixo estamos representando com o caracter coringa '%'
-- que a expressão deve iniciar com um caracter ou uma sequência de caracteres antecedendo
-- a expressão 'sonata in a majo', mas, no final indicamos um caracter '_'
-- que resulta em uma expressão que irá ignorar o último caracter após a expressão 'sonata in a majo'
select * from musicas where composicao ilike '%sonata in a majo_';


/* Funções PostgreSQL */

-- Count() retorna a quantidade de registros que a consulta filtrou
select count(*) from usuarios where idade >= 18;

-- atribuíndo alias ao resultado obtido da quantidade total de registros filtrados
select count(*) as "quantidadeUsuarios" from usuarios where idade >= 18;

-- Concatenando duas colunas e aplicando alias, no caso abaixo estamos concatenando
-- as colunas nome e email de modo que teremos como resultado, por exemplo:
-- Victor - victor.torres@cubos.academy
select nome || ' - ' || email as "Nome - Email" from usuarios;
select concat(nome, ' - ', email) as "Nome - Email" from usuarios;

-- AVG - efetua o cálculo da média entre o conjunto de valores de uma coluna especificada
-- No caso será tirada média baseando-se na coluna idade da tabela usuários
select avg(idade) from usuarios;

-- ROUND
-- aplica arredondamento nos valores 
select round(avg(idade)) from usuarios;

-- se aplicado com o segunda parâmetro informado, significa que o arredondamento
--será baseado na quantidade de casas decimais informadas no parâmetro
--na ilutracao abaixo arredondaremos para duas casas decimais
select round(avg(idade), 2) from usuarios;

-- MIN
-- retorna o valor mínimo do conjunto de valores de uma coluna especificada

-- abaixo estamos buscando a menor idade existente na tabela de usuários
select min(idade) from usuarios;

-- quando aplicamos o MIN em uma coluna que não possui valores numéricos
--ocorrerá aplicação da ordenação ASC com base na coluna aplicada como critério no MIN

-- aplicando MIN em coluna que possui varchar | texto
select min(nome) from usuarios;
-- abaixo query semelhante mas que traz o mesmo retorno
select nome from usuarios order by nome asc limit 1;

-- aplicando MIN em coluna que possui datetime | data
select min(cadastro) from usuarios;
-- abaixo query semelhante mas que traz o mesmo retorno
select cadastro from usuarios order by cadastro asc limit 1;

-- MAX
-- retorna o valor máximo do conjunto de valores de uma coluna especificada

-- abaixo estamos buscando a menor idade na tabela de usuários
select max(idade) from usuarios;

-- quando aplicamos o MAX em uma coluna que não possui valores numéricos
--ocorrerá aplicação da ordenação DESC com base na coluna aplicada como critério no MAX

-- aplicando MAX em coluna que possui varchar | texto
select max(nome) from usuarios;
-- abaixo query semelhante mas que traz o mesmo retorno
select nome from usuarios order by nome desc limit 1;

-- aplicando MAX em coluna que possui datetime | data
select max(cadastro) from usuarios;
-- abaixo query semelhante mas que traz o mesmo retorno
select cadastro from usuarios order by cadastro desc limit 1;


-- SUM
-- retorna a soma de um conjunto de valores de uma coluna especificada

-- abaixo aplicamos a soma entre as idades da tabela usuários
select sum(idade) from usuarios;

-- NOW
-- retorna data e hora corrente (momento atual)
select now();

-- Monte uma query que retorne a quantidade de produtos 
-- agrupados por categoria e soma do estoque de todos os produtos
-- de cada categoria.
select categoria, count(id) as "quantidadeProdutos", 
sum(estoque) as "somaTotalEstoque" from farmacia group by categoria;


-- CRUD SQL

-- Criação da tabela produtos
create table if not exists produtos (
	id serial primary key,
  	nome text,
  	descricao text,
  	preco integer,
  	categoria text
);

/* INSERT INTO */
insert into produtos (nome, descricao, preco, categoria) values ('Caderno', 'Linda Camisa', 5990, 'Roupas');
insert into produtos (nome, preco, categoria) values ('Caderno', 2000, 'Material escolar');
insert into produtos (nome, descricao, preco, categoria) values ('Calça Jeans', NULL, 12900, 'Roupas'),('Bermuda', 'Bermuda longa preta', 12900, 'Roupas');

/* UPDATE */
update produtos set nome = 'Caderno de 10 materias' where id = 3;
update produtos set categoria = 'Calças', preco = 12950 where descricao is null;
update produtos set nome = 'Caderno'; -- NUNCA FAÇA ISSO (UPDATE SEM WHERE)

/* DELETE */
delete from produtos where id = 1;
delete from produtos where descricao is null;
delete from produtos; -- NUNCA FAÇA ISSO 2 (DELETE SEM WHERE)

select * from produtos;
