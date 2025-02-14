CREATE OR REPLACE PACKAGE BODY VE_ALTA_CLIENTE_QUIOSCO_PG IS

--------------------
---- FUNCIONES -----
--------------------

FUNCTION ve_valida_uso_fn (
         ev_cod_uso  IN   al_usos.cod_uso%TYPE,
         sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
           sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
           sn_num_evento     OUT NOCOPY   ge_errores_pg.evento

) RETURN BOOLEAN IS

ln_comis NUMBER;
lv_sql   ge_errores_pg.vquery;
lv_des_error      ge_errores_pg.desevent;

BEGIN
      sn_cod_retorno  := 0;
      sv_mens_retorno := '';
      sn_num_evento   := 0;

      lv_sql := 'SELECT count(1) FROM   al_usos      WHERE  cod_uso = '||ev_cod_uso||'';

      SELECT count(1)
      INTO     ln_comis
      FROM   al_usos
      WHERE  cod_uso = ev_cod_uso;

      IF ln_comis > 0 THEN
           RETURN TRUE;
      END IF;

      RETURN FALSE;

EXCEPTION
      WHEN OTHERS THEN
           sn_cod_retorno  := 12501;
         sv_mens_retorno := 'Codigo uso no existe en la tabla AL_USOS';
         lv_des_error    := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.ve_valida_uso_fn;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.ve_valida_uso_fn', lv_sql, SQLCODE, lv_des_error);
         RETURN FALSE;
END ve_valida_uso_fn;

----------------------------------------------
FUNCTION ve_valida_ciclo_fn (
         ev_cod_ciclo IN   fa_ciclos.cod_ciclo%TYPE,
         sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
           sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
           sn_num_evento     OUT NOCOPY   ge_errores_pg.evento
) RETURN BOOLEAN IS

ln_comis NUMBER;
lv_sql   ge_errores_pg.vquery;
lv_des_error      ge_errores_pg.desevent;

BEGIN

      lv_sql := 'SELECT count(1) FROM fa_ciclos WHERE cod_ciclo = '||ev_cod_ciclo||'';
      SELECT count(1)
      INTO     ln_comis
      FROM   fa_ciclos
      WHERE  cod_ciclo = ev_cod_ciclo;

      IF ln_comis > 0 THEN
           RETURN TRUE;
      END IF;

      RETURN FALSE;

EXCEPTION
      WHEN OTHERS THEN
      sn_cod_retorno  := 12500;
      sv_mens_retorno := 'Codigo ciclo no existe en la tabla FA_CICLOS';
      lv_des_error    := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.ve_valida_ciclo_fn;- ' || SQLERRM;
      sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.ve_valida_ciclo_fn', lv_sql, SQLCODE, lv_des_error);
      RETURN FALSE;
END ve_valida_ciclo_fn;

