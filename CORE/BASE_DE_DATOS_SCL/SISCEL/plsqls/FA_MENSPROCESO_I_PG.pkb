CREATE OR REPLACE PACKAGE BODY fa_mensproceso_i_pg IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "FA_MENSPROCESO_I_PG"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Orlando Cabezas"
    Programador="Orlando Cabezas"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package de persistencia de la tabla FA_MENSPROCESO
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
   PROCEDURE pv_agregar_pr (
      en_num_proceso      IN              fa_mensproceso.num_proceso%TYPE,
      en_cod_formul       IN              fa_mensproceso.cod_formulario%TYPE,
      en_cod_bloque       IN              fa_mensproceso.cod_bloque%TYPE,
      en_correlativo      IN              fa_mensproceso.corr_mensaje%TYPE,
      en_lineas           IN              fa_mensproceso.num_lineas%TYPE,
      ev_cod_orig         IN              fa_mensproceso.cod_origen%TYPE,
      ev_texto            IN              fa_mensproceso.desc_mensaje%TYPE,
      ev_ind_factur       IN              fa_mensproceso.ind_facturado%TYPE,
      ev_cod_prog         IN              VARCHAR2,
      sn_p_filasafectas   OUT NOCOPY      NUMBER,
      sn_p_retornora      OUT NOCOPY      NUMBER,
      sn_p_nroevento      OUT NOCOPY      NUMBER,
      sv_p_vcod_retorno   OUT NOCOPY      VARCHAR2) IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "PV_AGREGAR_PR"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Orlando Cabezas"
    Programador="Orlando Cabezas"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Prodedimiento que permite insertar registro en la tabla FA_MENSPROCESO>
    <Parámetros>
       <Entrada>
            <param nom="EN_NUM_PROCESO" Tipo="NUMBER">Número de proceso</param>
            <param nom="EN_COD_FORMUL" Tipo="NUMBER">codigo formulario</param>
         <param nom="EN_COD_BLOQUE" Tipo="NUMBER">codigo de  bloque</param>
         <param nom="EN_CORRELATIVO" Tipo="NUMBER">correlativo mensaje</param>
            <param nom="EN_LINEAS" Tipo="NUMBER">Número de lineas</param>
         <param nom="EV_COD_ORIG" Tipo="VARCHAR">codigo origen</param>
         <param nom="EV_TEXTO" Tipo="VARCHAR">texto cargo</param>
            <param nom="EV_IND_FACTUR" Tipo="VARCHAR">indicador de facturacion</param>
         <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
      </Entrada>
      <Salida>
         <param nom="SN_p_filasafectas" Tipo="NUMBER">Número de filas borradas</param>
         <param nom="SN_p_retornora" Tipo="NUMBER">Código error oracle </param>
         <param nom="SN_p_nroevento" Tipo="NUMBER">Número de evento</param>
         <param nom="SV_p_vcod_retorno" Tipo="VARCHAR">código retorno de error</param>
      </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
   BEGIN
      INSERT INTO fa_mensproceso
                  (num_proceso, cod_formulario, cod_bloque, corr_mensaje, num_lineas, cod_origen, desc_mensaje, ind_facturado, nom_usuario, fec_ingreso)
      VALUES      (en_num_proceso, en_cod_formul, en_cod_bloque, en_correlativo, en_lineas, ev_cod_orig, ev_texto, ev_ind_factur, USER, SYSDATE);

      sn_p_filasafectas := SQL%ROWCOUNT;
      sn_p_retornora := SQLCODE;
      sv_p_vcod_retorno := cv_0;
      sn_p_nroevento := 0;
   EXCEPTION
      WHEN OTHERS THEN
         sn_p_nroevento := ge_errores_pg.grabarpl (cn_0, ev_cod_prog, cv_des_error_v1, cv_version, USER, cv_procedure1, NULL, SQLCODE, SQLERRM);
         lv_v_verror := SUBSTR (cv_des_error_v1 || SQLERRM, 1, 255);
         sn_p_retornora := SQLCODE;
         sv_p_vcod_retorno := cv_4;
   END pv_agregar_pr;
END fa_mensproceso_i_pg;
/

SHOW ERRORS