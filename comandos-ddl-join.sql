/* criando banco de dados */
create database revisao_mysql;

/* criando tabela teste para abordar ALTER */
create table teste(
    id serial primary key not null,
    nome varchar(60),
    sobrenome varchar(60)
);

/* alter table - add */
/* adicionando uma nova coluna na tabela teste */
alter table teste add column coluna_nova varchar(10);

/* alter table - alter column */
/* alterando tipo primitivo de uma determinada coluna na tabela teste */
alter table teste alter column coluna_nova type text;

/* alter table - rename table */
/* renomenado tabela teste para categorias */
alter table teste rename to funcionarios;

/* alter table - rename column */
/* renomenado coluna coluna_nova da tabela funcionarios para coluna_nova_renomeada */
alter table funcionarios rename column coluna_nova to coluna_nova_renomeada;

/* alter table - drop column */
/* excluindo coluna coluna_nova_renomeada da tabela funcionarios */
alter table funcionarios drop column coluna_nova_renomeada;

/* exemplos insert into */
insert into funcionarios (nome, sobrenome)
values
('Victor', 'Torres'), ('Juliana', 'Matos'), ('Victor', 'Vidal'),
('Guido', 'Cerqueira'), ('Rafaela', 'Assis'), ('Clara', 'Battesini'),
('Gabriela', 'Cairo'), ('Fernanda', 'Sousa'), ('Amado', 'Amoroso');

/* truncate - exclui todos registros e zera a contagem de IDs */
truncate funcionarios restart identity;

/* select - para analisar os updates, deletes e truncate  */
select * from funcionarios;

/* drop */
/* excluindo tabela categorias */
drop table funcionarios;

/* excluindo banco de dados revisao_mysql */
drop database revisao_mysql;


/* Exercicios */
/* 1 - Remover coluna sobrenome na tabela categorias */
/* 2 - Alterar a coluna nome para descricao na tabela categorias */
/* 3 - Criar uma tabela produtos que tenha os seguintes campos: 
 * id (deve ser a chave primaria, nao pode ser nulo, deve se auto incrementar 
 * descricao (deve ser do tipo varchar, aceitando ate 60 caracteres 
 * categoria_id (deve ser do tipo inteiro, efetuar relacionamento com a coluna ID 
 * da tabela categorias como chave estrangeira) */

/* Resposta questao 1 */
alter table categorias drop column sobrenome;

/* Resposta questao 2 */
alter table categorias rename column nome to descricao;

/* Resposta questao 3 */
create table produtos(
  id serial primary key not null,
  descricao varchar(60) not null,
  categoria_id int references categorias(id)
);

/* Adicionando a chave estrangeira com a tabela categorias
 *  após a criação da tabela produtos */
alter table produtos add constraint produtos_categoria_id_foreign_key
foreign key (categoria_id) references categorias(id);

/* inner join, left join, right join (left e join possuem o mesmo intuito */
/* inserindo registos nas duas tabelas (produtos e categorias) */
insert into categorias (descricao) values
('eletrodomésticos'), ('eletroportáteis'), ('celulares'),
('móveis'), ('beleza e perfumaria'), ('informática');

insert into produtos (descricao, categoria_id) values
('mangá naruto', null), ('gibi turma da mônica', null), ('mangá dragon ball z', null),
('geladeira frost free', 1), ('lavadora de roupas', 1), ('cooktop 4 bocas', 1),
('robô aspirador', 2), ('panela de pressão elétrica', 2), ('fritadeira elétrica', 2),
('moto g9 play', 3), ('iphone SE', 3), ('galaxy A7', 3),
('one million 100ml', 5), ('212 100ml', 5), ('L`eau D`issey', 5),
('mouse', 6), ('teclado', 6), ('placa de vídeo', 6);

select * from produtos;
/* Inner Join - busca exibir registros de modo que encontre uma intersercção entre as tabelas,
ou seja, só ira exibir na consulta, os registros que possuam vínculo entre as tabelas através
das colunas id da tabela A e coluna_referencia da tabela B
Em resumo apenas irá exibir os registros que cumprirem a condição da cláusula ON de igualdade de valor entre
os dois campos das duas tabelas  */
select * from tabela_A
inner join tabela_B on (tabela_B.coluna_refencia = tabela_A.id);

select p.id, p.descricao, c.descricao
from produtos p
inner join categorias c on (p.categoria_id = c.id);


/* Left Join - ocorre de maneira que buscamos efetuar uma consulta em mais de uma tabela
e no caso a tabela que vem após o FROM é a que ficará a esquerda (tabela A), 
a tabela que vem após o LEFT JOIN é a que ficará a direita (tabela B).
De modo, que exiba na consulta todos os registros da tabela que está a esqueda
(tabela A) como uma forma de preferência, e, caso encontre a igualdade na condição ON
ele irá trazer informações da tabela que está a direita (tabela B)
Em resumo, caso a condição imposta na cláusula ON seja cumprida ele irá complementar a consulta
para determinados registros com os dados da tabela B relacionda*/

select * from tabela_A
left join tabela_B on (tabela_B.coluna_refencia = tabela_A.id);

select p.id, p.descricao, c.descricao
from produtos p
left join categorias c on (p.categoria_id = c.id);


/* Right Join - ocorre de maneira que buscamos efetuar uma consulta em mais de uma tabela
e no caso a tabela que vem após o FROM é a que ficará a esquerda (tabela A), 
a tabela que vem após o RIGHT JOIN é a que ficará a direita (tabela B).
De modo, que exiba na consulta todos os registros da tabela que está a direita
(tabela B) como uma forma de preferência, e, caso encontre a igualdade na condição ON
ele irá trazer informações da tabela que está a esquerda (tabela A)
Em resumo, caso a condição imposta na cláusula ON seja cumprida ele irá complementar a consulta
para determinados registros com os dados da tabela B relacionda*/

select * from tabela_A
right join tabela_B on (tabela_B.coluna_referencia = tabela_A.id);

select c.descricao, p.id, p.descricao
from produtos p
right join categorias c on (p.categoria_id = c.id);


/* comparativo para provarmos que left e right acabam retornando mesmo efeito se trabalharmos de maneira 
 * semelhante
 */
select p.id, p.descricao, c.descricao
from produtos p
left join categorias c on (p.categoria_id = c.id);

select p.id, p.descricao, c.descricao
from categorias c
right join produtos p on (p.categoria_id = c.id);
