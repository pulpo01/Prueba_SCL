CREATE OR REPLACE PACKAGE GA_VENTAS_SB_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GA_VENTAS_SB_PG"
          Lenguaje="PL/SQL"
          Fecha="02-05-2007"
          Versión="1.0"
          Diseñador= "Raúl Lozano "
                  Programador="Raúl Lozano"
          Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Package servicios base para Ventas</Descripción>
      <Parámetros>
         <Entrada>NA</Entrada>
         <Salida>NA</Salida>
      </Parámetros>
</Elemento>
</Documentación>
*/
IS
   TYPE refcursor IS REF CURSOR;
   CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
   CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'GA';
   CV_version              CONSTANT VARCHAR2 (2)  := '1';
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE GA_INSERT_VENTA_PR (
      SO_VENTAS                            IN OUT NOCOPY        VE_TIPOS_PG.TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE GA_UPDATE_VENTA_ESCA_PR (
      SO_VENTAS                            IN OUT NOCOPY        VE_TIPOS_PG.TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE GA_UPDATE_VENTA_ESCB_PR (
      SO_VENTAS                            IN OUT NOCOPY        VE_TIPOS_PG.TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE GA_UPDATE_VENTA_ESCC_PR (
      SO_VENTAS                            IN OUT NOCOPY        VE_TIPOS_PG.TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE GA_UPDATE_VENTA_ESCD_PR (
      SO_VENTAS                            IN OUT NOCOPY        VE_TIPOS_PG.TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    PROCEDURE GA_UPDATE_VENTA_PR (
      SO_VENTAS                    IN OUT NOCOPY        VE_TIPOS_PG. TIP_GA_VENTAS,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE GA_UPD_SITVENTA_PR (
      EN_NUM_VENTA             IN  GA_VENTAS.NUM_VENTA%TYPE,
      EV_COD_SITUACION         IN  GA_VENTAS.IND_ESTVENTA%TYPE,
      EN_IMP_VENTA             IN  GA_VENTAS.IMP_VENTA%TYPE,      
      EV_NOM_USUARIO           IN  GA_VENTAS.NOM_USUAR_VTA%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
PROCEDURE GA_UPD_MODVENTA_PR (
      EN_NUM_VENTA             IN  GA_VENTAS.NUM_VENTA%TYPE,
      EN_COD_MODVENTA          IN  GA_VENTAS.COD_MODVENTA%TYPE, 
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);      
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------      
END GA_VENTAS_SB_PG; 
/
SHOW ERRORS
