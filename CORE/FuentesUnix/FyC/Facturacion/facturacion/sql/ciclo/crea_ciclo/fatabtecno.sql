set echo off verify off
spool $WORKDIR/tab_FA_FACTECNO_TO_&1.log

prompt Table  FA_FACTECNO_TO_&1

Create table FA_FACTECNO_TO_&1
(IND_ORDENTOTAL        NUMBER   (12,0)  NOT NULL
,COD_CONCEPTO          NUMBER   (9,0)   NOT NULL
,COLUMNA               NUMBER   (6,0)   NOT NULL
,COD_TECNOLOGIA        VARCHAR2 (7)     NOT NULL
,COD_OFICINA_PRINCIPAL VARCHAR2 (2)     NOT NULL
,PRC_TECNOLOGIA        NUMBER   (5,2)   NOT NULL
,COD_GRPCONCEPTO       NUMBER   (9,0)   NOT NULL
)
pctfree     5
pctused     90
initrans    4
maxtrans    255
tablespace  FACTURACION_CICLOS_TTAB
storage (initial        8M
         next           3M
         minextents     1
         maxextents     256
         pctincrease    0
         freelists      8)

/

prompt Primary key PK_FA_FACTECNO_TO_&1

alter table FA_FACTECNO_TO_&1
add constraint PK_FA_FACTECNO_TO_&1 PRIMARY KEY
(IND_ORDENTOTAL, COD_CONCEPTO, COLUMNA, COD_TECNOLOGIA, COD_OFICINA_PRINCIPAL)
using index
pctfree     5
initrans    8
maxtrans    255
tablespace  FACTURACION_CICLOS_TIND
storage (initial        5M
         next           2M
         minextents     1
         maxextents     256
         pctincrease    0
         freelists      8)
/

comment on table FA_FACTECNO_TO_&1 is 'Tabla de Tecnologis de Clientes Facturados';

comment on column FA_FACTECNO_TO_&1..IND_ORDENTOTAL        is 'Indice que Asocia un Cliente a una Factura';
comment on column FA_FACTECNO_TO_&1..COLUMNA               is 'Secuencia';
comment on column FA_FACTECNO_TO_&1..COD_CONCEPTO          is 'Codigo de Concepto';
comment on column FA_FACTECNO_TO_&1..COD_TECNOLOGIA        is 'Código de Tecnología';
comment on column FA_FACTECNO_TO_&1..COD_OFICINA_PRINCIPAL is 'Código de Oficina Principal';
comment on column FA_FACTECNO_TO_&1..PRC_TECNOLOGIA        is 'Porcentaje de Tecnología';
comment on column FA_FACTECNO_TO_&1..COD_GRPCONCEPTO       is 'Código de Grupo de Conceptos (Mapeos Contables)';

grant SELECT on FA_FACTECNO_TO_&1 to  SISCEL_SELECT;
grant DELETE on FA_FACTECNO_TO_&1 to  ops$xpfactur;
grant INSERT on FA_FACTECNO_TO_&1 to  ops$xpfactur;
grant SELECT on FA_FACTECNO_TO_&1 to  ops$xpfactur;
grant UPDATE on FA_FACTECNO_TO_&1 to  ops$xpfactur;

create public synonym FA_FACTECNO_TO_&1 for
      FA_FACTECNO_TO_&1;
spool off
exit;

