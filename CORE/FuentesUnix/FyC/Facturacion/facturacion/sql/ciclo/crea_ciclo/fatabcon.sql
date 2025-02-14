set echo off verify off
spool $WORKDIR/tab_FA_FACTABON_&1.log

prompt Table  FA_FACTABON_&1

Create table FA_FACTABON_&1
(IND_ORDENTOTAL                          NUMBER   (12,0)  NOT NULL
,COD_CLIENTE                             NUMBER   (8,0)   NOT NULL
,NUM_ABONADO                             NUMBER   (8,0)   NOT NULL
,COD_PRODUCTO                            NUMBER   (1,0)   NOT NULL
,COD_SITUACION                           VARCHAR2 (3)     NOT NULL
,TOT_CARGOSME                            NUMBER   (14,4)  NOT NULL
,ACUM_CARGO                              NUMBER   (14,4)  NOT NULL
,ACUM_DTO                                NUMBER   (14,4)  NOT NULL
,ACUM_IVA                                NUMBER   (14,4)  NOT NULL
,COD_DETFACT                             NUMBER   (1,0)       NULL
,FEC_FINCONTRA                           DATE                 NULL
,IND_FACTUR                              NUMBER   (1,0)       NULL
,COD_CREDMOR                             NUMBER   (3,0)       NULL
,NOM_USUARIO                             VARCHAR2 (20)        NULL
,NOM_APELLIDO1                           VARCHAR2 (20)        NULL
,NOM_APELLIDO2                           VARCHAR2 (20)        NULL
,LIM_CREDITO                             NUMBER   (14,4)      NULL
,NUM_CELULAR                             NUMBER   (15,0)      NULL
,NUM_BEEPER                              NUMBER   (15,0)      NULL
,CAP_CODE                                NUMBER   (7,0)       NULL
,IND_SUPERTEL                            NUMBER   (1,0)       NULL
,NUM_TELEFIJA                            VARCHAR2 (15)        NULL
,COD_BARRAS                              VARCHAR2 (20)        NULL
,COD_ZONAABON                            NUMBER   (02)    NOT NULL
,IND_COBRODETLLAM                        NUMBER   (01)        NULL
)
pctfree  5
pctused  60
initrans  4
maxtrans  255
tablespace  FACTURACION_CICLOS_TTAB
storage
(initial    25M
next        10M
minextents  1
maxextents  256
pctincrease    0
freelists  8)

/
alter table FA_FACTABON_&1 modify ACUM_CARGO default 0
/
alter table FA_FACTABON_&1 modify ACUM_DTO default 0
/
alter table FA_FACTABON_&1 modify ACUM_IVA default 0
/

prompt Primary key PK_FA_FACTABON_&1

alter table FA_FACTABON_&1
add constraint PK_FA_FACTABON_&1 PRIMARY KEY
(IND_ORDENTOTAL
,NUM_ABONADO
)
using index
pctfree     5
initrans    8
maxtrans    255
tablespace  FACTURACION_CICLOS_TIND
storage
(initial     10M
next          2M
minextents  1
maxextents  256
pctincrease 0
freelists   8)
/

comment on table FA_FACTABON_&1 is
'Datos generales de abonados en factura';

comment on column FA_FACTABON_&1..IND_ORDENTOTAL is
'Indice que Asocia a un Documento el Abonado Celular';

comment on column FA_FACTABON_&1..NUM_ABONADO is
'Numero de Abonado';

comment on column FA_FACTABON_&1..COD_CLIENTE is
'Codigo de Cliente';

comment on column FA_FACTABON_&1..COD_PRODUCTO is
'Codigo de Producto del Abonado';

comment on column FA_FACTABON_&1..COD_SITUACION is
'Codigo de Situacion del Abonado en GA_ABOCEL';

comment on column FA_FACTABON_&1..TOT_CARGOSME is
'Total del documento sin deuda';

comment on column FA_FACTABON_&1..ACUM_CARGO is
'Acumulado Cargos';

comment on column FA_FACTABON_&1..ACUM_DTO is
'Acumulado Descuento';

comment on column FA_FACTABON_&1..ACUM_IVA is
'Acumulado de Iva';

comment on column FA_FACTABON_&1..NUM_CELULAR is
'Numero Celular';

comment on column FA_FACTABON_&1..NUM_BEEPER is
'Numero Beeper';

comment on column FA_FACTABON_&1..CAP_CODE is
'CAP Code de Beeper';

comment on column FA_FACTABON_&1..COD_DETFACT is
'Codigo de detalle';

comment on column FA_FACTABON_&1..FEC_FINCONTRA is
'Fecha de fin de contrato';

comment on column FA_FACTABON_&1..IND_FACTUR is
'Indicador de si el abonado es facturable';

comment on column FA_FACTABON_&1..COD_CREDMOR is
'Codigo de Credito de Morosidad';

comment on column FA_FACTABON_&1..NOM_USUARIO is
'Nombre de Usuario Celular';

comment on column FA_FACTABON_&1..NOM_APELLIDO1 is
'Apellido Paterno';

comment on column FA_FACTABON_&1..NOM_APELLIDO2 is
'Apellido Materno';

comment on column FA_FACTABON_&1..LIM_CREDITO is
'Limite Credito';

comment on column FA_FACTABON_&1..IND_SUPERTEL is
'Indicador de si el abonado tiene contrato de SuperTelefono';

comment on column FA_FACTABON_&1..NUM_TELEFIJA is
'Numero Telefonico de Red Fija';

comment on column FA_FACTABON_&1..COD_BARRAS is
'Codigo de barras';

comment on column FA_FACTABON_&1..COD_ZONAABON is
'Codigo de Zona Tributaria de Abonado';

comment on column FA_FACTABON_&1..IND_COBRODETLLAM is
'Indicador Cobro Detalle Llamada';

grant SELECT on FA_FACTABON_&1 to  SISCEL_SELECT;
grant DELETE on FA_FACTABON_&1 to  ops$xpfactur;
grant INSERT on FA_FACTABON_&1 to  ops$xpfactur;
grant SELECT on FA_FACTABON_&1 to  ops$xpfactur;
grant UPDATE on FA_FACTABON_&1 to  ops$xpfactur;

create public synonym FA_FACTABON_&1 for
      FA_FACTABON_&1;
spool off
exit;
