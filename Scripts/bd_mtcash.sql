--use master;
--GO
--drop database bd_mtcash;
--GO
	
CREATE database bd_mtcash;
GO

use bd_mtcash;
GO

create schema mtcash;
GO

create table mtcash.tb_uf(
id_uf int identity not null primary key,	
uf varchar(2) not null,
pais varchar(15) null
);
go


create table mtcash.tb_cidade(	
id_cidade int identity not null primary key,
cidade varchar(30) not null,
id_uf int not null
foreign key (id_uf)
references mtcash.tb_uf(id_uf)
);
go

create table mtcash.tb_endereco(
id_endereco int identity not null primary key,
endereco varchar(100) null,
numero int null,
complemento varchar(30) null,
id_cidade int not null
foreign key(id_cidade)
references mtcash.tb_cidade(id_cidade)
);
go

create table mtcash.tb_contato(
id_contato int identity not null primary key,
email varchar(100) null,
telefone varchar(14) null
);
go

create table mtcash.tb_usuario(
id_usuario int identity not null primary key,
nome varchar(150) not null,
tipo_documento varchar(10) null,
documento varchar(20) null,
cpf varchar(20) null,
data_nascimento date null,
funcao varchar(30) null,
modulos varchar(50) null,
user_atv bit null,
tipo varchar(50) null,
usuario varchar(30) unique not null,
senha varchar(300) not null
);
GO

 create table mtcash.tb_permissao_usuario(
 id_permissao int identity not null primary key,
 modulo varchar(1) not null,
 permissao varchar(20)  null,
 id_usuario int not null
 foreign key(id_usuario)
 references mtcash.tb_usuario(id_usuario)
 );
 go

 select * from mtcash.tb_permissao_usuario where id_usuario = 2

