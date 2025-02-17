/*DROP TABLE PESSOA*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- PESSOAS
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE PESSOA 
(
    ID_PESSOA        INT         NOT NULL,
    CPF              VARCHAR(11) NOT NULL,
    NOME             VARCHAR(50) NOT NULL,
    FONE             VARCHAR(30),
    EHWHATS          CHAR(1)     DEFAULT 'S' NOT NULL,
    SENHA            VARCHAR(20) NOT NULL,
    EMAIL            VARCHAR(50),
    ATIVO            CHAR(1)     DEFAULT 'S' NOT NULL,
    EHOFICIAL        CHAR(1)     DEFAULT 'N' NOT NULL,
    LIB_CADDESASTRE  CHAR(1)     DEFAULT 'N' NOT NULL,
    REGISTRO_OFICIAL VARCHAR(50),
    CONTATOS         BLOB,
    END_LOG          VARCHAR(50),
    END_NUM          VARCHAR(6),
    END_BAI          VARCHAR(30),
    END_CID          VARCHAR(30),
    END_CEP          VARCHAR(8),
    END_COM          VARCHAR(30),
    END_UF           VARCHAR(2)
);

ALTER TABLE PESSOA ADD CONSTRAINT MUNICIPIOSDESLOCAMENTO_PK PRIMARY KEY(ID_PESSOA);
ALTER TABLE PESSOA ADD CONSTRAINT PESSOA_UK UNIQUE (CPF);

ALTER TABLE PESSOA ADD CONSTRAINT PESSOAEHWHATS_CK CHECK (EHWHATS IN ('S','N'));
ALTER TABLE PESSOA ADD CONSTRAINT PESSOAATIVO_CK CHECK(ATIVO IN ('S','N','B'));
ALTER TABLE PESSOA ADD CONSTRAINT PESSOAEHOFICIAL_CK CHECK (EHOFICIAL IN ('S','N'));
ALTER TABLE PESSOA ADD CONSTRAINT PESSOALIB_CADDESASTRE_CK CHECK (LIB_CADDESASTRE IN ('S','N'));

CREATE SEQUENCE PESSOA_SEQ
INCREMENT BY 1
NOMINVALUE 
NOMAXVALUE
NOCYCLE 
NOCACHE;
/*--------------------------------------------------------------------------------------------------------------------------------*/

/*DROP TABLE DESASTRE;*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- DESASTRE
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE DESASTRE 
(
    ID_DESASTRE INT         NOT NULL,
    DESCRICAO   VARCHAR(50) NOT NULL,
    TIPO        CHAR(1)     NOT NULL,
    DATA        DATE        NOT NULL,
    ATIVO       CHAR(1)     DEFAULT 'S' NOT NULL,
    CIDADE      VARCHAR(30) NOT NULL,
    UF          VARCHAR(2)  NOT NULL
);

ALTER TABLE DESASTRE ADD CONSTRAINT DESASTRE_PK PRIMARY KEY(ID_DESASTRE);
ALTER TABLE DESASTRE ADD CONSTRAINT DESASTRE_UK UNIQUE (DESCRICAO);

ALTER TABLE DESASTRE ADD CONSTRAINT DESASTREATIVO_CK CHECK (ATIVO IN ('S','N'));
ALTER TABLE DESASTRE ADD CONSTRAINT DESASTRETIPO_CK CHECK (TIPO IN ('1','2','3','4','5','6','7','X'));

/*
NUMERACAO DA WIKIPÉDIA => https://pt.wikipedia.org/wiki/Desastre_natural#Refer%C3%AAncias  
    1 Afundamento e colapso
    2 Ciclones, furacões ou tufões
    3 Deslizamento ou escorregamento de terra
    4 Inundações
    5 Tempestades
    6 Tornados
    7 Outros fenômenos
    X -> PROCURADOS
*/

CREATE SEQUENCE DESASTRE_SEQ
INCREMENT BY 1
NOMINVALUE 
NOMAXVALUE
NOCYCLE 
NOCACHE;
/*--------------------------------------------------------------------------------------------------------------------------------*/

/*DROP TABLE UNIDATENDTO*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- UNIDADE DE ATENDIMENTO(UNIDADES QUE ESTÃO SOCORRENDO OS AFETADOS PELO DESASTRE)
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE UNIDATENDTO 
(
    ID_UNIDATENDTO INT        NOT NULL,
    NOME           VARCHAR(50) NOT NULL,
    ATIVO          CHAR(1)    DEFAULT 'S' NOT NULL,
    FONES          VARCHAR(50),
    EMAIL          VARCHAR(50),
    SITE           VARCHAR(50),
    NOME_RESP      VARCHAR(50),
    END_LOG        VARCHAR(50),
    END_NUM        VARCHAR(6),
    END_BAI        VARCHAR(30),
    END_CID        VARCHAR(30),
    END_CEP        VARCHAR(8),
    END_COM        VARCHAR(30),
    END_UF         VARCHAR(2),
    OBS            BLOB
);

ALTER TABLE UNIDATENDTO ADD CONSTRAINT UNIDATENDTO_PK PRIMARY KEY(ID_UNIDATENDTO);

ALTER TABLE UNIDATENDTO ADD CONSTRAINT UNIDATENDTOATIVO_CK CHECK (ATIVO IN ('S','N'));

CREATE SEQUENCE UNIDATENDTO_SEQ
INCREMENT BY 1
NOMINVALUE 
NOMAXVALUE
NOCYCLE 
NOCACHE;
/*--------------------------------------------------------------------------------------------------------------------------------*/

