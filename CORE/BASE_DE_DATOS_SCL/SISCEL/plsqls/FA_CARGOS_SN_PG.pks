CREATE OR REPLACE PACKAGE Fa_Cargos_Sn_Pg
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_CARGOS_SN_PG"
          Lenguaje="PL/SQL"
          Fecha="30-07-2007"
          Versión="1.0"
          Diseñador=""
          Programador="rao"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Servicios de negocio para cargos ocacionales</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS

    cv_error_no_clasif      VARCHAR2 (50) := 'No es posible clasificar el error';
    cv_cod_modulo           VARCHAR2 (2)  := 'FA';
    cv_version              VARCHAR2 (2)  := '1';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_CARGOS_ALTA_PR (REGISTRO        IN   FA_CARGOS_QT,
                         SN_cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                         SV_mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                         SN_num_evento       OUT NOCOPY ge_errores_pg.evento) ;


PROCEDURE FA_CARGOS_BAJA_PR (REGISTRO        IN   FA_CARGOS_QT,
                          SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                          SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                          SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                          );

PROCEDURE FA_CARGOS_INFACCEL_PR (EN_cod_cliente   IN GA_ABOCEL.cod_cliente%TYPE,
                                 EN_num_abonado   IN GA_ABOCEL.num_abonado%TYPE,
                                 EN_COD_CICLFACT  IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                 SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                 SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                 SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                          );

END Fa_Cargos_Sn_Pg;
/
SHOW ERRORS