CREATE OR REPLACE PACKAGE BODY ve_alta_cuenta_quiosco_pg IS
--------------------
---- FUNCIONES -----
--------------------

FUNCTION ve_valida_tipo_comis_fn (
		 ev_tipcomis  IN   VARCHAR2
) RETURN BOOLEAN IS

ln_comis NUMBER;

BEGIN
	  SELECT count(1)
	  INTO	 ln_comis
	  FROM   ve_tipcomis
	  WHERE  cod_tipcomis = ev_tipcomis;

	  IF ln_comis > 0 THEN
	  	 RETURN TRUE;
	  END IF;

	  RETURN FALSE;

EXCEPTION
      WHEN OTHERS THEN
	  	    RETURN FALSE;
END ve_valida_tipo_comis_fn;

--------------------
-- PROCEDIMIENTOS --
--------------------
   PROCEDURE ve_getcuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      sv_descuenta      OUT NOCOPY      VARCHAR2,
      sv_tipcuenta      OUT NOCOPY      VARCHAR2,
      sv_responsable    OUT NOCOPY      VARCHAR2,
      sv_codtipident    OUT NOCOPY      VARCHAR2,
      sv_numident       OUT NOCOPY      VARCHAR2,
      sv_coddirec       OUT NOCOPY      VARCHAR2,
      sv_fecalta        OUT NOCOPY      VARCHAR2,
      sv_indestado      OUT NOCOPY      VARCHAR2,
      sv_telcontacto    OUT NOCOPY      VARCHAR2,
      sv_indsector      OUT NOCOPY      VARCHAR2,
      sv_clascta        OUT NOCOPY      VARCHAR2,
      sv_codcatribut    OUT NOCOPY      VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsector      OUT NOCOPY      VARCHAR2,
      sv_codsubcat      OUT NOCOPY      VARCHAR2,
      sv_indmultuso     OUT NOCOPY      VARCHAR2,
      sv_clipotencial   OUT NOCOPY      VARCHAR2,
      sv_razonsocial    OUT NOCOPY      VARCHAR2,
      sv_fecinvpac      OUT NOCOPY      VARCHAR2,
      sv_tipcomis       OUT NOCOPY      VARCHAR2,
      sv_usuarasesor    OUT NOCOPY      VARCHAR2,
      sv_fecnac         OUT NOCOPY      VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getCuenta_PR"
         Lenguaje="PL/SQL"
         Fecha="19-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              DATOS CUENTA
       </Retorno>
      <Descripción>
              DATOS CUENTA
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
          </Entrada>
            <Salida>
            <param nom="SV_desCuenta"    Tipo="STRING"> descripcion Cuenta </param>
            <param nom="SV_tipCuenta"    Tipo="STRING"> Tipo de Cuenta I=Individual, E= Empresa </param>
            <param nom="SV_responsable"  Tipo="STRING"> Nombre del Responsable </param>
            <param nom="SV_codTipident"  Tipo="STRING"> Tipo de Identificacion</param>
            <param nom="SV_numIdent"     Tipo="STRING"> Número de identificacion</param>
            <param nom="SV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
            <param nom="SV_fecAlta"      Tipo="STRING"> Fecha de Nacimiento </param>
            <param nom="SV_indEstado"    Tipo="STRING"> Estado de la Cuenta</param>
            <param nom="SV_TelContacto"  Tipo="STRING"> Telefono Contacto de la Cuenta</param>
            <param nom="SV_indSector"    Tipo="STRING"> Indice Sector de la Cuenta</param>
            <param nom="SV_clasCta"      Tipo="STRING"> Clase de la Cuenta</param>
            <param nom="SV_codCatribut"  Tipo="STRING"> Codigo de Categoria Tributaria de la Cuenta</param>
            <param nom="SV_codCategoria" Tipo="STRING"> Codigo de Categoria de la Cuenta</param>
            <param nom="SV_codSector"    Tipo="STRING"> Codigo de sector de la Cuenta</param>
            <param nom="SV_codSubCat"    Tipo="STRING"> Codigo de Subcategoria Tributaria de la Cuenta</param>
            <param nom="SV_indMultuso"   Tipo="STRING"> Indicador de Multiples usos</param>
            <param nom="SV_cliPotencial" Tipo="STRING"> Indicador de Cuenta Potencial </param>
            <param nom="SV_razonSocial"  Tipo="STRING"> Indicador de Cuenta Potencial </param>
            <param nom="SV_fecInVPac"    Tipo="STRING"> Fecha de la primera venta PA </param>
            <param nom="SV_tipComis"     Tipo="STRING"> Codigo de Tipo de Comisionista </param>
            <param nom="SV_usuarAsesor"  Tipo="STRING"> Nombre Usuario asesor de la cuenta </param>
            <param nom="SV_fecNac"       Tipo="STRING"> Fecha de Nacimiento </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql         EXCEPTION;
      lv_deserror       ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      lv_formatofecha   VARCHAR2 (30);
      lv_formatohora    VARCHAR2 (30);
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      --  Obtenemos El Valor Para Formato Fecha (Sel2)
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_formatosel2, cv_modulo_ge, cv_producto, lv_formatofecha, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      --  Obtenemos El Valor Para Formato Hora (Sel7)
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_formatosel7, cv_modulo_ge, cv_producto, lv_formatohora, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_sql :=
         ' SELECT a.DES_CUENTA,' || 'a.TIP_CUENTA,' || 'a.NOM_RESPONSABLE,' || 'a.COD_TIPIDENT,' || 'a.NUM_IDENT,' || 'a.COD_DIRECCION,' || 'a.FEC_ALTA,' || 'a.IND_ESTADO,' || 'a.TEL_CONTACTO,' || 'a.IND_SECTOR,' || 'a.COD_CLASCTA,' || 'a.COD_CATRIBUT,'
         || 'a.COD_CATEGORIA,' || 'a.COD_SECTOR,' || 'a.COD_SUBCATEGORIA,' || 'a.IND_MULTUSO,' || 'a.IND_CLIEPOTENCIAL,' || 'a.DES_RAZON_SOCIAL,' || 'a.FEC_INIVTA_PAC,' || 'a.COD_TIPCOMIS,' || 'a.NOM_USUARIO_ASESOR,' || 'a.FEC_NACIMIENTO'
         || 'FROM ga_cuentas a ' || 'WHERE a.cod_cuenta = ' || ev_codcuenta;

      SELECT a.des_cuenta, a.tip_cuenta, a.nom_responsable, a.cod_tipident, a.num_ident, a.cod_direccion, TO_CHAR (a.fec_alta, lv_formatofecha || ' ' || lv_formatohora), a.ind_estado, a.tel_contacto, a.ind_sector, a.cod_clascta, a.cod_catribut,
             a.cod_categoria, a.cod_sector, a.cod_subcategoria, a.ind_multuso, a.ind_cliepotencial, a.des_razon_social, TO_CHAR (a.fec_inivta_pac, lv_formatofecha || ' ' || lv_formatohora), a.cod_tipcomis, a.nom_usuario_asesor,
             TO_CHAR (a.fec_nacimiento, lv_formatofecha || ' ' || lv_formatohora)
        INTO sv_descuenta, sv_tipcuenta, sv_responsable, sv_codtipident, sv_numident, sv_coddirec, sv_fecalta, sv_indestado, sv_telcontacto, sv_indsector, sv_clascta, sv_codcatribut,
             sv_codcategoria, sv_codsector, sv_codsubcat, sv_indmultuso, sv_clipotencial, sv_razonsocial, sv_fecinvpac, sv_tipcomis, sv_usuarasesor,
             sv_fecnac
        FROM ga_cuentas a
       WHERE a.cod_cuenta = EV_codcuenta;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno   := 1;
         sv_menretorno   := 'No se pudo Recuperar Datos.';
         lv_deserror     := 'NO_DATA_FOUND:ve_alta_cuenta_quiosco_pg.VE_getCuenta_PR;- ' || SQLERRM;
         sn_numevento    := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getCuenta_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10739;
         sv_menretorno := 'Error al obtener Datos de la Cuenta';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_getCuenta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getCuenta_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getcuenta_pr;

   PROCEDURE ve_getcuentaidentif_pr (
      ev_codtipident    IN              VARCHAR2,
      ev_numident       IN              VARCHAR2,
      sv_codcuenta      OUT NOCOPY      VARCHAR2,
      sv_descuenta      OUT NOCOPY      VARCHAR2,
      sv_tipcuenta      OUT NOCOPY      VARCHAR2,
      sv_responsable    OUT NOCOPY      VARCHAR2,
      sv_coddirec       OUT NOCOPY      VARCHAR2,
      sv_fecalta        OUT NOCOPY      VARCHAR2,
      sv_indestado      OUT NOCOPY      VARCHAR2,
      sv_telcontacto    OUT NOCOPY      VARCHAR2,
      sv_indsector      OUT NOCOPY      VARCHAR2,
      sv_clascta        OUT NOCOPY      VARCHAR2,
      sv_codcatribut    OUT NOCOPY      VARCHAR2,
      sv_codcategoria   OUT NOCOPY      VARCHAR2,
      sv_codsector      OUT NOCOPY      VARCHAR2,
      sv_codsubcat      OUT NOCOPY      VARCHAR2,
      sv_indmultuso     OUT NOCOPY      VARCHAR2,
      sv_clipotencial   OUT NOCOPY      VARCHAR2,
      sv_razonsocial    OUT NOCOPY      VARCHAR2,
      sv_fecinvpac      OUT NOCOPY      VARCHAR2,
      sv_tipcomis       OUT NOCOPY      VARCHAR2,
      sv_usuarasesor    OUT NOCOPY      VARCHAR2,
      sv_fecnac         OUT NOCOPY      VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getCuentaIdentif_PR"
         Lenguaje="PL/SQL"
         Fecha="19-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno>
              DATOS CUENTA
       </Retorno>
      <Descripción>
              DATOS CUENTA POR NUMERO IDENTIFICACION
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codTipident"  Tipo="STRING"> Tipo de Identificacion</param>
            <param nom="EV_numIdent"     Tipo="STRING"> Número de identificacion</param>
          </Entrada>
            <Salida>
            <param nom="SV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
            <param nom="SV_desCuenta"    Tipo="STRING"> descripcion Cuenta </param>
            <param nom="SV_tipCuenta"    Tipo="STRING"> Tipo de Cuenta I=Individual, E= Empresa </param>
            <param nom="SV_responsable"  Tipo="STRING"> Nombre del Responsable </param>
            <param nom="SV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
            <param nom="SV_fecAlta"      Tipo="STRING"> Fecha de Nacimiento </param>
            <param nom="SV_indEstado"    Tipo="STRING"> Estado de la Cuenta</param>
            <param nom="SV_TelContacto"  Tipo="STRING"> Telefono Contacto de la Cuenta</param>
            <param nom="SV_indSector"    Tipo="STRING"> Indice Sector de la Cuenta</param>
            <param nom="SV_clasCta"      Tipo="STRING"> Clase de la Cuenta</param>
            <param nom="SV_codCatribut"  Tipo="STRING"> Codigo de Categoria Tributaria de la Cuenta</param>
            <param nom="SV_codCategoria" Tipo="STRING"> Codigo de Categoria de la Cuenta</param>
            <param nom="SV_codSector"    Tipo="STRING"> Codigo de sector de la Cuenta</param>
            <param nom="SV_codSubCat"    Tipo="STRING"> Codigo de Subcategoria Tributaria de la Cuenta</param>
            <param nom="SV_indMultuso"   Tipo="STRING"> Indicador de Multiples usos</param>
            <param nom="SV_cliPotencial" Tipo="STRING"> Indicador de Cuenta Potencial </param>
            <param nom="SV_razonSocial"  Tipo="STRING"> Indicador de Cuenta Potencial </param>
            <param nom="SV_fecInVPac"    Tipo="STRING"> Fecha de la primera venta PA </param>
            <param nom="SV_tipComis"     Tipo="STRING"> Codigo de Tipo de Comisionista </param>
            <param nom="SV_usuarAsesor"  Tipo="STRING"> Nombre Usuario asesor de la cuenta </param>
            <param nom="SV_fecNac"       Tipo="STRING"> Fecha de Nacimiento </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      error_sql         EXCEPTION;
      lv_deserror       ge_errores_pg.desevent;
      lv_sql            ge_errores_pg.vquery;
      lv_formatofecha   VARCHAR2 (30);
      lv_formatohora    VARCHAR2 (30);
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      --  Obtenemos El Valor Para Formato Fecha (Sel2)
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_formatosel2, cv_modulo_ge, cv_producto, lv_formatofecha, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      --  Obtenemos El Valor Para Formato Hora (Sel7)
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_formatosel7, cv_modulo_ge, cv_producto, lv_formatohora, sn_codretorno, sv_menretorno, sn_numevento);

      IF (sn_codretorno <> 0) THEN
         RAISE error_sql;
      END IF;

      lv_sql :=
         ' SELECT a.cod_cuenta,' || 'a.DES_CUENTA,' || 'a.TIP_CUENTA,' || 'a.NOM_RESPONSABLE,' || 'a.COD_DIRECCION,' || 'a.FEC_ALTA,' || 'a.IND_ESTADO,' || 'a.TEL_CONTACTO,' || 'a.IND_SECTOR,' || 'a.COD_CLASCTA,' || 'a.COD_CATRIBUT,' || 'a.COD_CATEGORIA,'
         || 'a.COD_SECTOR,' || 'a.COD_SUBCATEGORIA,' || 'a.IND_MULTUSO,' || 'a.IND_CLIEPOTENCIAL,' || 'a.DES_RAZON_SOCIAL,' || 'a.FEC_INIVTA_PAC,' || 'a.COD_TIPCOMIS,' || 'a.NOM_USUARIO_ASESOR,' || 'a.FEC_NACIMIENTO' || 'FROM ga_cuentas a '
         || 'WHERE a.cod_tipident = ' || ev_codtipident || 'AND a.num_ident = ' || ev_numident;

      SELECT a.cod_cuenta, a.des_cuenta, a.tip_cuenta, a.nom_responsable, a.cod_direccion, TO_CHAR (a.fec_alta, lv_formatofecha || lv_formatohora), a.ind_estado, a.tel_contacto, a.ind_sector, a.cod_clascta, a.cod_catribut, a.cod_categoria, a.cod_sector,
             a.cod_subcategoria, a.ind_multuso, a.ind_cliepotencial, a.des_razon_social, TO_CHAR (a.fec_inivta_pac, lv_formatofecha || lv_formatohora), a.cod_tipcomis, a.nom_usuario_asesor, TO_CHAR (a.fec_nacimiento, lv_formatofecha || lv_formatohora)
        INTO sv_codcuenta, sv_descuenta, sv_tipcuenta, sv_responsable, sv_coddirec, sv_fecalta, sv_indestado, sv_telcontacto, sv_indsector, sv_clascta, sv_codcatribut, sv_codcategoria, sv_codsector,
             sv_codsubcat, sv_indmultuso, sv_clipotencial, sv_razonsocial, sv_fecinvpac, sv_tipcomis, sv_usuarasesor, sv_fecnac
        FROM ga_cuentas a
       WHERE a.cod_tipident = ev_codtipident AND a.num_ident = ev_numident
       AND ROWNUM = 1 ORDER BY FEC_ALTA DESC;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_codretorno   := 1;
         sv_menretorno   := 'No se pudo recuperar datos.';
         lv_deserror     := 'NO_DATA_FOUND:ve_alta_cuenta_quiosco_pg.VE_getCuentaIdentif_PR;- ' || SQLERRM;
         sn_numevento    := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getCuentaIdentif_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10740;
         sv_menretorno := 'Error al obtener Datos de la Cuenta por Numero de Identificacion';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_getCuentaIdentif_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getCuentaIdentif_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getcuentaidentif_pr;
