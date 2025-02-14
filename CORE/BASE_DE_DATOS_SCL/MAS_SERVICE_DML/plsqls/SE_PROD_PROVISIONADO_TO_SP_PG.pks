CREATE OR REPLACE PACKAGE SE_PROD_PROVISIONADO_TO_SP_PG
IS
/*
<Documentación
   TipoDoc = "PACKAGE">
   <Elemento
      Nombre = "IC_DETALLEMOVIMIENTO_TO_SP_PG"
   Lenguaje="PL/SQL"
   Fecha creación="11-05-2010"
   Creado por="Carlos Sellao H."
   Fecha modificacion=""
   Modificado por=""
   Ambiente Desarrollo="BD">
   <Retorno>N/A</Retorno>
   <Descripción>Rutinas para tabla IC_DETALLEMOVIMIENTO_TO </Descripción>
   <Parámetros>
      <Entrada>N/A</Entrada>
   <Salida>N/A</Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
    CV_error_no_clasif CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
    CN_Err_Abo CONSTANT NUMBER(3) := 203;
    CN_Err_Cli CONSTANT NUMBER(3) := 149;
    CN_Err_Usuario CONSTANT NUMBER(7) := 300008;
    CN_Err_Cel CONSTANT NUMBER(3) := 480;
    CV_cod_modulo CONSTANT VARCHAR2 (2)  := 'SE';
    CV_version CONSTANT VARCHAR2 (3)  := '1.0';

PROCEDURE SE_PROD_OFER_PR ( EN_NUM_ABONADO IN icc_movimiento.num_abonado%TYPE,
                            EN_COD_PROD_CONTRATADO IN icc_movimiento.cod_prod_contratado%TYPE,
                            SN_COD_PROD_OFER  OUT pr_productos_contratados_to.cod_prod_ofertado%TYPE,
                            SV_DES_PROD_OFER  OUT pf_productos_ofertados_td.des_prod_ofertado%TYPE,
                            SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                            SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                            SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento );

PROCEDURE SE_GRABA_PA_PR ( EN_NUM_ABONADO IN icc_movimiento.num_abonado%TYPE,
                           EN_COD_PROD_CONTRATADO IN icc_movimiento.cod_prod_contratado%TYPE,
                           EN_COD_ESPEC_PROV IN se_espec_provisionamiento_td.cod_espec_prov%TYPE,
                           SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                           SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                           SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento );
                           
PROCEDURE SE_BORRA_PA_PR ( EN_NUM_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE);

PROCEDURE SE_ESTADOACTIVO_PA_PR ( EN_NUM_MOVIMIENTO IN icc_movimiento.num_movimiento%TYPE);

PROCEDURE SE_APROVISIONA_PA_PR ( EN_NUM_ABONADO    IN icc_movimiento.num_abonado%TYPE,
                              EN_cod_prod_cont  IN se_prod_provisionado_to.cod_prod_contratado%TYPE,
                              SN_cod_prod_ofer  OUT se_prod_provisionado_to.cod_prod_ofertado%TYPE,
                              SV_des_prod_ofer  OUT se_prod_provisionado_to.des_prod_ofertado%TYPE,
                              SN_COD_RETORNO  OUT NOCOPY  ge_errores_pg.CodError,
                              SV_MENS_RETORNO OUT NOCOPY  ge_errores_pg.MsgError,
                              SN_NUM_EVENTO   OUT NOCOPY  ge_errores_pg.evento );
                              
END SE_PROD_PROVISIONADO_TO_SP_PG;
/
SHOW ERRORS