CREATE OR REPLACE PACKAGE FA_PRESUPUESTO_SN_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_PRESUPUESTO_SN_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versión="1.0"
          Diseñador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Servicios de negocio para presupuestos</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/

-- v1.1 COL 77754|12-02-2009|SAQL

IS

    cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
    cv_cod_modulo           VARCHAR2 (2)  := 'FA';
    cv_version              VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE FA_PRESUPUESTO_BORRA_PR (REGISTRO        IN OUT NOCOPY FA_PRESUPUESTO_QT,
                          SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                          SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                          SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                          );

-- INI COL 77754|12-02-2009|SAQL
PROCEDURE FA_VALIDA_ELIM_PRES_PR(
   FA_PRESUP_NUM_PROC   IN    FA_PRESUPUESTO.NUM_PROCESO%TYPE,
   FA_PRESUP_NUM_VTA    IN    FA_PRESUPUESTO.NUM_VENTA%TYPE,
   SN_cod_retorno       OUT   NOCOPY ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno      OUT   NOCOPY ge_errores_td.det_msgerror%TYPE,
   SN_num_evento        OUT   NOCOPY ge_errores_pg.evento
);
-- FIN  COL 77754|12-02-2009|SAQL

END FA_PRESUPUESTO_SN_PG;
/
SHOW ERRORS
