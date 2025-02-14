CREATE OR REPLACE PACKAGE FA_DCTO_CLTE_SB_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_DCTO_CLTE_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="19-02-2007"
          Versión="1.0"
          Diseñador=""
          Programador="Javier Garcia"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package busqueda actualizacion de segmento</Descripción>
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




   PROCEDURE FA_VALIDA_CLTE_EMPRESA_SB_PR (
                                  EN_Cod_cliente     IN  GA_INTARCEL.COD_CLIENTE%TYPE,
                                                                  SV_Cod_Plantarif   OUT NOCOPY TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                                              );

   PROCEDURE FA_OBTIENE_CARGO_BASICO_SB_PR (
                                  EV_Cod_cargobasico IN  TA_PLANTARIF.COD_CARGOBASICO%TYPE,
                                                                  SD_Fec_desdedcto   OUT NOCOPY DATE,
                                                                  SD_Fec_hastadcto   OUT NOCOPY DATE,
                                                                  SN_Imp_cargobasico OUT NOCOPY FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE,
                                                                  SV_Cod_moneda          OUT NOCOPY TA_CARGOSBASICO.COD_MONEDA%TYPE,
                                  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                                              );



   PROCEDURE FA_VALIDA_PLANTAR_BDINAM_SB_PR (
                                                                  EN_Cod_cliente     IN GA_INTARCEL.COD_CLIENTE%TYPE,
                                                                  EV_Cod_plantarif   IN TA_PLANTARIF.COD_PLANTARIF%TYPE,
                                                                  SV_Cod_cargoBasico OUT NOCOPY TA_PLANTARIF.COD_CARGOBASICO%TYPE,
                                                                  SN_Flg_rango       OUT NOCOPY TA_PLANTARIF.FLG_RANGO%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                                              );

   PROCEDURE FA_VALIDA_RANGO_FECHA_SB_PR (
                                  EN_Cod_cliente     IN GA_INTARCEL.COD_CLIENTE%TYPE,
                                                                  ED_Fec_desdedcto   IN DATE,
                                                                  ED_Fec_hastadcto   IN DATE,
                                                                  SN_Num_Registros   OUT NOCOPY NUMBER,
                                  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                                              );

    PROCEDURE FA_VALIDA_RANGO_FECHA_M_SB_PR (
                                  EN_Cod_cliente     IN GA_INTARCEL.COD_CLIENTE%TYPE,
                                                                  ER_Row_Id                      IN RowId,
                                                                  ED_Fec_desdedcto   IN DATE,
                                                                  ED_Fec_hastadcto   IN DATE,
                                                                  SN_Num_Registros   OUT NOCOPY NUMBER,
                                  SN_Cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento      OUT NOCOPY ge_errores_pg.evento
                                                              );



END FA_DCTO_CLTE_SB_PG;
/
SHOW ERRORS
