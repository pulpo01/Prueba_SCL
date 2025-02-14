CREATE OR REPLACE PACKAGE FA_DCTO_CLTE_SN_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "FA_DCTO_CLTE_SN_PG"
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




   PROCEDURE FA_INS_DCTO_CLTE_BLSDINAM_PR (
                                                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  EN_Cod_cargobasico             IN FA_DCTOS_SERV_REC_TD.COD_CARGOBASICO%TYPE,
                                                                  EV_cod_plantarif                       IN FA_DCTOS_SERV_REC_TD.COD_PLANTARIF%TYPE,
                                                                  EN_Mto_descuento               IN FA_DCTOS_SERV_REC_TD.IMP_DESCUENTO%TYPE,
                                                                  ED_Fec_desdedcto                       IN FA_DCTOS_SERV_REC_TD.FEC_DESDEDCTO%TYPE,
                                                                  ED_Fec_hastadcto                       IN FA_DCTOS_SERV_REC_TD.FEC_HASTADCTO%TYPE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              );

   PROCEDURE FA_MODIF_DCTO_CLTE_BLSDINAM_PR (
                                  EN_Cod_cliente                         IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_vigencia                        IN DATE,
                                                                  ED_Fec_desdedcto_new           IN FA_DCTOS_SERV_REC_TD.FEC_DESDEDCTO%TYPE,
                                                                  ED_Fec_hastadcto_new           IN FA_DCTOS_SERV_REC_TD.FEC_HASTADCTO%TYPE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              );

   PROCEDURE FA_BORRA_DCTO_CLTE_BLSDINAM_PR (
                                                                  EN_Cod_cliente                         IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_cierre_Vigencia         IN DATE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              );

   PROCEDURE FA_CONS_DCTO_CLTE_BLSDINAM_PR (
                                                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_valida_vigencia     IN DATE,
                                                                  SV_Cod_plantarif                   OUT NOCOPY FA_DCTOS_SERV_REC_TD.COD_PLANTARIF%TYPE,
                                                                  SN_Imp_descuento                   OUT NOCOPY FA_DCTOS_SERV_REC_TD.IMP_DESCUENTO%TYPE,
                                                                  SD_Fec_desdedcto           OUT NOCOPY FA_DCTOS_SERV_REC_TD.FEC_DESDEDCTO%TYPE,
                                                                  SD_Fec_hastadcto                   OUT NOCOPY FA_DCTOS_SERV_REC_TD.FEC_HASTADCTO%TYPE,
                                  SN_Cod_retorno             OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno            OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento              OUT NOCOPY ge_errores_pg.evento
                                                              );

        PROCEDURE FA_CONS_CARGO_BASICO_CLTE (
                                                                  EN_Cod_cliente             IN FA_DCTOS_SERV_REC_TD.COD_CLIENTE%TYPE,
                                                                  ED_Fec_valida_vigencia         IN DATE,
                                                                  SN_Imp_CargoBasico             OUT NOCOPY FA_DCTOS_SERV_REC_TD.IMP_CARGO_BASICO%TYPE,
                                  SN_Cod_retorno                 OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_Mens_retorno                OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_Num_evento                  OUT NOCOPY ge_errores_pg.evento
                                                              );


END FA_DCTO_CLTE_SN_PG;
/
SHOW ERRORS
