CREATE OR REPLACE PACKAGE BODY AL_CAMBIO_USO_PG IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : AL_CAMBIO_USO_PG .-
-- * Descripci¾n        : Rutinas de Cambio de Uso para seriados.-
-- * Fecha de creaci¾n  : 05-06-2006
-- * Responsable        : Logistica.-
-- *************************************************************

   CN_cero           CONSTANT PLS_INTEGER := 0;
   CV_cero           CONSTANT VARCHAR2(1) := '0';
   CN_uno            CONSTANT PLS_INTEGER := 1;
   CV_modulo         CONSTANT VARCHAR2(2)  := 'AL';

   CV_ind_equipo     CONSTANT VARCHAR2(2)  := 'E';
   CV_ind_accesorio  CONSTANT VARCHAR2(2)  := 'A';
   CV_entrada        CONSTANT VARCHAR2(2)  := 'E';
   CV_salida         CONSTANT VARCHAR2(2)  := 'S';
   CV_GSM                CONSTANT VARCHAR2(2)  := 'G';
   CV_ACDMA              CONSTANT VARCHAR2(2)  := 'A';
   CV_DCDMA              CONSTANT VARCHAR2(2)  := 'D';
   CV_ErrorNoCla     CONSTANT VARCHAR2(21) := 'Error no clasificado';

   -- INI.XO-200606291153 --
   CV_Simcard            CONSTANT VARCHAR2(16)  := 'TIP_SIMCARD_GSM';
   CV_padre                      CONSTANT PLS_INTEGER := 144;
   -- FIN.XO-200606291153 --

   GV_TGSM               al_articulos.tip_terminal%type;
   GN_cod_error          ge_evento_detalle_to.cod_error%TYPE;
   GN_evento             ge_evento_detalle_to.evento%TYPE;
   GV_sSql                       ge_evento_detalle_to.query%TYPE;
   GE_error          EXCEPTION;

