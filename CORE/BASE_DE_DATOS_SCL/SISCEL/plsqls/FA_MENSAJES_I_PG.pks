CREATE OR REPLACE PACKAGE fa_mensajes_i_pg IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "FA_MENSAJES_I_PG"
    Lenguaje="PL/SQL"
    Fecha="14-12-2006"
    Versión="1.0"
    Diseñador="Orlando Cabezas"
    Programador="Orlando Cabezas"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package de persistencia de la tabla FA_MENSAJES
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/
   cv_version        CONSTANT VARCHAR2 (3)   := '1.0';
   cv_procedure1     CONSTANT VARCHAR2 (100) := 'FA_MENSAJES_I_PG.PV_AGREGAR_PR';
   cv_0              CONSTANT VARCHAR2 (1)   := '0';
   cv_4              CONSTANT VARCHAR2 (1)   := '4';
   cn_0              CONSTANT NUMBER (1)     := 0;
   cv_des_error_v1   CONSTANT VARCHAR2 (100) := 'Error el insertar registro en la tabla FA_MENSAJES.';
   lv_v_verror                VARCHAR2 (255);
   cn_20010          CONSTANT NUMBER (6)     := -20010;

   PROCEDURE pv_agregar_pr (
      en_correlativo      IN              fa_mensajes.corr_mensaje%TYPE,
      en_lineas           IN              fa_mensajes.num_linea%TYPE,
      ev_mensaje          IN              fa_mensajes.desc_mensaje%TYPE,
      ev_menslin          IN              ga_abocel.clase_servicio%TYPE,
      ev_idioma           IN              fa_mensajes.cod_idioma%TYPE,
      en_lineasmen        IN              fa_mensajes.cant_lineasmen%TYPE,
      en_caractlin        IN              fa_mensajes.cant_caractlin%TYPE,
      ev_cod_prog         IN              VARCHAR2,
      sn_p_filasafectas   OUT NOCOPY      NUMBER,
      sn_p_retornora      OUT NOCOPY      NUMBER,
      sn_p_nroevento      OUT NOCOPY      NUMBER,
      sv_p_vcod_retorno   OUT NOCOPY      VARCHAR2);
END fa_mensajes_i_pg;
/

SHOW ERRORS