----------------------------------------------
--------------------
-- PROCEDIMIENTOS --
--------------------


   PROCEDURE ve_getfecha_pr (
      ev_fecha                       VARCHAR2,
      ev_formatofecha                VARCHAR2,
      ev_formatohora                 VARCHAR2,
      sd_fecha          OUT NOCOPY   DATE,
      sn_cod_retorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*--
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getFecha_PR
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> NUMBER </Retorno>
      <Descripción>
         Retorna una fecha formateada segun parametros
      </Descripción>
      <Parámetros>
      <Entrada>
           <param nom="EV_fecha"        Tipo="VARCHAR2">fecha a formatear</param>
           <param nom="EV_formatofecha" Tipo="VARCHAR2">formato fecha</param>
           <param nom="EV_formatohora"  Tipo="VARCHAR2">formato hora</param>
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
      lv_des_error      ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      lv_codesql        ga_errores.cod_sqlcode%TYPE;
      lv_errmsql        ga_errores.cod_sqlerrm%TYPE;
      ln_numevento      NUMBER;
      lv_fechamaxima    VARCHAR2 (20);
      lv_formatofecha   VARCHAR2 (20);
      lv_formatohora    VARCHAR2 (20);
      ld_fecha          DATE;

   BEGIN

      sn_cod_retorno  := 0;
      sv_mens_retorno := NULL;
      sn_num_evento   := 0;

      --  OBTENEMOS EL VALOR PARA FORMATO FECHA SEL2
      lv_sql:= 've_intermediario_pg.ve_obtiene_valor_parametro_pr (ev_formatofecha, cv_modulo_ge, cv_producto, lv_formatofecha, lv_codesql, lv_errmsql, ln_numevento)';
      ve_intermediario_pg.ve_obtiene_valor_parametro_pr (ev_formatofecha, cv_modulo_ge, cv_producto, lv_formatofecha, lv_codesql, lv_errmsql, ln_numevento);

      --  OBTENEMOS EL VALOR PARA FORMATO FECHA SEL7
      lv_sql:= 've_intermediario_pg.ve_obtiene_valor_parametro_pr (ev_formatohora, cv_modulo_ge, cv_producto, lv_formatohora, lv_codesql, lv_errmsql, ln_numevento)';
      ve_intermediario_pg.ve_obtiene_valor_parametro_pr (ev_formatohora, cv_modulo_ge, cv_producto, lv_formatohora, lv_codesql, lv_errmsql, ln_numevento);

      lv_sql   := 'TO_DATE(' || ev_fecha || ',' || lv_formatofecha || ' ' || lv_formatohora || ')';
      sd_fecha := TO_DATE (ev_fecha, lv_formatofecha || ' ' || lv_formatohora);

   EXCEPTION
      WHEN OTHERS THEN
         lv_formatofecha := 'YYYYMMDD HH24MISS';
         sn_cod_retorno  := 10184;
         sv_mens_retorno := 'Error al obtener valor formato fecha';
         lv_des_error    := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getFecha_PR;- ' || SQLERRM;
         sn_num_evento   := ge_errores_pg.grabarpl (sn_num_evento, cv_modulo_ga, sv_mens_retorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getFecha_PR', lv_sql, SQLCODE, lv_des_error);
   END ve_getfecha_pr;

   PROCEDURE ve_getplancomercial_pr (
      ev_codcalifcte   IN              ve_plan_calcli.cod_calclien%TYPE,
      sn_codplancom    OUT NOCOPY      ve_cabplancom.cod_plancom%TYPE,
      sv_desplancom    OUT NOCOPY      ve_cabplancom.des_plancom%TYPE,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getPlanComercial_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna codigo y descripcion plan comercial, segun calificacion del cliente
      </Retorno>
      <Descripción>
              Retorna codigo y descripcion plan comercial, segun calificacion del cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codCalifCte"   Tipo="STRING"> codigo calificacion cliente </param>
          </Entrada>
            <Salida>
            <param nom="SV_codPlanCom"    Tipo="STRING"> codigo plan comercial </param>
            <param nom="SV_desPlanCom"    Tipo="STRING"> descripcion plan comercial </param>
            <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN

      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := ' SELECT b.cod_plancom,b.des_plancom '
             || ' FROM   ve_plan_calcli a, ve_cabplancom b'
             || ' WHERE  a.cod_plancom = b.cod_plancom '
             || ' AND    a.cod_calclien   = ' || ev_codcalifcte
             || ' AND    SYSDATE BETWEEN a.fec_asignacion '
             || ' AND    NVL(a.fec_desasignac,SYSDATE) '
             || ' AND    b.cod_plancom = a.cod_plancom '
             || ' AND   SYSDATE BETWEEN b.fec_desde '
             || ' AND NVL(b.fec_hasta,SYSDATE)';

      SELECT b.cod_plancom, b.des_plancom
        INTO sn_codplancom, sv_desplancom
        FROM ve_plan_calcli a, ve_cabplancom b
       WHERE a.cod_plancom  = b.cod_plancom
         AND a.cod_calclien = ev_codcalifcte
         AND SYSDATE BETWEEN a.fec_asignacion
         AND NVL (a.fec_desasignac, SYSDATE)
         AND b.cod_plancom = a.cod_plancom
         AND SYSDATE BETWEEN b.fec_desde
         AND NVL (b.fec_hasta, SYSDATE);

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10185;
         sv_menretorno := 'Error al consultar Plan Comercial, según calificación del cliente';
         lv_deserror   := 'NO_DATA_FOUND:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getPlanComercial_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getPlanComercial_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10000;
         sv_menretorno :='No es posible ejecutar este servicio.';
         lv_deserror   :='OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getPlanComercial_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getPlanComercial_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getplancomercial_pr;

   PROCEDURE ve_getcodigonuevocliente_pr (
      sn_codcliente   OUT NOCOPY   ge_clientes.cod_cliente%TYPE,
      sn_codretorno   OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getCodigoNuevoCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="23-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna codigo nuevo cliente
      </Retorno>
      <Descripción>
              Retorna codigo nuevo cliente
      </Descripción>
      <Parámetros>
            <Entrada>
               <param nom="SN_codCliente"  Tipo="STRING"> codigo nuevo cliente </param>
            </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql        := 'GE_SEG_CLIENTES_FN()';

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10186;
         sv_menretorno := 'Error al recuperar datos código nuevo cliente';
         lv_deserror   := 'NO_DATA_FOUND:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getCodigoNuevoCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getCodigoNuevoCliente_PR', lv_sql, SQLCODE, lv_deserror);

     WHEN OTHERS THEN
         sn_codretorno := 10700;
         sv_menretorno := 'Error al obtener código nuevo del cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getCodigoNuevoCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getCodigoNuevoCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getcodigonuevocliente_pr;

   PROCEDURE ve_getprospectocliente_pr (
      ev_codtipident     IN              ve_prospectos.cod_tipident%TYPE,
      ev_numident        IN              ve_prospectos.num_ident%TYPE,
      sv_nomnombre       OUT NOCOPY      ve_prospectos.nom_nombre%TYPE,
      sv_nomapellido1    OUT NOCOPY      ve_prospectos.nom_apellido1%TYPE,
      sv_nomapellido2    OUT NOCOPY      ve_prospectos.nom_apellido2%TYPE,
      sv_numtelef1       OUT NOCOPY      ve_prospectos.num_telef1%TYPE,
      sv_numtelef2       OUT NOCOPY      ve_prospectos.num_telef2%TYPE,
      sv_numfax          OUT NOCOPY      ve_prospectos.num_fax%TYPE,
      sv_nomreprlegal    OUT NOCOPY      ve_prospectos.nom_reprlegal%TYPE,
      sv_codtipidrepr    OUT NOCOPY      ve_prospectos.cod_tipidrepr%TYPE,
      sv_numidrepr       OUT NOCOPY      ve_prospectos.num_idrepr%TYPE,
      sn_codrubro        OUT NOCOPY      ve_prospectos.cod_rubro%TYPE,
      sv_codbanco        OUT NOCOPY      ve_prospectos.cod_banco%TYPE,
      sv_numcuenta       OUT NOCOPY      ve_prospectos.num_cuenta%TYPE,
      sv_codtiptarjeta   OUT NOCOPY      ve_prospectos.cod_tiptarjeta%TYPE,
      sv_numtarjeta      OUT NOCOPY      ve_prospectos.num_tarjeta%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getProspecto_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna cregistro de Evaluacion de Riesgo, segun numero de identificacion
      </Retorno>
      <Descripción>
              Retorna cregistro de Evaluacion de Riesgo, segun numero de identificacion
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codTipIdent" Tipo="STRING"> codigo tipo identificador </param>
            <param nom="EV_numIdent"    Tipo="STRING"> numero de identificacion </param>
          </Entrada>
            <Salida>
            <param nom="SV_nomNombre"     Tipo="STRING"> nombre </param>
            <param nom="SV_nomApellido1"  Tipo="STRING"> apellido 1 </param>
            <param nom="SV_nomApellido2"  Tipo="STRING"> apellido 2 </param>
            <param nom="SV_numTelef1"     Tipo="STRING"> numero telefono 1</param>
            <param nom="SV_numTelef2"     Tipo="STRING"> numero telefono 2</param>
            <param nom="SV_numFax"        Tipo="STRING"> numero fax </param>
            <param nom="SV_nomReprlegal"  Tipo="STRING"> nombre representante legal </param>
            <param nom="SV_codTipidrepr"  Tipo="STRING"> codigo tipo representante legal</param>
            <param nom="SV_numIdrepr"     Tipo="STRING"> numero identificador representante </param>
            <param nom="SN_codRubro"      Tipo="NUMBER"> codigo rubro </param>
            <param nom="SV_codBanco"      Tipo="STRING"> codigo banco </param>
            <param nom="SV_numCuenta"     Tipo="STRING"> numero cuenta </param>
            <param nom="SV_codTiptarjeta" Tipo="STRING"> codigo tipo tarjeta </param>
            <param nom="SV_numTarjeta"    Tipo="STRING"> numero tarjeta </param>
            <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */

      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := ' SELECT a.nom_nombre, a.nom_apellido1, a.nom_apellido2, a.num_telef1, a.num_telef2, a.num_fax, a.nom_reprlegal, a.cod_tipidrepr,'
             || ' a.num_idrepr, a.cod_rubro, a.cod_banco, a.num_cuenta, a.cod_tiptarjeta, a.num_tarjeta '
             || ' FROM ve_prospectos a'
             || ' WHERE a.cod_tipident ='''|| ev_codtipident || ''' '
             || ' AND   a.num_ident    ='  || ev_numident;

      SELECT a.nom_nombre, a.nom_apellido1, a.nom_apellido2, a.num_telef1, a.num_telef2, a.num_fax, a.nom_reprlegal, a.cod_tipidrepr,
             a.num_idrepr, a.cod_rubro, a.cod_banco, a.num_cuenta, a.cod_tiptarjeta, a.num_tarjeta
        INTO sv_nomnombre, sv_nomapellido1, sv_nomapellido2, sv_numtelef1, sv_numtelef2, sv_numfax, sv_nomreprlegal, sv_codtipidrepr,
             sv_numidrepr, sn_codrubro, sv_codbanco, sv_numcuenta, sv_codtiptarjeta, sv_numtarjeta
        FROM ve_prospectos a
       WHERE a.cod_tipident = ev_codtipident
         AND a.num_ident = ev_numident;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno  := 10187;
         sv_menretorno  := 'Error al consultar registro de Evaluacion de Riesgo';
         lv_deserror    := 'NO_DATA_FOUND:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoCliente_PR;- ' || SQLERRM;
         sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoCliente_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10701;
         sv_menretorno := 'Error al consultar Propecto del cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getprospectocliente_pr;

   PROCEDURE ve_getprospectodireccion_pr (
      en_codprospecto   IN              ve_prodireccion.cod_prospecto%TYPE,
      ev_tipdireccion   IN              ve_prodireccion.cod_tipdireccion%TYPE,
      sn_coddireccion   OUT NOCOPY      ve_prodireccion.cod_direccion%TYPE,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getProspectoDireccion_PR"
         Lenguaje="PL/SQL"
         Fecha="17-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna plan tarifario autorizado
      </Retorno>
      <Descripción>
              Retorna plan tarifario autorizado para la evaluacion de riesgo
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_numSolicitud" Tipo="NUMBER"> numero de solicitud </param>
            <param nom="EV_tipDireccion" Tipo="STRING"> tipo direccion </param>
          </Entrada>
            <Salida>
            <param nom="SV_codPlanTarif" Tipo="STRING"> codigo plan tarifario </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := 'SELECT a.cod_direccion '
             || 'FROM   ve_prodireccion a '
             || 'WHERE  a.cod_prospecto   <=' || en_codprospecto
             || 'AND    a.cod_tipdireccion = ' || ev_tipdireccion;

      SELECT a.cod_direccion
        INTO sn_coddireccion
        FROM ve_prodireccion a
       WHERE a.cod_prospecto <= en_codprospecto
         AND a.cod_tipdireccion = ev_tipdireccion;
                                                                                                                                                                    -- 2 !!!
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10188;
         sv_menretorno := 'Error al obtener datos del plan tarifario';
         lv_deserror   := 'NO_DATA_FOUND:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoDireccion_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoDireccion_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10702;
         sv_menretorno := 'Error al consultar Prospecto de dirección';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoDireccion_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getProspectoDireccion_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getprospectodireccion_pr;

   PROCEDURE ve_getclientevendedor_pr (
      ev_codtipident     IN              ge_clientes.cod_tipident%TYPE,
      ev_numident        IN              ge_clientes.num_ident%TYPE,
      sn_codcategoria    OUT NOCOPY      ge_clientes.cod_categoria%TYPE,
      sn_codsector       OUT NOCOPY      ge_clientes.cod_sector%TYPE,
      sn_codsupervisor   OUT NOCOPY      ge_clientes.cod_supervisor%TYPE,
      sn_codvendedor     OUT NOCOPY      ve_vendcliente.cod_vendedor%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getClienteVendedor_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              datos cliente y vendedor
      </Retorno>
      <Descripción>
              Saber si otro cliente con igual identificacion ya esta creado
      <Parámetros>
      </Descripción>
             <Entrada>
                <param nom="EV_codTipIdent"   Tipo="STRING"> codigo tipo identificador </param>
                <param nom="EV_numIdent"      Tipo="STRING"> numero de identificacion </param>
             </Entrada>
             <Salida>
                <param nom="SN_codCategoria"  Tipo="NUMBER"> codigo categoria </param>
                <param nom="SN_codSector"     Tipo="NUMBER"> codigo sector </param>
                <param nom="SN_codSupervisor" Tipo="NUMBER"> codigo supervisor </param>
                <param nom="SN_codVendedor"   Tipo="NUMBER"> codigo vendedor </param>
                <param nom="SN_codRetorno"    Tipo="NUMBER"> codigo de retorno del procedimiento </param>
                <param nom="SV_menRetorno"    Tipo="STRING"> Mensaje de retorno del procedimiento </param>
                <param nom="SN_numEvento"     Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
             </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */

      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := 'SELECT a.cod_categoria, a.cod_sector,a.cod_supervisor, b.cod_vendedor '
             || 'FROM   ge_clientes a,ve_vendcliente b '
             || 'WHERE  a.num_ident = ''' || ev_numident || ''' '
             || 'AND    a.num_ident = ''' || ev_numident || ''' '
             || 'AND    a.cod_categoria IS NOT NULL '
             || 'AND    a.cod_cliente = b.cod_cliente(+)';

      SELECT a.cod_categoria, a.cod_sector, a.cod_supervisor, b.cod_vendedor
        INTO sn_codcategoria, sn_codsector, sn_codsupervisor, sn_codvendedor
        FROM ge_clientes a, ve_vendcliente b
       WHERE a.cod_tipident = ev_codtipident
         AND a.num_ident    = ev_numident
         AND a.cod_categoria IS NOT NULL
         AND a.cod_cliente  = b.cod_cliente(+);

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno := 10189;
         sv_menretorno := 'Error al obtener datos del cliente y vendedor';
         lv_deserror   := 'NO_DATA_FOUND:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getClienteVendedor_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getClienteVendedor_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10703;
         sv_menretorno := 'Error al consultar datos del cliente y vendedor';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getClienteVendedor_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getClienteVendedor_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getclientevendedor_pr;

   PROCEDURE ve_getcodigonuevaempresa_pr (
      sn_codempresa   OUT          ga_empresa.cod_empresa%TYPE,
      sn_codretorno   OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getCodigoNuevaEmpresa_PR"
         Lenguaje="PL/SQL"
         Fecha="17-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna codigo nueva empresa
      </Retorno>
        <Descripción>
              Retorna codigo nueva empresa
        </Descripción>
        <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
              <param nom="SN_codempresa" Tipo="NUMBER"> codigo nueva empresa </param>
              <param nom="SN_codRetorno" Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno" Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"  Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
         </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql := 'SELECT ga_seq_empresa.NEXTVAL FROM DUAL';

      SELECT ga_seq_empresa.NEXTVAL
        INTO sn_codempresa
        FROM DUAL;

   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10704;
         sv_menretorno := 'Error al consultar codigo nueva empresa';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getCodigoNuevaEmpresa_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getCodigoNuevaEmpresa_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getcodigonuevaempresa_pr;

   PROCEDURE ve_getlistgedcodigos_pr (
      ev_modulo        IN              VARCHAR2,
      ev_tabla         IN              VARCHAR2,
      ev_columna       IN              VARCHAR2,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListGedCodigos_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de codigos
      </Descripción>
      <Parámetros>
            <Entrada>
            </Entrada>
              <param nom="EV_modulo"      Tipo="STRING"> modulo </param>
              <param nom="EV_tabla"       Tipo="STRING"> tabla </param>
              <param nom="EV_columna"     Tipo="STRING"> columna </param>
            <Salida>
              <param nom="SV_cursorDatos" Tipo="CURSOR"> cursor codigos </param>
              <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1)'
             || 'FROM   ged_codigos a'
             || 'WHERE  a.cod_modulo  ='|| ev_modulo
             || 'AND    a.nom_tabla   ='|| ev_tabla
             || 'AND    a.nom_columna ='||ev_columna;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ged_codigos a
       WHERE a.cod_modulo  = ev_modulo
         AND a.nom_tabla   = ev_tabla
         AND a.nom_columna = ev_columna;

      lv_sql := 'SELECT a.cod_valor,a.des_valor '
             || 'FROM   ged_codigos a '
             || 'WHERE  a.cod_modulo   = ' || ev_modulo
             || 'AND    a.nom_tabla    = ' || ev_tabla
             || 'AND    a.nom_columna  = ' || ev_columna;

      OPEN sc_cursordatos FOR
         SELECT a.cod_valor, a.des_valor
           FROM ged_codigos a
          WHERE a.cod_modulo  = ev_modulo
            AND a.nom_tabla   = ev_tabla
            AND a.nom_columna = ev_columna;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10190;
         sv_menretorno := 'Error al consultar lista de códigos';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListGedCodigos_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListGedCodigos_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10705;
         sv_menretorno := 'Error al tratar de obtener lista de codigos';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListGedCodigos_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListGedCodigos_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistgedcodigos_pr;

   PROCEDURE ve_getlisttiposidentif_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListTiposIdentif_PR"
         Lenguaje="PL/SQL"
         Fecha="17-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de tipos de identificacion
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor tipos de identificacion </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */

      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1)'
             || 'FROM ge_tipident';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_tipident;

      lv_sql := 'SELECT a.cod_tipident,a.des_tipident,a.ind_pertrib,a.ind_salefact '
             || 'FROM ge_tipident a ';

      OPEN sc_cursordatos FOR
         SELECT a.cod_tipident, a.des_tipident, a.ind_pertrib, a.ind_salefact
           FROM ge_tipident a;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10191;
         sv_menretorno := 'Error al consultar lista de tipos de identificacion';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTiposIdentif_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTiposIdentif_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10706;
         sv_menretorno :='Error al obtener lista de tipos de Identificacion';
         lv_deserror   :='OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTiposIdentif_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTiposIdentif_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlisttiposidentif_pr;

   PROCEDURE ve_getlistcategorias_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListCategorias_PR"
         Lenguaje="PL/SQL"
         Fecha="17-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de categorias
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor categorias </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
        ln_contador := 0;

     lv_sql := 'SELECT COUNT (1) FROM ge_categorias';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_categorias;

      lv_sql := 'SELECT a.cod_categoria,a.des_categoria'
             || 'FROM ge_categorias a ';

      OPEN sc_cursordatos FOR
         SELECT a.cod_categoria, a.des_categoria
           FROM ge_categorias a;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno  := 10192;
         sv_menretorno  := 'Error al consultar lista de categorias';
         lv_deserror    := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategorias_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno  := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento   := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategorias_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10707;
         sv_menretorno := 'Error al obtener lista de las categorias';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategorias_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategorias_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistcategorias_pr;

   PROCEDURE ve_getlistcategimpositivas_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListCategImpositivas_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de categorias impositivas
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor categorias impositivas </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1) FROM ge_catimpositiva';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_catimpositiva;

      lv_sql := 'SELECT   a.cod_catimpos,a.des_catimpos '
             || 'FROM     ge_catimpositiva a '
             || 'ORDER BY a.des_catimpos';

      OPEN sc_cursordatos FOR
           SELECT a.cod_catimpos, a.des_catimpos
             FROM ge_catimpositiva a
         ORDER BY a.des_catimpos;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10193;
         sv_menretorno := 'Error al consultar lista de categorias impositivas';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategImpositivas_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategImpositivas_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10708;
         sv_menretorno := 'Error al obtener lista de caterias impositivas';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategImpositivas_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListCategImpositivas_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistcategimpositivas_pr;

   PROCEDURE ve_getlisttipcomisionistas_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListTipComisionistas_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de tipos de comisionistas
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor tipos de comisionistas </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1) FROM ve_tipcomis';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ve_tipcomis;

      lv_sql := 'SELECT a.cod_tipcomis,a.des_tipcomis, a.ind_vta_externa'
             || ' FROM ve_tipcomis a '
             || ' ORDER BY a.des_tipcomis';

      OPEN sc_cursordatos FOR
           SELECT a.cod_tipcomis, a.des_tipcomis, a.ind_vta_externa
             FROM ve_tipcomis a
         ORDER BY a.des_tipcomis;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10194;
         sv_menretorno := 'Error al consultar lista de tipos de comisionistas';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTipComisionistas_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTipComisionistas_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10709;
         sv_menretorno := 'Error al obtener lista de tipos de comisionistas';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTipComisionistas_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTipComisionistas_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlisttipcomisionistas_pr;

   PROCEDURE ve_getlistmodalidadpago_pr (
      en_indmanual     IN              ge_sispago.ind_manual%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
       /*
       <Documentación TipoDoc = "Procedimiento">
          Elemento Nombre = "VE_getListModalidadPago_PR"
          Lenguaje="PL/SQL"
          Fecha="22-05-2007"
          Versión="1.0.0"
          Diseñador="wjrc"
          Programador="wjrc"
          Ambiente="BD"
       <Retorno>
               Cursor
       </Retorno>
       <Descripción>
               Retorna lista de modalidad de pago
       </Descripción>
       <Parámetros>
             <Entrada>
              <param nom="EN_indManual"    Tipo="NUMBER"> indicador tipo de pago </param>
           </Entrada>
             <Salida>
               <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor modalidad de pago </param>
               <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
               <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
               <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
           </Salida>
       </Parámetros>
       </Elemento>
       </Documentación>
       */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := ' SELECT COUNT (1)'
             || ' FROM   ge_sispago a'
             || ' WHERE  a.ind_manual =' || en_indmanual;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_sispago a
       WHERE a.ind_manual = en_indmanual;

      lv_sql := 'SELECT a.cod_sispago,a.des_sispago '
             || 'FROM   ge_sispago a '
             || 'WHERE  a.ind_manual = ' || en_indmanual
             || 'ORDER  BY a.des_sispago';

      OPEN sc_cursordatos FOR
           SELECT a.cod_sispago, a.des_sispago
             FROM ge_sispago a
            WHERE a.ind_manual = en_indmanual
         ORDER BY a.des_sispago;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10195;
         sv_menretorno :='Error al consultar lista de modalidad de pago';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10710;
         sv_menretorno := 'Error al obtener lista de Modalidad de Pago';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistmodalidadpago_pr;

   PROCEDURE ve_getlistmodalidadpago_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListModalidadPago_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de modalidad de pago
      </Descripción>
      <Parámetros>
            <Entrada>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor modalidad de pago </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1) FROM ge_sispago a';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_sispago a;

      lv_sql := 'SELECT a.cod_sispago,a.des_sispago,a.ind_manual '
             || 'FROM   ge_sispago a '
             || 'ORDER BY a.des_sispago';

      OPEN sc_cursordatos FOR
           SELECT a.cod_sispago, a.des_sispago, a.ind_manual
             FROM ge_sispago a
         ORDER BY a.des_sispago;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10195;
         sv_menretorno := 'Error al consultar lista de modalidad de pago';
         lv_deserror   := 'No se encontraron modalidaes de pago';
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10710;
         sv_menretorno := 'Error al obtener lista de Modalidad de Pago';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListModalidadPago_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistmodalidadpago_pr;

   PROCEDURE ve_getlistbancospac_pr (
      en_indpac        IN              ge_bancos.ind_pac%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListBancosPAC_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de bancos segun indicador PAC
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_indPAC"    Tipo="NUMBER"> indicador pago automatico de cuenta </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor bancos </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      error_validacion       EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      IF en_indpac IS NULL THEN
         sn_codretorno := 10196;
         sv_menretorno := 'Indicador de Pac no debe ser Nulo';
         RAISE error_validacion;
      END IF;

      IF NOT (en_indpac = 1 OR en_indpac = 0) THEN
         sn_codretorno := 10197;
         sv_menretorno := 'Indicador de Pac debe tener valores 1 ó 0';
         RAISE error_validacion;
      END IF;

     lv_sql := 'SELECT COUNT (1)'
            || 'FROM   ge_bancos a';
            --|| 'WHERE  a.ind_pac = '|| en_indpac; CSR-11002 INC-173004

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_bancos a;
       --WHERE a.ind_pac = en_indpac;

      lv_sql := 'SELECT a.cod_banco,a.des_banco '
             || 'FROM   ge_bancos a '
             --|| 'WHERE  a.ind_pac = ' || en_indpac CSR-11002 INC-173004
             || 'ORDER  BY a.des_banco';

      OPEN sc_cursordatos FOR
           SELECT a.cod_banco, a.des_banco
             FROM ge_bancos a
           -- WHERE a.ind_pac = en_indpac CSR-11002 INC-173004
         ORDER BY a.des_banco;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN error_validacion THEN
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancos_PR', lv_sql, sn_codretorno, sv_menretorno);

      WHEN no_data_found_cursor THEN
         sn_codretorno := 10198;
         sv_menretorno := 'Error al consultar lista de bancos segun indicador PAC';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancosPAC_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancos_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10711;
         sv_menretorno := 'Error al consultar lista de Bancos segun indicador PAC';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancosPAC_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancosPAC_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistbancospac_pr;

   PROCEDURE ve_getlistbancospac_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListBancosPAC_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de bancos segun indicador PAC
      </Descripción>
      <Parámetros>
            <Entrada>
               <param nom="EN_indPAC"    Tipo="NUMBER"> indicador pago automatico de cuenta </param>
            </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor bancos </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      error_validacion       EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1) FROM ge_bancos a';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_bancos a;

      lv_sql := 'SELECT a.cod_banco,a.des_banco,a.ind_pac '
             || 'FROM ge_bancos a '
             || 'ORDER BY a.des_banco';

      OPEN sc_cursordatos FOR
           SELECT a.cod_banco, a.des_banco, a.ind_pac
             FROM ge_bancos a
         ORDER BY a.des_banco;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10199;
         sv_menretorno := 'Error no se encontraron Bancos';
         lv_deserror   := 'No se encontraron Bancos';
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancos_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10712;
         sv_menretorno := 'Error al obtener lista de Bancos';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancosPAC_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListBancosPAC_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistbancospac_pr;

   PROCEDURE ve_getlistsucursalesbanco_pr (
      ev_codbanco      IN              ge_sucursales.cod_banco%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListSucursalesBanco_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de sucursales del banco
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EN_codBanco"    Tipo="STRING"> codigo del banco </param>
            </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor sucursales banco </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

     lv_sql := 'SELECT COUNT (1) '
            || ' FROM  ge_sucursales a'
            || ' WHERE a.cod_banco ='|| ev_codbanco;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_sucursales a
       WHERE a.cod_banco = ev_codbanco;

       lv_sql := 'SELECT a.cod_sucursal,a.des_sucursal '
              || 'FROM   ge_sucursales a '
              || 'WHERE  a.cod_banco = ' || ev_codbanco
              || 'ORDER BY a.des_sucursal';

      OPEN sc_cursordatos FOR
           SELECT a.cod_sucursal, a.des_sucursal
             FROM ge_sucursales a
            WHERE a.cod_banco = ev_codbanco
         ORDER BY a.des_sucursal;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10200;
         sv_menretorno := 'Error al consultar lista de sucursales del banco';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSucursalesBanco_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSucursalesBanco_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10713;
         sv_menretorno := 'Error al obtener Lista de Sucursales de Bancos';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSucursalesBanco_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSucursalesBanco_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistsucursalesbanco_pr;

   PROCEDURE ve_getlisttarjetas_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListTarjetas_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de tarjetas
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor tarjetas SCL </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1)'
              ||'FROM ge_tiptarjetas';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_tiptarjetas;

      lv_sql := 'SELECT a.cod_tiptarjeta,a.des_tiptarjeta '
             || 'FROM ge_tiptarjetas a '
             || 'ORDER BY a.des_tiptarjeta';

      OPEN sc_cursordatos FOR
           SELECT a.cod_tiptarjeta, a.des_tiptarjeta
             FROM ge_tiptarjetas a
         ORDER BY a.des_tiptarjeta;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10201;
         sv_menretorno := 'Error al consultar lista de tarjetas';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTarjetas_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTarjetasSCL_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10714;
         sv_menretorno :='Error al obtener Lista de Tarjetas';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTarjetas_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListTarjetas_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlisttarjetas_pr;

   PROCEDURE ve_getlistoficinasscl_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListOficinasSCL_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista de oficinas en SCL
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor oficinas </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1) FROM ge_oficinas';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_oficinas;

      lv_sql := 'SELECT a.cod_oficina,a.des_oficina '
             || 'FROM   ge_oficinas a '
             || 'ORDER BY a.des_oficina';

      OPEN sc_cursordatos FOR
           SELECT a.cod_oficina, a.des_oficina
             FROM ge_oficinas a
         ORDER BY a.des_oficina;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10202;
         sv_menretorno :='Error al consultar lista de oficinas en SCL';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListOficinasSCL_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListOficinasSCL_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10715;
         sv_menretorno :='Error al obtener Lista de Oficinas SCL';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListOficinasSCL_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListOficinasSCL_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistoficinasscl_pr;

   PROCEDURE ve_getlistplancomcalcte_pr (
      ev_codcalifcte   IN              ve_plan_calcli.cod_calclien%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListPlanComCalCte_PR"
         Lenguaje="PL/SQL"
         Fecha="05-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              Retorna lista planes comerciales por calidad del cliente
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EV_codCalifCte"  Tipo="STRING"> codigo calificacion cliente </param>
            </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor planes comerciales </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
            </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1)'
             || 'FROM   ve_plan_calcli a, ve_cabplancom b'
             || 'WHERE  a.cod_calclien = ev_codcalifcte '
             || 'AND    a.cod_plancom  = b.cod_plancom '
             || 'AND SYSDATE BETWEEN a.fec_asignacion '
             || 'AND NVL (a.fec_desasignac, SYSDATE) '
             || 'AND SYSDATE BETWEEN b.fec_desde '
             || ' AND NVL (b.fec_hasta, SYSDATE)';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ve_plan_calcli a, ve_cabplancom b
       WHERE a.cod_calclien = ev_codcalifcte
         AND a.cod_plancom = b.cod_plancom
         AND SYSDATE BETWEEN a.fec_asignacion
         AND NVL (a.fec_desasignac, SYSDATE)
         AND SYSDATE BETWEEN b.fec_desde
         AND NVL (b.fec_hasta, SYSDATE);

     lv_sql :='SELECT b.cod_plancom,b.des_plancom '
           || ' FROM ve_plan_calcli a, ve_cabplancom b '
           || ' WHERE a.cod_calclien = ' || ev_codcalifcte
           || ' AND a.cod_plancom    = b.cod_plancom '
           || ' AND SYSDATE BETWEEN a.fec_asignacion '
           || ' AND NVL(a.fec_desasignac,SYSDATE) '
           || ' AND SYSDATE BETWEEN b.fec_desde '
           || ' AND NVL(b.fec_hasta,SYSDATE)';


      OPEN sc_cursordatos FOR
         SELECT b.cod_plancom, b.des_plancom
           FROM ve_plan_calcli a, ve_cabplancom b
          WHERE a.cod_calclien = ev_codcalifcte
            AND a.cod_plancom = b.cod_plancom
            AND SYSDATE BETWEEN a.fec_asignacion
            AND NVL (a.fec_desasignac, SYSDATE)
            AND SYSDATE BETWEEN b.fec_desde
            AND NVL (b.fec_hasta, SYSDATE);

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10203;
         sv_menretorno :='Error al consultar lista de planes comerciales por calidad del cliente';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPlanComCalCte_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPlanComCalCte_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10716;
         sv_menretorno :='Error al obtener Lista Planes Comerciales por Calidad del Cliente';
         lv_deserror   :='OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPlanComCalCte_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPlanComCalCte_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistplancomcalcte_pr;

   PROCEDURE ve_getlistsubcategimpos_pr (
      ev_codcategimp   IN              al_tipo_codigo.tip_codigo%TYPE,
      sc_cursordatos   OUT NOCOPY      refcursor,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListSubCategImpos_PR"
         Lenguaje="PL/SQL"
         Fecha="22-05-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Retorna codigo y descripcion subcategoria impositiva
      </Retorno>
      <Descripción>
              Retorna codigo y descripcion subcategoria impositiva
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codCategImp" Tipo="STRING"> codigo categoria impositiva </param>
          </Entrada>
            <Salida>
            <param nom="SV_codSubCateg"  Tipo="STRING"> codigo subcategoria impositiva </param>
            <param nom="SV_desSubCateg"  Tipo="STRING"> descripcion subcategoria impositiva </param>
            <param nom="SN_codRetorno"  Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"  Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"   Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

     lv_sql :=' SELECT COUNT (1)'
            ||' FROM   al_tipo_codigo a, ged_codigos b'
            ||' WHERE  b.cod_modulo = cv_modulo_ga'
            ||' AND    b.nom_tabla  = a.nom_tabla '
            ||' AND    b.nom_columna = a.campo_codigo '
            ||' AND LENGTH (b.cod_valor) <= 3 '
            ||' AND    a.tip_codigo = cv_subcatimpos || ev_codcategimp';

      SELECT COUNT (1)
        INTO ln_contador
        FROM al_tipo_codigo a, ged_codigos b
       WHERE b.cod_modulo = cv_modulo_ga
         AND b.nom_tabla  = a.nom_tabla
         AND b.nom_columna = a.campo_codigo
         AND LENGTH (b.cod_valor) <= 3
         AND a.tip_codigo = cv_subcatimpos || ev_codcategimp;

     lv_sql :=' SELECT b.cod_valor,b.des_valor '
            ||' FROM   al_tipo_codigo a, ged_codigos b'
            ||' WHERE  b.cod_modulo  = ' || cv_modulo_ga
            ||' AND    b.nom_tabla   = a.nom_tabla '
            ||' AND    b.nom_columna = a.campo_codigo '
            ||' AND    LENGTH(b.cod_valor) <= 3 '
            ||' AND    a.tip_codigo  =' || cv_subcatimpos || ev_codcategimp;

      OPEN sc_cursordatos FOR
         SELECT b.cod_valor, b.des_valor
           FROM al_tipo_codigo a, ged_codigos b
          WHERE b.cod_modulo  = cv_modulo_ga
            AND b.nom_tabla   = a.nom_tabla
            AND b.nom_columna = a.campo_codigo
            AND LENGTH (b.cod_valor) <= 3
            AND a.tip_codigo  = cv_subcatimpos || ev_codcategimp;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10204;
         sv_menretorno :='Error al consultar subcategoria impositiva';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSubCategImpos_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSubCategImpos_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10717;
         sv_menretorno :='Error al obtener SubCategoria Impositiva';
         lv_deserror  := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSubCategImpos_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListSubCategImpos_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistsubcategimpos_pr;

   PROCEDURE ve_getlistactividades_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListActividades_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              Cursor
      </Retorno>
      <Descripción>
              RETORNA LISTADO DE ACTIVIDADES
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor actividades </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      lv_sql := 'SELECT COUNT (1) FROM ge_actividades';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_actividades;

      lv_sql := 'SELECT a.cod_actividad,a.des_actividad '
             || 'FROM ge_actividades a';

      OPEN sc_cursordatos FOR
         SELECT a.cod_actividad, a.des_actividad
           FROM ge_actividades a;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10205;
         sv_menretorno :='Error al consultar listado de actividades';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListActividades_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListActividades_PR', lv_sql, sn_codretorno, lv_deserror);

       WHEN OTHERS THEN
         sn_codretorno := 10718;
         sv_menretorno :='Error al obtener Listados de Actividades';
         lv_deserror   :='OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListActividades_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListActividades_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistactividades_pr;

   PROCEDURE ve_getlistpaises_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListPaises_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              CURSOR
      </Retorno>
      <Descripción>
              RETORNA LISTADO DE PAISES
      </Descripción>
      <Parámetros>
             <Entrada> N/A </Entrada>
            <Salida>
              <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor paises </param>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      no_data_found_cursor   EXCEPTION;
      lv_deserror            ge_errores_pg.desevent;
      lv_sql                 ge_errores_pg.vquery;
      ln_contador            NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

     lv_sql := 'SELECT COUNT (1) FROM ge_paises';

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_paises;

      lv_sql := 'SELECT a.cod_pais,a.des_pais FROM ge_paises a';

      OPEN sc_cursordatos FOR
         SELECT a.cod_pais, a.des_pais
           FROM ge_paises a;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno := 10206;
         sv_menretorno := 'Error al consultar Listado de Paises';
         lv_deserror   := SUBSTR ('NO_DATA_FOUND_CURSOR:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPaises_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPaises_PR', lv_sql, sn_codretorno, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10719;
         sv_menretorno := 'Error al obtener Listados de Paises';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPaises_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getListPaises_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistpaises_pr;

   PROCEDURE ve_inssecdespachocliente_pr (
      en_codcliente   IN              ga_secdespclie.cod_cliente%TYPE,
      ev_usuario      IN              VARCHAR2,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insSecDespachoCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA SECUENCIA DE DESPACHO PARA EL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente </param>
              <param nom="EV_coddespacho" Tipo="STRING"> codigo solicitud despacho </param>
             </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql           EXCEPTION;
      lv_deserror         ge_errores_pg.desevent;
      lv_sql              ge_errores_pg.vquery;
      lv_codigodespacho   VARCHAR2 (10);
      lv_fechamaxima      VARCHAR2 (20);
      ld_fecha            DATE;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      --  Obtenemos El Valor Para Formato Fecha Maxima
      lv_sql  :=' ve_intermediario_pg.ve_obtiene_valor_parametro_pr (cv_nompar_fechamaxima, cv_modulo_ge, cv_producto, lv_fechamaxima, sn_codretorno, sv_menretorno, sn_numevento)';
      ve_intermediario_pg.ve_obtiene_valor_parametro_pr (cv_nompar_fechamaxima, cv_modulo_ge, cv_producto, lv_fechamaxima, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      ve_getfecha_pr (lv_fechamaxima, cv_nompar_formatosel2, cv_nompar_formatosel7, ld_fecha, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;
      lv_sql  :=' fa_servicios_facturacion_pg.fa_getcodigodespacho_pr (lv_codigodespacho, sn_codretorno, sv_menretorno, sn_numevento)';
      fa_servicios_facturacion_pg.fa_getcodigodespacho_pr (lv_codigodespacho, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_sql :='INSERT INTO ga_secdespclie(cod_cliente, '
             || 'cod_despacho, '
             || 'fec_desde, '
             || 'fec_hasta, '
             || 'nom_usuario, '
             || 'fec_ultmod) '
             || 'VALUES (' || en_codcliente || ', '
             || lv_codigodespacho || ','
             || 'SYSDATE, ' || ld_fecha || ','
             || ev_usuario || ','
             || 'SYSDATE)';

      INSERT INTO ga_secdespclie
                  (cod_cliente, cod_despacho, fec_desde, fec_hasta, nom_usuario, fec_ultmod)
      VALUES      (en_codcliente, lv_codigodespacho, SYSDATE, ld_fecha, ev_usuario, SYSDATE);

   EXCEPTION
      WHEN error_sql THEN
         sn_codretorno := 10720;
         sv_menretorno := 'Error al ingresar Secuencia de Despacho para el Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insSecDespachoCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insSecDespachoCliente_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10720;
         sv_menretorno :='Error al ingresar Secuencia de Despacho para el Cliente';
         lv_deserror  := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insSecDespachoCliente_PR;- ' || SQLERRM;
         sn_numevento := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insSecDespachoCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inssecdespachocliente_pr;

   PROCEDURE ve_inscategoriatributaria_pr (
      en_codcliente   IN              ga_catributclie.cod_cliente%TYPE,
      ev_codcattrib   IN              ga_catributclie.cod_catribut%TYPE,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insCategoriaTributaria_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA CATEGORIA TRIBUTARIA PARA EL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EN_codcliente"  Tipo="NUMBER"> codigo cliente </param>
              <param nom="EV_codcattrib"  Tipo="STRING"> codigo categoria tributaria </param>
            </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql        EXCEPTION;
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      lv_fechamaxima   VARCHAR2 (20);
      ld_fecha         DATE;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      --  Obtenemos El Valor Para Formato Fecha Maxima
      lv_sql:='ve_intermediario_pg.ve_obtiene_valor_parametro_pr (cv_nompar_fechamaxima, cv_modulo_ge, cv_producto, lv_fechamaxima, sn_codretorno, sv_menretorno, sn_numevento)';
      ve_intermediario_pg.ve_obtiene_valor_parametro_pr (cv_nompar_fechamaxima, cv_modulo_ge, cv_producto, lv_fechamaxima, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;
      --  Obtenemos Fecha Maxima
      ve_getfecha_pr (lv_fechamaxima, cv_nompar_formatosel2, cv_nompar_formatosel7, ld_fecha, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_sql := 'INSERT INTO ga_catributclie(cod_cliente, ' || 'fec_desde, ' || 'fec_hasta, ' || 'cod_catribut) '
             || 'VALUES (' || en_codcliente || ',' || 'SYSDATE, '|| ld_fecha || ',' || ev_codcattrib || ')';

      INSERT INTO ga_catributclie
                  (cod_cliente, fec_desde, fec_hasta, cod_catribut)
      VALUES      (en_codcliente, SYSDATE, ld_fecha, ev_codcattrib);

   EXCEPTION
      WHEN error_sql THEN
         sn_codretorno := 10721;
         sv_menretorno := 'Error al ingresar Categoria Tributaria para el Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCategoriaTributaria_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCategoriaTributaria_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10721;
         sv_menretorno := 'Error al ingresar Categoria Tributaria para el Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCategoriaTributaria_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCategoriaTributaria_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inscategoriatributaria_pr;

   PROCEDURE ve_insempresa_pr (
      ev_desempresa     IN              ga_empresa.des_empresa%TYPE,
      en_codproducto    IN              ga_empresa.cod_producto%TYPE,
      ev_codplantarif   IN              ga_empresa.cod_plantarif%TYPE,
      en_codciclo       IN              ga_empresa.cod_ciclo%TYPE,
      en_codcliente     IN              ga_empresa.cod_cliente%TYPE,
      en_numabonados    IN              ga_empresa.num_abonados%TYPE,
      ev_usuario        IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insEmpresa_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA EMPRESA ASOCIADA AL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EN_codempresa"   Tipo="NUMBER"> codigo empresa </param>
              <param nom="EV_desempresa"   Tipo="STRING"> descripcion empresa </param>
              <param nom="EN_codproducto"  Tipo="NUMBER"> codigo producto </param>
              <param nom="EV_codplantarif" Tipo="STRING"> codigo plan tarifario </param>
              <param nom="EN_codciclo"     Tipo="STRING"> codigo ciclo </param>
              <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
              <param nom="EN_numabonados"  Tipo="NUMBER"> numero abonados </param>
            </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql       EXCEPTION;
      lv_deserror     ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
      ln_codempresa   NUMBER;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      -- Obtiene Codigo Empresa
      lv_sql:='VE_ALTA_CLIENTE_QUIOSCO_PG.ve_getcodigonuevaempresa_pr (ln_codempresa, sn_codretorno, sv_menretorno, sn_numevento)';
      VE_ALTA_CLIENTE_QUIOSCO_PG.ve_getcodigonuevaempresa_pr (ln_codempresa, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_sql := 'INSERT INTO ga_empresa(cod_empresa, '
             || 'des_empresa, '
             || 'cod_producto, '
             || 'cod_plantari, '
             || 'fec_alta, '
             || 'nom_usuarora, '
             || 'cod_ciclo, '
             || 'cod_cliente, '
             || 'num_abonados) '
             || 'VALUES (' || ln_codempresa || ', '
             || ev_desempresa   || ','
             || en_codproducto  || ','
             || ev_codplantarif || ','
             || 'SYSDATE'     || ','
             || ev_usuario    || ','
             || en_codciclo   || ','
             || en_codcliente || ','
             || en_numabonados || ')';

      INSERT INTO ga_empresa
                  (cod_empresa, des_empresa, cod_producto, cod_plantarif, fec_alta, nom_usuarora, cod_ciclo, cod_cliente, num_abonados)
      VALUES      (ln_codempresa, ev_desempresa, en_codproducto, ev_codplantarif, SYSDATE, ev_usuario, en_codciclo, en_codcliente, en_numabonados);

   EXCEPTION
      WHEN error_sql THEN
         sn_codretorno := 10722;
         sv_menretorno := 'Error al ingresar Empresa Asociada al Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insEmpresa_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insEmpresa_PR', lv_sql, SQLCODE, lv_deserror);

     WHEN OTHERS THEN
         sn_codretorno := 10722;
         sv_menretorno := 'Error al ingresar Empresa Asociada al Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insEmpresa_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insEmpresa_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insempresa_pr;

   PROCEDURE ve_inscliente_pr (
      ev_cod_cliente          IN              VARCHAR2,
      ev_nom_cliente          IN              VARCHAR2,
      ev_cod_tipident         IN              VARCHAR2,
      ev_num_ident            IN              VARCHAR2,
      ev_cod_calclien         IN              VARCHAR2,
      ev_ind_situacion        IN              VARCHAR2,
      ev_ind_factur           IN              VARCHAR2,
      ev_ind_traspaso         IN              VARCHAR2,
      ev_ind_agente           IN              VARCHAR2,
      ev_num_fax              IN              VARCHAR2,
      ev_ind_mandato          IN              VARCHAR2,
      ev_nom_usuarora         IN              VARCHAR2,
      ev_ind_alta             IN              VARCHAR2,
      ev_cod_cuenta           IN              VARCHAR2,
      ev_ind_acepvent         IN              VARCHAR2,
      ev_cod_abc              IN              VARCHAR2,
      ev_cod_123              IN              VARCHAR2,
      ev_cod_actividad        IN              VARCHAR2,
      ev_cod_pais             IN              VARCHAR2,
      ev_tef_cliente1         IN              VARCHAR2,
      ev_num_abocel           IN              VARCHAR2,
      ev_tef_cliente2         IN              VARCHAR2,
      ev_num_abobeep          IN              VARCHAR2,
      ev_ind_debito           IN              VARCHAR2,
      ev_num_abotrunk         IN              VARCHAR2,
      ev_cod_prospecto        IN              VARCHAR2,
      ev_num_abotrek          IN              VARCHAR2,
      ev_cod_sispago          IN              VARCHAR2,
      ev_nom_apeclien1        IN              VARCHAR2,
      ev_nom_email            IN              VARCHAR2,
      ev_num_aborent          IN              VARCHAR2,
      ev_nom_apeclien2        IN              VARCHAR2,
      ev_num_aboroaming       IN              VARCHAR2,
      ev_fec_acepvent         IN              VARCHAR2,
      ev_imp_stopdebit        IN              VARCHAR2,
      ev_cod_banco            IN              VARCHAR2,
      ev_cod_sucursal         IN              VARCHAR2,
      ev_ind_tipcuenta        IN              VARCHAR2,
      ev_cod_tiptarjeta       IN              VARCHAR2,
      ev_num_ctacorr          IN              VARCHAR2,
      ev_num_tarjeta          IN              VARCHAR2,
      ev_fec_vencitarj        IN              VARCHAR2,
      ev_cod_bancotarj        IN              VARCHAR2,
      ev_cod_tipidtrib        IN              VARCHAR2,
      ev_num_identtrib        IN              VARCHAR2,
      ev_cod_tipidentapor     IN              VARCHAR2,
      ev_num_identapor        IN              VARCHAR2,
      ev_nom_apoderado        IN              VARCHAR2,
      ev_cod_oficina          IN              VARCHAR2,
      ev_fec_baja             IN              VARCHAR2,
      ev_cod_cobrador         IN              VARCHAR2,
      ev_cod_pincli           IN              VARCHAR2,
      ev_cod_ciclo            IN              VARCHAR2,
      ev_num_celular          IN              VARCHAR2,
      ev_ind_tippersona       IN              VARCHAR2,
      ev_cod_ciclonue         IN              VARCHAR2,
      ev_cod_categoria        IN              VARCHAR2,
      ev_cod_sector           IN              VARCHAR2,
      ev_cod_supervisor       IN              VARCHAR2,
      ev_ind_estcivil         IN              VARCHAR2,
      ev_fec_nacimien         IN              VARCHAR2,
      ev_ind_sexo             IN              VARCHAR2,
      ev_num_int_grup_fam     IN              VARCHAR2,
      ev_cod_npi              IN              VARCHAR2,
      ev_cod_subcategoria     IN              VARCHAR2,
      ev_cod_uso              IN              VARCHAR2,
      ev_cod_idioma           IN              VARCHAR2,
      ev_cod_tipident2        IN              VARCHAR2,
      ev_num_ident2           IN              VARCHAR2,
      ev_nom_usuario_asesor   IN              VARCHAR2,
      ev_cod_operadora        IN              VARCHAR2,
      ev_id_segmento          IN              VARCHAR2,
      ev_cod_crediticia       IN              VARCHAR2, --CSR-11002
      sn_codretorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY      ge_errores_pg.evento) IS

      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="13-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Inserta nuevo cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_cod_cliente"      Tipo="STRING"> codigo cliente </param>
            <param nom="EV_nom_cliente"       Tipo="STRING"> </param>
            <param nom="EV_cod_tipident"      Tipo="STRING"> </param>
            <param nom="EV_num_ident"         Tipo="STRING"> </param>
            <param nom="EV_cod_calclien"      Tipo="STRING"> </param>
            <param nom="EV_ind_situacion"     Tipo="STRING"> </param>
            <param nom="EV_ind_factur"        Tipo="STRING"> </param>
            <param nom="EV_ind_traspaso"      Tipo="STRING"> </param>
            <param nom="EV_ind_agente"        Tipo="STRING"> </param>
            <param nom="EV_num_fax"           Tipo="STRING"> </param>
            <param nom="EV_ind_mandato"       Tipo="STRING"> </param>
            <param nom="EV_nom_usuarora"      Tipo="STRING"> </param>
            <param nom="EV_ind_alta"          Tipo="STRING"> </param>
            <param nom="EV_cod_cuenta"        Tipo="STRING"> </param>
            <param nom="EV_ind_acepvent"      Tipo="STRING"> </param>
            <param nom="EV_cod_abc"           Tipo="STRING"> </param>
            <param nom="EV_cod_123"           Tipo="STRING"> </param>
            <param nom="EV_cod_actividad"     Tipo="STRING"> </param>
            <param nom="EV_cod_pais"          Tipo="STRING"> </param>
            <param nom="EV_tef_cliente1"      Tipo="STRING"> </param>
            <param nom="EV_num_abocel"        Tipo="STRING"> </param>
            <param nom="EV_tef_cliente2"      Tipo="STRING"> </param>
            <param nom="EV_num_abobeep"       Tipo="STRING"> </param>
            <param nom="EV_ind_debito"        Tipo="STRING"> </param>
            <param nom="EV_num_abotrunk"      Tipo="STRING"> </param>
            <param nom="EV_cod_prospecto"     Tipo="STRING"> </param>
            <param nom="EV_num_abotrek"       Tipo="STRING"> </param>
            <param nom="EV_cod_sispago"       Tipo="STRING"> </param>
            <param nom="EV_nom_apeclien1"     Tipo="STRING"> </param>
            <param nom="EV_nom_email"         Tipo="STRING"> </param>
            <param nom="EV_num_aborent"       Tipo="STRING"> </param>
            <param nom="EV_nom_apeclien2"     Tipo="STRING"> </param>
            <param nom="EV_num_aboroaming"    Tipo="STRING"> </param>
            <param nom="EV_fec_acepvent"      Tipo="STRING"> </param>
            <param nom="EV_imp_stopdebit"     Tipo="STRING"> </param>
            <param nom="EV_cod_banco"         Tipo="STRING"> </param>
            <param nom="EV_cod_sucursal"      Tipo="STRING"> </param>
            <param nom="EV_ind_tipcuenta"     Tipo="STRING"> </param>
            <param nom="EV_cod_tiptarjeta"    Tipo="STRING"> </param>
            <param nom="EV_num_ctacorr"       Tipo="STRING"> </param>
            <param nom="EV_num_tarjeta"       Tipo="STRING"> </param>
            <param nom="EV_fec_vencitarj"     Tipo="STRING"> </param>
            <param nom="EV_cod_bancotarj"     Tipo="STRING"> </param>
            <param nom="EV_cod_tipidtrib"     Tipo="STRING"> </param>
            <param nom="EV_num_identtrib"     Tipo="STRING"> </param>
            <param nom="EV_cod_tipidentapor"  Tipo="STRING"> </param>
            <param nom="EV_num_identapor"     Tipo="STRING"> </param>
            <param nom="EV_nom_apoderado"     Tipo="STRING"> </param>
            <param nom="EV_cod_oficina"       Tipo="STRING"> </param>
            <param nom="EV_fec_baja"          Tipo="STRING"> </param>
            <param nom="EV_cod_cobrador"      Tipo="STRING"> </param>
            <param nom="EV_cod_pincli"        Tipo="STRING"> </param>
            <param nom="EV_cod_ciclo"         Tipo="STRING"> </param>
            <param nom="EV_num_celular"       Tipo="STRING"> </param>
            <param nom="EV_ind_tippersona"    Tipo="STRING"> </param>
            <param nom="EV_cod_ciclonue"      Tipo="STRING"> </param>
            <param nom="EV_cod_categoria"     Tipo="STRING"> </param>
            <param nom="EV_cod_sector"        Tipo="STRING"> </param>
            <param nom="EV_cod_supervisor"    Tipo="STRING"> </param>
            <param nom="EV_ind_estcivil"      Tipo="STRING"> </param>
            <param nom="EV_fec_nacimien"      Tipo="STRING"> </param>
            <param nom="EV_ind_sexo"          Tipo="STRING"> </param>
            <param nom="EV_num_int_grup_fam"  Tipo="STRING"> </param>
            <param nom="EV_cod_npi"           Tipo="STRING"> </param>
            <param nom="EV_cod_subcategoria"  Tipo="STRING"> </param>
            <param nom="EV_cod_uso"           Tipo="STRING"> </param>
            <param nom="EV_cod_idioma"        Tipo="STRING"> </param>
            <param nom="EV_cod_tipident2"     Tipo="STRING"> </param>
            <param nom="EV_num_ident2"        Tipo="STRING"> </param>
            <param nom="EV_nom_usuario_asesor"Tipo="STRING"> </param>
            <param nom="EV_cod_operadora"     Tipo="STRING"> </param>
            <param nom="EV_id_segmento"       Tipo="STRING"> </param>
            <param nom="EV_cod_crediticia"    Tipo="STRING"> </param>
          </Entrada>
            <Salida>
              <param nom="SN_codRetorno"      Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"      Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"       Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */

      error_controlado EXCEPTION;

      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;

   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;

      lv_sql :=
         'INSERT INTO ge_clientes (' || ' cod_cliente ' || ',nom_cliente ' || ',cod_tipident ' || ',num_ident ' || ',cod_calclien ' || ',ind_situacion ' || ',fec_alta ' || ',ind_factur ' || ',ind_traspaso ' || ',ind_agente ' || ',fec_ultmod '
         || ',num_fax ' || ',ind_mandato ' || ',nom_usuarora ' || ',ind_alta ' || ',cod_cuenta ' || ',ind_acepvent ' || ',cod_abc ' || ',cod_123 ' || ',cod_actividad ' || ',cod_pais ' || ',tef_cliente1 ' || ',num_abocel ' || ',tef_cliente2 '
         || ',num_abobeep ' || ',ind_debito ' || ',num_abotrunk ' || ',cod_prospecto ' || ',num_abotrek ' || ',cod_sispago ' || ',nom_apeclien1 ' || ',nom_email ' || ',num_aborent ' || ',nom_apeclien2 ' || ',num_aboroaming ' || ',fec_acepvent '
         || ',imp_stopdebit ' || ',cod_banco ' || ',cod_sucursal ' || ',ind_tipcuenta ' || ',cod_tiptarjeta ' || ',num_ctacorr ' || ',num_tarjeta ' || ',fec_vencitarj ' || ',cod_bancotarj ' || ',cod_tipidtrib ' || ',num_identtrib '
         || ',cod_tipidentapor ' || ',num_identapor ' || ',nom_apoderado ' || ',cod_oficina ' || ',fec_baja ' || ',cod_cobrador ' || ',cod_pincli ' || ',cod_ciclo ' || ',num_celular ' || ',ind_tippersona ' || ',cod_ciclonue ' || ',cod_categoria '
         || ',cod_sector ' || ',cod_supervisor ' || ',ind_estcivil ' || ',fec_nacimien ' || ',ind_sexo ' || ',num_int_grup_fam ' || ',cod_npi ' || ',cod_subcategoria ' || ',cod_uso ' || ',cod_idioma ' || ',cod_tipident2 ' || ',num_ident2 '
         || ',nom_usuario_asesor ' || ',cod_operadora ' || ',cod_crediticia ' || ')' || 'VALUES ( ';

      IF (ev_cod_cliente IS NOT NULL) AND (LENGTH (ev_cod_cliente) > 0) THEN
         lv_sql := lv_sql || ev_cod_cliente;
      ELSE
         lv_sql := lv_sql || 'NULL';
      END IF;

      IF (ev_nom_cliente IS NOT NULL) AND (LENGTH (ev_nom_cliente) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_cliente || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipident IS NOT NULL) AND (LENGTH (ev_cod_tipident) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipident || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ident IS NOT NULL) AND (LENGTH (ev_num_ident) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_ident || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_calclien IS NOT NULL) AND (LENGTH (ev_cod_calclien) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_calclien || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_situacion IS NOT NULL) AND (LENGTH (ev_ind_situacion) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_situacion || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      lv_sql := lv_sql || ',SYSDATE';

      IF (ev_ind_factur IS NOT NULL) AND (LENGTH (ev_ind_factur) > 0) THEN
         lv_sql := lv_sql || ',' || ev_ind_factur;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_traspaso IS NOT NULL) AND (LENGTH (ev_ind_traspaso) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_traspaso || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_agente IS NOT NULL) AND (LENGTH (ev_ind_agente) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_agente || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      lv_sql := lv_sql || ',SYSDATE';

      IF (ev_num_fax IS NOT NULL) AND (LENGTH (ev_num_fax) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_fax || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_mandato IS NOT NULL) AND (LENGTH (ev_ind_mandato) > 0) THEN
         lv_sql := lv_sql || ',' || ev_ind_mandato;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_usuarora IS NOT NULL) AND (LENGTH (ev_nom_usuarora) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_usuarora || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_alta IS NOT NULL) AND (LENGTH (ev_ind_alta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_alta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_cuenta IS NOT NULL) AND (LENGTH (ev_cod_cuenta) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_cuenta;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_acepvent IS NOT NULL) AND (LENGTH (ev_ind_acepvent) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_acepvent || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_abc IS NOT NULL) AND (LENGTH (ev_cod_abc) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_abc || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_123 IS NOT NULL) AND (LENGTH (ev_cod_123) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_123;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_actividad IS NOT NULL) AND (LENGTH (ev_cod_actividad) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_actividad;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_pais IS NOT NULL) AND (LENGTH (ev_cod_pais) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_pais || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_tef_cliente1 IS NOT NULL) AND (LENGTH (ev_tef_cliente1) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_tef_cliente1 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_abocel IS NOT NULL) AND (LENGTH (ev_num_abocel) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_abocel;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_tef_cliente2 IS NOT NULL) AND (LENGTH (ev_tef_cliente2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_tef_cliente2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_abobeep IS NOT NULL) AND (LENGTH (ev_num_abobeep) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_abobeep;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_debito IS NOT NULL) AND (LENGTH (ev_ind_debito) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_debito || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_abotrunk IS NOT NULL) AND (LENGTH (ev_num_abotrunk) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_abotrunk;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_prospecto IS NOT NULL) AND (LENGTH (ev_cod_prospecto) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_prospecto;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_abotrek IS NOT NULL) AND (LENGTH (ev_num_abotrek) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_abotrek;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_sispago IS NOT NULL) AND (LENGTH (ev_cod_sispago) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_sispago;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_apeclien1 IS NOT NULL) AND (LENGTH (ev_nom_apeclien1) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_apeclien1 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_email IS NOT NULL) AND (LENGTH (ev_nom_email) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_email || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_aborent IS NOT NULL) AND (LENGTH (ev_num_aborent) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_aborent;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_apeclien2 IS NOT NULL) AND (LENGTH (ev_nom_apeclien2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_apeclien2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_aboroaming IS NOT NULL) AND (LENGTH (ev_num_aboroaming) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_aboroaming;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fec_acepvent IS NOT NULL) AND (LENGTH (ev_fec_acepvent) > 0) THEN
         lv_sql := lv_sql || ',TO_DATE(''' || ev_fec_acepvent || ''',''' || cv_formatofecha || ''')';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_imp_stopdebit IS NOT NULL) AND (LENGTH (ev_imp_stopdebit) > 0) THEN
         lv_sql := lv_sql || ',' || ev_imp_stopdebit;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_banco IS NOT NULL) AND (LENGTH (ev_cod_banco) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_banco || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_sucursal IS NOT NULL) AND (LENGTH (ev_cod_sucursal) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_sucursal || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_tipcuenta IS NOT NULL) AND (LENGTH (ev_ind_tipcuenta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_tipcuenta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tiptarjeta IS NOT NULL) AND (LENGTH (ev_cod_tiptarjeta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tiptarjeta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ctacorr IS NOT NULL) AND (LENGTH (ev_num_ctacorr) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_ctacorr || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_tarjeta IS NOT NULL) AND (LENGTH (ev_num_tarjeta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_tarjeta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fec_vencitarj IS NOT NULL) AND (LENGTH (ev_fec_vencitarj) > 0) THEN
         lv_sql := lv_sql || ',TO_DATE(''' || ev_fec_vencitarj || ''',''' || cv_formatofecha || ''')';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_bancotarj IS NOT NULL) AND (LENGTH (ev_cod_bancotarj) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_bancotarj || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipidtrib IS NOT NULL) AND (LENGTH (ev_cod_tipidtrib) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipidtrib || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_identtrib IS NOT NULL) AND (LENGTH (ev_num_identtrib) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_identtrib || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipidentapor IS NOT NULL) AND (LENGTH (ev_cod_tipidentapor) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipidentapor || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_identapor IS NOT NULL) AND (LENGTH (ev_num_identapor) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_identapor || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_apoderado IS NOT NULL) AND (LENGTH (ev_nom_apoderado) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_apoderado || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_oficina IS NOT NULL) AND (LENGTH (ev_cod_oficina) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_oficina || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fec_baja IS NOT NULL) AND (LENGTH (ev_fec_baja) > 0) THEN
         lv_sql := lv_sql || ',TO_DATE(''' || ev_fec_baja || ''',''' || cv_formatofecha || ''')';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_cobrador IS NOT NULL) AND (LENGTH (ev_cod_cobrador) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_cobrador;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_pincli IS NOT NULL) AND (LENGTH (ev_cod_pincli) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_pincli || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_ciclo IS NOT NULL) AND (LENGTH (ev_cod_ciclo) > 0) THEN
          IF NOT ve_valida_ciclo_fn (ev_cod_ciclo,sn_codretorno, sv_menretorno,sn_numevento) THEN
             sn_codretorno := 12500;
             sv_menretorno := 'Codigo ciclo no existe en la tabla FA_CICLOS';
             RAISE error_controlado;
         END IF;
         lv_sql := lv_sql || ',' || ev_cod_ciclo;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_celular IS NOT NULL) AND (LENGTH (ev_num_celular) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_celular;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_tippersona IS NOT NULL) AND (LENGTH (ev_ind_tippersona) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_tippersona || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_ciclonue IS NOT NULL) AND (LENGTH (ev_cod_ciclonue) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_ciclonue;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_categoria IS NOT NULL) AND (LENGTH (ev_cod_categoria) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_categoria;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_sector IS NOT NULL) AND (LENGTH (ev_cod_sector) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_sector;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_supervisor IS NOT NULL) AND (LENGTH (ev_cod_supervisor) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_supervisor;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_estcivil IS NOT NULL) AND (LENGTH (ev_ind_estcivil) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_estcivil || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fec_nacimien IS NOT NULL) AND (LENGTH (ev_fec_nacimien) > 0) THEN
         lv_sql := lv_sql || ',TO_DATE(''' || ev_fec_nacimien || ''',''' || cv_formatofecha || ''')';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_sexo IS NOT NULL) AND (LENGTH (ev_ind_sexo) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_sexo || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_int_grup_fam IS NOT NULL) AND (LENGTH (ev_num_int_grup_fam) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_int_grup_fam;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_npi IS NOT NULL) AND (LENGTH (ev_cod_npi) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_npi;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_subcategoria IS NOT NULL) AND (LENGTH (ev_cod_subcategoria) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_subcategoria || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_uso IS NOT NULL) AND (LENGTH (ev_cod_uso) > 0) THEN
         IF NOT ve_valida_uso_fn (ev_cod_uso,sn_codretorno, sv_menretorno,sn_numevento) THEN
             sn_codretorno := 12501;
             sv_menretorno := 'Codigo uso no existe en la tabla AL_USOS';
             RAISE error_controlado;
         END IF;
         lv_sql := lv_sql || ',''' || ev_cod_uso || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_idioma IS NOT NULL) AND (LENGTH (ev_cod_idioma) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_idioma || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipident2 IS NOT NULL) AND (LENGTH (ev_cod_tipident2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipident2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ident2 IS NOT NULL) AND (LENGTH (ev_num_ident2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_ident2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_usuario_asesor IS NOT NULL) AND (LENGTH (ev_nom_usuario_asesor) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_usuario_asesor || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_operadora IS NOT NULL) AND (LENGTH (ev_cod_operadora) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_operadora || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      --INICIO CSR-11002
      IF (ev_cod_crediticia IS NOT NULL) AND (LENGTH (ev_cod_crediticia) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_crediticia || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;
      --FIN CSR-11002

      lv_sql := lv_sql || ')';

      EXECUTE IMMEDIATE lv_sql;
   EXCEPTION
         WHEN error_controlado THEN
           lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCliente_PR', lv_sql, SQLCODE, lv_deserror);


      WHEN OTHERS THEN
         sn_codretorno := 10723;
         sv_menretorno := 'Error al Ingresar Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inscliente_pr;

   PROCEDURE ve_insmodcliente_pr (
      ev_cod_cliente        IN              VARCHAR2,
      ev_cod_tipmodi        IN              VARCHAR2,
      ev_fec_modifica       IN              VARCHAR2,
      ev_nom_usuarora       IN              VARCHAR2,
      ev_nom_cliente        IN              VARCHAR2,
      ev_cod_tipident       IN              VARCHAR2,
      ev_num_ident          IN              VARCHAR2,
      ev_cod_calclien       IN              VARCHAR2,
      ev_cod_plancom        IN              VARCHAR2,
      ev_ind_factur         IN              VARCHAR2,
      ev_ind_traspaso       IN              VARCHAR2,
      ev_cod_actividad      IN              VARCHAR2,
      ev_cod_pais           IN              VARCHAR2,
      ev_tef_cliente1       IN              VARCHAR2,
      ev_tef_cliente2       IN              VARCHAR2,
      ev_num_fax            IN              VARCHAR2,
      ev_ind_debito         IN              VARCHAR2,
      ev_cod_sispago        IN              VARCHAR2,
      ev_nom_apeclien1      IN              VARCHAR2,
      ev_nom_apeclien2      IN              VARCHAR2,
      ev_imp_stopdebit      IN              VARCHAR2,
      ev_cod_banco          IN              VARCHAR2,
      ev_cod_sucursal       IN              VARCHAR2,
      ev_ind_tipcuenta      IN              VARCHAR2,
      ev_cod_tiptarjeta     IN              VARCHAR2,
      ev_num_ctacorr        IN              VARCHAR2,
      ev_num_tarjeta        IN              VARCHAR2,
      ev_fec_vencitarj      IN              VARCHAR2,
      ev_cod_bancotarj      IN              VARCHAR2,
      ev_cod_tipidtrib      IN              VARCHAR2,
      ev_num_identtrib      IN              VARCHAR2,
      ev_cod_tipidentapor   IN              VARCHAR2,
      ev_num_identapor      IN              VARCHAR2,
      ev_nom_apoderado      IN              VARCHAR2,
      ev_cod_oficina        IN              VARCHAR2,
      ev_cod_pincli         IN              VARCHAR2,
      ev_nom_email          IN              VARCHAR2,
      ev_cod_ciclo          IN              VARCHAR2,
      ev_cod_categoria      IN              VARCHAR2,
      ev_cod_sector         IN              VARCHAR2,
      ev_cod_supervisor     IN              VARCHAR2,
      ev_cod_npi            IN              VARCHAR2,
      ev_cod_empresa        IN              VARCHAR2,
      ev_tip_plantarif      IN              VARCHAR2,
      ev_cod_plantarif      IN              VARCHAR2,
      ev_cod_cargobasico    IN              VARCHAR2,
      ev_num_os             IN              VARCHAR2,
      ev_num_ciclos         IN              VARCHAR2,
      ev_num_minutos        IN              VARCHAR2,
      ev_cod_idioma         IN              VARCHAR2,
      ev_cod_tipident2      IN              VARCHAR2,
      ev_num_ident2         IN              VARCHAR2,
      ev_cod_plaza          IN              VARCHAR2,
      ev_des_refdoc         IN              VARCHAR2,
      ev_cod_limconsumo     IN              VARCHAR2,
      ev_cod_subcategoria   IN              VARCHAR2,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insModCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="14-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA MODIFICACIONES AL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
             <param nom="EV_cod_cliente"        Tipo="STRING"> codigo cliente </param>
             <param nom="EV_cod_tipmodi"        Tipo="STRING"> </param>
            <param nom="EV_fec_modifica"        Tipo="STRING"> </param>
            <param nom="EV_nom_usuarora"        Tipo="STRING"> </param>
            <param nom="EV_nom_cliente"         Tipo="STRING"> </param>
            <param nom="EV_cod_tipident"        Tipo="STRING"> </param>
            <param nom="EV_num_ident"           Tipo="STRING"> </param>
            <param nom="EV_cod_calclien"        Tipo="STRING"> </param>
            <param nom="EV_cod_plancom"         Tipo="STRING"> </param>
            <param nom="EV_ind_factur"          Tipo="STRING"> </param>
            <param nom="EV_ind_traspaso"        Tipo="STRING"> </param>
            <param nom="EV_cod_actividad"       Tipo="STRING"> </param>
            <param nom="EV_cod_pais"            Tipo="STRING"> </param>
            <param nom="EV_tef_cliente1"        Tipo="STRING"> </param>
            <param nom="EV_tef_cliente2"        Tipo="STRING"> </param>
            <param nom="EV_num_fax"             Tipo="STRING"> </param>
            <param nom="EV_ind_debito"          Tipo="STRING"> </param>
            <param nom="EV_cod_sispago"         Tipo="STRING"> </param>
            <param nom="EV_nom_apeclien1"       Tipo="STRING"> </param>
            <param nom="EV_nom_apeclien2"       Tipo="STRING"> </param>
            <param nom="EV_imp_stopdebit"       Tipo="STRING"> </param>
            <param nom="EV_cod_banco"           Tipo="STRING"> </param>
            <param nom="EV_cod_sucursal"        Tipo="STRING"> </param>
            <param nom="EV_ind_tipcuenta"       Tipo="STRING"> </param>
            <param nom="EV_cod_tiptarjeta"      Tipo="STRING"> </param>
            <param nom="EV_num_ctacorr"         Tipo="STRING"> </param>
            <param nom="EV_num_tarjeta"         Tipo="STRING"> </param>
            <param nom="EV_fec_vencitarj"       Tipo="STRING"> </param>
            <param nom="EV_cod_bancotarj"       Tipo="STRING"> </param>
            <param nom="EV_cod_tipidtrib"       Tipo="STRING"> </param>
            <param nom="EV_num_identtrib"       Tipo="STRING"> </param>
            <param nom="EV_cod_tipidentapor"    Tipo="STRING"> </param>
            <param nom="EV_num_identapor"       Tipo="STRING"> </param>
            <param nom="EV_nom_apoderado"       Tipo="STRING"> </param>
            <param nom="EV_cod_oficina"         Tipo="STRING"> </param>
            <param nom="EV_cod_pincli"          Tipo="STRING"> </param>
            <param nom="EV_nom_email"           Tipo="STRING"> </param>
            <param nom="EV_cod_ciclo"           Tipo="STRING"> </param>
            <param nom="EV_cod_categoria"       Tipo="STRING"> </param>
            <param nom="EV_cod_sector"          Tipo="STRING"> </param>
            <param nom="EV_cod_supervisor"      Tipo="STRING"> </param>
            <param nom="EV_cod_npi"             Tipo="STRING"> </param>
            <param nom="EV_cod_empresa"         Tipo="STRING"> </param>
            <param nom="EV_tip_plantarif"       Tipo="STRING"> </param>
            <param nom="EV_cod_plantarif"       Tipo="STRING"> </param>
            <param nom="EV_cod_cargobasico"     Tipo="STRING"> </param>
            <param nom="EV_num_os"              Tipo="STRING"> </param>
            <param nom="EV_num_ciclos"          Tipo="STRING"> </param>
            <param nom="EV_num_minutos"         Tipo="STRING"> </param>
            <param nom="EV_cod_idioma"          Tipo="STRING"> </param>
            <param nom="EV_cod_tipident2"       Tipo="STRING"> </param>
            <param nom="EV_num_ident2"          Tipo="STRING"> </param>
            <param nom="EV_cod_plaza"           Tipo="STRING"> </param>
            <param nom="EV_des_refdoc"          Tipo="STRING"> </param>
            <param nom="EV_cod_limconsumo"      Tipo="STRING"> </param>
            <param nom="EV_cod_subcategoria"    Tipo="STRING"> </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"     Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      lv_sql :=
         'INSERT INTO ga_modcli(cod_cliente ' || ',cod_tipmodi ' || ',fec_modifica ' || ',nom_usuarora ' || ',nom_cliente ' || ',cod_tipident ' || ',num_ident ' || ',cod_calclien ' || ',cod_plancom ' || ',ind_factur ' || ',ind_traspaso '
         || ',cod_actividad ' || ',cod_pais ' || ',tef_cliente1 ' || ',tef_cliente2 ' || ',num_fax ' || ',ind_debito ' || ',cod_sispago ' || ',nom_apeclien1 ' || ',nom_apeclien2 ' || ',imp_stopdebit ' || ',cod_banco ' || ',cod_sucursal '
         || ',ind_tipcuenta ' || ',cod_tiptarjeta ' || ',num_ctacorr ' || ',num_tarjeta ' || ',fec_vencitarj ' || ',cod_bancotarj ' || ',cod_tipidtrib ' || ',num_identtrib ' || ',cod_tipidentapor ' || ',num_identapor ' || ',nom_apoderado '
         || ',cod_oficina ' || ',cod_pincli ' || ',nom_email ' || ',cod_ciclo ' || ',cod_categoria ' || ',cod_sector ' || ',cod_supervisor ' || ',cod_npi ' || ',cod_empresa ' || ',tip_plantarif ' || ',cod_plantarif ' || ',cod_cargobasico ' || ',num_os '
         || ',num_ciclos ' || ',num_minutos ' || ',cod_idioma ' || ',cod_tipident2 ' || ',num_ident2 ' || ',cod_plaza ' || ',des_refdoc ' || ',cod_limconsumo ' || ') ' || 'VALUES (';

      IF (ev_cod_cliente IS NOT NULL) AND (LENGTH (ev_cod_cliente) > 0) THEN
         lv_sql := lv_sql || ev_cod_cliente;
      ELSE
         lv_sql := lv_sql || 'NULL';
      END IF;

      IF (ev_cod_tipmodi IS NOT NULL) AND (LENGTH (ev_cod_tipmodi) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipmodi || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      lv_sql := lv_sql || ',SYSDATE';

      IF (ev_nom_usuarora IS NOT NULL) AND (LENGTH (ev_nom_usuarora) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_usuarora || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_cliente IS NOT NULL) AND (LENGTH (ev_nom_cliente) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_cliente || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipident IS NOT NULL) AND (LENGTH (ev_cod_tipident) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipident || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ident IS NOT NULL) AND (LENGTH (ev_num_ident) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_ident || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_calclien IS NOT NULL) AND (LENGTH (ev_cod_calclien) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_calclien || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_plancom IS NOT NULL) AND (LENGTH (ev_cod_plancom) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_plancom;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_factur IS NOT NULL) AND (LENGTH (ev_ind_factur) > 0) THEN
         lv_sql := lv_sql || ',' || ev_ind_factur;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_traspaso IS NOT NULL) AND (LENGTH (ev_ind_traspaso) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_traspaso || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_actividad IS NOT NULL) AND (LENGTH (ev_cod_actividad) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_actividad;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_pais IS NOT NULL) AND (LENGTH (ev_cod_pais) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_pais || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_tef_cliente1 IS NOT NULL) AND (LENGTH (ev_tef_cliente1) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_tef_cliente1 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_tef_cliente2 IS NOT NULL) AND (LENGTH (ev_tef_cliente2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_tef_cliente2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_fax IS NOT NULL) AND (LENGTH (ev_num_fax) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_fax || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_debito IS NOT NULL) AND (LENGTH (ev_ind_debito) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_debito || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_sispago IS NOT NULL) AND (LENGTH (ev_cod_sispago) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_sispago;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_apeclien1 IS NOT NULL) AND (LENGTH (ev_nom_apeclien1) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_apeclien1 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_apeclien2 IS NOT NULL) AND (LENGTH (ev_nom_apeclien2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_apeclien2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_imp_stopdebit IS NOT NULL) AND (LENGTH (ev_imp_stopdebit) > 0) THEN
         lv_sql := lv_sql || ',' || ev_imp_stopdebit;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_banco IS NOT NULL) AND (LENGTH (ev_cod_banco) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_banco || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_sucursal IS NOT NULL) AND (LENGTH (ev_cod_sucursal) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_sucursal || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_ind_tipcuenta IS NOT NULL) AND (LENGTH (ev_ind_tipcuenta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_ind_tipcuenta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tiptarjeta IS NOT NULL) AND (LENGTH (ev_cod_tiptarjeta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tiptarjeta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ctacorr IS NOT NULL) AND (LENGTH (ev_num_ctacorr) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_ctacorr || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_tarjeta IS NOT NULL) AND (LENGTH (ev_num_tarjeta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_tarjeta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fec_vencitarj IS NOT NULL) AND (LENGTH (ev_fec_vencitarj) > 0) THEN
         lv_sql := lv_sql || ',TO_DATE(''' || ev_fec_vencitarj || ''',''' || cv_formatofecha || ''')';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_bancotarj IS NOT NULL) AND (LENGTH (ev_cod_bancotarj) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_bancotarj || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipidtrib IS NOT NULL) AND (LENGTH (ev_cod_tipidtrib) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipidtrib || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_identtrib IS NOT NULL) AND (LENGTH (ev_num_identtrib) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_identtrib || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipidentapor IS NOT NULL) AND (LENGTH (ev_cod_tipidentapor) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipidentapor || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_identapor IS NOT NULL) AND (LENGTH (ev_num_identapor) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_identapor || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_apoderado IS NOT NULL) AND (LENGTH (ev_nom_apoderado) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_apoderado || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_oficina IS NOT NULL) AND (LENGTH (ev_cod_oficina) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_oficina || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_pincli IS NOT NULL) AND (LENGTH (ev_cod_pincli) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_pincli || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_nom_email IS NOT NULL) AND (LENGTH (ev_nom_email) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_nom_email || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_ciclo IS NOT NULL) AND (LENGTH (ev_cod_ciclo) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_ciclo;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_categoria IS NOT NULL) AND (LENGTH (ev_cod_categoria) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_categoria;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_sector IS NOT NULL) AND (LENGTH (ev_cod_sector) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_sector;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_supervisor IS NOT NULL) AND (LENGTH (ev_cod_supervisor) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_supervisor;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_npi IS NOT NULL) AND (LENGTH (ev_cod_npi) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_npi;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_empresa IS NOT NULL) AND (LENGTH (ev_cod_empresa) > 0) THEN
         lv_sql := lv_sql || ',' || ev_cod_empresa;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_tip_plantarif IS NOT NULL) AND (LENGTH (ev_tip_plantarif) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_tip_plantarif || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_plantarif IS NOT NULL) AND (LENGTH (ev_cod_plantarif) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_plantarif || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_cargobasico IS NOT NULL) AND (LENGTH (ev_cod_cargobasico) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_cargobasico || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_os IS NOT NULL) AND (LENGTH (ev_num_os) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_os;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ciclos IS NOT NULL) AND (LENGTH (ev_num_ciclos) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_ciclos;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_minutos IS NOT NULL) AND (LENGTH (ev_num_minutos) > 0) THEN
         lv_sql := lv_sql || ',' || ev_num_minutos;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_idioma IS NOT NULL) AND (LENGTH (ev_cod_idioma) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_idioma || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_tipident2 IS NOT NULL) AND (LENGTH (ev_cod_tipident2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_tipident2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_num_ident2 IS NOT NULL) AND (LENGTH (ev_num_ident2) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_num_ident2 || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_plaza IS NOT NULL) AND (LENGTH (ev_cod_plaza) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_plaza || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_des_refdoc IS NOT NULL) AND (LENGTH (ev_des_refdoc) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_des_refdoc || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_cod_limconsumo IS NOT NULL) AND (LENGTH (ev_cod_limconsumo) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_cod_limconsumo || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      lv_sql := lv_sql || ')';

      EXECUTE IMMEDIATE lv_sql;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10724;
         sv_menretorno := 'Error al ingresar Modificaciones al Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insModCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insModCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insmodcliente_pr;

   PROCEDURE ve_insplancomcliente_pr (
      ev_cod_cliente    IN              VARCHAR2,
      ev_cod_plancom    IN              VARCHAR2,
      ev_nom_usuarora   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insPlanComCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="13-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA EL PLAN COMERCIAL DEL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_cliente"  Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_cod_plancom"  Tipo="STRING"> </param>
            <param nom="EV_nom_usuarora" Tipo="STRING"> </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      lv_fechamaxima   VARCHAR2 (20);
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      --  Obtenemos El Valor Para Fecha Maxima
      ve_intermediario_pg.ve_obtiene_valor_parametro_pr (cv_nompar_fechamaxima, cv_modulo_ge, cv_producto, lv_fechamaxima, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno = 0) THEN
         lv_sql :=
            'ga_cliente_pcom(cod_cliente, ' || 'cod_plancom, ' || 'fec_desde, ' || 'nom_usuarora, ' || 'fec_hasta) ' || 'VALUES (' || ev_cod_cliente || ', ' || ev_cod_plancom || ',' || 'SYSDATE' || ',' || ev_nom_usuarora || ',' || 'TO_DATE('
            || lv_fechamaxima || ',' || cv_formatofecmax || '))';

         INSERT INTO ga_cliente_pcom
                     (cod_cliente, cod_plancom, fec_desde, nom_usuarora, fec_hasta)
         VALUES      (ev_cod_cliente, ev_cod_plancom, SYSDATE, ev_nom_usuarora, TO_DATE (lv_fechamaxima, cv_formatofecmax));
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10725;
         sv_menretorno := 'Error al ingresar Plan Comercial del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insPlanComCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insPlanComCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insplancomcliente_pr;

   PROCEDURE ve_insrespcliente_pr (
      ev_cod_cliente       IN              VARCHAR2,
      ev_num_orden         IN              VARCHAR2,
      ev_cod_tipident      IN              VARCHAR2,
      ev_num_ident         IN              VARCHAR2,
      ev_nom_responsable   IN              VARCHAR2,
      sn_codretorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno        OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento         OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insRespCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="13-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Inserta responsables del cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_cliente"     Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_num_orden"       Tipo="STRING"> </param>
            <param nom="EV_cod_tipident"    Tipo="STRING"> </param>
            <param nom="EV_num_ident"       Tipo="STRING"> </param>
            <param nom="EV_nom_responsable" Tipo="STRING"> </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      lv_fechamaxima   VARCHAR2 (20);
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'ga_respclientes(cod_cliente, ' || 'num_orden, ' || 'cod_tipident, ' || 'num_ident, ' || 'nom_responsable) ' || 'VALUES (' || ev_cod_cliente || ', ' || ev_num_orden || ',' || ev_cod_tipident || ',' || ev_num_ident || ',' || ev_nom_responsable
         || ')';

      INSERT INTO ga_respclientes
                  (cod_cliente, num_orden, cod_tipident, num_ident, nom_responsable)
      VALUES      (ev_cod_cliente, ev_num_orden, ev_cod_tipident, ev_num_ident, ev_nom_responsable);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10726;
         sv_menretorno := 'Error al ingrear Responsables del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insRespCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insRespCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insrespcliente_pr;

   PROCEDURE ve_insdireccioncliente_pr (
      ev_cod_cliente        IN              VARCHAR2,
      ev_cod_tipdireccion   IN              VARCHAR2,
      ev_cod_direccion      IN              VARCHAR2,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insDireccionCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="13-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Inserta direccion del cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_cliente"      Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_cod_tipdireccion" Tipo="STRING"> </param>
            <param nom="EV_cod_direccion"    Tipo="STRING"> </param>
          </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'ga_direccli (cod_cliente, ' || 'cod_tipdireccion, ' || 'cod_direccion) ' || 'VALUES (' || ev_cod_cliente || ', ' || ev_cod_tipdireccion || ',' || ev_cod_direccion || ')';

      INSERT INTO ga_direccli
                  (cod_cliente, cod_tipdireccion, cod_direccion)
      VALUES      (ev_cod_cliente, ev_cod_tipdireccion, ev_cod_direccion);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10727;
         sv_menretorno := 'Error al ingresar Direccion del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insDireccionCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insDireccionCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insdireccioncliente_pr;

   PROCEDURE ve_inscatimposcliente_pr (
      ev_cod_cliente    IN              VARCHAR2,
      ev_cod_catimpos   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insCatImposCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="13-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA EL CATEGORIA IMPOSITIVA DEL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_cod_cliente"  Tipo="STRING"> codigo cliente </param>
            <param nom="EV_cod_catimpos" Tipo="STRING"> </param>
          </Entrada>
            <Salida>
              <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql        EXCEPTION;
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      lv_fechamaxima   VARCHAR2 (20);
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      --  Obtenemos El Valor Para Fecha Maxima
      ve_intermediario_pg.ve_obtiene_valor_parametro_pr (cv_nompar_fechamaxima, cv_modulo_ge, cv_producto, lv_fechamaxima, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_sql :=
               'ga_catimpclientes(cod_cliente, ' || 'cod_catimpos, ' || 'fec_desde, ' || 'fec_hasta) ' || 'VALUES (' || ev_cod_cliente || ', ' || ev_cod_catimpos || ',' || 'SYSDATE' || ',' || 'TO_DATE(' || lv_fechamaxima || ',' || cv_formatofecmax || '))';

      INSERT INTO ge_catimpclientes
                  (cod_cliente, cod_catimpos, fec_desde, fec_hasta)
      VALUES      (ev_cod_cliente, ev_cod_catimpos, SYSDATE, TO_DATE (lv_fechamaxima, cv_formatofecmax));
   EXCEPTION
      WHEN error_sql THEN
         sn_codretorno := 10728;
         sv_menretorno := 'Error al ingresar Categoria Impositiva del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCatImposCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCatImposCliente_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10728;
         sv_menretorno := 'Error al ingresar Categoria Impositiva del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCatImposCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insCatImposCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inscatimposcliente_pr;

   PROCEDURE ve_insvendcliente_pr (
      ev_cod_vendedor   IN              VARCHAR2,
      ev_cod_cliente    IN              VARCHAR2,
      ev_nom_usuario    IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insVendCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="13-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA RELACION VENDEDOR CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_vendedor" Tipo="NUMBER"> codigo vendedor </param>
            <param nom="EN_cod_cliente"  Tipo="NUMBER"> codigo cliente </param>
            <param nom="EV_nom_usuario"  Tipo="STRING"> nombre usuario </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      lv_fechamaxima   VARCHAR2 (20);
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'INSERT INTO ve_vendcliente(cod_vendedor, ' || 'cod_cliente, ' || 'fec_asignacion, ' || 'nom_usuario) ' || 'VALUES (' || ev_cod_vendedor || ', ' || ev_cod_cliente || ', ' || 'SYSDATE, ' || ev_nom_usuario || ')';
--       INSERT INTO ve_vendcliente(cod_vendedor,
--                                    cod_cliente,
--                            fec_asignacion,
--                            nom_usuario)
--       VALUES (EV_cod_vendedor,
--                 EV_cod_cliente,
--             SYSDATE,
--             EV_nom_usuario);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10729;
         sv_menretorno :='Error al ingresar Relacion Vendedor Cliente';
         lv_deserror   :='OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insVendCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_insVendCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_insvendcliente_pr;

   PROCEDURE ve_updcategcliente_pr (
      ev_cod_cliente     IN              VARCHAR2,
      ev_cod_categoria   IN              VARCHAR2,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updCategCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Actualiza categoria del cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_cod_cliente"   Tipo="NUMBER"> codigo cliente </param>
            <param nom="EN_cod_categoria" Tipo="NUMBER"> codigo categoria </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
              <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
              <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'UPDATE ge_clientes ' || 'SET cod_categoria = ' || ev_cod_categoria || 'WHERE cod_cliente = ' || ev_cod_cliente;

      UPDATE ge_clientes
         SET cod_categoria = ev_cod_categoria
       WHERE cod_cliente = ev_cod_cliente;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10730;
         sv_menretorno := 'Error al Actualizar Categoria del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updCategCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updCategCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_updcategcliente_pr;

   PROCEDURE ve_updcodigousocliente_pr (
      ev_codcuenta    IN              VARCHAR2,
      ev_coduso       IN              VARCHAR2,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updCodigoUsoCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Actualiza codigo uso del cliente
      </Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_codCuenta" Tipo="STRING"> codigo cuenta </param>
            <param nom="EN_codUso"    Tipo="STRING"> codigo uso </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'UPDATE ge_clientes a' || 'SET a.cod_uso  = ' || ev_coduso || 'WHERE a.cod_cuenta = ' || ev_codcuenta;

      UPDATE ge_clientes a
         SET a.cod_uso = ev_coduso
       WHERE a.cod_cuenta = ev_codcuenta;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10731;
         sv_menretorno := 'Error al actualizar Codigo Uso del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updCodigoUsoCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updCodigoUsoCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_updcodigousocliente_pr;

   PROCEDURE ve_updcategclientecta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_codcategoria   IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updCategClienteCta_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Actualiza codigo categoria del cliente,segun codigo cuenta
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codCuenta" Tipo="STRING"> codigo cuenta </param>
            <param nom="EN_codUso"    Tipo="STRING"> codigo uso </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'UPDATE ge_clientes a' || 'SET a.cod_categoria  = ' || ev_codcategoria || 'WHERE a.cod_cuenta = ' || ev_codcuenta || 'AND (a.cod_categoria IS NULL or a.cod_categoria = 0)';

      UPDATE ge_clientes a
         SET a.cod_categoria = ev_codcategoria
       WHERE a.cod_cuenta = ev_codcuenta AND (a.cod_categoria IS NULL OR a.cod_categoria = 0);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10732;
         sv_menretorno := 'Error al Actualiza Codigo Categoria del Cliente, segun Codigo Cuenta';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updCategClienteCta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updCategClienteCta_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_updcategclientecta_pr;

   PROCEDURE ve_updsubcategcliente_pr (
      ev_codcliente    IN              VARCHAR2,
      ev_codsubcateg   IN              VARCHAR2,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updSubCategCliente_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Actualiza codigo subcategoria del cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codCliente"  Tipo="STRING"> codigo cliente </param>
            <param nom="EN_codSubCateg" Tipo="STRING"> codigo subcategoria </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'UPDATE ge_clientes a' || ' SET a.cod_subcategoria  = ' || ev_codsubcateg || ' WHERE a.cod_cliente = ' || ev_codcliente;

      UPDATE ge_clientes a
         SET a.cod_subcategoria = ev_codsubcateg
       WHERE a.cod_cliente = ev_codcliente;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10733;
         sv_menretorno := 'Error al Actualizar Codigo Subcategoria del Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updSubCategCliente_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updSubCategCliente_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_updsubcategcliente_pr;

   PROCEDURE ve_updempresa_pr (
      en_cod_empresa   IN              ga_empresa.cod_empresa%TYPE,
      en_numabonados   IN              ga_empresa.num_abonados%TYPE,
      ev_usuario       IN              VARCHAR2,
      sn_codretorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insEmpresa_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Inserta empresa asociada al cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codempresa"   Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_desempresa"   Tipo="STRING"> descripcion empresa </param>
            <param nom="EN_codproducto"  Tipo="NUMBER"> codigo producto </param>
            <param nom="EV_codplantarif" Tipo="STRING"> codigo plan tarifario </param>
            <param nom="EN_codciclo"     Tipo="STRING"> codigo ciclo </param>
            <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
            <param nom="EN_numabonados"  Tipo="NUMBER"> numero abonados </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql       EXCEPTION;
      lv_deserror     ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
      ln_codempresa   NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'UPDATE ga_empresa SET' || ' nom_usuarora = ' || ev_usuario || ',' || ' num_abonados = ' || en_numabonados || ' WHERE cod_empresa = ' || en_cod_empresa;

      UPDATE ga_empresa
         SET nom_usuarora = ev_usuario,
             num_abonados = en_numabonados
       WHERE cod_empresa = en_cod_empresa;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10734;
         sv_menretorno := 'Error al modificar Empresa Asociada al Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updEmpresa_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updEmpresa_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_updempresa_pr;

   PROCEDURE ve_selempresa_pr (
      en_cod_cliente     IN              ga_empresa.num_abonados%TYPE,
      sn_cod_empresa     OUT NOCOPY      ga_empresa.cod_empresa%TYPE,
      sv_des_empresa     OUT NOCOPY      ga_empresa.des_empresa%TYPE,
      sn_cod_producto    OUT NOCOPY      ga_empresa.cod_producto%TYPE,
      sv_cod_plantarif   OUT NOCOPY      ga_empresa.cod_plantarif%TYPE,
      sd_fec_alta        OUT NOCOPY      ga_empresa.fec_alta%TYPE,
      sv_nom_usuarora    OUT NOCOPY      ga_empresa.nom_usuarora%TYPE,
      sn_cod_ciclo       OUT NOCOPY      ga_empresa.cod_ciclo%TYPE,
      sn_cod_cliente     OUT NOCOPY      ga_empresa.cod_cliente%TYPE,
      sv_tip_terminal    OUT NOCOPY      ga_empresa.tip_terminal%TYPE,
      sn_num_abonados    OUT NOCOPY      ga_empresa.num_abonados%TYPE,
      sn_codretorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno      OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento       OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insEmpresa_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Inserta empresa asociada al cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codempresa"   Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_desempresa"   Tipo="STRING"> descripcion empresa </param>
            <param nom="EN_codproducto"  Tipo="NUMBER"> codigo producto </param>
            <param nom="EV_codplantarif" Tipo="STRING"> codigo plan tarifario </param>
            <param nom="EN_codciclo"     Tipo="STRING"> codigo ciclo </param>
            <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
            <param nom="EN_numabonados"  Tipo="NUMBER"> numero abonados </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql       EXCEPTION;
      lv_deserror     ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
      ln_codempresa   NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql := 'SELECT cod_empresa' || ' FROM ga_empresa' || ' WHERE cod_cliente = ' || en_cod_cliente || ' AND ROWNUM < 2';

      SELECT cod_empresa, des_empresa, cod_producto, cod_plantarif, fec_alta, nom_usuarora, cod_ciclo, cod_cliente, tip_terminal, num_abonados
        INTO sn_cod_empresa, sv_des_empresa, sn_cod_producto, sv_cod_plantarif, sd_fec_alta, sv_nom_usuarora, sn_cod_ciclo, sn_cod_cliente, sv_tip_terminal, sn_num_abonados
        FROM ga_empresa
       WHERE cod_cliente = en_cod_cliente AND ROWNUM < 2;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10735;
         sv_menretorno := 'Error al consultar Empresa Asociada al Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updEmpresa_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_updEmpresa_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_selempresa_pr;

   PROCEDURE ve_getcliente_pr (
      ev_cod_cliente          IN              VARCHAR,
      sv_cod_cliente          OUT             VARCHAR2,
      sv_nom_cliente          OUT             VARCHAR2,
      sv_cod_tipident         OUT             VARCHAR2,
      sv_num_ident            OUT             VARCHAR2,
      sv_cod_calclien         OUT             VARCHAR2,
      sv_ind_situacion        OUT             VARCHAR2,
      sv_fec_alta             OUT             VARCHAR2,
      sv_ind_factur           OUT             VARCHAR2,
      sv_ind_traspaso         OUT             VARCHAR2,
      sv_ind_agente           OUT             VARCHAR2,
      sv_fec_ultmod           OUT             VARCHAR2,
      sv_num_fax              OUT             VARCHAR2,
      sv_ind_mandato          OUT             VARCHAR2,
      sv_nom_usuarora         OUT             VARCHAR2,
      sv_ind_alta             OUT             VARCHAR2,
      sv_cod_cuenta           OUT             VARCHAR2,
      sv_ind_acepvent         OUT             VARCHAR2,
      sv_cod_abc              OUT             VARCHAR2,
      sv_cod_123              OUT             VARCHAR2,
      sv_cod_actividad        OUT             VARCHAR2,
      sv_cod_pais             OUT             VARCHAR2,
      sv_tef_cliente1         OUT             VARCHAR2,
      sv_num_abocel           OUT             VARCHAR2,
      sv_tef_cliente2         OUT             VARCHAR2,
      sv_num_abobeep          OUT             VARCHAR2,
      sv_ind_debito           OUT             VARCHAR2,
      sv_num_abotrunk         OUT             VARCHAR2,
      sv_cod_prospecto        OUT             VARCHAR2,
      sv_num_abotrek          OUT             VARCHAR2,
      sv_cod_sispago          OUT             VARCHAR2,
      sv_nom_apeclien1        OUT             VARCHAR2,
      sv_nom_email            OUT             VARCHAR2,
      sv_num_aborent          OUT             VARCHAR2,
      sv_nom_apeclien2        OUT             VARCHAR2,
      sv_num_aboroaming       OUT             VARCHAR2,
      sv_fec_acepvent         OUT             VARCHAR2,
      sv_imp_stopdebit        OUT             VARCHAR2,
      sv_cod_banco            OUT             VARCHAR2,
      sv_cod_sucursal         OUT             VARCHAR2,
      sv_ind_tipcuenta        OUT             VARCHAR2,
      sv_cod_tiptarjeta       OUT             VARCHAR2,
      sv_num_ctacorr          OUT             VARCHAR2,
      sv_num_tarjeta          OUT             VARCHAR2,
      sv_fec_vencitarj        OUT             VARCHAR2,
      sv_cod_bancotarj        OUT             VARCHAR2,
      sv_cod_tipidtrib        OUT             VARCHAR2,
      sv_num_identtrib        OUT             VARCHAR2,
      sv_cod_tipidentapor     OUT             VARCHAR2,
      sv_num_identapor        OUT             VARCHAR2,
      sv_nom_apoderado        OUT             VARCHAR2,
      sv_cod_oficina          OUT             VARCHAR2,
      sv_fec_baja             OUT             VARCHAR2,
      sv_cod_cobrador         OUT             VARCHAR2,
      sv_cod_pincli           OUT             VARCHAR2,
      sv_cod_ciclo            OUT             VARCHAR2,
      sv_num_celular          OUT             VARCHAR2,
      sv_ind_tippersona       OUT             VARCHAR2,
      sv_cod_ciclonue         OUT             VARCHAR2,
      sv_cod_categoria        OUT             VARCHAR2,
      sv_cod_sector           OUT             VARCHAR2,
      sv_cod_supervisor       OUT             VARCHAR2,
      sv_ind_estcivil         OUT             VARCHAR2,
      sv_fec_nacimien         OUT             VARCHAR2,
      sv_ind_sexo             OUT             VARCHAR2,
      sv_num_int_grup_fam     OUT             VARCHAR2,
      sv_cod_npi              OUT             VARCHAR2,
      sv_cod_subcategoria     OUT             VARCHAR2,
      sv_cod_uso              OUT             VARCHAR2,
      sv_cod_idioma           OUT             VARCHAR2,
      sv_cod_tipident2        OUT             VARCHAR2,
      sv_num_ident2           OUT             VARCHAR2,
      sv_nom_usuario_asesor   OUT             VARCHAR2,
      sv_cod_operadora        OUT             VARCHAR2,
      sv_id_segmento          OUT             VARCHAR2,
      sv_cod_tecnologia       OUT             VARCHAR2,
      sv_cod_empresa          OUT             VARCHAR2,
      sv_cod_plantarif        OUT             VARCHAR2,
      sv_des_empresa          OUT             VARCHAR2,
      sv_num_abonados         OUT             VARCHAR2,
      sv_num_abonados_plan    OUT             VARCHAR2,
      sn_codretorno           OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insEmpresa_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              INSERTA EMPRESA ASOCIADA AL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codempresa"   Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_desempresa"   Tipo="STRING"> descripcion empresa </param>
            <param nom="EN_codproducto"  Tipo="NUMBER"> codigo producto </param>
            <param nom="EV_codplantarif" Tipo="STRING"> codigo plan tarifario </param>
            <param nom="EN_codciclo"     Tipo="STRING"> codigo ciclo </param>
            <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
            <param nom="EN_numabonados"  Tipo="NUMBER"> numero abonados </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql       EXCEPTION;
      lv_deserror     ge_errores_pg.desevent;
      lv_sql          ge_errores_pg.vquery;
      ln_codempresa   NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'SELECT cod_cliente, nom_cliente, cod_tipident, num_ident, cod_calclien, ind_situacion, fec_alta, ind_factur, ind_traspaso, ind_agente, fec_ultmod, num_fax,'
         || ' ind_mandato, nom_usuarora, ind_alta, cod_cuenta, ind_acepvent, cod_abc, cod_123, cod_actividad, cod_pais, tef_cliente1, num_abocel, tef_cliente2,'
         || ' num_abobeep, ind_debito, num_abotrunk, cod_prospecto, num_abotrek, cod_sispago, nom_apeclien1, nom_email, num_aborent, nom_apeclien2, num_aboroaming,'
         || ' fec_acepvent, imp_stopdebit, cod_banco, cod_sucursal, ind_tipcuenta, cod_tiptarjeta, num_ctacorr, num_tarjeta, fec_vencitarj, cod_bancotarj, cod_tipidtrib,'
         || ' num_identtrib, cod_tipidentapor, num_identapor, nom_apoderado, cod_oficina, fec_baja, cod_cobrador, cod_pincli, cod_ciclo, num_celular, ind_tippersona,'
         || ' cod_ciclonue, cod_categoria, cod_sector, cod_supervisor, ind_estcivil, fec_nacimien, ind_sexo, num_int_grup_fam, cod_npi, cod_subcategoria, cod_uso,'
         || ' cod_idioma, cod_tipident2, num_ident2, nom_usuario_asesor, cod_operadora, id_segmento, cod_tecnologia' || ' FROM ge_clientes a' || ' WHERE a.cod_cliente = ' || ev_cod_cliente;



      SELECT a.cod_cliente, nom_cliente, cod_tipident, num_ident, cod_calclien, ind_situacion, a.fec_alta, ind_factur, ind_traspaso, ind_agente, fec_ultmod, num_fax, ind_mandato, a.nom_usuarora, ind_alta,
             cod_cuenta, ind_acepvent, cod_abc, cod_123, cod_actividad, cod_pais, tef_cliente1, num_abocel, tef_cliente2, num_abobeep, ind_debito, num_abotrunk, cod_prospecto, num_abotrek, cod_sispago,
             nom_apeclien1, nom_email, num_aborent, nom_apeclien2, num_aboroaming, fec_acepvent, imp_stopdebit, cod_banco, cod_sucursal, ind_tipcuenta, cod_tiptarjeta, num_ctacorr, num_tarjeta, fec_vencitarj,
             cod_bancotarj, cod_tipidtrib, num_identtrib, cod_tipidentapor, num_identapor, nom_apoderado, cod_oficina, fec_baja, cod_cobrador, cod_pincli, a.cod_ciclo, num_celular, ind_tippersona, cod_ciclonue,
             cod_categoria, cod_sector, cod_supervisor, ind_estcivil, fec_nacimien, ind_sexo, num_int_grup_fam, cod_npi, cod_subcategoria, cod_uso, cod_idioma, cod_tipident2, num_ident2, nom_usuario_asesor,
             cod_operadora, null, null, nvl(b.cod_empresa,0), nvl(b.cod_plantarif,''), b.des_empresa, nvl(b.num_abonados,0), c.num_abonados
        INTO sv_cod_cliente, sv_nom_cliente, sv_cod_tipident, sv_num_ident, sv_cod_calclien, sv_ind_situacion, sv_fec_alta, sv_ind_factur, sv_ind_traspaso, sv_ind_agente, sv_fec_ultmod, sv_num_fax, sv_ind_mandato, sv_nom_usuarora, sv_ind_alta,
             sv_cod_cuenta, sv_ind_acepvent, sv_cod_abc, sv_cod_123, sv_cod_actividad, sv_cod_pais, sv_tef_cliente1, sv_num_abocel, sv_tef_cliente2, sv_num_abobeep, sv_ind_debito, sv_num_abotrunk, sv_cod_prospecto, sv_num_abotrek, sv_cod_sispago,
             sv_nom_apeclien1, sv_nom_email, sv_num_aborent, sv_nom_apeclien2, sv_num_aboroaming, sv_fec_acepvent, sv_imp_stopdebit, sv_cod_banco, sv_cod_sucursal, sv_ind_tipcuenta, sv_cod_tiptarjeta, sv_num_ctacorr, sv_num_tarjeta, sv_fec_vencitarj,
             sv_cod_bancotarj, sv_cod_tipidtrib, sv_num_identtrib, sv_cod_tipidentapor, sv_num_identapor, sv_nom_apoderado, sv_cod_oficina, sv_fec_baja, sv_cod_cobrador, sv_cod_pincli, sv_cod_ciclo, sv_num_celular, sv_ind_tippersona, sv_cod_ciclonue,
             sv_cod_categoria, sv_cod_sector, sv_cod_supervisor, sv_ind_estcivil, sv_fec_nacimien, sv_ind_sexo, sv_num_int_grup_fam, sv_cod_npi, sv_cod_subcategoria, sv_cod_uso, sv_cod_idioma, sv_cod_tipident2, sv_num_ident2, sv_nom_usuario_asesor,
             sv_cod_operadora, sv_id_segmento, sv_cod_tecnologia, sv_cod_empresa ,sv_cod_plantarif,sv_des_empresa, sv_num_abonados, sv_num_abonados_plan
        FROM ge_clientes a, ga_empresa b, ta_plantarif c
       WHERE a.cod_cliente = ev_cod_cliente
         AND b.cod_cliente(+) = a.cod_cliente
         AND c.COD_PLANTARIF(+) = b.COD_PLANTARIF;


   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10736;
         sv_menretorno := 'Error al consultar datos del cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.ve_getcliente_pr;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.ve_getcliente_pr', lv_sql, SQLCODE, lv_deserror);
   END ve_getcliente_pr;

   PROCEDURE ga_update_estado_venta_pr (
      so_ventas       IN OUT NOCOPY   ve_tipos_pg.tip_ga_ventas,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación
        TipoDoc = "Procedure">>
         <Elemento
            Nombre = "GA_INSERT_VENTA_PR
            Lenguaje="PL/SQL"
            Fecha="03-05-2007"
            Versión="La del package"
            Diseñador="Raúl Lozano"
            Programador="Raúl Lozano"
            Ambiente Desarrollo="BD">
            <Retorno>SO_cuenta</Retorno>>
            <Descripción>
                        RECUPERA EL CÓDIGO DEL PROCESO DE VENTA
             </Descripción>>
            <Parámetros>
               <Entrada>
                  <param nom="SO_VENTAS Tipo="estructura">estructura de ga_ventas</param>>
               </Entrada>
               <Salida>
                  <param nom="SO_VENTAS         Tipo="estructura">estructura de ga_ventas</param>>
                  <param nom="SN_cod_retorno"   Tipo="NUMERICO">Codigo de Retorno</param>>
                  <param nom="SV_mens_retorno"  Tipo="CARACTER">Mensaje de Retorno</param>>
                  <param nom="SN_num_evento"    Tipo="NUMERICO">Numero de Evento</param>>
               </Salida>
            </Parámetros>
         </Elemento>
      </Documentación>
      */
      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
      CanAboamist   NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;

      SELECT SUM (DECODE (conc.cod_tipconce, 3, imp_facturable, 0))+SUM (DECODE (conc.cod_tipconce, 1, imp_facturable, 0))+SUM (DECODE (conc.cod_tipconce, 2, imp_facturable, 0))
        INTO so_ventas (1).imp_venta
        FROM siscel.fa_presupuesto pre, fa_conceptos conc
       WHERE pre.cod_concepto = conc.cod_concepto
         AND pre.num_venta = so_ventas (1).num_venta
         AND cod_cliente > 0
         AND pre.cod_concepto > 0
         AND columna > 0;

      IF (so_ventas (1).ind_estventa = 'AC') then

         SELECT count(1)
           INTO CanAboamist
           FROM ga_abocel
          WHERE num_venta = so_ventas (1).num_venta;


           IF  CanAboamist > 1 THEN

              lv_sql := 'UPDATE ga_ventas'
                     || ' SET ind_estventa = ' || so_ventas (1).ind_estventa
                     || ' num_transaccion = ' || so_ventas (1).num_transaccion                                                      --<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                     || ' num_contrato = ' || so_ventas (1).num_contrato
                     || ' a.fec_aceprec = SYSDATE'
                     || ' a.nom_usuar_acerec = ' || so_ventas (1).nom_usuar_acerec
                     || ' WHERE num_venta = ' || so_ventas (1).num_venta;

              UPDATE ga_ventas a
                 SET a.ind_estventa = so_ventas (1).ind_estventa,
                     a.num_transaccion = so_ventas (1).num_transaccion,                                                                                                                                     --<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                     a.num_contrato = so_ventas (1).num_contrato,
                     a.fec_aceprec = SYSDATE,
                     a.nom_usuar_acerec = so_ventas (1).nom_usuar_acerec,
                     a.mto_garantia = so_ventas (1).mto_garantia,
                     a.imp_venta = so_ventas (1).imp_venta
               WHERE a.num_venta = so_ventas (1).num_venta;

              lv_sql := 'UPDATE ga_abocel a'
                     || ' SET a.fec_acepventa = SYSDATE,'
                     || ' a.fec_ultmod = SYSDATE'
                     || ' WHERE num_venta = ' || so_ventas (1).num_venta;

              UPDATE ga_abocel a
                 SET a.fec_acepventa = SYSDATE,
                     a.fec_ultmod = SYSDATE
               WHERE a.num_venta = so_ventas (1).num_venta;

         END IF;
      ELSE

            SELECT count(1)
            INTO CanAboamist
            FROM ga_aboamist
           WHERE num_venta = so_ventas (1).num_venta;


           IF  CanAboamist < 1 THEN

                   lv_sql := 'UPDATE ga_ventas'
                     || ' SET ind_estventa = '|| so_ventas (1).ind_estventa
                     || ' num_transaccion = ' || so_ventas (1).num_transaccion
                     || ' num_contrato = '    || so_ventas (1).num_contrato
                     || ' a.fec_aceprec = SYSDATE'
                     || ' a.nom_usuar_acerec = '|| so_ventas (1).nom_usuar_acerec
                     || ' WHERE num_venta = ' || so_ventas (1).num_venta;

              UPDATE ga_ventas a
                 SET a.ind_estventa = so_ventas (1).ind_estventa,
                     a.num_transaccion = so_ventas (1).num_transaccion,                                                                                                                                     --<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                     a.num_contrato = so_ventas (1).num_contrato,
                     a.nom_usuar_acerec = so_ventas (1).nom_usuar_acerec,
                     a.mto_garantia = so_ventas (1).mto_garantia,
                     a.imp_venta = so_ventas (1).imp_venta
               WHERE num_venta = so_ventas (1).num_venta;

              lv_sql := 'UPDATE ga_abocel a'
                     || ' SET a.fec_acepventa = SYSDATE,'
                     || ' a.fec_ultmod = SYSDATE'
                     || ' WHERE num_venta = ' || so_ventas (1).num_venta;

              UPDATE ga_abocel a
                 SET a.fec_ultmod = SYSDATE
               WHERE num_venta = so_ventas (1).num_venta;

           ELSE

              lv_sql := 'UPDATE ga_ventas'
                     || ' SET ind_estventa = '|| so_ventas (1).ind_estventa
                     || ' num_transaccion = ' || so_ventas (1).num_transaccion
                     || ' num_contrato = '    || so_ventas (1).num_contrato
                     || ' a.fec_aceprec = SYSDATE'
                     || ' a.nom_usuar_acerec = '|| so_ventas (1).nom_usuar_acerec
                     || ' WHERE num_venta = ' || so_ventas (1).num_venta;

              UPDATE ga_ventas a
                 SET a.ind_estventa = 'AC',
                     a.num_transaccion = so_ventas (1).num_transaccion,                                                                                                                                     --<secuencia asociada a uso de tabla de paso GA_TRANSACABO>
                     a.num_contrato = so_ventas (1).num_contrato,
                     a.nom_usuar_acerec = so_ventas (1).nom_usuar_acerec,
                     a.fec_aceprec = SYSDATE,
                     a.mto_garantia = so_ventas (1).mto_garantia,
                     a.imp_venta = so_ventas (1).imp_venta
               WHERE num_venta = so_ventas (1).num_venta;

              lv_sql := 'UPDATE ga_aboamist a'
                     || ' SET a.fec_acepventa = SYSDATE,'
                     || ' a.fec_ultmod = SYSDATE'
                     || ' WHERE num_venta = ' || so_ventas (1).num_venta;

              UPDATE ga_aboamist a
                 SET a.fec_ultmod = SYSDATE,
                     a.fec_acepventa = SYSDATE
               WHERE num_venta = so_ventas (1).num_venta;

                lv_sql := 'UPDATE ge_clientes a'
                     || ' SET a.ind_acepvent =1,'
                     || ' a.fec_acepvent = sysdate'
                     || ' WHERE a.cod_cliente = '||so_ventas (1).cod_cliente;


                UPDATE ge_clientes a
                   SET a.ind_acepvent =1,
                       a.fec_acepvent = sysdate
                 WHERE a.cod_cliente = so_ventas (1).cod_cliente;


           END IF;

     END IF;

   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10737;
         sv_menretorno := 'Error al modificar Estado de la Venta';
         lv_deserror   := sv_menretorno;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.GA_UPDATE_ESTADO_VENTA_PR', lv_sql, SQLCODE, lv_deserror);
   END ga_update_estado_venta_pr;

   PROCEDURE ve_getcentral_pr (
      ev_cod_hlr                    VARCHAR2,
      ev_cod_celda                  VARCHAR2,
      sv_cod_central   OUT NOCOPY   icg_central.cod_central%TYPE,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insEmpresa_PR"
         Lenguaje="PL/SQL"
         Fecha="06-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              Inserta empresa asociada al cliente
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EN_codempresa"   Tipo="NUMBER"> codigo empresa </param>
            <param nom="EV_desempresa"   Tipo="STRING"> descripcion empresa </param>
            <param nom="EN_codproducto"  Tipo="NUMBER"> codigo producto </param>
            <param nom="EV_codplantarif" Tipo="STRING"> codigo plan tarifario </param>
            <param nom="EN_codciclo"     Tipo="STRING"> codigo ciclo </param>
            <param nom="EN_codcliente"   Tipo="NUMBER"> codigo cliente </param>
            <param nom="EN_numabonados"  Tipo="NUMBER"> numero abonados </param>
          </Entrada>
            <Salida>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      lv_deserror      ge_errores_pg.desevent;
      lv_sql           ge_errores_pg.vquery;
      n_canregistros   NUMBER;
      poscicion        NUMBER;
      sc_cur_cliente   refcursor;
      contador         NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'SELECT count(1)' || ' FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e' || ' WHERE b.cod_celda = ' || ev_cod_celda || ' AND c.cod_subalm = b.cod_subalm' || ' AND d.cod_alm = c.cod_alm' || ' AND e.cod_alm = d.cod_alm'
         || ' AND e.cod_hlr = ' || ev_cod_hlr;

      SELECT COUNT (1)
        INTO n_canregistros
        FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e
       WHERE b.cod_celda = ev_cod_celda AND c.cod_subalm = b.cod_subalm AND d.cod_alm = c.cod_alm AND e.cod_alm = d.cod_alm AND e.cod_hlr = ev_cod_hlr AND e.cod_central IN (1, 2);

      lv_sql := 'poscicion := (DBMS_RANDOM.value()*' || n_canregistros || ')+1';
      poscicion := (DBMS_RANDOM.VALUE () * n_canregistros) + 1;
      lv_sql :=
         'SELECT cod_central' || ' FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e' || ' WHERE b.cod_celda = ' || ev_cod_celda || ' AND c.cod_subalm = b.cod_subalm' || ' AND d.cod_alm = c.cod_alm' || ' AND e.cod_alm = d.cod_alm'
         || ' AND e.cod_hlr = ev_cod_hlr';

      OPEN sc_cur_cliente FOR
         SELECT cod_central
           FROM ge_celdas b, ge_subalms c, ge_alms d, icg_central e
          WHERE b.cod_celda = ev_cod_celda AND c.cod_subalm = b.cod_subalm AND d.cod_alm = c.cod_alm AND e.cod_alm = d.cod_alm AND e.cod_hlr = ev_cod_hlr;

      lv_sql := 'FOR contador IN 1..' || poscicion || ' LOOP';

      FOR contador IN 1 .. poscicion LOOP
         lv_sql := 'FETCH sc_cur_cliente INTO sv_cod_central';

         FETCH sc_cur_cliente
          INTO sv_cod_central;
      END LOOP;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10738;
         sv_menretorno :='Error al obtener Empresa Asociada al Cliente';
         lv_deserror   := 'OTHERS:VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getcentral_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 'VE_ALTA_CLIENTE_QUIOSCO_PG.VE_getcentral_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getcentral_pr;

END VE_ALTA_CLIENTE_QUIOSCO_PG;
/

SHOW ERRORS