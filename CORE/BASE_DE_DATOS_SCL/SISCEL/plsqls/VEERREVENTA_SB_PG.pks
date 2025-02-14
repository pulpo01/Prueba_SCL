CREATE OR REPLACE PACKAGE VE_CIERREVENTA_SB_PG
/*
<Documentación TipoDoc = "Package">
   <Elemento Nombre = "GA_sbas_cuenta_PG"
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
        PROCEDURE VE_CODIGO_PROCS_VENTA_PR (
      SO_MATRIZESTADOS             IN OUT NOCOPY        VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE VE_CODIGO_ESTFINAL_VENTA_PR (
      SO_MATRIZESTADOS             IN OUT NOCOPY        VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD,
          Fec_Venta                                IN                           VE_MATRIZESTADOS_TD.FEC_DESDE%TYPE,
      SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        PROCEDURE VE_NUM_UNIDADES_VENTA_PR (
      SO_ABOCEL                            IN OUT                       VE_TIPOS_PG.TIP_GA_ABOCEL,
          NUM_UNIDADES                     OUT NOCOPY           GA_ABOCEL.NUM_VENTA%TYPE,
          SN_cod_retorno           OUT NOCOPY       ge_errores_td.cod_msgerror%TYPE,
      SV_mens_retorno          OUT NOCOPY       ge_errores_td.det_msgerror%TYPE,
      SN_num_evento            OUT NOCOPY               ge_errores_pg.evento);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


END VE_CIERREVENTA_SB_PG; 
/
SHOW ERRORS