--------------------------------------------------------------------------------------------
--* CURSORES - LISTAS
--------------------------------------------------------------------------------------------
   PROCEDURE ve_getlistcuentas_pr (
      ev_criteriobusq   IN              VARCHAR2,
      ev_filtro         IN              VARCHAR2,
      ev_valorbusq      IN              VARCHAR2,
      ev_tipoidentif    IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListCuentas_PR"
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
              RETORNA LISTADO DE CUENTAS SEGUN PARAMETROS
              Criterios; NI (numero identificador)
                         CC (codigo cliente)
                      NC (nombre cliente)
                      DC (descripcion cuenta)

              Filtro: I (igual a)
                      C (contiene)
      </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_criterioBusq" Tipo="STRING"> criterio de busqueda </param>
            <param nom="EV_filtro"       Tipo="STRING"> filtro de busqueda </param>
            <param nom="EV_valorBusq"    Tipo="STRING"> valor de busqueda </param>
            <param nom="EV_tipoIdentif"  Tipo="STRING"> tipo identificador </param>
          </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor cuentas </param>
            <param nom="SN_codRetorno"   Tipo="NUMBER"> codigo de retorno del procedimiento </param>
            <param nom="SV_menRetorno"   Tipo="STRING"> Mensaje de retorno del procedimiento </param>
            <param nom="SN_numEvento"    Tipo="NUMBER"> numero de evento en caso de error en ejecucion </param>
          </Salida>
      </Parámetros>
      </Elemento>
      </Documentación>
      */
      CURSOR lc_cursor (
         entrada   VARCHAR2) IS
         SELECT 'CUE', a.cod_cuenta, a.cod_tipident, b.des_tipident, a.num_ident, a.des_cuenta
           FROM ga_cuentas a, ge_tipident b
          WHERE a.cod_tipident = b.cod_tipident AND a.des_cuenta = entrada;

      no_data_found_cursor     EXCEPTION;
      error_parametros         EXCEPTION;
      cv_numidentif   CONSTANT VARCHAR2 (2)           := 'NI';
      cv_codcliente   CONSTANT VARCHAR2 (2)           := 'CC';
      cv_nomcliente   CONSTANT VARCHAR2 (2)           := 'NC';
      cv_desccuenta   CONSTANT VARCHAR2 (2)           := 'DC';
      cv_esiguala     CONSTANT VARCHAR2 (1)           := 'I';
      cv_contiene     CONSTANT VARCHAR2 (1)           := 'C';
      lv_deserror              ge_errores_pg.desevent;
      lv_sql                   ge_errores_pg.vquery;
      ln_contador              NUMBER;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento  := 0;
      ln_contador   := 0;

      IF ev_criteriobusq = cv_numidentif THEN
         SELECT COUNT (1)
           INTO ln_contador
           FROM ga_cuentas a, ge_tipident b
          WHERE a.cod_tipident = b.cod_tipident AND a.cod_tipident = ev_tipoidentif AND a.num_ident = ev_valorbusq;

         lv_sql :=
            'SELECT ' || '''CUE'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || 'FROM   ga_cuentas a, ge_tipident b ' || 'WHERE  a.cod_tipident = b.cod_tipident '
            || ' AND a.cod_tipident = ''' || ev_tipoidentif || ''' ' || ' AND a.num_ident = ''' || ev_valorbusq || ''' ';

         IF (ln_contador = 0) THEN
            SELECT COUNT (1)
              INTO ln_contador
              FROM ge_clientes c, ga_cuentas a, ge_tipident b
             WHERE c.cod_tipident = ev_tipoidentif AND c.num_ident = ev_valorbusq AND c.cod_cuenta = a.cod_cuenta AND a.cod_tipident = b.cod_tipident;

            lv_sql :=
               'SELECT DISTINCT ' || '''CUE2'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b '
               || 'WHERE c.cod_tipident = ''' || ev_tipoidentif || ''' ' || ' AND c.num_ident = ''' || ev_valorbusq || ''' ' || ' AND c.COD_CUENTA = a.COD_CUENTA ' || ' AND a.COD_TIPIDENT = b.COD_TIPIDENT ';
         END IF;

      ELSIF ev_criteriobusq = cv_codcliente THEN
         SELECT COUNT (1)
           INTO ln_contador
           FROM ge_clientes c, ga_cuentas a, ge_tipident b
          WHERE c.cod_cliente = ev_valorbusq AND c.cod_cuenta = a.cod_cuenta AND a.cod_tipident = b.cod_tipident;

         lv_sql :=
            'SELECT ' || '''CUE'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b ' || 'WHERE c.cod_cliente = '
            || ev_valorbusq || ' AND c.COD_CUENTA = a.COD_CUENTA ' || ' AND a.COD_TIPIDENT = b.COD_TIPIDENT ';

      ELSIF ev_criteriobusq = cv_nomcliente THEN
         IF ev_filtro = cv_esiguala THEN
            SELECT COUNT (1)
              INTO ln_contador
              FROM ge_clientes c, ga_cuentas a, ge_tipident b
             WHERE c.nom_cliente = ev_valorbusq AND c.cod_cuenta = a.cod_cuenta AND a.cod_tipident = b.cod_tipident;

            lv_sql :=
               'SELECT DISTINCT ' || '''CUE'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b ' || 'WHERE c.nom_cliente = '''
               || ev_valorbusq || ''' ' || ' AND c.COD_CUENTA = a.COD_CUENTA ' || ' AND a.COD_TIPIDENT = b.COD_TIPIDENT ';
         ELSIF ev_filtro = cv_contiene THEN
            SELECT COUNT (1)
              INTO ln_contador
              FROM ge_clientes c, ga_cuentas a, ge_tipident b
             WHERE c.nom_cliente LIKE '%' || ev_valorbusq || '%' AND c.cod_cuenta = a.cod_cuenta AND a.cod_tipident = b.cod_tipident;

            lv_sql :=
               'SELECT DISTINCT ' || '''CUE'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || 'FROM ge_clientes c, ga_cuentas a, ge_tipident b '
               || 'WHERE c.nom_cliente LIKE ''%' || ev_valorbusq || '%'' ' || 'AND c.COD_CUENTA = a.COD_CUENTA ' || 'AND a.COD_TIPIDENT = b.COD_TIPIDENT ';
         ELSE
            RAISE error_parametros;
         END IF;

      ELSIF ev_criteriobusq = cv_desccuenta THEN
         IF ev_filtro = cv_esiguala THEN
            SELECT COUNT (1)
              INTO ln_contador
              FROM ga_cuentas a, ge_tipident b
             WHERE a.cod_tipident = b.cod_tipident AND a.des_cuenta = ev_valorbusq;

            lv_sql :=
               'SELECT ' || '''CUE'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || ' FROM   ga_cuentas a, ge_tipident b ' || ' WHERE  a.cod_tipident = b.cod_tipident '
               || ' AND a.des_cuenta = ''' || ev_valorbusq || ''' ';
         --OPEN lc_cursor(EV_valorBusq);
         ELSIF ev_filtro = cv_contiene THEN
            SELECT COUNT (1)
              INTO ln_contador
              FROM ga_cuentas a, ge_tipident b
             WHERE a.des_cuenta LIKE '%' || ev_valorbusq || '%' AND a.cod_tipident = b.cod_tipident;

            lv_sql :=
               'SELECT ' || '''CUE'', ' || 'a.cod_cuenta, ' || 'a.cod_tipident, ' || 'b.des_tipident, ' || 'a.num_ident, ' || 'a.des_cuenta, ' || 'a.tip_cuenta ' || ' FROM   ga_cuentas a, ge_tipident b ' || ' WHERE a.des_cuenta LIKE ''%' || ev_valorbusq
               || '%'' ' || ' AND a.cod_tipident = b.cod_tipident';
         ELSE
            RAISE error_parametros;
         END IF;
      ELSE
         RAISE error_parametros;
      END IF;

      OPEN sc_cursordatos FOR lv_sql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN error_parametros THEN
         sn_codretorno   := 2;
         sv_menretorno   := 'No se Pudo Actualizar Datos.';

      WHEN no_data_found_cursor THEN
         sn_codretorno   := 1;
         sv_menretorno   := 'No se Pudo Recuperar Datos.';
         lv_deserror     := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_alta_cuenta_quiosco_pg.VE_getListCuentas_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno   := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento    := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getListCuentas_PR', lv_sql, sn_codretorno, lv_deserror);

     WHEN OTHERS THEN
         sn_codretorno := 10741;
         sv_menretorno := 'Error al Consultar Listado de Cuentas Segun Parametros';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_getListCuentas_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getListCuentas_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistcuentas_pr;

   PROCEDURE ve_getlistclasifcuenta_pr (
      sc_cursordatos   OUT NOCOPY   refcursor,
      sn_codretorno    OUT NOCOPY   ge_errores_pg.coderror,
      sv_menretorno    OUT NOCOPY   ge_errores_pg.msgerror,
      sn_numevento     OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_getListClasifCuenta_PR"
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
              RETORNA LISTA DE CLASIFICACIONES DE UNA CUENTA
      </Descripción>
      <Parámetros>
            <Entrada> N/A </Entrada>
            <Salida>
            <param nom="SV_cursorDatos"  Tipo="CURSOR"> cursor clasificaciones cuenta </param>
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
      sn_numevento := 0;
      lv_sql := 'SELECT a.cod_clascta,a.des_clascta ' || 'FROM ge_clascta a ' || 'ORDER BY a.des_clascta';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ge_clascta;

      OPEN sc_cursordatos FOR
         SELECT   a.cod_clascta, a.des_clascta
             FROM ge_clascta a
         ORDER BY a.des_clascta;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;

   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_codretorno   := 1;
         sv_menretorno   := 'No se pudo Recuperar Datos.';
         lv_deserror     := SUBSTR ('NO_DATA_FOUND_CURSOR:ve_alta_cuenta_quiosco_pg.VE_getListClasifCuenta_PR;- ' || SQLERRM, 1, cn_largoerrtec);
         sv_menretorno   := SUBSTR (sv_menretorno, 1, cn_largodesc);
         sn_numevento    := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getListClasifCuenta_PR', lv_sql, sn_codretorno, lv_deserror);

       WHEN OTHERS THEN
         sn_codretorno := 10742;
         sv_menretorno := 'Error al obtener Lista de Clasificaciones de una Cuenta';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_getListClasifCuenta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_getListClasifCuenta_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_getlistclasifcuenta_pr;
--------------------------------------------------------------------------------------------
--* INSERTS y UPDATES
--------------------------------------------------------------------------------------------
   PROCEDURE ve_inscuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_descuenta      IN              VARCHAR2,
      ev_tipcuenta      IN              VARCHAR2,
      ev_responsable    IN              VARCHAR2,
      ev_codtipident    IN              VARCHAR2,
      ev_numident       IN              VARCHAR2,
      ev_coddirec       IN              VARCHAR2,
      ev_indestado      IN              VARCHAR2,
      ev_telcontacto    IN              VARCHAR2,
      ev_indsector      IN              VARCHAR2,
      ev_clascta        IN              VARCHAR2,
      ev_codcatribut    IN              VARCHAR2,
      ev_codcategoria   IN              VARCHAR2,
      ev_codsector      IN              VARCHAR2,
      ev_codsubcat      IN              VARCHAR2,
      ev_indmultuso     IN              VARCHAR2,
      ev_clipotencial   IN              VARCHAR2,
      ev_razonsocial    IN              VARCHAR2,
      ev_fecinvpac      IN              VARCHAR2,
      ev_tipcomis       IN              VARCHAR2,
      ev_usuarasesor    IN              VARCHAR2,
      ev_fecnac         IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insCuenta_PR"
         Lenguaje="PL/SQL"
         Fecha="08-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="NRCA"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
          <Descripción>
                  INSERTA CUENTA
          </Descripción>
      <Parámetros>
            <Entrada>
            <param nom="EV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
            <param nom="EV_desCuenta"    Tipo="STRING"> descripcion Cuenta </param>
            <param nom="EV_tipCuenta"    Tipo="STRING"> Tipo de Cuenta I=Individual, E= Empresa </param>
            <param nom="EV_responsable"  Tipo="STRING"> Nombre del Responsable </param>
            <param nom="EV_codTipident"  Tipo="STRING"> Tipo de Identificacion</param>
            <param nom="EV_numIdent"     Tipo="STRING"> Número de identificacion</param>
            <param nom="EV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
            <param nom="EV_indEstado"    Tipo="STRING"> Estado de la Cuenta</param>
            <param nom="EV_TelContacto"  Tipo="STRING"> Telefono Contacto de la Cuenta</param>
            <param nom="EV_indSector"    Tipo="STRING"> Indice Sector de la Cuenta</param>
            <param nom="EV_clasCta"      Tipo="STRING"> Clase de la Cuenta</param>
            <param nom="EV_codCatribut"  Tipo="STRING"> Codigo de Categoria Tributaria de la Cuenta</param>
            <param nom="EV_codCategoria" Tipo="STRING"> Codigo de Categoria de la Cuenta</param>
            <param nom="EV_codSector"    Tipo="STRING"> Codigo de sector de la Cuenta</param>
            <param nom="EV_codSubCat"    Tipo="STRING"> Codigo de Subcategoria Tributaria de la Cuenta</param>
            <param nom="EV_indMultuso"   Tipo="STRING"> Indicador de Multiples usos</param>
            <param nom="EV_cliPotencial" Tipo="STRING"> Indicador de Cuenta Potencial </param>
            <param nom="EV_razonSocial"  Tipo="STRING"> Indicador de Cuenta Potencial </param>
            <param nom="EV_fecInVPac"    Tipo="STRING"> Fecha de la primera venta PA </param>
            <param nom="EV_tipComis"     Tipo="STRING"> Codigo de Tipo de Comisionista </param>
            <param nom="EV_usuarAsesor"  Tipo="STRING"> Nombre Usuario asesor de la cuenta </param>
            <param nom="EV_fecNac"       Tipo="STRING"> Fecha de Nacimiento </param>
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
	  error_controlado EXCEPTION;

      lv_deserror   ge_errores_pg.desevent;
      lv_sql        ge_errores_pg.vquery;
   BEGIN
      sn_codretorno := 0;
      sv_menretorno := NULL;
      sn_numevento := 0;
      lv_sql :=
         'INSERT INTO ga_cuentas(' || 'cod_cuenta,' || 'des_cuenta,' || 'tip_cuenta,' || 'nom_responsable,' || 'cod_tipident,' || 'num_ident,' || 'cod_direccion,' || 'fec_alta,' || 'ind_estado,' || 'tel_contacto,' || 'ind_sector,' || 'cod_clascta,'
         || 'cod_catribut,' || 'cod_categoria,' || 'cod_sector,' || 'cod_subcategoria,' || 'ind_multuso,' || 'ind_cliepotencial,' || 'des_razon_social,' || 'fec_inivta_pac,' || 'cod_tipcomis,' || 'nom_usuario_asesor,' || 'fec_nacimiento)' || 'VALUES (';

      IF (ev_codcuenta IS NOT NULL) AND (LENGTH (ev_codcuenta) > 0) THEN
         lv_sql := lv_sql || ev_codcuenta;
      ELSE
         lv_sql := lv_sql || 'NULL';
      END IF;

      IF (ev_descuenta IS NOT NULL) AND (LENGTH (ev_descuenta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_descuenta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_tipcuenta IS NOT NULL) AND (LENGTH (ev_tipcuenta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_tipcuenta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_responsable IS NOT NULL) AND (LENGTH (ev_responsable) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_responsable || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_codtipident IS NOT NULL) AND (LENGTH (ev_codtipident) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_codtipident || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_numident IS NOT NULL) AND (LENGTH (ev_numident) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_numident || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_coddirec IS NOT NULL) AND (LENGTH (ev_coddirec) > 0) THEN
         lv_sql := lv_sql || ',' || ev_coddirec;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      lv_sql := lv_sql || ',SYSDATE';

      IF (ev_indestado IS NOT NULL) AND (LENGTH (ev_indestado) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_indestado || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_telcontacto IS NOT NULL) AND (LENGTH (ev_telcontacto) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_telcontacto || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_indsector IS NOT NULL) AND (LENGTH (ev_indsector) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_indsector || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_clascta IS NOT NULL) AND (LENGTH (ev_clascta) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_clascta || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_codcatribut IS NOT NULL) AND (LENGTH (ev_codcatribut) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_codcatribut || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_codcategoria IS NOT NULL) AND (LENGTH (ev_codcategoria) > 0) THEN
         lv_sql := lv_sql || ',' || ev_codcategoria;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_codsector IS NOT NULL) AND (LENGTH (ev_codsector) > 0) THEN
         lv_sql := lv_sql || ',' || ev_codsector;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_codsubcat IS NOT NULL) AND (LENGTH (ev_codsubcat) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_codsubcat || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_indmultuso IS NOT NULL) AND (LENGTH (ev_indmultuso) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_indmultuso || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_clipotencial IS NOT NULL) AND (LENGTH (ev_clipotencial) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_clipotencial || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_razonsocial IS NOT NULL) AND (LENGTH (ev_razonsocial) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_razonsocial || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fecinvpac IS NOT NULL) AND (LENGTH (ev_fecinvpac) > 0) THEN
         lv_sql := lv_sql || ',' || ev_fecinvpac;
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

  	  IF (ev_tipcomis IS NOT NULL) AND (LENGTH (ev_tipcomis) > 0) THEN

		 IF NOT ve_valida_tipo_comis_fn (ev_tipcomis) THEN
	     	sn_codretorno := 12496;
		 	sv_menretorno := 'Codigo Tipo comisionista no existe';
	     	RAISE error_controlado;
		 END IF;
		 lv_sql := lv_sql || ',''' || ev_tipcomis || '''';
	  ELSE
	     lv_sql := lv_sql || ',NULL';
	  END IF;

      IF (ev_usuarasesor IS NOT NULL) AND (LENGTH (ev_usuarasesor) > 0) THEN
         lv_sql := lv_sql || ',''' || ev_usuarasesor || '''';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      IF (ev_fecnac IS NOT NULL) AND (LENGTH (ev_fecnac) > 0) THEN
         lv_sql := lv_sql || ',TO_DATE(''' || ev_fecnac || ''',''' || cv_formatofecha || ''')';
      ELSE
         lv_sql := lv_sql || ',NULL';
      END IF;

      lv_sql := lv_sql || ')';

      EXECUTE IMMEDIATE lv_sql;
   EXCEPTION
      WHEN error_controlado THEN
	  	 lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_insCuenta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_insCuenta_PR', lv_sql, SQLCODE, lv_deserror);

      WHEN OTHERS THEN
         sn_codretorno := 10743;
         sv_menretorno := 'Error al Ingresar Cuenta';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_insCuenta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_insCuenta_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inscuenta_pr;

   PROCEDURE ve_inssubcuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_codsubcuenta   IN              VARCHAR2,
      ev_dessubcuenta   IN              VARCHAR2,
      ev_coddirec       IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_insSubCuenta_PR"
         Lenguaje="PL/SQL"
         Fecha="08-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="NRCA"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
          <Descripción>
                  INSERTA SUBCUENTA
          </Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_codCuenta"    Tipo="STRING"> Codigo Cuenta </param>
            <param nom="EV_codSubCuenta" Tipo="STRING"> Codigo SubCuenta </param>
            <param nom="EV_desSubCuenta" Tipo="STRING"> descripcion SubCuenta </param>
            <param nom="EV_codDirec"     Tipo="STRING"> Codigo de Direccion</param>
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
      lv_sql := 'INSERT INTO ga_cuentas((cod_cuenta,cod_subcuenta,des_subcuenta,' || 'cod_direccion,' || 'fec_alta) ' || 'VALUES (' || ev_codcuenta || ', ' || ev_codsubcuenta || ',' || ev_dessubcuenta || ',' || ev_coddirec || ',' || 'SYSDATE)';

      INSERT INTO ga_subcuentas
                  (cod_cuenta, cod_subcuenta, des_subcuenta, cod_direccion, fec_alta)
      VALUES      (ev_codcuenta, ev_codsubcuenta, ev_dessubcuenta, ev_coddirec, SYSDATE);
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10744;
         sv_menretorno := 'Error al ingresar SubCuenta';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_insSubCuenta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_insSubCuenta_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_inssubcuenta_pr;

   PROCEDURE ve_updcategcuenta_pr (
      ev_codcuenta      IN              VARCHAR2,
      ev_codcategoria   IN              VARCHAR2,
      ev_codsubcateg    IN              VARCHAR2,
      ev_codmultuso     IN              VARCHAR2,
      ev_codcliepot     IN              VARCHAR2,
      ev_desrazon       IN              VARCHAR2,
      sn_codretorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_updCategCuenta_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              ACTUALIZA CATEGORIA DE LA CUENTA
      </Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EN_codCuenta"    Tipo="NUMBER"> codigo cuenta </param>
            <param nom="EV_codCategoria" Tipo="STRING"> codigo categoria </param>
            <param nom="EV_codSubCateg"  Tipo="STRING"> codigo subcategoria </param>
            <param nom="EV_codMultUso"   Tipo="STRING"> codigo multi uso </param>
            <param nom="EV_codCliePot"   Tipo="STRING"> codigo cliente potencial </param>
            <param nom="EV_desRazon"     Tipo="STRING"> descripcion razon </param>
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
      lv_sql :=
         'UPDATE ga_cuentas a ' || ' SET a.cod_categoria = ' || ev_codcategoria || ' ,a.cod_subcategoria = ' || ev_codsubcateg || ' ,a.ind_multuso = ' || ev_codmultuso || ' ,a.ind_cliepotencial = ' || ev_codcliepot || ' ,a.des_razon_social = '
         || ev_desrazon || ' WHERE cod_cuenta = ' || ev_codcuenta;

      UPDATE ga_cuentas a
         SET a.cod_categoria = ev_codcategoria,
             a.cod_subcategoria = ev_codsubcateg,
             a.ind_multuso = ev_codmultuso,
             a.ind_cliepotencial = ev_codcliepot,
             a.des_razon_social = ev_desrazon
       WHERE cod_cuenta = ev_codcuenta;

   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10745;
         sv_menretorno :='Error al Actualizar Categoria de la Cuenta';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_updCategCuenta_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_updCategCuenta_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_updcategcuenta_pr;

--------------------------------------------------------------------------------------------
--* DELETEs
--------------------------------------------------------------------------------------------
   PROCEDURE ve_delcategctaspotenciales_pr (
      ev_numidentif   IN              VARCHAR2,
      sn_codretorno   OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento    OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentación TipoDoc = "Procedimiento">
         Elemento Nombre = "VE_delCategCtasPotenciales_PR"
         Lenguaje="PL/SQL"
         Fecha="15-06-2007"
         Versión="1.0.0"
         Diseñador="wjrc"
         Programador="wjrc"
         Ambiente="BD"
      <Retorno> N/A </Retorno>
      <Descripción>
              ACTUALIZA CATEGORIA DEL CLIENTE
      </Descripción>
      <Parámetros>
            <Entrada>
              <param nom="EV_numIdentif"   Tipo="STRING"> numero identificacion </param>
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
      lv_sql := 'DELETE FROM gat_categ_ctas_potenciales a ' || 'WHERE a.num_ident = ' || ev_numidentif;

      DELETE FROM gat_categ_ctas_potenciales a
            WHERE a.num_ident = ev_numidentif;
   EXCEPTION
      WHEN OTHERS THEN
         sn_codretorno := 10746;
         sv_menretorno := 'Error al eliminar Categoria Cuentas Potenciales del Cliente';
         lv_deserror   := 'OTHERS:ve_alta_cuenta_quiosco_pg.VE_delCategCtasPotenciales_PR;- ' || SQLERRM;
         sn_numevento  := ge_errores_pg.grabarpl (sn_numevento, cv_modulo_ga, sv_menretorno, '1.0', USER, 've_alta_cuenta_quiosco_pg.VE_delCategCtasPotenciales_PR', lv_sql, SQLCODE, lv_deserror);
   END ve_delcategctaspotenciales_pr;
END ve_alta_cuenta_quiosco_pg;
/
SHOW ERRORS