PROCEDURE AL_PARAMETRO_NSIMPLE_PR (EN_modulo IN ge_modulos.cod_modulo%type,
                                   EV_nom_parametro IN VARCHAR2,
                                                                   EN_padre IN NUMBER,
                                                                   SN_valor OUT NOCOPY NUMBER,
                                                                   SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_PARAMETRO_NSIMPLE_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_modulo" Tipo="VARCHAR2">Código de Modulo</param>
            <param nom="EV_nom_parametro" Tipo="VARCHAR2">Nombre Parametro</param>
            <param nom="EN_padre" Tipo="NUMBER">Código Padre</param>
         </Entrada>
         <Salida>
            <param nom="SN_valor" Tipo="NUMBER">Valor Parametro/param>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN
    GV_sSql := 'SELECT a.valor_numerico ';
        GV_sSql := GV_sSql || 'FROM al_parametros_simples_vw a';
        GV_sSql := GV_sSql || 'WHERE a.cod_modulo='|| EN_modulo;
        GV_sSql := GV_sSql || 'AND a.nom_parametro='||EV_nom_parametro;
        GV_sSql := GV_sSql || 'AND a.cod_parametro_padre ='|| EN_padre;

    SELECT a.valor_numerico
        INTO SN_valor
        FROM al_parametros_simples_vw a
        WHERE a.cod_modulo= EN_modulo
        AND a.nom_parametro=EV_nom_parametro
        AND a.cod_parametro_padre = EN_padre;
EXCEPTION
        WHEN OTHERS THEN
                GN_cod_error := 769;--Problemas al Obtener Parámetro.-
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_PARAMETRO_NSIMPLE_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_PARAMETRO_NSIMPLE_PR;


PROCEDURE AL_INSERTAMOVIMIENTO_PR(EN_serie_inicial IN al_series.num_serie%TYPE,
                                  EN_tip_movim     IN al_movimientos.tip_movimiento%TYPE,
                                  EN_uso           IN al_movimientos.cod_uso%TYPE,
                                  EN_uso_destino   IN al_movimientos.cod_uso_dest%TYPE,
                                  EN_cod_bodega     IN al_movimientos.cod_bodega%TYPE,
                                  EN_tip_stock      IN al_movimientos.tip_stock%TYPE,
                                  EN_cod_articulo   IN al_movimientos.cod_articulo%TYPE,
                                  EN_cod_estado     IN al_movimientos.cod_estado%TYPE,
                                  EN_cod_producto   IN al_movimientos.cod_producto%TYPE,
                                  SV_mens_retorno  OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_INSERTAMOVIMIENTO_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_serie_inicial" Tipo="VARCHAR2">Numero de Serie</param>
            <param nom="EN_tip_movim" Tipo="NUMBER">Tipo de Movimiento</param>
            <param nom="EN_uso" Tipo="NUMBER">Codigo uso </param>
            <param nom="EN_uso_destino" Tipo="NUMBER">Codigo uso destino</param>
            <param nom="EN_cod_bodega" Tipo="NUMBER">Codigo Bodega</param>
            <param nom="EN_tip_stock" Tipo="NUMBER">Tipo de Stock</param>
            <param nom="EN_cod_articulo" Tipo="NUMBER">Codigo Articulo</param>
            <param nom="EN_cod_estado" Tipo="NUMBER">Codigo Estado</param>
            <param nom="EN_cod_producto" Tipo="NUMBER">Código Producto</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  LN_nro_movimiento  al_movimientos.num_movimiento%type;
  pmovim         al_movimientos%ROWTYPE;
  BEGIN
        SV_mens_retorno:=CV_cero;

    GV_sSql := 'SELECT al_seq_mvto.NEXTVAL INTO NumNov FROM DUAL';
    SELECT al_seq_mvto.NEXTVAL
    INTO LN_nro_movimiento
    FROM DUAL;

    pmovim.num_movimiento := LN_nro_movimiento;
    pmovim.tip_movimiento := EN_tip_movim ;
    pmovim.fec_movimiento := SYSDATE;
    pmovim.tip_stock := EN_tip_stock;
    pmovim.cod_bodega :=EN_cod_bodega;
    pmovim.cod_articulo := EN_cod_articulo ;
    pmovim.cod_uso := EN_uso;
    pmovim.cod_estado := EN_cod_estado;
    pmovim.num_cantidad := 1;
    pmovim.cod_estadomov := 'SO';
    pmovim.nom_usuarora := USER;
    pmovim.tip_stock_dest := NULL;
    pmovim.cod_bodega_dest := NULL;
    pmovim.cod_uso_dest := EN_uso_destino;
    pmovim.cod_estado_dest := NULL;
    pmovim.num_serie := EN_serie_inicial;
    pmovim.num_desde := CN_cero;
    pmovim.num_hasta := NULL;
    pmovim.num_guia := NULL;
    pmovim.prc_unidad := NULL;
    pmovim.cod_transaccion := NULL;
    pmovim.num_transaccion := NULL;
    pmovim.NUM_SERIEMEC := NULL;
    pmovim.NUM_TELEFONO := NULL;
    pmovim.CAP_CODE := NULL;
    pmovim.COD_PRODUCTO := EN_cod_producto;
    pmovim.COD_CENTRAL := NULL;
    pmovim.COD_MONEDA := NULL;
    pmovim.COD_SUBALM := NULL;
    pmovim.COD_CENTRAL_DEST := NULL;
    pmovim.COD_SUBALM_DEST := NULL;
    pmovim.NUM_TELEFONO_DEST := NULL;
    pmovim.COD_CAT := NULL;
    pmovim.COD_CAT_DEST := NULL;
    pmovim.IND_TELEFONO := NULL;
    pmovim.PLAN := NULL;
    pmovim.CARGA := NULL;
    pmovim.NUM_SEC_LOCA := NULL;
    pmovim.COD_HLR := NULL;
    pmovim.COD_PLAZA := NULL;

    GV_sSql := 'AL_PAC_VALIDACIONES.p_inserta_movim(pmovim)';
    AL_PAC_VALIDACIONES.p_inserta_movim(pmovim);
EXCEPTION
    WHEN OTHERS THEN
       GN_cod_error:=775;--No se puede generar el movimiento.-
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_INSERTAMOVIMIENTO_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_INSERTAMOVIMIENTO_PR;

-- INI.XO-200606291153 --
PROCEDURE AL_PARAMETRO_VSIMPLE_PR (EN_modulo IN ge_modulos.cod_modulo%type,
                                   EV_nom_parametro IN VARCHAR2,
                                                                   EN_padre IN NUMBER,
                                                                   SV_valor OUT NOCOPY VARCHAR2,
                                                                   SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_PARAMETRO_VSIMPLE_PR"
      Fecha modificacion=" "
      Fecha creacion=""
      Constructor=""
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_modulo" Tipo="VARCHAR2">Código de Modulo</param>
            <param nom="EV_nom_parametro" Tipo="VARCHAR2">Nombre Parametro</param>
            <param nom="EN_padre" Tipo="NUMBER">Código Padre</param>
         </Entrada>
         <Salida>
            <param nom="SN_valor" Tipo="VARCHAR2">Valor Parametro/param>
            <param nom="SV_mens_retorno" Tipo="VARCHAR">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN
    SV_mens_retorno:=CV_cero;

    GV_sSql := 'SELECT a.valor_texto ';
        GV_sSql := GV_sSql || 'FROM al_parametros_simples_vw a';
        GV_sSql := GV_sSql || 'WHERE a.cod_modulo='|| EN_modulo;
        GV_sSql := GV_sSql || 'AND a.nom_parametro='||EV_nom_parametro;
        GV_sSql := GV_sSql || 'AND a.cod_parametro_padre ='|| EN_padre;

    SELECT a.valor_texto
        INTO SV_valor
        FROM al_parametros_simples_vw a
        WHERE a.cod_modulo= EN_modulo
        AND a.nom_parametro=EV_nom_parametro
        AND a.cod_parametro_padre = EN_padre;
EXCEPTION
        WHEN OTHERS THEN
                GN_cod_error := 769;--Problemas al Obtener Parámetro.-
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_PARAMETRO_VSIMPLE_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_PARAMETRO_VSIMPLE_PR;
-- FIN.XO-200606291153 --

PROCEDURE AL_VALIDA_CONSISTENCIA_SERIE(EN_num_serie IN al_series.num_serie%type,
                                       SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_VALIDA_CONSISTENCIA_SERIE"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_serie_inicial" Tipo="VARCHAR2">Numero de Serie</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
    LN_cod_articulo al_articulos.cod_articulo%type;
    LN_cod_bodega al_series.cod_bodega%type;
        LN_cod_estado al_series.cod_estado%type;
        LN_estado_valido al_series.cod_estado%type;
    LN_ind_telefono al_series.ind_telefono%type;
    LN_num_celular al_series.num_telefono%type;
        LN_ind_seriado al_articulos.ind_seriado%type;
        LV_ind_equiacc al_articulos.ind_equiacc%type;
        LV_tip_terminal al_articulos.tip_terminal%type;
        LN_bodega_usuario al_series.cod_bodega%type;
        LN_ultimo_digito PLS_INTEGER;
        LN_digito_verificador PLS_INTEGER;

        -- INI.XO-200606291153 --
        LV_valor   al_parametros_simples_vw.valor_texto%type;
        LV_mens_retorno al_parametros_simples_vw.des_parametro%type;
        -- FIN.XO-200606291153 --

BEGIN
     SV_mens_retorno:=CV_cero;

         -- INI.XO-200606291153 --
         AL_PARAMETRO_VSIMPLE_PR(CV_modulo,CV_Simcard,CV_padre,LV_valor,LV_mens_retorno);

         IF LV_mens_retorno <> CV_Cero THEN
                 RAISE GE_error;
         END IF;
         -- FIN.XO-200606291153 --

         BEGIN
         GV_sSql := 'SELECT cod_articulo, cod_bodega, cod_estado,ind_telefono, num_telefono';
         GV_sSql := GV_sSql ||' FROM al_series';
         GV_sSql := GV_sSql ||' WHERE num_serie='||EN_num_serie;
         SELECT cod_articulo, cod_bodega, cod_estado,ind_telefono, num_telefono
         INTO LN_cod_articulo, LN_cod_bodega, LN_cod_estado, LN_ind_telefono, LN_num_celular
         FROM al_series
         WHERE num_serie=EN_num_serie;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                        GN_cod_error:=107; /* La serie ingresada no existe en SCL */
                        RAISE GE_error;
         END;

         BEGIN
                  SELECT cod_estado
                  INTO LN_estado_valido
                  FROM al_estados
                  WHERE cod_estado= LN_cod_estado
                   AND  ind_disponibilidad=CN_uno;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                    GN_cod_error := 105; /* Estado no Permitido para realizar el cambio*/
                        RAISE GE_error;
            WHEN OTHERS THEN
                        GN_cod_error := 18; /* Estado no existe en SCL */
                        RAISE GE_error;
         END;


     BEGIN
             GV_sSql := 'SELECT ind_seriado, ind_equiacc, tip_terminal';
         GV_sSql := GV_sSql ||' FROM al_articulos';
         GV_sSql := GV_sSql ||' WHERE cod_articulo='||LN_cod_articulo;
         SELECT ind_seriado, ind_equiacc, tip_terminal
         INTO LN_ind_seriado,LV_ind_equiacc,LV_tip_terminal
         FROM al_articulos
         WHERE cod_articulo=LN_cod_articulo;
     EXCEPTION
            WHEN OTHERS THEN
                        GN_cod_error := 35; /* Articulo no existe en SCL */
                        RAISE GE_error;
         END;

         -- INI.XO-200606291153 --
         GV_sSql := LV_Valor || '=' || LV_tip_terminal;
         IF LV_Valor = LV_tip_terminal THEN
                 GN_cod_error := 799; /* El Cambio de Uso para una Simcard no es permitido */
                 RAISE GE_error;
         END IF;
         -- FIN.XO-200606291153 --

         GV_sSql := 'NOT (('||LN_ind_telefono||' = '||CN_cero||') AND ('||LN_num_celular||' is null))';
         IF NOT ((LN_ind_telefono = CN_cero) AND (LN_num_celular is null)) THEN
             GN_cod_error := 771; /* Serie No Debe estar numerada */
                 RAISE GE_error;
         END IF;

         GV_sSql := LN_ind_seriado ||'<>'|| CN_uno;
         IF LN_ind_seriado <> CN_uno THEN
             GN_cod_error := 772; /* Articulo debe ser seriado */
         RAISE GE_error;
         END IF;

         BEGIN
             GV_sSql := 'SELECT cod_bodega';
         GV_sSql := GV_sSql ||' FROM al_usua_bodegas';
         GV_sSql := GV_sSql ||' WHERE cod_bodega='||LN_cod_bodega;
                 GV_sSql := GV_sSql ||'   AND nom_usuarora = user';
         SELECT cod_bodega
         INTO LN_bodega_usuario
         FROM al_usua_bodegas
         WHERE cod_bodega=LN_cod_bodega
                   AND nom_usuarora = USER;
     EXCEPTION
            WHEN NO_DATA_FOUND THEN
                    GN_cod_error := 773; /* Usuario no tiene permiso a la bodega*/
                        RAISE GE_error;
            WHEN OTHERS THEN
                        GN_cod_error := 774; /* Problemas al obtener la bodega del usuario */
                        RAISE GE_error;
         END;

EXCEPTION
    WHEN GE_error THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VALIDA_CONSISTENCIA_SERIE', GV_sSql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
           GN_cod_error:=107;/* La serie ingresada no existe.*/
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VALIDA_CONSISTENCIA_SERIE', GV_sSql, SQLCODE, SQLERRM);
END AL_VALIDA_CONSISTENCIA_SERIE;

PROCEDURE AL_VERIFICA_EXISTENCIA_SERIE(EN_num_serie IN al_series.num_serie%TYPE,
                                        SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_VERIFICA_EXISTENCIA_SERIE"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="VARCHAR2">Numero de Serie</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
    LN_retorno PLS_INTEGER;
BEGIN
     SV_mens_retorno:=CV_cero;
     GV_sSql :=' SELECT count(1)';
         GV_sSql := GV_sSql ||' FROM al_series';
         GV_sSql := GV_sSql ||' WHERE num_serie='||EN_num_serie;

         SELECT count(1)
         INTO LN_retorno
         FROM al_series
         WHERE num_serie=EN_num_serie;

         IF LN_retorno = CN_cero THEN
                GN_cod_error:=107;/* La serie ingresada no existe.*/
                RAISE GE_error;
         END IF;
EXCEPTION
    WHEN GE_error THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_EXISTENCIA_SERIE', GV_sSql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
           GN_cod_error:=107;/* La serie ingresada no existe.*/
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_EXISTENCIA_SERIE', GV_sSql, SQLCODE, SQLERRM);
END AL_VERIFICA_EXISTENCIA_SERIE;


PROCEDURE AL_VALIDA_SERIE_PR(EN_num_serie IN al_series.num_serie%TYPE,
                             SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_VALIDA_SERIE_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="VARCHAR2">Numero de Serie</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
    LN_retorno PLS_INTEGER;
BEGIN
     SV_mens_retorno:=CV_cero;

     AL_VERIFICA_EXISTENCIA_SERIE(EN_num_serie,SV_mens_retorno);
         IF SV_mens_retorno <> CV_cero THEN
            RAISE GE_error;
         END IF;

         AL_VALIDA_CONSISTENCIA_SERIE(EN_num_serie,SV_mens_retorno);
         IF SV_mens_retorno <> CV_cero THEN
            RAISE GE_error;
         END IF;

EXCEPTION
    WHEN GE_error THEN
           IF SV_mens_retorno = CV_cero THEN
                  IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_ErrorNoCla;
              END IF;
           END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl(CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VALIDA_SERIE_PR', GV_sSql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
                GN_cod_error:=107;/* La serie ingresada no existe.*/
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VALIDA_SERIE_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_VALIDA_SERIE_PR;



PROCEDURE AL_VERIFICA_USO_DESTINO_PR(EV_parametro IN VARCHAR2,
                                     EN_parametro_padre IN NUMBER,
                                     SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_VERIFICA_USO_DESTINO_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
             <param nom="EV_parametro" Tipo="VARCHAR2">Parametro que contine el nombre del uso de cambio</param>
            <param nom="EN_parametro_padre" Tipo="NUMBER">Codigo Padre del parametro ingresado</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
        LN_retorno PLS_INTEGER;
BEGIN
     SV_mens_retorno := CV_cero;

     GV_sSql := 'count(1)';
     GV_sSql := GV_sSql || ' FROM al_usos a, al_parametros_multiples_vw b';
     GV_sSql := GV_sSql || ' WHERE b.cod_modulo='|| CV_modulo;
     GV_sSql := GV_sSql || '   AND b.nom_parametro='|| EV_parametro;
     GV_sSql := GV_sSql || '   AND b.cod_parametro_padre ='|| EN_parametro_padre;
     GV_sSql := GV_sSql || '   AND b.valor_numerico=a.cod_uso';
     SELECT count(1)
         INTO LN_retorno
     FROM al_usos a, al_parametros_multiples_vw b
     WHERE b.cod_modulo=CV_modulo
       AND b.nom_parametro=EV_parametro
       AND b.cod_parametro_padre=EN_parametro_padre
       AND b.valor_numerico=a.cod_uso;

         IF LN_retorno = CN_cero THEN
            GN_cod_error:= 766;/* Para este Uso, no existen usos de cambio*/
            RAISE GE_error;
         END IF;

EXCEPTION
    WHEN GE_error THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_USO_DESTINO_PR', GV_sSql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
                GN_cod_error := 768; /* Problemas al recuperar Usos de Cambio */
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_USO_DESTINO_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_VERIFICA_USO_DESTINO_PR;

PROCEDURE AL_VERIFICA_TIPMOV_PROCESO_PR(EN_proceso IN al_procesos_tipmovim.cod_proceso%TYPE,
                                        EN_ind_entsal IN al_tipos_movimientos.ind_entsal%TYPE,
                                        SV_mens_retorno OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_VERIFICA_TIPMOV_PROCESO_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
           <param nom="EN_proceso" Tipo="VARCHAR2">Nombre del proceso asoicado al cambio de uso</param>
            <param nom="EN_ind_entsal" Tipo="NUMBER">Indicador de Movimiento</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
        LN_retorno PLS_INTEGER;
BEGIN
     SV_mens_retorno:=CV_cero;
     GV_sSql := 'SELECT count(1) ';
     GV_sSql := GV_sSql || ' FROM al_tipos_movimientos a, al_procesos_tipmovim b ';
     GV_sSql := GV_sSql || ' WHERE b.cod_proceso = '|| EN_proceso;
     GV_sSql := GV_sSql || '   AND a.ind_entsal = ' || EN_ind_entsal ;
     GV_sSql := GV_sSql || '   AND a.tip_movimiento = b.tip_movimiento ';

         SELECT count(1)
         INTO LN_retorno
         FROM al_tipos_movimientos a, al_procesos_tipmovim b
         WHERE b.cod_proceso = EN_proceso
         AND a.ind_entsal =  EN_ind_entsal
         AND a.tip_movimiento = b.tip_movimiento;

         IF LN_retorno = CN_cero THEN
            GN_cod_error:=765;/*El Proceso No Tiene Ningún Tipo de Movimiento Asociado*/
            RAISE GE_error;
         END IF;

EXCEPTION
    WHEN GE_error THEN
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
              SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_TIPMOV_PROCESO_PR', GV_sSql, SQLCODE, SQLERRM);
    WHEN OTHERS THEN
                GN_cod_error := 767; /*Problemas al recuperar los tipos de movimientos para el proceso de Cambio de Uso*/
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_TIPMOV_PROCESO_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_VERIFICA_TIPMOV_PROCESO_PR;

PROCEDURE AL_OBTIENE_USO_DESTINO_PR (EV_parametro IN VARCHAR2,
                                     EN_parametro_padre IN NUMBER,
                                     SV_mens_retorno OUT NOCOPY VARCHAR2,
                                     SN_uso_final OUT NOCOPY refcursor)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_OBTIENE_USO_DESTINO_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EV_parametro" Tipo="VARCHAR2">Parametro que contine el nombre del uso de cambio</param>
            <param nom="EN_parametro_padre" Tipo="NUMBER">Codigo Padre del parametro ingresado</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SN_uso_final" Tipo="CURSOR">cursor con informacion de los usos disponibles para realizar el camnbio</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN

     SV_mens_retorno := CV_cero;

     AL_VERIFICA_USO_DESTINO_PR(EV_parametro,EN_parametro_padre,SV_mens_retorno);

     GV_sSql := 'SELECT  a.des_uso,a.cod_uso';
     GV_sSql := GV_sSql || ' FROM al_usos a, al_parametros_multiples_vw b';
     GV_sSql := GV_sSql || ' WHERE b.cod_modulo='|| CV_modulo;
     GV_sSql := GV_sSql || '   AND b.nom_parametro='|| EV_parametro;
     GV_sSql := GV_sSql || '   AND b.cod_parametro_padre ='|| EN_parametro_padre;
     GV_sSql := GV_sSql || '   AND b.valor_numerico=a.cod_uso';
     OPEN SN_uso_final FOR
     SELECT a.des_uso,a.cod_uso
     FROM al_usos a, al_parametros_multiples_vw b
     WHERE b.cod_modulo=CV_modulo
       AND b.nom_parametro=EV_parametro
       AND b.cod_parametro_padre=EN_parametro_padre
       AND b.valor_numerico=a.cod_uso;

EXCEPTION
    WHEN OTHERS THEN
           GN_cod_error := 768; /* Problemas al recuperar Usos de Cambio */
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_OBTIENE_USO_DESTINO_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_OBTIENE_USO_DESTINO_PR;


PROCEDURE AL_OBTIENE_TIPMOV_PROCESO_PR(EN_proceso IN al_procesos_tipmovim.cod_proceso%TYPE,
                                       EN_ind_entsal IN al_tipos_movimientos.ind_entsal%TYPE,
                                       SV_mens_retorno OUT NOCOPY VARCHAR2,
                                       SN_tip_movim OUT NOCOPY refcursor)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_OBTIENE_TIPMOV_PROCESO_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_proceso" Tipo="VARCHAR2">Nombre del proceso asoicado al cambio de uso</param>
            <param nom="EN_ind_entsal" Tipo="NUMBER">Indicador de Movimiento</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SN_tip_movim" Tipo="CURSOR">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN
     SV_mens_retorno := CV_cero;

         AL_VERIFICA_TIPMOV_PROCESO_PR(En_proceso,En_ind_entsal,SV_mens_retorno);

     GV_sSql := 'SELECT a.des_movimiento, a.tip_movimiento';
     GV_sSql := GV_sSql || ' FROM al_tipos_movimientos a, al_procesos_tipmovim b ';
     GV_sSql := GV_sSql || ' WHERE b.cod_proceso = '|| EN_proceso;
     GV_sSql := GV_sSql || '   AND a.ind_entsal = ' || EN_ind_entsal ;
     GV_sSql := GV_sSql || '   AND a.tip_movimiento = b.tip_movimiento ';
     OPEN SN_tip_movim FOR
         SELECT a.des_movimiento, a.tip_movimiento
         FROM al_tipos_movimientos a, al_procesos_tipmovim b
         WHERE b.cod_proceso = EN_proceso
         AND a.ind_entsal =  EN_ind_entsal
         AND a.tip_movimiento = b.tip_movimiento;

EXCEPTION
    WHEN OTHERS THEN
           GN_cod_error := 767; /*Problemas al recuperar los tipos de movimientos para el proceso de Cambio de Uso*/
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_OBTIENE_TIPMOV_PROCESO_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_OBTIENE_TIPMOV_PROCESO_PR;


PROCEDURE AL_OBTIENE_DETALLE_SERIE_PR (EN_num_serie IN al_series.num_serie%TYPE,
                                       SV_mens_retorno OUT NOCOPY VARCHAR2,
                                       SN_detalle_serie OUT NOCOPY refcursor)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_OBTIENE_DETALLE_SERIE_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_num_serie" Tipo="VARCHAR2">Numero de Serie</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SN_detalle_serie" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN
         SV_mens_retorno := CV_cero;

     AL_VALIDA_SERIE_PR(EN_num_serie,SV_mens_retorno);

         GV_sSql := 'SELECT a.num_serie,c.des_bodega,b.des_articulo, d.des_uso,';
     GV_sSql := GV_sSql || '      b.cod_modelo, f.des_stock, g.des_tiparticulo, e.des_estado,';
     GV_sSql := GV_sSql || '      h.des_fabricante, i.can_stock,null,';
     GV_sSql := GV_sSql || '      a.cod_bodega, a.tip_stock, a.cod_articulo,a.cod_uso,null,';
     GV_sSql := GV_sSql || '      a.cod_estado, b.tip_articulo, b.ind_equiacc, b.tip_terminal,';
     GV_sSql := GV_sSql || '      b.cod_producto ';
     GV_sSql := GV_sSql || 'FROM al_series a, al_articulos b,';
     GV_sSql := GV_sSql || '     al_stock i, al_bodegas c,al_fabricantes h,';
     GV_sSql := GV_sSql || '     al_usos d, al_tipos_stock f, al_estados e, al_tipos_articulos g';
     GV_sSql := GV_sSql || 'WHERE a.num_serie ='||EN_num_serie;
     GV_sSql := GV_sSql || '  AND g.tip_articulo=b.tip_articulo';
     GV_sSql := GV_sSql || '  AND g.cod_producto=b.cod_producto';
     GV_sSql := GV_sSql || '  AND e.cod_estado=a.cod_estado';
     GV_sSql := GV_sSql || '  AND f.tip_stock=a.tip_stock';
     GV_sSql := GV_sSql || '  AND d.cod_uso=a.cod_uso ';
     GV_sSql := GV_sSql || '  AND h.cod_fabricante=b.cod_fabricante';
     GV_sSql := GV_sSql || '  AND c.cod_bodega=a.cod_bodega';
     GV_sSql := GV_sSql || '  AND i.cod_bodega=a.cod_bodega';
     GV_sSql := GV_sSql || '  AND i.tip_stock=a.tip_stock';
     GV_sSql := GV_sSql || '  AND i.cod_articulo=a.cod_articulo';
     GV_sSql := GV_sSql || '  AND i.cod_uso=a.cod_uso ';
     GV_sSql := GV_sSql || '  AND i.cod_estado=a.cod_estado';
     GV_sSql := GV_sSql || '  AND i.cod_plaza=a.cod_plaza';
     GV_sSql := GV_sSql || '  AND i.num_desde=a.num_desde';
     GV_sSql := GV_sSql || '  AND b.cod_articulo=a.cod_articulo';
     OPEN SN_detalle_serie FOR
     SELECT a.num_serie,c.des_bodega,b.des_articulo, d.des_uso,
            b.cod_modelo, f.des_stock,
                        g.des_tiparticulo,
                        e.des_estado,
            h.des_fabricante, i.can_stock,null,
            a.cod_bodega, a.tip_stock, a.cod_articulo,a.cod_uso, null,
            a.cod_estado, b.tip_articulo, b.ind_equiacc, b.tip_terminal,
            b.cod_producto,a.cod_hlr
     FROM al_series a, al_articulos b,
          al_stock i, al_bodegas c, al_fabricantes h,
          al_usos d, al_tipos_stock f, al_estados e, al_tipos_articulos g
     WHERE a.num_serie =EN_num_serie
       AND g.tip_articulo=b.tip_articulo
       AND g.cod_producto=b.cod_producto
       AND e.cod_estado=a.cod_estado
       AND f.tip_stock=a.tip_stock
       AND d.cod_uso=a.cod_uso
       AND h.cod_fabricante=b.cod_fabricante
       AND c.cod_bodega=a.cod_bodega
       AND i.cod_bodega=a.cod_bodega
       AND i.tip_stock=a.tip_stock
       AND i.cod_articulo=a.cod_articulo
       AND i.cod_uso=a.cod_uso
       AND i.cod_estado=a.cod_estado
       AND i.cod_plaza=a.cod_plaza
       AND i.num_desde=a.num_desde
       AND b.cod_articulo=a.cod_articulo ;

EXCEPTION
    WHEN OTHERS THEN
           GN_cod_error := 776; /*Problemas al recuperar el detalle de la Serie*/
           IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_OBTIENE_DETALLE_SERIE_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_OBTIENE_DETALLE_SERIE_PR;


PROCEDURE AL_CAMBIO_USO_PUNTUAL_PR(EN_serie_inicial IN al_series.num_serie%TYPE,
                                   EN_tip_movim     IN al_movimientos.tip_movimiento%TYPE,
                                   EN_uso           IN al_movimientos.cod_uso%TYPE,
                                   EN_uso_destino   IN al_movimientos.cod_uso_dest%TYPE,
                                   EN_cod_bodega     IN al_movimientos.cod_bodega%TYPE,
                                   EN_tip_stock      IN al_movimientos.tip_stock%TYPE,
                                   EN_cod_articulo   IN al_movimientos.cod_articulo%TYPE,
                                   EN_cod_estado     IN al_movimientos.cod_estado%TYPE,
                                   EN_cod_producto   IN al_movimientos.cod_producto%TYPE,
                                   SV_mens_retorno  OUT NOCOPY VARCHAR2)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_CAMBIO_USO_PUNTUAL_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_serie_inicial" Tipo="VARCHAR2">Numero de Serie</param>
            <param nom="EN_tip_movim" Tipo="NUMBER">Tipo de Movimiento</param>
            <param nom="EN_uso" Tipo="NUMBER">Codigo uso </param>
            <param nom="EN_uso_destino" Tipo="NUMBER">Codigo uso destino</param>
            <param nom="EN_cod_bodega" Tipo="NUMBER">Codigo Bodega</param>
            <param nom="EN_tip_stock" Tipo="NUMBER">Tipo de Stock</param>
            <param nom="EN_cod_articulo" Tipo="NUMBER">Codigo Articulo</param>
            <param nom="EN_cod_estado" Tipo="NUMBER">Codigo Estado</param>
            <param nom="EN_cod_producto" Tipo="NUMBER">Código Producto</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN
         SV_mens_retorno := CV_cero;

         AL_INSERTAMOVIMIENTO_PR(EN_serie_inicial,EN_tip_movim,EN_uso,EN_uso_destino,EN_cod_bodega,
                                                         EN_tip_stock,EN_cod_articulo,EN_cod_estado,EN_cod_producto,SV_mens_retorno);
         IF SV_mens_retorno <>  CV_cero THEN
             RAISE GE_error;
         END IF;

EXCEPTION
   WHEN GE_error THEN
       IF SV_mens_retorno = CV_cero THEN
             IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
                SV_mens_retorno := CV_ErrorNoCla;
             END IF;
           END IF;
           GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_VERIFICA_USO_DESTINO_PR', GV_sSql, SQLCODE, SQLERRM);
        WHEN OTHERS THEN
                GN_cod_error := 777;--Problemas al recuperar detalle de la Serie.-
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_CAMBIO_USO_PUNTUAL_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_CAMBIO_USO_PUNTUAL_PR;


PROCEDURE AL_PARAMETROS_PR (EN_modulo IN ge_modulos.cod_modulo%type,
                            EV_nom_parametro IN VARCHAR2,
                            EN_padre IN NUMBER,
                            EN_tipocol IN NUMBER,
                            SV_mens_retorno OUT NOCOPY VARCHAR2,
                            SN_parametros OUT NOCOPY refcursor)
IS
/*
<Documentacion TipoDoc = "PROCEDURE">
   <Elemento
      Nombre = "AL_PARAMETROS_PR"
      Fecha modificacion=" "
      Fecha creacion="08-06-2006"
      Constructor="Marcela Lucero R."
      Modificador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion></Descripcion>
      <Parametros>
         <Entrada>
            <param nom="EN_modulo" Tipo="VARCHAR2">Codigo Modulo</param>
            <param nom="EV_nom_parametro" Tipo="VARCHAR2">Nombre Parametro</param>
            <param nom="EN_padre" Tipo="NUMBER">Codigo Padre </param>
            <param nom="EN_tipocol" Tipo="NUMBER">Tipo columna de donde se obtiene el valor del parametro</param>
            <param nom="EN_cod_bodega" Tipo="NUMBER">Codigo Bodega</param>
            <param nom="EN_tip_stock" Tipo="NUMBER">Tipo de Stock</param>
            <param nom="EN_cod_articulo" Tipo="NUMBER">Codigo Articulo</param>
            <param nom="EN_cod_estado" Tipo="NUMBER">Codigo Estado</param>
            <param nom="EN_cod_producto" Tipo="NUMBER">Código Producto</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno" Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SN_parametros" Tipo="CURSOR">Valor de Parametro</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
BEGIN
    SV_mens_retorno := CV_cero;

    IF EN_tipocol =CN_cero THEN

        GV_sSql := 'SELECT a.valor_numerico ';
        GV_sSql := GV_sSql || 'FROM al_parametros_simples_vw a';
        GV_sSql := GV_sSql || 'WHERE a.cod_modulo='|| EN_modulo;
        GV_sSql := GV_sSql || 'AND a.nom_parametro='||EV_nom_parametro;
        GV_sSql := GV_sSql || 'AND a.cod_parametro_padre ='|| EN_padre;
        OPEN SN_parametros FOR
        SELECT a.valor_numerico
        FROM al_parametros_simples_vw a
        WHERE a.cod_modulo= EN_modulo
        AND a.nom_parametro=EV_nom_parametro
        AND a.cod_parametro_padre = EN_padre;
    ELSE

        GV_sSql := 'SELECT a.valor_texto ';
        GV_sSql := GV_sSql || 'FROM al_parametros_simples_vw a';
        GV_sSql := GV_sSql || 'WHERE a.cod_modulo='|| EN_modulo;
        GV_sSql := GV_sSql || 'AND a.nom_parametro='||EV_nom_parametro;
        GV_sSql := GV_sSql || 'AND a.cod_parametro_padre ='|| EN_padre;
        OPEN SN_parametros FOR
        SELECT a.valor_texto
        FROM al_parametros_simples_vw a
        WHERE a.cod_modulo= EN_modulo
        AND a.nom_parametro=EV_nom_parametro
        AND a.cod_parametro_padre = EN_padre;
        END IF;

EXCEPTION
        WHEN OTHERS THEN
                GN_cod_error := 624;--Problemas al Obtener Parámetro.-
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GN_cod_error,SV_mens_retorno) THEN
               SV_mens_retorno := CV_ErrorNoCla;
            END IF;
                GN_evento  := Ge_Errores_Pg.Grabarpl( CN_cero,CV_modulo,SV_mens_retorno, '1.0.0', USER, 'AL_PARAMETROS_PR', GV_sSql, SQLCODE, SQLERRM);
END AL_PARAMETROS_PR;





END AL_CAMBIO_USO_PG;
/
SHOW ERRORS