create table mtcash.tb_endereco_usuario(
id_endereco_usuario int identity not null primary key,
uf varchar(2) not null,
cidade varchar(30) not null,
endereco varchar(100) null,
numero int null,
complemento varchar(30) null,
id_usuario int not null
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.tb_contato_usuario(
id_contato_usuario int identity not null primary key,
id_contato int not null,
id_usuario int not null
foreign key(id_contato)
references mtcash.tb_contato(id_contato),
foreign key (id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.tb_login(
id_login int identity not null primary key,
id_usuario int not null,
data_login datetime not null
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.tb_cliente(
id_cliente int identity not null primary key,
nome varchar(150) not null,
tipo_documento varchar(10) null,
documento varchar(20) null,
cpf varchar(20) null,
data_nascimento date null,
tipo varchar(50) null
);
GO


create table mtcash.tb_endereco_cliente(
id_endereco_cliente int identity not null primary key,
uf varchar(2) not null,
cidade varchar(30) not null,
endereco varchar(100) null,
numero int null,
complemento varchar(30) null,
id_cliente int not null
foreign key(id_cliente)
references mtcash.tb_cliente(id_cliente)
);
go

create table mtcash.tb_contato_cliente(
id_contato_cliente int identity not null primary key,
email varchar(100) null,
telefone varchar(14) null,
id_cliente int not null
foreign key (id_cliente)
references mtcash.tb_cliente(id_cliente)
);
go

create table mtcash.u_tb_conta_corrente(
id_conta_corrente int identity not null primary key,
banco varchar(20) not null,
favorecido varchar(120) not null,
tipo_conta varchar(25) not null,
agencia varchar(11) not null,
operacao varchar(8) not null,
conta varchar(11) not null,
valor decimal(8,2) not null
);
go

create table mtcash.u_tb_categoria(
id_categoria int identity not null primary key,
categoria varchar(50) null,
tipo_categoria varchar(20) null,
tipo_plano varchar(10) null,
entidade_pai int null
);
go

create table mtcash.u_tb_receita(
id_receita int identity not null primary key,
descricao varchar(100) not null,
diavencimento varchar(2) not null,
mesvencimento varchar(2) not null,
valor_total decimal(8,2) not null,
desconto decimal(8,2) null,
paga bit null,
datainicio datetime not null
);
go

--select * from mtcash.u_tb_receita WHERE descricao like '%' AND paga = 'False'
--select * from mtcash.u_tb_receita;

create table mtcash.u_parcela_receita_tb(
id_parcela int identity not null primary key,
id_receita int not null,
numero_parcela int not null,
valor_parcela decimal(8,2) not null,
data_vencimento datetime not null,
desconto decimal(8,2) null,
quitada bit not null
foreign key(id_receita)
references mtcash.u_tb_receita(id_receita)
);
GO

create table mtcash.u_recebimento_parcela_receita_tb(
id_recebimento_parcela int identity not null primary key,
id_usuario int not null,
id_parcela int not null,
data_recebimento datetime null,
total_recebido decimal(8,2) not null
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario),
foreign key(id_parcela)
references mtcash.u_parcela_receita_tb(id_parcela)
);
GO


create table mtcash.u_tb_recibo(
id_recibo int identity not null primary key,
id_usuario int not null,
data_recibo datetime not null,
valor_total decimal(8,2) not null
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.u_tb_item_recibo(
id_item_recibo int identity not null primary key,
id_recibo int not null,
id_parcela int not null,
valor decimal(8,2) not null,
desconto decimal(8,2) null
foreign key(id_recibo)
references mtcash.u_tb_recibo(id_recibo)
);
go

create table mtcash.u_tb_quita_receita(
id_quitacao int identity not null primary key,
id_receita int not null,
id_usuario int not null,
valor_total decimal(8,2) not null,
desconto_total decimal(8,2) null,
data_quitacao datetime not null
foreign key(id_receita)
references mtcash.u_tb_receita(id_receita),
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.u_tb_despesa(
id_despesa int identity not null primary key,
descricao varchar(100) not null,
dia varchar(2) not null,
mes varchar(2) not null,
ano varchar(4) not null,
valor_despesa decimal(8,2) not null,
desconto decimal(8,2) null,
periodo varchar(30) null,
paga varchar(5) null
);
go
select * from mtcash.u_tb_despesa

create table mtcash.u_tb_plano_conta(
id_plano_conta int identity not null primary key,
id_categoria int not null,
id_despesa int not null,
foreign key(id_categoria)
references mtcash.u_tb_categoria(id_categoria),
foreign key(id_despesa)
references mtcash.u_tb_despesa(id_despesa)
);
go

create table mtcash.u_tb_paga_despesa(
id_paga_despesa int identity not null primary key,
id_usuario int not null,
data_paga datetime not null,
valor_total decimal(8,2) not null
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.u_tb_item_despesa(
id_item_despesa int identity not null primary key,
id_paga_despesa int not null,
id_despesa int not null,
valor_despesa decimal(8,2) not null,
foreign key(id_paga_despesa)
references mtcash.u_tb_paga_despesa(id_paga_despesa),
foreign key(id_despesa)
references mtcash.u_tb_despesa(id_despesa)
);
go

create table mtcash.u_tb_pagamento(
id_pagamento int identity not null primary key,
id_paga_despesa int not null,
id_usuario int not null,
id_conta_corrente int null,
status varchar(45) not null,
data_pagamento datetime not null,
valor_pago decimal(8,2) null,
troco decimal(8,2) null,
forma_pgto varchar(20) null
foreign key (id_usuario)
references mtcash.tb_usuario(id_usuario),
foreign key(id_conta_corrente)
references mtcash.u_tb_conta_corrente(id_conta_corrente),
foreign key(id_paga_despesa)
references mtcash.u_tb_paga_despesa(id_paga_despesa)
);
go

create table mtcash.tb_fale_conosco(
id_fale_conosco int identity not null primary key,
id_usuario int not null,
mensagem varchar(200) not null,
data_mensagem datetime not null,
observacoes varchar(100) not null
foreign key(id_usuario)
references mtcash.tb_usuario(id_usuario)
);
go

create table mtcash.u_tb_investimento(
id_investimento int identity not null primary key,
data_registro datetime not null,
data_inicio datetime not null,
data_final datetime not null,
valor_total decimal(8,2) not null,
custo_total decimal(8,2) not null
);
GO

create table mtcash.u_tb_plano_investimento(
id_plano_investimento int identity not null primary key,
parcelas int not null,
valor_parcela decimal(8,2) not null,
parcelas_paga int not null,
valor_restante decimal(8,2) not null,
id_investimento int not null
foreign key(id_investimento)
references mtcash.u_tb_investimento(id_investimento)
);
go


create table mtcash.u_tb_bem_investimento(
id_bem int identity not null primary key,
descricao varchar(100) not null,
lucro decimal(8,2) not null,
custo decimal(8,2) not null,
garantia varchar(5) not null,
observacoes varchar(100) not null,
id_investimento int not null
foreign key (id_investimento)
references mtcash.u_tb_investimento(id_investimento)
);
go

create table mtcash.u_tb_transacao_mensal(
id_transacao_mensal int identity not null primary key,
id_conta_corrente int not null,
data_transacao datetime not null,
origem varchar(150) not null,
destino varchar(150) not null,
valor decimal(8,2) not null
);
go

create table mtcash.u_tb_transacao_mensal_investimento(
id_transacao_investimento int identity not null primary key,
id_transacao_mensal int not null,
id_plano_investimento int not null
foreign key(id_plano_investimento)
references mtcash.u_tb_plano_investimento(id_plano_investimento),
foreign key(id_transacao_mensal)
references mtcash.u_tb_transacao_mensal(id_transacao_mensal)
);
go

create table mtcash.u_log(
id_log int identity not null primary key,
messagem varchar(200) not null,
stacktrace varchar  null,
detalhes varchar(200) null,
data_ocorreu datetime not null
);
GO


select  * from mtcash.u_log;
insert into mtcash.tb_usuario (nome, usuario, senha, modulos) values('admin','admin','admin', 'ucfi');
GO

 insert into mtcash.tb_permissao_usuario (permissao, modulo, id_usuario) values ('apxr','u',1)
 GO
  insert into mtcash.tb_permissao_usuario (permissao, modulo, id_usuario) values ('apxr','c',1)
 GO
  insert into mtcash.tb_permissao_usuario (permissao, modulo, id_usuario) values ('apxr','f',1)
 GO
  insert into mtcash.tb_permissao_usuario (permissao, modulo, id_usuario) values ('apxr','i',1)
 GO
  insert into mtcash.tb_permissao_usuario (permissao, modulo, id_usuario) values ('apxr','e',1)
 GO

 select * from mtcash.tb_permissao_usuario
 GO

select * from mtcash.tb_usuario;
GO
--create table mtcash.outros_gastos_tb(
--id_gasto int identity not null primary key,
--descricao_gasto varchar(100)null,
--data_gasto datetime null,
--valor_gasto decimal(10,2) null,
--forma_pagamento varchar(20) null,
--troco decimal(8,2) null,
--id_conta int not null
--foreign key (id_conta)
--references mtcash.contas_tb(id_conta)
--);
--GO

-- valor total dividido pela parcela dará resultado a quantidade de meses
--create table mtcash.investimentos_tb(
--id_investimento int identity not null primary key,
--produto varchar(100) null,
--data_inicio datetime null,
--data_final datetime null,
--valor_total decimal(10,2) null,
--valor_investido_mensal decimal(10,2) null,
--prazo_meses float null,
--total_pago decimal(10,2) null
--);
--GO

--pensar e criar uma tabela que armazenara o quanto voce pode gastar, baseando - se na renda e nas contas e investimentos.
--create table mtcash.compras_tb(
--id_compra int identity not null primary key,
--produto varchar(100) null,
--preco_unitario decimal(10,2) null,
--quantidade int null,
--preco_total decimal(10,2) null,
--id_conta int null
--foreign key (id_conta)
--references mtcash.contas_tb(id_conta)
--);
--GO

--create table mtcash.vendas_tb(
--id_venda int identity not null primary key,
--produto varchar(100) null,
--preco_unitario decimal(10,2) null,
--quantidade int null,
--preco_total decimal(10,2) null,
--id_conta int null,
--foreign key (id_conta)
--references mtcash.contas_tb(id_conta)
--);
--GO

-- inserir tabela emprestimos, mas pensa antes