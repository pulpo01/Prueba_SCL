set echo off verify off
spool $WORKDIR/tab_FA_FACTCLIE_&1.log

prompt Table  FA_FACTCLIE_&1

Create table FA_FACTCLIE_&1
(IND_ORDENTOTAL                          NUMBER   (12,0)  NOT NULL
,COD_CLIENTE                             NUMBER   (8,0)   NOT NULL
,NOM_CLIENTE                             VARCHAR2 (50)    NOT NULL
,COD_PLANCOM                             NUMBER   (6,0)   NOT NULL
,NOM_APECLIEN1                           VARCHAR2 (20)    NULL
,NOM_APECLIEN2                           VARCHAR2 (20)    NULL
,TEF_CLIENTE1                            VARCHAR2 (15)    NULL
,TEF_CLIENTE2                            VARCHAR2 (15)    NULL
,DES_ACTIVIDAD                           VARCHAR2 (40)    NULL
,NOM_CALLE                               VARCHAR2 (50)    NULL
,NUM_CALLE                               VARCHAR2 (10)    NULL
,NUM_PISO                                VARCHAR2 (10)    NULL
,DES_COMUNA                              VARCHAR2 (30)    NULL
,DES_CIUDAD                              VARCHAR2 (30)    NULL
,COD_PAIS                                VARCHAR2 (3)     NULL
,COD_RUTADESP                            NUMBER   (3,0)   NOT NULL
,IND_DEBITO                              CHAR (1)     NULL
,IMP_STOPDEBIT                           NUMBER   (14,4)  NULL
,COD_BANCO                               VARCHAR2 (15)     NULL
,COD_SUCURSAL                            VARCHAR2 (4)     NULL
,IND_TIPCUENTA                           CHAR (1)     NULL
,COD_TIPTARJETA                          VARCHAR2 (3)     NULL
,NUM_CTACORR                             VARCHAR2 (18)    NULL
,NUM_TARJETA                             VARCHAR2 (18)    NULL
,FEC_VENCITARJ                           DATE          NULL
,COD_BANCOTARJ                           VARCHAR2 (15)     NULL
,COD_TIPIDTRIB                           VARCHAR2 (2)     NULL
,NUM_IDENTTRIB                           VARCHAR2 (20)    NULL
,NUM_FAX                                 VARCHAR2 (15)    NULL
,COD_IDIOMA                              VARCHAR2(5)      NOT NULL
,GLS_DIRECCLIE                           VARCHAR2(250)    NOT NULL
)
pctfree  5
pctused  60
initrans  4
maxtrans  255
tablespace  FACTURACION_CICLOS_TTAB   
storage
(initial   25M    
next       10M   
minextents  1
maxextents  256
pctincrease    0
freelists  8)

/
alter table FA_FACTCLIE_&1 modify COD_RUTADESP default 1
/

prompt Primary key PK_FA_FACTCLIE_&1

alter table FA_FACTCLIE_&1
add constraint PK_FA_FACTCLIE_&1 PRIMARY KEY
(IND_ORDENTOTAL
)
using index
pctfree     5
initrans    8
maxtrans    255
tablespace   FACTURACION_CICLOS_TIND
storage
(initial    10M   
next        2M   
minextents  1
maxextents  256
pctincrease 0
freelists   8)
/

comment on table FA_FACTCLIE_&1 is
'Tabla de Historico de Clientes Facturados';

comment on column FA_FACTCLIE_&1..IND_ORDENTOTAL is
'Indice que Asocia un Cliente a una Factura';

comment on column FA_FACTCLIE_&1..COD_CLIENTE is
'Codigo del cliente';

comment on column FA_FACTCLIE_&1..NOM_CLIENTE is
'Nombre o razon social del cliente';

comment on column FA_FACTCLIE_&1..COD_PLANCOM is
'Plan comercial asignado al cliente';

comment on column FA_FACTCLIE_&1..NOM_APECLIEN1 is
'Primer apellido del cliente';

comment on column FA_FACTCLIE_&1..NOM_APECLIEN2 is
'Segundo apellido del cliente';

comment on column FA_FACTCLIE_&1..TEF_CLIENTE1 is
'Primer telefono de contacto del cliente';

comment on column FA_FACTCLIE_&1..TEF_CLIENTE2 is
'Segundo telefono de contacto del cliente';

comment on column FA_FACTCLIE_&1..DES_ACTIVIDAD is
'Actividad del Cliente';

comment on column FA_FACTCLIE_&1..NOM_CALLE is
'Nombre Calle';

comment on column FA_FACTCLIE_&1..NUM_CALLE is
'Numero Calle';

comment on column FA_FACTCLIE_&1..NUM_PISO is
'Numero de Piso';

comment on column FA_FACTCLIE_&1..DES_COMUNA is
'Descripcion Comuna';

comment on column FA_FACTCLIE_&1..DES_CIUDAD is
'Ciudad';

comment on column FA_FACTCLIE_&1..COD_PAIS is
'Codigo del pais del cliente';

comment on column FA_FACTCLIE_&1..COD_RUTADESP is
'Codigo de Ruta de Despacho';

comment on column FA_FACTCLIE_&1..IND_DEBITO is
'Indicador de Debito Automatico (No/Banco/Tarjeta)';

comment on column FA_FACTCLIE_&1..IMP_STOPDEBIT is
'Importe maximo para mandar debito automatico al banco o sobre tarjeta';

comment on column FA_FACTCLIE_&1..COD_BANCO is
'Codigo del banco del cliente';

comment on column FA_FACTCLIE_&1..COD_SUCURSAL is
'Codigo de la sucursal del banco del cliente';

comment on column FA_FACTCLIE_&1..IND_TIPCUENTA is
'Indicativo de Tipo de cuenta (C/A) Cuenta Corriente/Cuenta Ahorro';

comment on column FA_FACTCLIE_&1..COD_TIPTARJETA is
'Tipo de tarjeta de cliente';

comment on column FA_FACTCLIE_&1..NUM_CTACORR is
'Numero de la cuenta corriente del cliente';

comment on column FA_FACTCLIE_&1..NUM_TARJETA is
'Numero de la tarjeta del cliente';

comment on column FA_FACTCLIE_&1..FEC_VENCITARJ is
'Fecha de vencimiento de la tarjeta';

comment on column FA_FACTCLIE_&1..COD_BANCOTARJ is
'Codigo del baco de la tarjeta';

comment on column FA_FACTCLIE_&1..COD_TIPIDTRIB is
'Tipo de identificacion Tributaria';

comment on column FA_FACTCLIE_&1..NUM_IDENTTRIB is
'Numero de identificacion de la documentacion Tributaria';

comment on column FA_FACTCLIE_&1..NUM_FAX is
'Numero de FAX';

grant SELECT on FA_FACTCLIE_&1 to  SISCEL_SELECT;
grant DELETE on FA_FACTCLIE_&1 to  ops$xpfactur;
grant INSERT on FA_FACTCLIE_&1 to  ops$xpfactur;
grant SELECT on FA_FACTCLIE_&1 to  ops$xpfactur;
grant UPDATE on FA_FACTCLIE_&1 to  ops$xpfactur;

create public synonym FA_FACTCLIE_&1 for
      FA_FACTCLIE_&1;
spool off
exit;


