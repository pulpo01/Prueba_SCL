WHENEVER SQLERROR EXIT 1
set echo off verify off
spool $WORKDIR/tab_FA_DETDCTOCLIELOC_&1.log

prompt Table  FA_DETDCTOCLIELOC_&1

CREATE TABLE FA_DETDCTOCLIELOC_&1
(
  COD_CLIENTE    NUMBER(8)   NOT NULL,
  COD_CICLO 	 NUMBER(2)   NOT NULL,
  COD_PLANDESC 	 VARCHAR2(5) NOT NULL,
  NUM_SECUENCIA  NUMBER(8)   NOT NULL,
  COD_GRUPOAPLI  NUMBER(6)   NOT NULL,
  NUM_CUADRANTE  NUMBER(6)   NOT NULL,
  VALOR_DCTO     NUMBER      NOT NULL,
  TIP_DCTO       VARCHAR2(2) NOT NULL,
  TIP_ENTIDAD    VARCHAR2(5) NOT NULL
)
TABLESPACE FACTURACION_CICLOS_TTAB
PCTUSED    60
PCTFREE    5
INITRANS   4
MAXTRANS   255
LOGGING 
NOCACHE
NOPARALLEL;


COMMENT ON TABLE FA_DETDCTOCLIELOC_&1 IS 'Tabla de Evaluacion de Descuento de Clientes Locutorios.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..COD_CLIENTE IS 'C�digo de cliente.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..COD_CICLO IS 'C�digo de ciclo del cliente.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..COD_PLANDESC IS 'C�digo del plan de descuento.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..NUM_SECUENCIA IS 'Numero de secuencia.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..COD_GRUPOAPLI IS 'C�digo de grupo aplicado.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..NUM_CUADRANTE IS 'Numero de cuadrante.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..VALOR_DCTO IS 'Valor de descuento.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..TIP_DCTO IS 'Tipo de descuento.';

COMMENT ON COLUMN FA_DETDCTOCLIELOC_&1..TIP_ENTIDAD IS 'Tipo de Entidad.';


CREATE UNIQUE INDEX FA_DELOC_&1._PK ON FA_DETDCTOCLIELOC_&1
(COD_CLIENTE, COD_CICLO, COD_PLANDESC)
LOGGING
TABLESPACE FACTURACION_CICLOS_TIND
PCTFREE    5
INITRANS   8
MAXTRANS   255
NOPARALLEL;

ALTER TABLE FA_DETDCTOCLIELOC_&1 ADD (
  CONSTRAINT FA_DELOC_&1._PK PRIMARY KEY (COD_CLIENTE, COD_CICLO, COD_PLANDESC)
    USING INDEX 
    TABLESPACE FACTURACION_CICLOS_TIND
    PCTFREE    5
    INITRANS   8
    MAXTRANS   255);

GRANT SELECT ON FA_DETDCTOCLIELOC_&1 TO SISCEL_SELECT;
GRANT DELETE ON FA_DETDCTOCLIELOC_&1 TO  ops$xpfactur;
GRANT INSERT ON FA_DETDCTOCLIELOC_&1 TO  ops$xpfactur;
GRANT SELECT ON FA_DETDCTOCLIELOC_&1 TO  ops$xpfactur;
GRANT UPDATE ON FA_DETDCTOCLIELOC_&1 TO  ops$xpfactur;

CREATE PUBLIC SYNONYM FA_DETDCTOCLIELOC_&1 FOR FA_DETDCTOCLIELOC_&1;

spool off

exit;

--******************************************************************************************
--** Informaci�n de Versionado *************************************************************
--******************************************************************************************
--** Pieza                                               : 
--**  %ARCHIVE%
--** Identificador en PVCS                               : 
--**  %PID%
--** Producto                                            : 
--**  %PP%
--** Revisi�n                                            : 
--**  %PR%
--** Autor de la Revisi�n                                :          
--**  %AUTHOR%
--** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : 
--**  %PS%
--** Fecha de Creaci�n de la Revisi�n                    : 
--**  %DATE% 
--** Worksets ******************************************************************************
--** %PIRW%
--** Historia ******************************************************************************
--** %PL%
--******************************************************************************************