/*DROP TABLE LISTA;*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- LISTA (LISTA COM AS PESSOAS ENCONTRADAS E SITUAÇÃO)
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE LISTA 
(
    ID_LISTA        INT         NOT NULL,
    ID_DESASTRE     INT         NOT NULL,
    ID_UNIDATENDTO  INT,
    INSERIDOPOR     CHAR(1)     NOT NULL,
    NOME            VARCHAR(50) NOT NULL,
    CPF             VARCHAR(11),
    IDADE           INT(3)      DEFAULT 0 NOT NULL,
    OBTO            CHAR(1)     DEFAULT 'N' NOT NULL,
    ENCERRADO       CHAR(1)     DEFAULT 'N' NOT NULL,
    DATA_HORA       DATE        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CARACTERISTICAS BLOB
);

ALTER TABLE LISTA ADD CONSTRAINT LISTA_PK PRIMARY KEY(ID_LISTA);

ALTER TABLE LISTA ADD CONSTRAINT LISTAOBTO_CK CHECK (OBTO IN ('S','N'));
ALTER TABLE LISTA ADD CONSTRAINT LISTAENCE_CK CHECK (ENCERRADO IN ('S','N'));
ALTER TABLE LISTA ADD CONSTRAINT LISTAINSE_CK CHECK (INSERIDOPOR IN ('D','P'));/*D-DEFESA CIVIL,ORGÃO | P-PESSOA,PERENTE,CONHECIDO*/

ALTER TABLE LISTA ADD (CONSTRAINT LISTADES_FK FOREIGN KEY (ID_DESASTRE) REFERENCES DESASTRE(ID_DESASTRE));
ALTER TABLE LISTA ADD (CONSTRAINT LISTAUNA_FK FOREIGN KEY (ID_UNIDATENDTO) REFERENCES UNIDATENDTO(ID_UNIDATENDTO));

CREATE SEQUENCE LISTA_SEQ
INCREMENT BY 1
NOMINVALUE 
NOMAXVALUE
NOCYCLE 
NOCACHE;
/*--------------------------------------------------------------------------------------------------------------------------------*/

/*DROP TABLE FOTO;*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- IMAGENS
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE FOTO 
(
    ID_FOTO        INT      NOT NULL,
    IMAGEM         BLOB,
    ID_UNIDATENDTO INT,
    ID_DESASTRE    INT,
    ID_PESSOA      INT,
    ID_LISTA       INT
);

ALTER TABLE FOTO ADD CONSTRAINT FOTO_PK PRIMARY KEY(ID_FOTO);

ALTER TABLE FOTO ADD (CONSTRAINT FOTODES_FK FOREIGN KEY (ID_DESASTRE)    REFERENCES DESASTRE(ID_DESASTRE));
ALTER TABLE FOTO ADD (CONSTRAINT FOTOUNA_FK FOREIGN KEY (ID_UNIDATENDTO) REFERENCES UNIDATENDTO(ID_UNIDATENDTO));
ALTER TABLE FOTO ADD (CONSTRAINT FOTOPES_FK FOREIGN KEY (ID_PESSOA)      REFERENCES PESSOA(ID_PESSOA));
ALTER TABLE FOTO ADD (CONSTRAINT FOTOLST_FK FOREIGN KEY (ID_LISTA)       REFERENCES LISTA(ID_LISTA));

CREATE SEQUENCE FOTO_SEQ
INCREMENT BY 1
NOMINVALUE 
NOMAXVALUE
NOCYCLE 
NOCACHE;
/*--------------------------------------------------------------------------------------------------------------------------------*/

/*DROP TABLE PESSOAPROCURA;*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- PESSOAPROCURA (JUNÇÃO DA PESSOA COM A LISTA -> "QUEM ESTÁ PROCURANDO QUEM")
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE PESSOAPROCURA 
(
    ID_LISTA       INT NOT NULL,
    ID_PESSOA      INT NOT NULL
);

ALTER TABLE PESSOAPROCURA ADD CONSTRAINT PESSOAPROCURA_PK PRIMARY KEY(ID_LISTA, ID_PESSOA);

ALTER TABLE PESSOAPROCURA ADD (CONSTRAINT PESSOAPROCURALST_FK FOREIGN KEY (ID_LISTA)  REFERENCES LISTA(ID_LISTA));
ALTER TABLE PESSOAPROCURA ADD (CONSTRAINT PESSOAPROCURAPES_FK FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA(ID_PESSOA));
/*--------------------------------------------------------------------------------------------------------------------------------*/

/*DROP TABLE DESASTREUNIDATENDTO;*/
/*--------------------------------------------------------------------------------------------------------------------------------
-- DESASTE X UNIDADES DE ATENDIMENTO
--------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE DESASTREUNIDATENDTO 
(
    ID_DESASTRE    INT NOT NULL,
    ID_UNIDATENDTO INT NOT NULL
);

ALTER TABLE DESASTREUNIDATENDTO ADD CONSTRAINT DESATDTO_PK PRIMARY KEY(ID_DESASTRE, ID_UNIDATENDTO);

ALTER TABLE DESASTREUNIDATENDTO ADD (CONSTRAINT DESATDTODES_FK FOREIGN KEY (ID_DESASTRE)    REFERENCES DESASTRE(ID_DESASTRE));
ALTER TABLE DESASTREUNIDATENDTO ADD (CONSTRAINT DESATDTOUNA_FK FOREIGN KEY (ID_UNIDATENDTO) REFERENCES UNIDATENDTO(ID_UNIDATENDTO));
/*--------------------------------------------------------------------------------------------------------------------------------*/
