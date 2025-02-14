CREATE OR REPLACE PACKAGE BODY ve_intermediario_quiosco_pg IS
   FUNCTION ve_descompone_cadena_fn (
      ev_cadena           IN              VARCHAR2,
      en_largosubstring   IN              NUMBER,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
      RETURN tipoarray IS
      /*--
      <Documentación TipoDoc = "Funcion">
         Elemento Nombre = "VE_descompone_servicios_FN"
         Lenguaje="PL/SQL"
         Fecha="21-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Descompone cadena de servicios : 6 caracteres
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_cadena" Tipo="VARCHAR2"> cadena de entrada</param>
      </Entrada>
      <Salida>
           <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
           <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      la_arreglosalida   tipoarray              := tipoarray ();
      lv_des_error       ge_errores_pg.desevent;
      lv_sql             ge_errores_pg.vquery;
      icont              INTEGER;
      ipos               INTEGER;
      lv_cadena          ge_errores_pg.msgerror;                                                                                                                                                                        --VARCHAR2(300); Inc. 89593 14-05-2009
   BEGIN
      lv_sql := ev_cadena;
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF (LENGTH (ev_cadena) < en_largosubstring) THEN
         lv_cadena := '0';
         la_arreglosalida (1) := lv_cadena;
      ELSE
         lv_cadena := ev_cadena;
      END IF;

      icont := 0;
      ipos := en_largosubstring;

      LOOP
         IF (ipos = 0) THEN
            EXIT;
         END IF;

         icont := icont + 1;
         la_arreglosalida.EXTEND;
         la_arreglosalida (icont) := TRIM (SUBSTR (lv_cadena, 1, ipos));
         lv_cadena := TRIM (SUBSTR (lv_cadena, ipos + 1, LENGTH (lv_cadena)));

         IF (lv_cadena = '' OR LENGTH (lv_cadena) < en_largosubstring OR lv_cadena IS NULL) THEN
            ipos := 0;
         ELSE
            ipos := en_largosubstring;
         END IF;
      END LOOP;

      RETURN la_arreglosalida;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10817;
         sv_mens_retorno := 'Error al descomponer cadena de servicios';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_descompone_cadena_FN;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_descompone_cadena_FN', lv_sql, SQLCODE, lv_des_error);
   END ve_descompone_cadena_fn;

   FUNCTION ve_descompone_cadena_fn (
      ev_cadena         IN              VARCHAR2,
      ev_separador      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN tipoarray IS
      /*--
      <Documentación TipoDoc = "Funcion">
         Elemento Nombre = "VE_descompone_cadena_FN"
         Lenguaje="PL/SQL"
         Fecha="21-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Descompone cadena en campos. Caracter separador "/"
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_cadena" Tipo="VARCHAR2"> cadena de entrada</param>
      </Entrada>
      <Salida>
           <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
           <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      la_arreglosalida        tipoarray              := tipoarray ();
      cv_separador   CONSTANT CHAR                   := ev_separador;
      icont                   INTEGER;
      ipos                    INTEGER;
      bexiste                 BOOLEAN;
      lv_cadena               ge_errores_pg.msgerror;                                                                                                                                                                   --inc. 94818 22-06-2009 VARCHAR2(300);
      lv_des_error            ge_errores_pg.desevent;
      lv_sql                  ge_errores_pg.vquery;
   BEGIN
      lv_sql          := ev_cadena;
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;

      IF (SUBSTR (ev_cadena, LENGTH (ev_cadena), 1) = cv_separador) THEN
         lv_cadena := ev_cadena || '0';
      ELSE
         lv_cadena := ev_cadena;
      END IF;

      icont := 0;
      ipos  := INSTR (lv_cadena, cv_separador);

      IF (ipos = 1) THEN
         lv_cadena := TRIM (SUBSTR (lv_cadena, ipos + 1, LENGTH (lv_cadena)));
         ipos := INSTR (lv_cadena, cv_separador);
         bexiste := TRUE;
      ELSE
         bexiste := FALSE;
      END IF;

      LOOP
         IF (ipos = 0) THEN
            EXIT;
         END IF;

         bexiste := TRUE;
         icont := icont + 1;
         la_arreglosalida.EXTEND;
         la_arreglosalida (icont) := TRIM (SUBSTR (lv_cadena, 1, ipos - 1));
         lv_cadena := TRIM (SUBSTR (lv_cadena, ipos + 1, LENGTH (lv_cadena)));
         ipos := INSTR (lv_cadena, cv_separador);
      END LOOP;

      IF (bexiste) THEN
         icont := icont + 1;
         la_arreglosalida.EXTEND;
         la_arreglosalida (icont) := TRIM (lv_cadena);
      END IF;

      RETURN la_arreglosalida;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10817;
         sv_mens_retorno := 'Error al descomponer cadena de servicios';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_descompone_cadena_FN;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_descompone_cadena_FN', lv_sql, SQLCODE, lv_des_error);
   END ve_descompone_cadena_fn;

   FUNCTION ve_obtieneformatofecha_fn (
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento)
      RETURN VARCHAR2 IS
      /*--
      <Documentación TipoDoc = "Función">
         Elemento Nombre = "VE_ObtieneFormatoFecha_FN"
         Lenguaje="PL/SQL"
         Fecha="21-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> NUMBER </Retorno>
      <Descripción>
         Retorna el formato de fecha segun parametros (FORMATO_SEL2)
      </Descripción>
      <Parámetros>
      <Entrada> NA </Entrada>
      <Salida>
           <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
           <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_formatofecha   ged_parametros.val_parametro%TYPE;
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT val_parametro a' || ' FROM ged_parametros a' || ' WHERE a.cod_producto = ' || cv_producto || ' AND a.cod_modulo = ' || cv_modulo_ge || ' AND a.nom_parametro = ' || cv_formato_fecha;

      SELECT val_parametro a
        INTO lv_formatofecha
        FROM ged_parametros a
       WHERE a.cod_producto = cv_producto AND a.cod_modulo = cv_modulo_ge AND a.nom_parametro = cv_formato_fecha;

      RETURN lv_formatofecha;
   EXCEPTION
      WHEN OTHERS THEN
         lv_formatofecha := 'YYYYMMDD HH24MISS';
         sn_cod_retorno  := 10818;
         sv_mens_retorno := 'Error al obtener el formato de fecha segun parametros';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneFormatoFecha_FN;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneFormatoFecha_FN', lv_sql, SQLCODE, lv_des_error);
   END ve_obtieneformatofecha_fn;

   FUNCTION ve_convertir_fn (
      eb_valor          IN              BOOLEAN,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN PLS_INTEGER IS
      /*--
      <Documentación TipoDoc = "Función">
         Elemento Nombre = "VE_convertir_FN"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> PLS_INTEGER </Retorno>
      <Descripción>
         Convierte entrada booleana en integer
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EB_valor" Tipo="BOOLEAN"> valor boolean TRUE o FALSE </param>
      </Entrada>
      <Salida>
           <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
           <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
         <param nom="Salida" Tipo="PLS_INTEGER"> equivalente de TRUE o FALSE en ineteger </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;

      IF eb_valor = TRUE THEN
         RETURN ci_true;
      ELSE
         RETURN ci_false;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10819;
         sv_mens_retorno := 'Error al convertir entrada booleana en integer';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_convertir_FN;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_convertir_FN', NULL, SQLCODE, lv_des_error);
   END ve_convertir_fn;

   FUNCTION ve_obtienenumdiasnum_fn (
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento)
      RETURN NUMBER IS
      /*--
      <Documentación TipoDoc = "Función">
         Elemento Nombre = "VE_ObtieneNumDiasNum_FN"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> NUMBER </Retorno>
      <Descripción>
         Retorna el numero de dias num
      </Descripción>
      <Parámetros>
      <Entrada> NA </Entrada>
      <Salida>
           <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
           <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
         <param nom="Salida" Tipo="NUMBER">Numero Dias Num</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      li_numdiasnum   NUMBER;
      lv_des_error    ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;
      lv_sql := 'SELECT GA_SEQ_NUMDIASNUM.NEXTVAL FROM DUAL';

      SELECT ga_seq_numdiasnum.NEXTVAL
        INTO li_numdiasnum
        FROM DUAL;

      RETURN li_numdiasnum;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10820;
         sv_mens_retorno := 'Error al obtener el numero de dias num';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneNumDiasNum_FN;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneNumDiasNum_FN', lv_sql, SQLCODE, lv_des_error);
   END ve_obtienenumdiasnum_fn;

   PROCEDURE ve_obtiene_valor_parametro_pr (
      ev_nomparametro   IN              ged_parametros.nom_parametro%TYPE,
      ev_codmodulo      IN              ged_parametros.cod_modulo%TYPE,
      ev_codproducto    IN              ged_parametros.cod_producto%TYPE,
      sv_valparametro   OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_valor_parametro_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> Retorna el valor del parametro buscado </Retorno>
      <Descripción>
         Retorna el valor del parametro
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_nomparametro" Tipo="VARCHAR2">Nombre del parametro</param>
            <param nom="EV_codmodulo" Tipo="VARCHAR2">codigo de modulo</param>
            <param nom="EV_codproducto" Tipo="VARCHAR2">codigo de producto</param>
          </Entrada>
            <Salida>
            <param nom="SV_valparametro" Tipo="VARCHAR2">valor de parametro buscado</param>
            <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
              <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
              <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT a.val_parametro ' || 'FROM ged_parametros a ' || 'WHERE a.nom_parametro = ' || ev_nomparametro || ' AND a.cod_modulo = ' || ev_codmodulo || ' AND a.cod_producto = ' || ev_codproducto;

      SELECT a.val_parametro
        INTO sv_valparametro
        FROM ged_parametros a
       WHERE a.nom_parametro = ev_nomparametro AND a.cod_modulo = ev_codmodulo AND a.cod_producto = ev_codproducto;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10752;
         sv_mens_retorno := 'Error al consultar valor del parametro';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_obtiene_valor_parametro_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_obtiene_valor_parametro_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10821;
         sv_mens_retorno := 'Error al obtener el valor del parametro especificado';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_obtiene_valor_parametro_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_valor_parametro_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_valor_parametro_pr;

   PROCEDURE ve_obtiene_secuencia_pr (
      ev_nomsecuencia   IN              VARCHAR2,
      sv_secuencia      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) AS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_secuencia_PR"
         Lenguaje="PL/SQL"
         Fecha="22-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> Numero de secuencia solicitado </Retorno>
      <Descripción> Retorna el numero de secuencia </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_nomsecuencia" Tipo="VARCHAR2"> identificador de la secuencia</param>
      </Entrada>
      <Salida>
         <param nom="SV_secuencia" Tipo="VARCHAR2"> numero secuencia</param>
         <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
         <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT ' || ev_nomsecuencia || '.NEXTVAL FROM DUAL';

      EXECUTE IMMEDIATE lv_sql
                   INTO sv_secuencia;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10822;
         sv_mens_retorno := 'Error al obtener el numero de secuencia solicitado';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_obtiene_secuencia_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_secuencia_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_secuencia_pr;

   PROCEDURE ve_obtiene_transaccion_pr (
      en_transaccion    IN              NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_transaccion_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>Obtiene transacion de tabla GA_TRANSACABO</Retorno>
      <Descripción>
         OBTIENE TRANSACION DE TABLA GA_TRANSACABO
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EN_transaccion" Tipo="NUMBER> numero de transaccion </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
         <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_sql         ge_errores_pg.vquery;
      lv_des_error   ge_errores_pg.desevent;
	  n_cod_error    ga_transacabo.cod_retorno%TYPE;
	  v_des_error    ga_transacabo.des_cadena%TYPE;
	  error_restriccion EXCEPTION;

   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT a.cod_retorno,a.des_cadena ' || 'INTO   SN_cod_retorno, SV_mens_retorno ' || 'FROM   ga_transacabo a ' || 'WHERE  a.num_transaccion = ' || en_transaccion;

      SELECT nvl(a.cod_retorno,0), a.des_cadena
        INTO n_cod_error, sv_mens_retorno
        FROM ga_transacabo a
       WHERE a.num_transaccion = en_transaccion;

	   IF n_cod_error <> 0 THEN
	      RAISE error_restriccion;
	   END IF;



   EXCEPTION
      WHEN error_restriccion THEN
         sn_cod_retorno  := 1753;
         lv_des_error    := 'error_restriccion :ve_intermediario_quiosco_pg.ve_obtiene_transaccion_pr;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_secuencia_PR', lv_sql, SQLCODE, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10753;
         sv_mens_retorno :='Error al obtener transacion de tabla GA_TRANSACABO';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.ve_obtiene_transaccion_pr;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_secuencia_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10823;
         sv_mens_retorno := 'Error al obtener numero de transacion';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.ve_obtiene_transaccion_pr;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_secuencia_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_transaccion_pr;

   PROCEDURE ve_bloqdesbloq_vendedor_pr (
      ev_codvendedor    IN              ve_vendedores.cod_vendedor%TYPE,
      ec_accion         IN              CHAR,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_bloqdesbloq_vendedor_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>Bloquea o desbloquea el vendedor</Retorno>
      <Descripción>
         Bloquea o desbloquea el vendedor segun accion
         accion:
                "B" bloquea / "D" desbloquea
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_codvendedor" Tipo="NUMBER> codigo del vendedor </param>
         <param nom="EC_accion"      Tipo="CHAR"> accion a realizar </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      le_exception_fin     EXCEPTION;
   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ',' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      END IF;

      -- llamar procedimiento de bloqueo/desbloqueo del vendedor
      lv_sql := 'P_GA_BLOQUEA_VENDEDOR(' || ln_num_transaccion || ',' || ev_codvendedor || ',' || ec_accion || ')';
      p_ga_bloquea_vendedor (ln_num_transaccion, ev_codvendedor, ec_accion);
      -- verificamos estado del llamado
      lv_sql := 'VE_obtiene_transaccion_PR(' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_transaccion_pr (ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      END IF;
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin:ve_intermediario_quiosco_pg.VE_bloqdesbloq_vendedor_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_bloqdesbloq_vendedor_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10824;
         sv_mens_retorno := 'Error al bloquear o desbloquear vendedor segun accion especificada';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_bloqdesbloq_vendedor_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_bloqdesbloq_vendedor_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_bloqdesbloq_vendedor_pr;
/*procedimiento comentado debido a que la llamada al método  ve_numeracion_pg.p_numeracion_automatica_pr no existe.*/
/*método ve_obtienenumerocelularaut_pr habilitado nuevamente*/
 PROCEDURE ve_obtienenumerocelularaut_pr (
      ev_codsubalm       IN              VARCHAR2,
      ev_codcentral      IN              VARCHAR2,
      ev_coduso          IN              VARCHAR2,
      ev_codactabo       IN              VARCHAR2,
      sv_numerocelular   OUT NOCOPY      VARCHAR2,
      sv_tipocelular     OUT NOCOPY      VARCHAR2,
      sv_categoria       OUT NOCOPY      VARCHAR2,
      sv_fechabaja       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS

      /*
      <Documentación TipoDoc = "Procedimiento">
      <Elemento Nombre = "VE_ObtieneNumeroCelularAut_PR"
      Lenguaje="PL/SQL"
      Fecha="01-03-2007"
      Versión="1.0.0"
      Diseñador="wjrc"
      Programador="wjrc"
      Ambiente="BD">
      <Retorno> Numero de celular </Retorno>
      <Descripción> Retorna el numero de celular </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_codsubalm"  Tipo="STRING"> codigo sub alimentador </param>
            <param nom="EV_codcentral" Tipo="STRING"> codigo central</param>
            <param nom="EV_coduso"     Tipo="STRING"> codigo uso </param>
            <param nom="EV_codActabo"  Tipo="STRING"> codigo actuacion venta </param>
         </Entrada>
         <Salida>
            <param nom="SV_numerocelular"  Tipo="STRING"> numero celular obtenido</param>
            <param nom="SV_tipocelular"    Tipo="STRING"> tipo del celular obtenido</param>
            <param nom="SV_categoria"      Tipo="STRING"> categoria del celular obtenido</param>
            <param nom="SV_fechabaja"      Tipo="STRING"> fecha baja del celular obtenido</param>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
         </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */

      ln_num_transaccion   NUMBER;
      ln_num_celular       NUMBER;
      ln_max               NUMBER;
      ln_ind               NUMBER;
	  ld_fecbaja		   DATE;
	  v_format_fecha 	   ga_transacabo.des_cadena%TYPE;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      la_arreglo           tipoarray              := tipoarray ();
      le_exception_fin     EXCEPTION;
      lv_cadena            ge_errores_pg.msgerror;                                                                                                                                                                      --inc. 94818 22-06-2009 VARCHAR2(100);
   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;

	  SELECT  val_parametro
	  INTO  v_format_fecha
	  FROM  ged_parametros
	  WHERE  cod_producto = 1
	  AND  cod_modulo = 'GE'
	  AND  nom_parametro = 'FORMATO_SEL2';

	   ve_numeracion_quiosco_pg.p_numeracion_automatica_pr(ev_codactabo, ev_codsubalm, ev_codcentral, ev_coduso,ln_num_celular,sv_categoria,ld_fecbaja,sv_tipocelular,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

	   sv_numerocelular := TO_CHAR(ln_num_celular);
	   sv_fechabaja		:= TO_CHAR(ld_fecbaja,v_format_fecha);

	   IF sn_cod_retorno <> 0 THEN
            RAISE le_exception_fin;
       END IF;

   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin: ve_intermediario_quiosco_pg.VE_ObtieneNumeroCelularAut_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneNumeroCelularAut_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10825;
         sv_mens_retorno := 'Error al obtener numero de celular';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneNumeroCelularAut_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneNumeroCelularAut_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtienenumerocelularaut_pr;

   PROCEDURE ve_reserva_numero_celular_pr (
      en_transaccion       IN              NUMBER,
      ev_numerolinea       IN              VARCHAR2,
      ev_numeroorden       IN              VARCHAR2,
      ev_numerocelular     IN              VARCHAR2,
      ev_codsubalmacen     IN              VARCHAR2,
      ev_codigocentral     IN              VARCHAR2,
      ev_codigocategoria   IN              VARCHAR2,
      ev_codigouso         IN              VARCHAR2,
      ev_indprocnumero     IN              VARCHAR2,
      ev_fecbajacelular    IN              VARCHAR2,
	  ev_usuarioora        IN              VARCHAR2,
      sn_cod_retorno       OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_reserva_numero_celular_PR"
         Lenguaje="PL/SQL"
         Fecha="21-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Inserta reserva numero celular en GA_RESNUMCEL
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EN_transaccion"     Tipo="NUMBER"> numero de transaccion </param>
         <param nom="EV_numeroLinea"     Tipo="VARCHAR2"> numero de linea </param>
         <param nom="EV_numeroOrden"     Tipo="VARCHAR2"> numero de orden </param>
         <param nom="EV_numeroCelular"   Tipo="VARCHAR2"> numero de celular </param>
         <param nom="EV_codSubAlmacen"   Tipo="VARCHAR2"> codigo sub almacen </param>
         <param nom="EV_codigoCentral"   Tipo="VARCHAR2"> codigo central </param>
         <param nom="EV_codigoCategoria" Tipo="VARCHAR2"> codigo categoria </param>
         <param nom="EV_codigoUso"       Tipo="VARCHAR2"> codigo uso </param>
         <param nom="EV_indProcNumero"   Tipo="VARCHAR2"> indicador procedencia numero </param>
         <param nom="EV_fecBajaCelular"  Tipo="VARCHAR2"> fecha baja celular </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_fecbajacelular   VARCHAR2 (100);
      lv_des_error        ge_errores_pg.desevent;
      lv_sql              ge_errores_pg.vquery;
      le_exception_fin    EXCEPTION;
      ln_count            NUMBER;
      lv_cod_subalm       ga_reserva.cod_subalm%TYPE;
      lv_cod_central      ga_reserva.cod_central%TYPE;
      lv_cod_cat          ga_reserva.cod_cat%TYPE;
      lv_cod_uso          ga_reserva.cod_uso%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      ln_count := 0;
      lv_cod_subalm := ev_codsubalmacen;
      lv_cod_central := ev_codigocentral;
      lv_cod_cat := ev_codigocategoria;
      lv_cod_uso := ev_codigouso;

      IF (ev_indprocnumero = cv_procnumero) THEN
         lv_fecbajacelular := TO_DATE (ev_fecbajacelular, ve_obtieneformatofecha_fn (sn_cod_retorno, sv_mens_retorno, sn_num_evento));

         IF sn_cod_retorno != 0 THEN
            RAISE le_exception_fin;
         END IF;
      ELSE
         lv_fecbajacelular := NULL;
      END IF;

      lv_sql := 'SELECT 1' || ' FROM ga_reserva a' || ' WHERE  a.num_celular =' || ev_numerocelular;

      SELECT COUNT (1)
        INTO ln_count
        FROM ga_reserva a
       WHERE a.num_celular = ev_numerocelular;

      IF (ln_count > 0) THEN
         lv_sql := 'SELECT a.cod_subalm,a.cod_central,' || ' a.cod_cat,a.cod_uso' || ' FROM   ga_reserva a' || ' WHERE  a.num_celular =' || ev_numerocelular;

         SELECT a.cod_subalm, a.cod_central, a.cod_cat, a.cod_uso
           INTO lv_cod_subalm, lv_cod_central, lv_cod_cat, lv_cod_uso
           FROM ga_reserva a
          WHERE a.num_celular = ev_numerocelular;
      END IF;

      lv_sql :=
         'INSERT INTO ga_resnumcel (num_transaccion' || '	,num_linea' || '	,num_orden' || '	,num_celular' || '	,cod_subalm' || '	,cod_producto' || '	,cod_central' || '	,cod_cat' || '	,cod_uso' || '	,fec_reserva' || '	,nom_usuario' || '	,ind_procnum'
         || '	,fec_baja' || ') VALUES (' || en_transaccion || ' ,' || ev_numerolinea || ' ,' || ev_numeroorden || ' ,' || ev_numerocelular || ' ,' || lv_cod_subalm || ' ,' || cv_producto || ' ,' || lv_cod_central || ' ,' || lv_cod_cat || ' ,'
         || lv_cod_uso || ' ,SYSDATE' || ' ,' ||ev_usuarioora || ' ,' || ev_indprocnumero || ' ,' || lv_fecbajacelular || ' )';

      INSERT INTO ga_resnumcel
                  (num_transaccion, num_linea, num_orden, num_celular, cod_subalm, cod_producto, cod_central, cod_cat, cod_uso, fec_reserva, nom_usuario, ind_procnum                         -- Indicativo de Procedencia del número; (L)ibres, (R)eutilizable
                                                                                                                                                                     ,
                   fec_baja                                                                                                                                                                                                       -- Si IND_PROCNUM = L -> NULL
                           )
      VALUES      (en_transaccion, ev_numerolinea, ev_numeroorden, ev_numerocelular, lv_cod_subalm, cv_producto, lv_cod_central, lv_cod_cat, lv_cod_uso, SYSDATE, ev_usuarioora, ev_indprocnumero,
                   lv_fecbajacelular);
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin:ve_intermediario_quiosco_pg.VE_reserva_numero_celular_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_reserva_numero_celular_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10826;
         sv_mens_retorno := 'Error al insertar reserva de numero celular';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_reserva_numero_celular_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_reserva_numero_celular_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_reserva_numero_celular_pr;

   PROCEDURE ve_obtienegrupotecnologico_pr (
      ev_tecnologia     IN              VARCHAR2,
      sv_valor          OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtieneGrupoTecnologico_PR"
         Lenguaje="PL/SQL"
         Fecha="12-04-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> Grupo tecnologia GSM </Retorno>
      <Descripción>
         Retorna grupo tecnologia GSM
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_tecnologia" Tipo="VARCHAR2"> tecnologia</param>
      </Entrada>
      <Salida>
         <param nom="SV_valor" Tipo="VARCHAR2">Grupo tecnologia </param>
         <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
         <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'GA_APROVISIONAR_CENTRAL_PG.PV_GRUPO_TECNOLOGICO_FN' || '(' || ev_tecnologia || ')';
      sv_valor := ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn (ev_tecnologia);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10754;
         sv_mens_retorno :='Error al consultar grupo tecnologia GSM';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_ObtieneGrupoTecnologico_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10827;
         sv_mens_retorno :='Error al obtener grupo tecnologia GSM';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneGrupoTecnologico_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtienegrupotecnologico_pr;

   PROCEDURE ve_ejecuta_prebilling_pr (
      ev_sec_transacabo   IN              VARCHAR2,
      ev_actprebilling    IN              VARCHAR2,
      ev_productogral     IN              VARCHAR2,
      ev_cod_cliente      IN              VARCHAR2,
      ev_num_venta        IN              VARCHAR2,
      ev_num_transacvta   IN              VARCHAR2,
      ev_num_procfact     IN              VARCHAR2,
      ev_modgeneracion    IN              VARCHAR2,
      ev_cattributaria    IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ejecuta_prebilling_PR"
         Lenguaje="PL/SQL"
         Fecha="12-04-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> Ejecucion de Prebilling </Retorno>
      <Descripción>
         Ejecuta Prebilling
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_sec_transacabo" Tipo="VARCHAR2"> secuencia transacabo </param>
         <param nom="EV_actprebilling" Tipo="VARCHAR2"> código actuación prebilling </param>
         <param nom="EV_productogral" Tipo="VARCHAR2"> producto general</param>
         <param nom="EV_cod_cliente" Tipo="VARCHAR2"> código cliente</param>
         <param nom="EV_num_venta" Tipo="VARCHAR2"> número de la venta</param>
         <param nom="EV_num_transacvta" Tipo="VARCHAR2"> numero de la transaccion de la venta</param>
         <param nom="EV_num_procfact" Tipo="VARCHAR2"> número proceso facturación</param>
         <param nom="EV_modgeneracion" Tipo="VARCHAR2"> modo generación</param>
         <param nom="EV_cattributaria" Tipo="VARCHAR2"> categoria tributaria de la venta</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno" Tipo="NUMBER">codigo de retorno del procedimiento</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje de retorno del procedimiento</param>
         <param nom="SN_num_evento" Tipo="NUMBER">numero de evento en caso de error en ejecucion</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_des_error    ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
      sformatofecha   ged_parametros.val_parametro%TYPE;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- Incidencia 45971 [PAAA 15-11-2007, soporte]
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr ('FORMATO_SEL2', cv_modulo_ge, cv_producto, sformatofecha, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE NO_DATA_FOUND;
      END IF;
      -- Fin 45971
      p_interfases_abonados (ev_sec_transacabo, ev_actprebilling, ev_productogral, ev_cod_cliente, ev_num_venta, ev_num_transacvta, ev_num_procfact, ev_modgeneracion, ev_cattributaria, TO_CHAR (SYSDATE, sformatofecha));
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10755;
         sv_mens_retorno :='Error en la Ejecucion de Prebilling';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_ObtieneGrupoTecnologico_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10828;
         sv_mens_retorno :='Error en la ejecucion de Prebilling';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneGrupoTecnologico_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneGrupoTecnologico_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_ejecuta_prebilling_pr;
------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplaza_cliente_pr (
      scodcliente       IN              ga_ventas.cod_cliente%TYPE,
      codplazacliente   OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtienePlaza_Cliente_PR
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
          <Descripción>
                     Bloquea o desbloquea el vendedor segun accion
                     accion:
                            "B" bloquea / "D" desbloquea
          </Descripción>
      <Parámetros>
          <Entrada>
             <param nom="scodcliente" Tipo="VARCHAR2"> codigo de cliente </param>
             <param nom="codPlazaOficina"  Tipo="VARCHAR2"> Código de la plaza de la venta - vendedor</param>
          </Entrada>
          <Salida>
             <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
             <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
             <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;
      -- Funcion que  devuelve el codigo de plaza a través del código del Cliente
      lv_sql := 'FN_OBTIENE_PLAZACLIENTE(' || scodcliente || ')';
      codplazacliente := fn_obtiene_plazacliente (scodcliente);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10829;
         sv_mens_retorno := 'Error al obtener codigo de plaza para el cliente especificado';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtienePlaza_Cliente_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtienePlaza_Cliente_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtieneplaza_cliente_pr;
------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneplaza_oficina_pr (
      scodoficina       IN              ga_ventas.cod_oficina%TYPE,
      codplazaoficina   OUT NOCOPY      ga_ventas.cod_plaza%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtienePlaza_Oficina_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
                 Obtiene codigo de la plaza de la oficina
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="scodOficina"      Tipo="STRING"> codigo de oficina </param>
         <param nom="codPlazaOficina"  Tipo="STRING"> Código de la plaza de la venta - vendedor</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'FN_OBTIENE_PLAZAOFICINA(' || scodoficina || ')';
      codplazaoficina := fn_obtiene_plazaoficina (scodoficina);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10830;
         sv_mens_retorno := 'Error al obtener codigo de plaza para la oficina especificada';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtienePlaza_Oficina_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtienePlaza_Oficina_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtieneplaza_oficina_pr;
------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtienepresupuesto_pr (
      en_num_proceso    IN              NUMBER,
      sn_cargos         OUT NOCOPY      NUMBER,
      sn_descuentos     OUT NOCOPY      NUMBER,
      sn_impuestos      OUT NOCOPY      NUMBER,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtienePresupuesto_PR"
         Lenguaje="PL/SQL"
         Fecha="04-05-2007"
         Versión="1.0.0"
         Diseñador="Héctor Hermosilla"
         Programador=Héctor Hermosilla"
         Ambiente="BD"
      <Retorno> N/A</Retorno>
      <Descripción>
         OBTIENE PRESUPUESTO DE LA VENTA
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="En_num_proceso" Tipo="NUMBER"> numero proceso facturación</param>
      </Entrada>
      <Salida>
          <param nom="SN_cargos"       Tipo="NUMBER"> total cargos </param>
         <param nom="SN_descuentos"   Tipo="NUMBER"> total descuentos </param>
         <param nom="SN_impuestos"    Tipo="NUMBER"> total impuestos </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
          <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
          <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT presupuesto.imp_base, presupuesto.imp_dto,' || ' presupuesto.imp_impuesto' || ' FROM ga_presupuesto presupuesto' || ' WHERE presupuesto.num_proceso =' || en_num_proceso;

      SELECT SUM (presupuesto.imp_base), SUM (presupuesto.imp_dto), SUM (presupuesto.imp_impuesto)
        INTO sn_cargos, sn_descuentos, sn_impuestos
        FROM ga_presupuesto presupuesto
       WHERE presupuesto.num_proceso = en_num_proceso;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10756;
         sv_mens_retorno := 'Obtiene Presupuesto De La Venta';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_ObtienePresupuesto_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_ObtienePresupuesto_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10831;
         sv_mens_retorno := 'Error al obtener presupuesto para la venta';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtienePresupuesto_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtienePresupuesto_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtienepresupuesto_pr;
------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtieneoperadora_pr (
      sv_codoperadora   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtieneOperadora_PR"
         Lenguaje="PL/SQL"
         Fecha="05-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> NUMBER </Retorno>
      <Descripción>
         Retorna codigo operadora
      </Descripción>
      <Parámetros>
      <Entrada> N/A </Entrada>
      <Salida>
          <param nom="SV_codoperadora" Tipo="VARCHAR2"> codigo operadora </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
          <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
          <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;

      --lv_sql := 'SELECT cod_operadora_scl FROM ge_operadora_scl a'
	  --       || ' WHERE ind_oper_principal = 1';

	  --SELECT cod_operadora_scl
	  --  INTO sv_codoperadora
	  --  FROM ge_operadora_scl a
	  -- WHERE ind_oper_principal = 1;
      
      lv_sql := 'GE_OBTIENE_OPERADORA_LOCAL_FN';
      sv_codoperadora:=GE_OBTIENE_OPERADORA_LOCAL_FN(SN_cod_retorno,SV_mens_retorno,SN_num_evento); --CSR-11002

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10757;
         sv_mens_retorno := 'Error al Obtener Operadora';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_ObtieneOperadora_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_ObtieneOperadora_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10832;
         sv_mens_retorno := 'Error al obtener codigo de la operadora';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneOperadora_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneOperadora_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtieneoperadora_pr;

   PROCEDURE ve_obtieneoperadora_pr (
      sv_codoperadora   OUT NOCOPY   VARCHAR2,
      sv_desoperadora   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtieneOperadora_PR"
         Lenguaje="PL/SQL"
         Fecha="05-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> NUMBER </Retorno>
      <Descripción>
         Retorna codigo y descripcion de la operadora
      </Descripción>
      <Parámetros>
      <Entrada> N/A </Entrada>
      <Salida>
          <param nom="SV_codoperadora" Tipo="STRING"> codigo operadora </param>
          <param nom="SV_desoperadora" Tipo="STRING"> descripcion operadora </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
          <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
          <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT a.cod_operadora_scl,a.des_operadora_scl ' || 'INTO SV_codoperadora,SV_desoperadora ' || 'FROM ge_operadora_scl_local b,ge_operadora_scl a ' || 'WHERE a.cod_operadora_scl=b.cod_operadora_scl';

      SELECT a.cod_operadora_scl, a.des_operadora_scl
        INTO sv_codoperadora, sv_desoperadora
        FROM ge_operadora_scl_local b, ge_operadora_scl a
       WHERE a.cod_operadora_scl = b.cod_operadora_scl;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10758;
         sv_mens_retorno := 'Error al Obtener Codigo y Descripcion de la Operadora';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_ObtieneOperadora_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_ObtieneOperadora_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10832;
         sv_mens_retorno := 'Error al obtener codigo de la operadora';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneOperadora_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneOperadora_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtieneoperadora_pr;

------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_numeracion_manual_pr (
      ev_num_celular      IN              VARCHAR2,
      ev_tip_numeracion   IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_numeracion_manual_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
                 Llama procedimiento p_numeracion_manual
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_num_celular"    Tipo="VARCHAR2">numero celular</param>
         <param nom="EV_tip_numeracion" Tipo="VARCHAR2">tipo celular</param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      ln_num_transaccion   NUMBER;
      ln_count             NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      le_exception_fin     EXCEPTION;
      lv_cod_subalm        ga_reserva.cod_subalm%TYPE;
      lv_cod_central       ga_reserva.cod_central%TYPE;
      lv_cod_cat           ga_reserva.cod_cat%TYPE;
      lv_cod_uso           ga_reserva.cod_uso%TYPE;
	  lv_tip_numeracion	   VARCHAR2(1);
	  ln_count2             NUMBER;
	  ln_count3             NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
	  lv_tip_numeracion := ev_tip_numeracion;
      lv_sql := 'SELECT 1' || ' FROM ga_reserva a' || ' WHERE  a.num_celular =' || ev_num_celular;

      SELECT COUNT (1)
        INTO ln_count
        FROM ga_reserva a
       WHERE a.num_celular = ev_num_celular;

	    SELECT COUNT (1)
        INTO ln_count2
        FROM ga_CELNUM_REUTIL a
       WHERE a.num_celular = ev_num_celular;

	    SELECT COUNT (1)
        INTO ln_count3
        FROM ga_CELNUM_uso a
        WHERE ev_num_celular between a.num_desde and a.num_hasta
	  AND NUM_LIBRES  > 0;

      IF (ln_count > 0) THEN
         lv_sql := 'SELECT a.cod_subalm,a.cod_central,' || ' a.cod_cat,a.cod_uso' || ' FROM   ga_reserva a' || ' WHERE  a.num_celular =' || ev_num_celular;

         SELECT a.cod_subalm, a.cod_central, a.cod_cat, a.cod_uso
           INTO lv_cod_subalm, lv_cod_central, lv_cod_cat, lv_cod_uso
           FROM ga_reserva a
          WHERE a.num_celular = ev_num_celular;
	  ELSE
	  	  IF (ln_count2 > 0) THEN
		  	  SELECT a.cod_subalm, a.cod_central, a.cod_cat, a.uso_anterior
	           INTO lv_cod_subalm, lv_cod_central, lv_cod_cat, lv_cod_uso
	           FROM ga_celnum_reutil a
	          WHERE a.num_celular = ev_num_celular;

			  lv_tip_numeracion := 'R';
	  	  ELSE
	  	  	  IF (ln_count3 > 0) THEN
			  	  SELECT a.cod_subalm, a.cod_central, a.cod_cat, a.cod_uso
		           INTO lv_cod_subalm, lv_cod_central, lv_cod_cat, lv_cod_uso
		           FROM ga_celnum_uso a
		          WHERE ev_num_celular between a.num_desde and a.num_hasta
				  AND NUM_LIBRES  > 0;

				  lv_tip_numeracion := 'U';

				end if;
			end if;
		end if;


		 ve_numeracion_quiosco_pg.p_numeracion_manual_pr (lv_tip_numeracion,lv_cod_subalm,lv_cod_central,lv_cod_cat,lv_cod_uso,ev_num_celular,sn_cod_retorno,sv_mens_retorno,sn_num_evento);

		 IF sn_cod_retorno <> 0 THEN
            RAISE le_exception_fin;
         END IF;


   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin:ve_intermediario_quiosco_pg.VE_numeracion_manual_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_numeracion_manual_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10833;
         sv_mens_retorno := 'Error al obtener numeracion manual';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_numeracion_manual_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_numeracion_manual_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_numeracion_manual_pr;
------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_obtiene_prefijo_num_pr (
      en_numcelular     IN              ga_abocel.num_celular%TYPE,
      sv_numprefijo     OUT NOCOPY      ga_celnum_subalm.num_min%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_prefijo_num_PR"
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
          <Descripción>
                 OBTIENE PREFIJO DE NUMERO DE CELULAR
          </Descripción>
      <Parámetros>
          <Entrada>
             <param nom="EN_numcelular Tipo="NUMBER"> Numero de Celular</param>
          </Entrada>
      <Salida>
         <param nom="SV_numprefijo"   Tipo="VARCHAR2"> prefijo celular</param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'AL_FN_PREFIJO_NUMERO(' || en_numcelular || ')';
      sv_numprefijo := al_fn_prefijo_numero (en_numcelular);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10759 ;
         sv_mens_retorno := 'Error Obtener Prefijo de Numero de Celular';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_obtiene_prefijo_num_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_obtiene_prefijo_num_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10834;
         sv_mens_retorno :='Error al obtener prefijo de numero de celular';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_obtiene_prefijo_num_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_prefijo_num_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_prefijo_num_pr;
------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE ve_valida_autentificacion_pr (
      ev_numserie       IN              al_series.num_serie%TYPE,
      ev_procedencia    IN              VARCHAR2,
      en_coduso         IN              al_usos.cod_uso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_valida_autentificacion_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Bloquea o desbloquea el vendedor segun accion
         accion:
                "B" bloquea / "D" desbloquea
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_numserie"    Tipo="VARCHAR2"> numero de serie </param>
         <param nom="EV_procedencia" Tipo="VARCHAR2"> procedencia equipo (E/I) </param>
         <param nom="EV_numserie"    Tipo="VARCHAR2> numero de serie </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      le_exception_fin     EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ', ' || ln_num_transaccion || ', ' || sn_cod_retorno || ', ' || sv_mens_retorno || ', ' || sn_num_evento || ')';
      ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      END IF;

      -- llamar procedimiento valida autentificacion
      lv_sql := 'VT_VALIDA_AUTENTICACION_PR(' || ln_num_transaccion || ', ' || ev_numserie || ', ' || ev_procedencia || ', ' || en_coduso || ')';
      vt_valida_autenticacion_pr (ln_num_transaccion, ev_numserie, ev_procedencia, en_coduso);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      END IF;

      -- verificamos estado del llamado
      lv_sql := 'VE_obtiene_transaccion_PR(' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_transaccion_pr (ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      END IF;
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin:ve_intermediario_quiosco_pg.VE_valida_autentificacion_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_valida_autentificacion_PR', lv_sql, SQLCODE, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno  := 10835;
         sv_mens_retorno := 'Error al validar autenticacion';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_valida_autentificacion_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_valida_autentificacion_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_valida_autentificacion_pr;

   PROCEDURE ve_obtiene_imsi_simcard_pr (
      ev_num_serie      IN              gsm_det_simcard_to.num_simcard%TYPE,
      ev_cod_campo      IN              gsm_campos_to.cod_campo%TYPE,
      sv_imsi           OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_obtiene_imsi_simcard_PR"
         Lenguaje="PL/SQL"
         Fecha="08-05-2007"
         Versión="1.0.0"
         Diseñador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Obtiene imsi de la simcard, utilizado para insertar movimiento en centrales
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_num_serie"   Tipo="VARCHAR2"> numero de la serie simcard</param>
         <param nom="EV_cod_campo"   Tipo="VARCHAR2"> código campo</param>
      </Entrada>
      <Salida>
         <param nom="SV_imsi"         Tipo="VARCHAR2"> prefijo celular</param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'FRECUPERSIMCARD_FN(' || ev_num_serie || ',' || ev_cod_campo || ')';
      sv_imsi := frecupersimcard_fn (ev_num_serie, ev_cod_campo);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno  := 10760;
         sv_mens_retorno := 'Error al consultar Imsi de la Simcard';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_obtiene_imsi_simcard_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_estado_proceso_PG.VE_obtiene_imsi_simcard_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10836;
         sv_mens_retorno := 'Error al obtener imsi de la simcard';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_obtiene_imsi_simcard_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_obtiene_imsi_simcard_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtiene_imsi_simcard_pr;

   PROCEDURE ve_actualiza_stock_pr (
      ev_tipomovto       IN              VARCHAR2,
      ev_tipstock        IN              VARCHAR2,
      ev_codbodega       IN              VARCHAR2,
      ev_codarticulo     IN              VARCHAR2,
      ev_coduso          IN              VARCHAR2,
      ev_codestado       IN              VARCHAR2,
      ev_numventa        IN              VARCHAR2,
      ev_numserie        IN              VARCHAR2,
      ev_indtelef        IN              VARCHAR2,
      sv_nummovimiento   OUT NOCOPY      VARCHAR2,
      sv_indsercontel    OUT NOCOPY      VARCHAR2,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_actualiza_stock_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>N/A</Retorno>
      <Descripción>
         LLama procedimiento P_GA_INTERAL, para actualizar stock
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EC_tipoMovto"    Tipo="VARCHAR2"> tipo movimiento </param>
         <param nom="EC_TipStock"     Tipo="VARCHAR2"> tipo stock </param>
         <param nom="EC_CodBodega"    Tipo="VARCHAR2"> codigo bodega </param>
         <param nom="EC_CodArticulo"  Tipo="VARCHAR2"> codigo articulo </param>
         <param nom="EC_CodUso"       Tipo="VARCHAR2"> codigo uso </param>
         <param nom="EC_CodEstado"    Tipo="VARCHAR2"> codigo estado </param>
         <param nom="EC_NumVenta"     Tipo="VARCHAR2"> numero venta </param>
         <param nom="EC_Numserie"     Tipo="VARCHAR2"> numero serie </param>
         <param nom="EC_IndTelef"     Tipo="VARCHAR2"> indicador telefono </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      le_exception_fin     EXCEPTION;
      la_arreglo           tipoarray              := tipoarray ();
      lv_cadena            ge_errores_pg.msgerror;                                                                                                                                                                      --inc. 94818 22-06-2009 VARCHAR2(100);
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ',' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      END IF;

      lv_sql :=
         'P_GA_INTERAL(' || ln_num_transaccion || ',' || ev_tipomovto || ',' || ev_tipstock || ',' || ev_codbodega || ',' || ev_codarticulo || ',' || ev_coduso || ',' || ev_codestado || ',' || ev_numventa || ',' || '1' || ',' || ev_numserie || ','
         || ev_indtelef || ')';
      -- llamar procedimiento P_GA_INTERAL
      p_ga_interal (ln_num_transaccion, ev_tipomovto, ev_tipstock, ev_codbodega, ev_codarticulo, ev_coduso, ev_codestado, ev_numventa, '1',                                                                                                         -- cantidad
                    ev_numserie, ev_indtelef);
      -- verificamos estado del llamado
      lv_sql := 'VE_obtiene_transaccion_PR(' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_transaccion_pr (ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF sn_cod_retorno <> 0 THEN
         RAISE le_exception_fin;
      ELSE
         IF (sv_mens_retorno = '') THEN
            RAISE le_exception_fin;
         ELSE
            lv_cadena := sv_mens_retorno;
            la_arreglo := ve_descompone_cadena_fn (lv_cadena, '/', sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            sv_nummovimiento := la_arreglo (1);
            sv_indsercontel := la_arreglo (2);
         END IF;
      END IF;
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin:ve_intermediario_quiosco_pg.VE_actualiza_stock_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_actualiza_stock_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10837;
         sv_mens_retorno := 'Error al actualizar Stock';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_actualiza_stock_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_actualiza_stock_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_actualiza_stock_pr;

   PROCEDURE ve_getconsumefolio_pr (
      sv_valor          OUT NOCOPY   ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getConsumeFolio_PR"
         Lenguaje="PL/SQL"
         Fecha="07-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Obtiene valor que indica si la operadora consume folio
      </Descripción>
      <Parámetros>
      <Entrada> N/A </Entrada>
      <Salida>
         <param nom="SV_valor"        Tipo="STRING"> valor parametro </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'GE_FN_CONSUMOFOLIO_SCL()';
      sv_valor := ge_fn_consumofolio_scl ();
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10838;
         sv_mens_retorno := 'Error al obtener valor de si la operadora consume folio';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_getConsumeFolio_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_getConsumeFolio_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_getconsumefolio_pr;

   PROCEDURE ve_getdatosgener_pr (
      ev_columna        IN              VARCHAR2,
      sv_valor          OUT NOCOPY      ged_parametros.val_parametro%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getDatosGener_PR"
         Lenguaje="PL/SQL"
         Fecha="12-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Obtiene valor columna de la tabla ga_datosgener
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="SV_columna"     Tipo="STRING"> columna de la tabla </param>
      </Entrada>
      <Salida>
         <param nom="SV_valor"        Tipo="STRING"> valor </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'SELECT a.' || ev_columna || ' FROM ga_datosgener a';

      EXECUTE IMMEDIATE lv_sql
                   INTO sv_valor;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10839;
         sv_mens_retorno := 'Error al obtener valor columna de la tabla datos generales';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_getDatosGener_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_getDatosGener_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_getdatosgener_pr;

   PROCEDURE ve_validaridentificador_pr (
      ev_modulo         IN              VARCHAR2,
      en_correlativo    IN              NUMBER,
      ev_numidentif     IN              VARCHAR2,
      ev_tipoidentif    IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ValidarIdentificador_PR"
         Lenguaje="PL/SQL"
         Fecha="12-04-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
      </Retorno>
      <Descripción>
         Valida numero identificacion
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_modulo"      Tipo="STRING"> modulo </param>
         <param nom="EN_correlativo" Tipo="NUMBER"> correlativo </param>
         <param nom="EV_numIdentif"  Tipo="STRING"> numero identificador </param>
         <param nom="EV_tipoIdentif"  Tipo="STRING"> tipo identificador </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo de retorno del procedimiento</param>
         <param nom="SV_mens_retorno" Tipo="STRING"> Mensaje de retorno del procedimiento</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      le_exception_fin   EXCEPTION;
      lv_des_error       ge_errores_pg.desevent;
      lv_sql             ge_errores_pg.vquery;
      lv_cadena          ge_errores_pg.msgerror;                                                                                                                                                                        --inc. 94818 22-06-2009 VARCHAR2(500);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'ge_fn_ejecuta_rutina_bind' || '(''' || ev_modulo || ''',' || en_correlativo || ',''''' || ev_numidentif || ''',''' || ev_tipoidentif || ''''')';
      lv_cadena := ge_fn_ejecuta_rutina_bind (ev_modulo, en_correlativo, '''' || ev_numidentif || ''',''' || ev_tipoidentif || '''');

      IF (INSTR (lv_cadena, 'ERROR') > 0) THEN
         RAISE le_exception_fin;
      END IF;
   EXCEPTION
      WHEN le_exception_fin THEN
         sn_cod_retorno  := 10840;
         sv_mens_retorno := 'Error al validar número identificación';
         lv_des_error    := 'NO_DATA_FOUND:ve_intermediario_quiosco_pg.VE_ValidarIdentificador_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ValidarIdentificador_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10840;
         sv_mens_retorno := 'Error al validar numero identificacion';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ValidarIdentificador_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ValidarIdentificador_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_validaridentificador_pr;

   PROCEDURE ve_obtienecategoriacta_pr (
      ev_numidentif     IN              VARCHAR2,
      ev_codcategtrib   IN              VARCHAR2,
      ev_tipomodulo     IN              VARCHAR2,
      ev_tipidentif     IN              VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsubcateg    OUT NOCOPY      VARCHAR2,
      sv_codmultuso     OUT NOCOPY      VARCHAR2,
      sv_codcliepot     OUT NOCOPY      VARCHAR2,
      sv_desrazon       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
      <Elemento Nombre = "VE_ObtieneCategoriaCta_PR"
      Lenguaje="PL/SQL"
      Fecha="01-03-2007"
      Versión="1.0.0"
      Diseñador="wjrc"
      Programador="wjrc"
      Ambiente="BD">
      <Retorno> Categoria de la cuenta </Retorno>
      <Descripción> Retorna categoria de la cuenta </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_numIdentif"   Tipo="STRING"> numero identificador</param>
            <param nom="EV_codCategTrib" Tipo="STRING"> codigo categoria tributaria </param>
            <param nom="EV_tipoModulo"   Tipo="STRING"> tipo modulo </param>
         </Entrada>
         <Salida>
            <param nom="SV_codCategoria" Tipo="STRING"> codigo categoria </param>
            <param nom="SV_codSubCateg"  Tipo="STRING"> codigo subcategoria </param>
            <param nom="SV_codMultUso"   Tipo="STRING"> codigo multi uso </param>
            <param nom="SV_codCliePot"   Tipo="STRING"> codigo cliente potencial </param>
            <param nom="SV_desRazon"     Tipo="STRING"> descripcion razon </param>
            <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
         </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      le_exception_fin     EXCEPTION;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      la_arreglo           tipoarray              := tipoarray ();
      -- (1) codigo categoria
      -- (2) odigo subcategoria
      -- (3) codigo multi uso
      -- (4) codigo cliente potencial
      -- (5) descripcion razon
      lv_cadena            ge_errores_pg.msgerror;                                                                                                                                                                      --inc. 94818 22-06-2009 VARCHAR2(100);
      ln_num_transaccion   NUMBER;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ',' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

      -- Llamar Procedimiento De Categoria Cuenta
      lv_sql := 'GA_P_CATCUENTAS_QUIOSCO(' || ln_num_transaccion || ',' || ev_numidentif || ',' || ev_codcategtrib || ',' || ev_tipomodulo || ',' || ev_tipidentif ||')';
      ga_p_catcuentas_quiosco (ln_num_transaccion, ev_numidentif, ev_codcategtrib, ev_tipomodulo,ev_tipidentif);

      -- Verificamos Estado Del Llamado
      lv_sql := 'VE_obtiene_transaccion_PR(' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_transaccion_pr (ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      lv_cadena := sv_mens_retorno;

      IF (sn_cod_retorno = 0) THEN
         la_arreglo := ve_descompone_cadena_fn (lv_cadena, '/', sn_cod_retorno, sv_mens_retorno, sn_num_evento);

         IF (sn_cod_retorno <> 0) THEN
            RAISE le_exception_fin;
         END IF;

         sv_codcategoria := la_arreglo (1);
         sv_codsubcateg := la_arreglo (2);
         sv_codmultuso := la_arreglo (3);
         sv_codcliepot := la_arreglo (4);
         sv_desrazon := la_arreglo (5);
      ELSE
         RAISE le_exception_fin;
      END IF;
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin: ve_intermediario_quiosco_pg.VE_ObtieneCategoriaCta_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneCategoriaCta_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10841;
         sv_mens_retorno := 'Error al obtener categoria de la cuenta';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtieneCategoriaCta_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtieneCategoriaCta_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtienecategoriacta_pr;

   PROCEDURE ve_getminmdn_pr (
      ev_numcelular     IN              VARCHAR2,
      sv_minmdn         OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getMinMDN_PR"
         Lenguaje="PL/SQL"
         Fecha="24-07-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
         Obtiene prefijo de numero de celular
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_numCelular    Tipo="STRING"> numero de celular</param>
      </Entrada>
      <Salida>
         <param nom="SV_minMDN"       Tipo="STRING"> numero minMDN</param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno</param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error</param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento</param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'GE_FN_MIN_DE_MDN(' || ev_numcelular || ')';
      sv_minmdn := ge_fn_min_de_mdn (ev_numcelular);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10842;
         sv_mens_retorno := 'Error al obtener prefijo de numero de celular';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_getMinMDN_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_getMinMDN_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_getminmdn_pr;

   PROCEDURE ve_obtieneplazacliente_pr (
      ev_codcliente     IN              VARCHAR2,
      sn_codplaza       OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_ObtienePlazaCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="01-03-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
                 Obtiene codigo de la plaza del cliente
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_codCliente" Tipo="STRING"> codigo del cliente </param>
      </Entrada>
      <Salida>
         <param nom="SV_codPlaza"  Tipo="STRING"> Código de la plaza </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'FN_OBTIENE_PLAZACLIENTE(' || ev_codcliente || ')';
      sn_codplaza := fn_obtiene_plazaoficina (ev_codcliente);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10829;
         sv_mens_retorno := 'Error al obtener codigo de plaza para el cliente especificado';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_ObtienePlazaCliente_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_ObtienePlazaCliente_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_obtieneplazacliente_pr;

   PROCEDURE ve_validarepeticiongsm_pr (
      ev_numserie       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_validarepeticionGSM_PR"
         Lenguaje="PL/SQL"
         Fecha="01-10-2007"
         Versión="1.0.0"
         Diseñador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
                 Valida las veces que puede ser vendido un terminal GSM
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_numserie" Tipo="STRING"> numero serie terminal </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'VE_VALIDA_REPETICION_GSM_PR(' || ev_numserie || ')';

      IF ev_numserie <> cv_imei_dummy then  -- GDO INC 147741 30-09-2010
        ve_valida_repeticion_gsm_pr (ev_numserie, sn_cod_retorno);
      END IF;   -- GDO INC 147741 30-09-2010
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10844;
         sv_mens_retorno := 'Error al validar repeticion de venta gsm';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_validarepeticionGSM_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_validarepeticionGSM_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_validarepeticiongsm_pr;

   PROCEDURE ve_validaformatogsm_pr (
      ev_numserie       IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_validaformatoGSM_PR"
         Lenguaje="PL/SQL"
         Fecha="01-10-2007"
         Versión="1.0.0"
         Diseñador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
                 Valida formato numero serie de terminal GSM
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_numserie" Tipo="STRING"> numero serie terminal </param>
      </Entrada>
      <Salida>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
      lv_respuesta   VARCHAR2 (10);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      lv_sql := 'Ge_Vluhn_Fn (''' || ev_numserie || ''')';
      lv_respuesta := ge_vluhn_fn (ev_numserie);

      IF lv_respuesta = '0' THEN
         sn_cod_retorno := 1;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10845;
         sv_mens_retorno := 'Error al validar formato de numSerie terminal GSM';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_validaformatoGSM_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_validaformatoGSM_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_validaformatogsm_pr;

   PROCEDURE ve_reponenumeracion_pr (
      en_num_celular    IN              ga_resnumcel.num_celular%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
      <Elemento Nombre = "VE_reponeNumeracion_PR"
      Lenguaje="PL/SQL"
      Fecha="12-10-2007"
      Versión="1.0.0"
      Diseñador="Héctor Hermosilla"
      Programador="Héctor Hermosilla"
      Ambiente="BD">
      <Retorno> Numero de celular </Retorno>
      <Descripción> Repone numero celular</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"  Tipo="NUMBER"> numero celular </param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
         </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      lv_codsubalm         ga_resnumcel.cod_subalm%TYPE;
      ln_central           ga_resnumcel.cod_central%TYPE;
      ln_categoria         ga_resnumcel.cod_cat%TYPE;
      ln_uso               ga_resnumcel.cod_uso%TYPE;
      le_exception_fin     EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ',' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

      lv_sql := 'SELECT a.cod_subalm, a.cod_central,' || ' a.cod_cat, a.cod_uso' || ' FROM   ga_resnumcel a' || ' WHERE  a.num_celular = EN_num_celular' || ' AND ROWNUM <=1';

      SELECT a.cod_subalm, a.cod_central, a.cod_cat, a.cod_uso
        INTO lv_codsubalm, ln_central, ln_categoria, ln_uso
        FROM ga_resnumcel a
       WHERE a.num_celular = en_num_celular AND ROWNUM <= 1;

      -- llamar procedimiento que realiza reposición de número celular
      lv_sql := 'P_REPONER_NUMERACION(' || ln_num_transaccion || ',' || cv_repone_celular || ',' || lv_codsubalm || ',' || ln_central || ',' || ln_categoria || ',' || ln_uso || ',' || en_num_celular || ',' || TO_CHAR (SYSDATE, 'DD/MM/YYYY') || ')';
      p_reponer_numeracion (ln_num_transaccion, cv_repone_celular, lv_codsubalm, ln_central, ln_categoria, ln_uso, en_num_celular, TO_CHAR (SYSDATE, 'DD/MM/YYYY'));
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error := 'LE_exception_fin: ve_intermediario_quiosco_pg.VE_reponeNumeracion_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_reponeNumeracion_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10846;
         sv_mens_retorno := 'Error al Reponer Numero Celular';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_reponeNumeracion_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_reponeNumeracion_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_reponenumeracion_pr;

   PROCEDURE ve_reponenumeracion_pr (
      en_num_celular    IN              ga_resnumcel.num_celular%TYPE,
      ev_tip_repos      IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
      <Elemento Nombre = "VE_reponeNumeracion_PR"
      Lenguaje="PL/SQL"
      Fecha="12-10-2007"
      Versión="1.0.0"
      Diseñador="Héctor Hermosilla"
      Programador="Héctor Hermosilla"
      Ambiente="BD">
      <Retorno> Numero de celular </Retorno>
      <Descripción> Repone numero celular</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EN_num_celular"  Tipo="NUMBER"> numero celular </param>
            <param nom="EV_tip_repos"    Tipo="NUMBER"> tipo reposición </param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"    Tipo="NUMBER"> codigo retorno </param>
            <param nom="SV_mens_retorno"   Tipo="STRING"> glosa mensaje error </param>
            <param nom="SN_num_evento"     Tipo="NUMBER"> numero de evento </param>
         </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      ln_num_transaccion   NUMBER;
      lv_des_error         ge_errores_pg.desevent;
      lv_sql               ge_errores_pg.vquery;
      lv_codsubalm         ga_resnumcel.cod_subalm%TYPE;
      ln_central           ga_resnumcel.cod_central%TYPE;
      ln_categoria         ga_resnumcel.cod_cat%TYPE;
      ln_uso               ga_resnumcel.cod_uso%TYPE;
      le_exception_fin     EXCEPTION;
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := NULL;
      sn_num_evento := 0;
      -- obtener numero de transaccion
      lv_sql := 'VE_obtiene_secuencia_PR(' || '''GA_SEQ_TRANSACABO''' || ',' || ln_num_transaccion || ',' || sn_cod_retorno || ',' || sv_mens_retorno || ',' || sn_num_evento || ')';
      ve_obtiene_secuencia_pr ('GA_SEQ_TRANSACABO', ln_num_transaccion, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

      lv_sql := 'SELECT a.cod_subalm, a.cod_central,' || ' a.cod_cat, a.cod_uso' || ' FROM   ga_resnumcel a' || ' WHERE  a.num_celular = EN_num_celular' || ' AND ROWNUM <=1';

      SELECT a.cod_subalm, a.cod_central, a.cod_cat, a.cod_uso
        INTO lv_codsubalm, ln_central, ln_categoria, ln_uso
        FROM ga_resnumcel a
       WHERE a.num_celular = en_num_celular AND ROWNUM <= 1;

      -- llamar procedimiento que realiza reposición de número celular
      lv_sql := 'P_REPONER_NUMERACION(' || ln_num_transaccion || ',' || ev_tip_repos || ',' || lv_codsubalm || ',' || ln_central || ',' || ln_categoria || ',' || ln_uso || ',' || en_num_celular || ',' || TO_CHAR (SYSDATE, 'DD/MM/YYYY') || ')';
      p_reponer_numeracion (ln_num_transaccion, ev_tip_repos, lv_codsubalm, ln_central, ln_categoria, ln_uso, en_num_celular, TO_CHAR (SYSDATE, 'DD/MM/YYYY'));
   EXCEPTION
      WHEN le_exception_fin THEN
         lv_des_error  := 'LE_exception_fin: ve_intermediario_quiosco_pg.VE_reponeNumeracion_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_reponeNumeracion_PR', lv_sql, SQLCODE, lv_des_error);

      WHEN OTHERS THEN
         sn_cod_retorno  := 10846;
         sv_mens_retorno := 'Error al reponer numero celular';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_reponeNumeracion_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_reponeNumeracion_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_reponenumeracion_pr;

   PROCEDURE ve_validatarjeta_pr (
      ev_cod_tarjeta    IN              VARCHAR2,
      ev_num_tarjeta    IN              VARCHAR2,
      sv_resultado      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_validaTarjeta_PR"
         Lenguaje="PL/SQL"
         Fecha="17-10-2007"
         Versión="1.0.0"
         Diseñador="Héctor Hermosilla"
         Programador="Héctor Hermosilla"
         Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripción>
                 Valida tarjeta de crédito y retorna banco y resultado de validación asociada a ella
      </Descripción>
      <Parámetros>
      <Entrada>
         <param nom="EV_cod_tarjeta" Tipo="STRING"> codigo de tarjeta</param>
         <param nom="EV_num_tarjeta" Tipo="STRING"> numero tarjeta de credito </param>
      </Entrada>
      <Salida>
         <param nom="SV_resultado"    Tipo="STRING"> resultado de validación </param>
         <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
         <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
         <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      --*/
      lv_des_error   ge_errores_pg.desevent;
      lv_sql         ge_errores_pg.vquery;
   BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;
      lv_sql          := 'Co_Validatarjeta_Pg.Co_Validatarjeta_fn (''' || ev_cod_tarjeta || ''',''' || ev_num_tarjeta || ''')';
      sv_resultado := co_validatarjeta_pg.co_validatarjeta_fn (ev_cod_tarjeta, ev_num_tarjeta);
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10848;
         sv_mens_retorno := 'Error al validar tarjeta de credito';
         lv_des_error    := 'OTHERS:ve_intermediario_quiosco_pg.VE_validaTarjeta_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 've_intermediario_quiosco_pg.VE_validaTarjeta_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_validatarjeta_pr;
END ve_intermediario_quiosco_pg; 
/

SHOW ERRORS