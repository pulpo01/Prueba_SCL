CREATE OR REPLACE PACKAGE BODY fa_mensajes_i_pg IS
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
    <Descripción>
             Prodedimiento que permite insertar registro en la tabla FA_MENSAJES>
    <Parámetros>
           <Entrada>
            <param nom="EN_CORRELATIVO" Tipo="NUMBER">correlativo mensaje</param>
            <param nom="EN_LINEAS" Tipo="NUMBER">Número de lineas</param>
            <param nom="EV_MENSAJE " Tipo="VARCHAR">descripción breve</param>
            <param nom="EV_MENSLIN " Tipo="varchar">descripción cargo</param>
            <param nom="EN_LINEASMEN " Tipo="NUMBER">linea del mensaje</param>
            <param nom="EN_CARACTLIN" Tipo="NUMBER">caracteres por linea</param>
            <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
            <param nom="SN_p_filasafectas" Tipo="NUMBER">Número de filas borradas</param>
            <param nom="SN_p_retornora"    Tipo="NUMBER">Código error oracle </param>
            <param nom="SN_p_nroevento"    Tipo="NUMBER">Número de evento</param>
            <param nom="SV_p_vcod_retorno" Tipo="VARCHAR">código retorno de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/
      lv_menslin        VARCHAR2 (200);
      lv_menslin_aux    VARCHAR2 (200);
      ln_lineas         fa_mensajes.num_linea%TYPE;
      lv_menslin_aux2   VARCHAR2 (255);
      ln_i              NUMBER (3);
      ln_f              NUMBER (3);
      ln_j              NUMBER (1);
      ln_x              NUMBER (2);
      LV_sql            ge_errores_pg.vquery;

   BEGIN
      lv_menslin_aux2 := ev_menslin;
      ln_i := 1;
      ln_f := 200;
      ln_j := 0;
      ln_x := 0;
      sn_p_filasafectas := SQL%ROWCOUNT;
      sn_p_retornora := SQLCODE;
      sv_p_vcod_retorno := cv_0;
      sn_p_nroevento := 0;
      ln_lineas      := en_lineas;
      lv_menslin     := NVL (SUBSTR (lv_menslin_aux2, ln_i, ln_f), ' ');
      lv_menslin_aux := NVL (SUBSTR (lv_menslin_aux2, 201, 55), ' ');

      WHILE ln_j < 1 AND lv_menslin_aux2 <> ' ' LOOP
         IF lv_menslin = ' ' AND lv_menslin_aux = ' ' THEN
            lv_menslin := lv_menslin_aux2;
            ln_j := 1;
         END IF;

         IF lv_menslin <> ' ' AND lv_menslin_aux = ' ' THEN
            ln_j := 1;
         END IF;

         IF lv_menslin = ' ' AND lv_menslin_aux <> ' ' THEN
            ln_j := 1;
            lv_menslin := lv_menslin_aux;
         END IF;

         LV_sql:= 'INSERT INTO fa_mensajes'
               || '(corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)'
               || ' VALUES (' || en_correlativo ||',''' || ln_lineas ||''','''|| ev_mensaje ||''','''|| lv_menslin ||''',' || ev_idioma || ',' ||en_lineasmen || ',' || en_caractlin || ')';

         INSERT INTO fa_mensajes
                     (corr_mensaje, num_linea, desc_mensaje, desc_menslin, cod_idioma, cant_lineasmen, cant_caractlin)
         VALUES      (en_correlativo, ln_lineas, ev_mensaje, lv_menslin, ev_idioma, en_lineasmen, en_caractlin);

         ln_lineas := ln_lineas + 1;
         ln_i := 201;
         ln_f := 55;
         ln_x := ln_x + 1;

         IF (ln_x = 2) THEN
            ln_j := 2;
         END IF;

         lv_menslin := lv_menslin_aux;
         sn_p_filasafectas := SQL%ROWCOUNT;
         sn_p_retornora    := SQLCODE;
         sv_p_vcod_retorno := cv_0;
         sn_p_nroevento    := 0;
      END LOOP;

   EXCEPTION
      WHEN OTHERS THEN

         sn_p_nroevento    := ge_errores_pg.grabarpl (cn_0, ev_cod_prog, cv_des_error_v1, cv_version, USER, cv_procedure1, NULL, SQLCODE, SQLERRM);
         lv_v_verror       := SUBSTR (cv_des_error_v1 || SQLERRM, 1, 255);
         sn_p_retornora    := SQLCODE;
         sv_p_vcod_retorno := cv_4;

   END pv_agregar_pr;
END fa_mensajes_i_pg;
/

SHOW ERRORS