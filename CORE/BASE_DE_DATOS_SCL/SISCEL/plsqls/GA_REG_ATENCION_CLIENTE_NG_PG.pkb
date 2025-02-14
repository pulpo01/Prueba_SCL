CREATE OR REPLACE PACKAGE BODY ga_reg_atencion_cliente_ng_pg

AS

   EXC_VALOR_CELULAR     EXCEPTION;
   EXC_NUMERACION        EXCEPTION;
   EXC_PARAMETRO_CELULAR EXCEPTION;
   GV_error_no_clasif    VARCHAR2(50):= 'No es posible clasificar el error';
   GV_cod_vigencia       VARCHAR2(2) := 'V';

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_usuario_fn (
   EV_nom_usuario   IN             ci_reg_atencion_clientes.nom_usuarora%TYPE,
   SN_cod_retorno   OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_USUARIO_FN"
      Fecha creación="01-04-2005"
      Creado por="Maritza Tapia A
      Fecha modificación=" "
      Modificado por=" "
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que el usario se valido en SCL</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_nom_usuario" Tipo="Varchar">Nombre del usuario</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   LV_sSql            ge_errores_pg.vQuery;
   LL_des_error    ge_errores_pg.DesEvent;
   LV_nom_usuario  ci_reg_atencion_clientes.nom_usuarora%TYPE;
BEGIN

   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   LV_sSql := 'SELECT segus.nom_usuario ';
   LV_sSql := LV_sSql || ' INTO LV_nom_usuario';
   LV_sSql := LV_sSql || ' FROM ge_seg_usuario segus';
   LV_sSql := LV_sSql || ' WHERE segus.nom_usuario =' || EV_nom_usuario ;

   SELECT segus.nom_usuario
      INTO LV_nom_usuario
      FROM ge_seg_usuario segus
   WHERE segus.nom_usuario = EV_nom_usuario;
   RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         SN_cod_retorno := 172;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
         END IF;
         LL_des_error := 'ga_valida_usuario_fn('||EV_nom_usuario||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_valida_usuario_fn', LV_sSql, SQLCODE, LL_des_error );
         RETURN FALSE;

      WHEN OTHERS THEN
         SN_cod_retorno := 156;
         IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
            SV_mens_retorno := GV_error_no_clasif;
         END IF;
         LL_des_error := 'ga_valida_usuario_fn('||EV_nom_usuario||'); - ' || SQLERRM;
         SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_valida_usuario_fn', LV_sSql, SQLCODE, LL_des_error );
         RETURN FALSE;

END ga_valida_usuario_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_cod_atencion_fn (
   EN_cod_atencion  IN             ci_reg_atencion_clientes.cod_atencion%TYPE,
   SN_cod_retorno   OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_COD_ATENCION_FN"
      Fecha creación="01-04-2005"
      Creado por="Maritza Tapia A
      Fecha modificación=" "
      Modificado por=" "
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que el usario se valido en SCL</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_cod_atencion" Tipo="Numerico">codigo de atencion</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   LV_sSql            ge_errores_pg.vQuery;
   LL_des_error    ge_errores_pg.DesEvent;
   LN_cod_atencion ci_reg_atencion_clientes.cod_atencion%TYPE;
BEGIN

   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   LV_sSql := 'SELECT atenc.cod_atencion';
   LV_sSql := LV_sSql || ' INTO LN_cod_atencion';
   LV_sSql := LV_sSql || ' FROM ci_atencion_clientes atenc';
   LV_sSql := LV_sSql || ' WHERE atenc.ind_vigente = '|| GV_cod_vigencia;
   LV_sSql := LV_sSql || ' AND atenc.cod_atencion = '|| EN_cod_atencion;

   SELECT atenc.cod_atencion
     INTO LN_cod_atencion
     FROM ci_atencion_clientes atenc
   WHERE atenc.ind_vigente = GV_cod_vigencia
     AND atenc.cod_atencion = EN_cod_atencion;

   RETURN TRUE;

   EXCEPTION

   WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 175;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_valida_cod_atencion_fn('||EN_cod_atencion||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_valida_cod_atencion_fn', LV_sSql, SQLCODE, LL_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_valida_cod_atencion_fn('||EN_cod_atencion||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_valida_cod_atencion_fn', LV_sSql, SQLCODE, LL_des_error );
      RETURN FALSE;

END ga_valida_cod_atencion_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
FUNCTION ga_valida_cod_oficina_fn (
   EV_cod_oficina   IN             ci_reg_atencion_clientes.cod_oficina%TYPE,
   SN_cod_retorno   OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno  OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
   SN_num_evento    OUT NOCOPY     ge_errores_pg.Evento
)
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "GA_VALIDA_COD_OFICINA_FN"
      Fecha creación="01-04-2005"
      Creado por="Maritza Tapia A
      Fecha modificación=" "
      Modificado por=" "
      Ambiente Desarrollo="BD">
      <Retorno>BOOLEAN</Retorno>
      <Descripción>Valida que el usario se valido en SCL</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_cod_oficina" Tipo="VARCHAR">codigo de oficina </param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
RETURN BOOLEAN
AS
   LV_sSql                    ge_errores_pg.vQuery;
   LL_des_error            ge_errores_pg.DesEvent;
   LN_cod_oficina          ci_reg_atencion_clientes.cod_oficina%TYPE;
BEGIN

   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   LV_sSql := 'SELECT COUNT(1) ';
   LV_sSql := LV_sSql || ' INTO LN_ncanofic';
   LV_sSql := LV_sSql || ' FROM ge_oficinas ofic';
   LV_sSql := LV_sSql || ' WHERE ofic.cod_oficina =' ||EV_cod_oficina ;

   SELECT ofic.cod_oficina
     INTO LN_cod_oficina
     FROM ge_oficinas ofic
   WHERE ofic.cod_oficina = EV_cod_oficina;

   RETURN TRUE;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
      SN_cod_retorno := 173;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_valida_cod_oficina_fn('||EV_cod_oficina||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_valida_cod_oficina_fn', LV_sSql, SQLCODE, LL_des_error );
      RETURN FALSE;

   WHEN OTHERS THEN
      SN_cod_retorno := 156;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_valida_cod_oficina_fn('||EV_cod_oficina||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_valida_cod_oficina_fn', LV_sSql, SQLCODE, LL_des_error );
      RETURN FALSE;

END ga_valida_cod_oficina_fn;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ga_inserta_reg_atencion_pr (
   EN_num_celular      IN             ga_abocel.num_celular%TYPE,
   EN_cod_atencion     IN             ci_reg_atencion_clientes.cod_atencion%TYPE,
   EV_obs_atencion     IN             ci_reg_atencion_clientes.obs_atencion%TYPE,
   EV_nom_usuario      IN             ci_reg_atencion_clientes.nom_usuarora%TYPE,
   EV_cod_oficina      IN             ci_reg_atencion_clientes.cod_oficina%TYPE,
   SN_cod_retorno      OUT NOCOPY     ge_errores_td.cod_msgerror%TYPE,
   SV_mens_retorno     OUT NOCOPY     ge_errores_td.det_msgerror%TYPE,
   SN_num_evento       OUT NOCOPY     ge_errores_pg.evento
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "GA_INSERTA_REG_ATENCION_PG"
      Lenguaje="PL/SQL"
      Fecha creacion="31-03-2005"
      Creado por="Maritza Tapia"
      Fecha modificacion=""
      Modificado por=""
      <Retorno>NA</Retorno>
      <Descripción>Inserta un registro a la tabla CI_REG_ATENCION_CLIENTE</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular" Tipo="NUMERICO">Numero de celular</param>
            <param nom="EN_cod_atencion" Tipo="NUMERICO">Codigo de atencion al cliente</param>
            <param nom="EV_obs_atencion" Tipo="CARACTER">Observacion optativa de la atencion</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre del usuario Oracle</param>
            <param nom="EV_cod_oficina" Tipo="CARACTER">Codigo de oficina</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"     Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SV_mens_retorno"    Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
   PRAGMA AUTONOMOUS_TRANSACTION;
   error_ejecucion          EXCEPTION;
   error_parametro_celular  EXCEPTION;
   error_parametro_atencion EXCEPTION;
   error_parametro_usuario  EXCEPTION;
   error_parametro_oficina  EXCEPTION;
   error_abonado            EXCEPTION;
   LV_cod_oficina           ci_reg_atencion_clientes.cod_oficina%TYPE;
   LN_NumAbonado            ga_abocel.num_abonado%TYPE;
   LN_num_atencion          ci_reg_atencion_clientes.num_atencion%TYPE;
   LL_des_error             ge_errores_pg.DesEvent;
   LV_sSql                  ge_errores_pg.vQuery;

BEGIN

   SV_mens_retorno := '';
   SN_cod_retorno  := 0;
   SN_num_evento   := 0;

   IF EN_num_celular IS NULL THEN
         RAISE error_parametro_celular;
   END IF;

   IF EN_cod_atencion  IS NULL THEN
         RAISE error_parametro_atencion;
   END IF;

   IF EV_nom_usuario  IS NULL THEN
         RAISE error_parametro_usuario;
   END IF;

   IF EV_cod_oficina  IS NULL THEN
         RAISE error_parametro_oficina;
   END IF;

   IF NOT ga_segmentacion_pg.ga_valida_existabonado_fn (EN_num_celular, LN_NumAbonado, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT ga_valida_usuario_fn (EV_nom_usuario , SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT ga_valida_cod_atencion_fn (EN_cod_atencion, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   IF NOT ga_valida_cod_oficina_fn (EV_cod_oficina, SN_cod_retorno, SV_mens_retorno, SN_num_evento) THEN
      RAISE error_ejecucion;
   END IF;

   LV_sSql := 'SELECT CI_SEQ_NUMATTECLI.NEXTVAL INTO LN_num_atencion FROM DUAL';

   SELECT CI_SEQ_NUMATTECLI.NEXTVAL
     INTO LN_num_atencion
     FROM DUAL;

   LV_sSql := 'INSERT INTO CI_REG_ATENCION_CLIENTES'
           || ' (fec_inicio,  fec_termino, nom_usuarora, num_abonado, cod_atencion, obs_atencion, num_atencion, cod_oficina )'
           || ' VALUES ('||sysdate ||', '||sysdate||', '||EV_nom_usuario||' ,'||LN_NumAbonado||', '||EN_cod_atencion||', '||EV_obs_atencion||' ,'||LN_num_atencion||', '||EV_cod_oficina;

   INSERT INTO CI_REG_ATENCION_CLIENTES
   (fec_inicio,  fec_termino, nom_usuarora, num_abonado, cod_atencion, obs_atencion, num_atencion, cod_oficina )
   VALUES ( sysdate, sysdate, EV_nom_usuario, LN_NumAbonado, EN_cod_atencion, EV_obs_atencion, LN_num_atencion, EV_cod_oficina );

   COMMIT;

EXCEPTION
   WHEN error_parametro_celular THEN
      SN_cod_retorno := 142;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_inserta_reg_atencion_pr('||EN_num_celular||', '||EV_obs_atencion||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_inserta_reg_atencion_pr', LV_sSql, SQLCODE, LL_des_error );
      ROLLBACK;

   WHEN error_parametro_atencion THEN
      SN_cod_retorno := 175;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_inserta_reg_atencion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_inserta_reg_atencion_pr', LV_sSql, SQLCODE, LL_des_error );
      ROLLBACK;

   WHEN error_parametro_usuario THEN
      SN_cod_retorno := 172;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_inserta_reg_atencion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_inserta_reg_atencion_pr', LV_sSql, SQLCODE, LL_des_error );
      ROLLBACK;

   WHEN error_parametro_oficina  THEN
      SN_cod_retorno := 173;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_inserta_reg_atencion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_inserta_reg_atencion_pr', LV_sSql, SQLCODE, LL_des_error );
      ROLLBACK;

   WHEN error_ejecucion  THEN
      LL_des_error := 'ga_inserta_reg_atencion_pr('||EN_num_celular||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_inserta_reg_atencion_pr', LV_sSql, SQLCODE, LL_des_error );
      ROLLBACK;

   WHEN OTHERS THEN
      SN_cod_retorno := 174;
      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
          SV_mens_retorno := GV_error_no_clasif;
      END IF;
      LL_des_error := 'ga_inserta_reg_atencion_pr('||EN_num_celular||', '|| EN_cod_atencion||'); - ' || SQLERRM;
      SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'ga_inserta_reg_atencion_pr', LV_sSql, SQLCODE, LL_des_error );
      ROLLBACK;

END ga_inserta_reg_atencion_pr;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_reg_atencion_cliente_ng_pg;
/
SHOW ERRORS
