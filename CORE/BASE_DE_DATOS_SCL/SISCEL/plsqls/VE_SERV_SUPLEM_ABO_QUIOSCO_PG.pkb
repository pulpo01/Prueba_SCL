CREATE OR REPLACE PACKAGE BODY ve_serv_suplem_abo_quiosco_pg AS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_rec_cadena_central_fn (
      ev_codproducto      IN              icg_actuaciontercen.cod_producto%TYPE,
	  ev_cod_tecnologia   IN              icg_actuaciontercen.tip_tecnologia%TYPE,
	  ev_codsistema       IN              icg_actuaciontercen.cod_sistema%TYPE,
	  ev_codactuacion     IN              icg_actuaciontercen.cod_sistema%TYPE,
	  ev_codmodulo        IN              icg_actuacion.cod_modulo%TYPE,	
	  sv_cadenaservicio   OUT   	      icg_actuaciontercen.cod_servicios%TYPE,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento) 
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_codigoProceso_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el codigo del poceso</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_PerfilProceso Tipo="VARCHAR2" Descripcion = "Nombre perfil proceso" </param>
               </Entrada>
               <Salida>
                  <param nom="SV_CodProceso"   Tipo="VARCHAR2" Descripcion = "Codigo del Proceso" </param>
                                      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                      <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                                      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := null;

       lv_ssql := 'SELECT a.cod_servicios FROM icg_actuaciontercen a'
              || ' WHERE a.cod_producto = '||ev_codproducto 
	          || ' AND a.tip_tecnologia = '||ev_cod_tecnologia
		      || ' AND a.cod_sistema = '||ev_codsistema 
		      || ' AND a.cod_actuacion = '||ev_codactuacion;

      SELECT a.cod_servicios
        INTO sv_cadenaservicio
        FROM icg_actuaciontercen a
       WHERE a.cod_producto = ev_codproducto 
	     AND a.tip_tecnologia = ev_cod_tecnologia
		 AND a.cod_sistema = ev_codsistema 
		 AND a.cod_actuacion = ev_codactuacion;

      IF (sv_cadenaservicio = '' OR sv_cadenaservicio IS NULL) THEN
         sv_cadenaservicio := '';
		 
		 lv_ssql := 'SELECT cod_servicio FROM icg_actuacion'
                 || ' WHERE cod_actuacion = '||ev_codactuacion 
		         || ' AND cod_producto = '||ev_codproducto 
			     || ' AND cod_modulo = '||ev_codmodulo;

         SELECT cod_servicio
           INTO sv_cadenaservicio
           FROM icg_actuacion
          WHERE cod_actuacion = ev_codactuacion 
		    AND cod_producto = ev_codproducto 
			AND cod_modulo = ev_codmodulo;
			
      END IF;

      RETURN TRUE;
	  
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sv_cadenaservicio := '';
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno := 50519;
         sv_mens_retorno:='Error al obtener cadena de servicios';
         lv_des_error := 've_serv_suplem_abo_quiosco_pg.ve_infoCentralAboando_fn();- ' || SQLERRM;
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.ve_infoCentralAboando_fn', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_rec_cadena_central_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION ve_infoCentralAboando_fn (
      ev_numAboando      IN              ga_abocel.num_abonado%TYPE,	  
      sv_codsistema      OUT NOCOPY      icg_central.cod_sistema%TYPE,
	  sv_cod_tecnologia  OUT NOCOPY      icg_central.cod_tecnologia%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_codigoProceso_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el codigo del poceso</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_PerfilProceso Tipo="VARCHAR2" Descripcion = "Nombre perfil proceso" </param>
               </Entrada>
               <Salida>
                  <param nom="SV_CodProceso"   Tipo="VARCHAR2" Descripcion = "Codigo del Proceso" </param>
                                      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                      <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                                      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := null;

      SELECT b.cod_sistema, b.cod_tecnologia
	    INTO sv_codsistema, sv_cod_tecnologia
        FROM ga_abocel a, icg_central b
       WHERE a.num_abonado = ev_numAboando 
         AND b.cod_central = a.cod_central
       UNION
      SELECT b.cod_sistema, b.cod_tecnologia
        FROM ga_aboamist a, icg_central b
       WHERE a.num_abonado = ev_numAboando 
         AND b.cod_central = a.cod_central;

      RETURN TRUE;
	  
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 40519;
         sv_mens_retorno:='Error al obtener el código sistema del abonado';
         lv_des_error := 've_serv_suplem_abo_quiosco_pg.ve_infoCentralAboando_fn();- ' || SQLERRM;
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.ve_infoCentralAboando_fn', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := 50519;
         sv_mens_retorno:='Error al obtener el código sistema del abonado';
         lv_des_error := 've_serv_suplem_abo_quiosco_pg.ve_infoCentralAboando_fn();- ' || SQLERRM;
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.ve_infoCentralAboando_fn', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_infoCentralAboando_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   

   FUNCTION ve_codigoproceso_fn (
      ev_perfilproceso   IN              gad_procesos_perfiles.nom_perfil_proceso%TYPE,
      sv_codproceso      OUT NOCOPY      gad_procesos_perfiles.cod_proceso%TYPE,
      sn_cod_retorno     OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno    OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento      OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_codigoProceso_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el codigo del poceso</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_PerfilProceso Tipo="VARCHAR2" Descripcion = "Nombre perfil proceso" </param>
               </Entrada>
               <Salida>
                  <param nom="SV_CodProceso"   Tipo="VARCHAR2" Descripcion = "Codigo del Proceso" </param>
                                      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                      <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                                      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT a.cod_proceso' || ' FROM gad_procesos_perfiles a' || ' WHERE a.nom_perfil_proceso = ' || ev_perfilproceso;

      SELECT a.cod_proceso
        INTO sv_codproceso
        FROM gad_procesos_perfiles a
       WHERE a.nom_perfil_proceso = ev_perfilproceso;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10519;
         sv_mens_retorno:='Error al obtener el código de proceso';



         lv_des_error := SUBSTR ('OTHERS:NO_DATA_FOUND; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'NO_DATA_FOUND', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_codigoproceso_fn;

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
   FUNCTION ve_permisousuarioproceso_fn (
      ev_nusuario       IN              ge_seg_grpusuario.nom_usuario%TYPE,
      ev_cprograma      IN              ge_seg_perfiles.cod_programa%TYPE,
      ev_nversion       IN              ge_seg_perfiles.num_version%TYPE,
      ev_cproceso       IN              ge_seg_perfiles.cod_proceso%TYPE,
      sv_cproceso       OUT NOCOPY      ge_seg_perfiles.cod_proceso%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_permisoUsuarioProceso_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el codigo del poceso</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_NUsuario  Tipo="VARCHAR2" Descripcion = "Nombre del usuario </param>
                  <param nom="EV_CPrograma Tipo="VARCHAR2" Descripcion = "Codigo del programa" </param>
                  <param nom="EV_NVersion  Tipo="VARCHAR2" Descripcion = "Numero de la version" </param>
                  <param nom="EV_CProceso  Tipo="VARCHAR2" Descripcion = "Codigo del proceso" </param>
               </Entrada>
               <Salida>
                  <param nom="EV_CProceso  Tipo="VARCHAR2" Descripcion = "Codigo del proceso" </param>
                                     <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                     <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                     <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT a.cod_proceso' || ' FROM GE_SEG_PERFILES a, ge_seg_grpusuario b' || ' WHERE a.cod_grupo = b.cod_grupo' || ' AND b.nom_usuario = ' || ev_nusuario || ' AND a.cod_programa = ' || ev_cprograma || ' AND a.num_version = ' || ev_nversion
         || ' AND a.cod_proceso = ' || ev_cproceso || ' AND ROWNUM = 1';

      SELECT a.cod_proceso
        INTO sv_cproceso
        FROM ge_seg_perfiles a, ge_seg_grpusuario b
       WHERE a.cod_grupo = b.cod_grupo AND b.nom_usuario = ev_nusuario AND a.cod_programa = ev_cprograma AND a.num_version = ev_nversion AND a.cod_proceso = ev_cproceso AND ROWNUM = 1;

      RETURN TRUE;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sv_cproceso := '';
         sn_cod_retorno := 10519;
         sv_mens_retorno:='Error al obtener el código de proceso';

         lv_des_error := SUBSTR ('NO_DATA_FOUND:ve_serv_suplem_abo_quiosco_pg.VE_permisoUsuarioProceso_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_permisoUsuarioProceso_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN TRUE;
      WHEN OTHERS THEN
         sn_cod_retorno := 10519;
         sv_mens_retorno:='Error al obtener el código de proceso';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_permisoUsuarioProceso_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_permisoUsuarioProceso_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_permisousuarioproceso_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
   FUNCTION ve_tipoplan_fn (
      ev_cplantarif     IN              ta_plantarif.cod_plantarif%TYPE,
      sv_ctiplan        OUT NOCOPY      ta_plantarif.cod_tiplan%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_tipoPlan_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el codigo del poceso</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_CPlanTarif Tipo="VARCHAR2" Descripcion = "Codigo plan tarifario" </param>
               </Entrada>
               <Salida>
                  <param nom="SV_CTiplan"  Tipo="VARCHAR2" Descripcion = "Codigo tipo plan" </param>
                                      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                      <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT a.cod_tiplan' || ' FROM ta_plantarif a' || ' WHERE a.cod_plantarif =' || ev_cplantarif;

      SELECT a.cod_tiplan
        INTO sv_ctiplan
        FROM ta_plantarif a
       WHERE a.cod_plantarif = ev_cplantarif;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10520;
         sv_mens_retorno :='Error al obtener el código de tipo de plan';


         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_tipoPlan_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_tipoPlan_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_tipoplan_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
   FUNCTION ve_codigoactcentral_fn (
      ev_cproducto      IN              ga_actabo.cod_producto%TYPE,
      ev_cmodulo        IN              ga_actabo.cod_modulo%TYPE,
      ev_cactabo        IN              ga_actabo.cod_actabo%TYPE,
      ev_ctecnologia    IN              ga_actabo.cod_tecnologia%TYPE,
      sv_cactcentral    OUT NOCOPY      ga_actabo.cod_actcen%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_codigoActCentral_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el Codigo de Actuacion en Central Asociado</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_CProducto   Tipo="VARCHAR2" Descripcion = "Codigo producto" </param>
                  <param nom="EV_CModulo     Tipo="VARCHAR2" Descripcion = "Codigo modulo" </param>
                  <param nom="EV_CActAbo     Tipo="VARCHAR2" Descripcion = "Codigo actuacion abonado" </param>
                  <param nom="EV_CTecnologia Tipo="VARCHAR2" Descripcion = "Codigo tecnologia" </param>
               </Entrada>
               <Salida>
                  <param nom="SV_CActCentral"  Tipo="VARCHAR2" Descripcion = "Codigo actuacion central" </param>
                                      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                      <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_cactcentral := '';
      lv_ssql := 'SELECT a.cod_actcen ' || ' FROM ga_actabo a' || ' WHERE a.cod_producto = ' || ev_cproducto || ' AND a.cod_modulo = ' || ev_cmodulo || ' AND a.cod_actabo = ' || ev_cactabo || ' AND a.cod_tecnologia = ' || ev_ctecnologia;

      SELECT a.cod_actcen
        INTO sv_cactcentral
        FROM ga_actabo a
       WHERE a.cod_producto = ev_cproducto AND a.cod_modulo = ev_cmodulo AND a.cod_actabo = ev_cactabo AND a.cod_tecnologia = ev_ctecnologia;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10521;
         sv_mens_retorno := 'Error al obtener el código de actuación en central asociado';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_codigoActCentral_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_codigoActCentral_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_codigoactcentral_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_servicioscentrales_fn (
      ev_cproducto      IN              icg_actuaciontercen.cod_producto%TYPE,
      ev_cmodulo        IN              icg_actuacion.cod_modulo%TYPE,
      ev_cactuacion     IN              icg_actuaciontercen.cod_actuacion%TYPE,
      ev_cod_tecnologia IN              icg_actuaciontercen.tip_tecnologia%TYPE,
      ev_csistema       IN              icg_actuaciontercen.cod_sistema%TYPE,
      sv_cservicios     OUT NOCOPY      icg_actuaciontercen.cod_servicios%TYPE,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "FUNCTION">
         <Elemento
            Nombre = "VE_serviciosCentrales_FN"
            Lenguaje="PL/SQL"
            Fecha="07-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>BOOLEAN</Retorno>
            <Descripcion>Recuperar el Codigo de Actuacion en Central Asociado</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_CProducto    Tipo="VARCHAR2" Descripcion = "Codigo producto" </param>
                  <param nom="EV_CModulo      Tipo="VARCHAR2" Descripcion = "Codigo modulo" </param>
                  <param nom="EV_CActuacion   Tipo="VARCHAR2" Descripcion = "Codigo actuacion abonado" </param>
                  <param nom="EV_CTipTerminal Tipo="VARCHAR2" Descripcion = "Codigo tipo terminal" </param>
                  <param nom="EV_CSistema     Tipo="VARCHAR2" Descripcion = "Codigo sistema" </param>
               </Entrada>
               <Salida>
                  <param nom="SV_CServicios"  Tipo="VARCHAR2" Descripcion = "Servicios central" </param>
                                      <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                                      <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                                      <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sv_cservicios := '';
      lv_ssql :=
                'SELECT a.cod_servicios' || ' FROM icg_actuaciontercen a' || ' WHERE a.cod_producto = ' || ev_cproducto || ' AND a.cod_actuacion = ' || ev_cactuacion || ' AND a.tip_tecnologia = '||ev_cod_tecnologia ||' AND a.cod_sistema = ' || ev_csistema;

      SELECT a.cod_servicios
        INTO sv_cservicios
        FROM icg_actuaciontercen a
       WHERE a.cod_producto = ev_cproducto
	     AND a.cod_actuacion = ev_cactuacion
		 AND a.tip_tecnologia = ev_cod_tecnologia
		 AND a.cod_sistema = ev_csistema;
		-- AND a.TIP_TECNOLOGIA = 'GSM';

      IF sv_cservicios IS NULL OR sv_cservicios = '' THEN
         sv_cservicios := '';
         lv_ssql := 'SELECT cod_servicio' || ' FROM icg_actuacion a' || ' WHERE a.cod_producto =' || ev_cproducto || ' AND a.cod_modulo = ' || ev_cmodulo || ' AND a.cod_actuacion = ' || ev_cactuacion;

         SELECT cod_servicio
           INTO sv_cservicios
           FROM icg_actuacion a
          WHERE a.cod_producto = ev_cproducto 
		    AND a.cod_modulo = ev_cmodulo 
			AND a.cod_actuacion = ev_cactuacion;
			
      END IF;

      RETURN TRUE;
   EXCEPTION
   
      WHEN NO_DATA_FOUND THEN
	     sv_cservicios := '';
         RETURN TRUE;   
      WHEN OTHERS THEN
         sn_cod_retorno := 10522;
         sv_mens_retorno :='Error al obtener el servicio de actuación';
         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_serviciosCentrales_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_serviciosCentrales_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_servicioscentrales_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtienessdeic_pr (
      ev_cproducto      IN              ga_servsuplabo.cod_producto%TYPE,
      ev_cservsupl      IN              ga_servsuplabo.cod_servsupl%TYPE,
      ev_cnivel         IN              ga_servsuplabo.cod_nivel%TYPE,
      sv_cservicio      OUT NOCOPY      VARCHAR2,
      sv_cconcepto      OUT NOCOPY      VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "VE_ObtieneSSdeIC_PR"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripcion>Obtiene los servicios suplementarios por defecto a interfaz con centrales</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_CProducto" Tipo="VARCHAR2" Descripcion = "Codigo Producto" </param>
                  <param nom="EV_CServsupl" Tipo="VARCHAR2" Descripcion = "Codigo Servicio Suplementario" </param>
                  <param nom="EV_CNivel"    Tipo="VARCHAR2" Descripcion = "Codigo Nivel" </param>
               </Entrada>
               <Salida>
           <param nom="SV_CServicio"  Tipo="VARCHAR2" Descripcion = "Codigo Servicio" </param>
           <param nom="SV_CConcepto"  Tipo="VARCHAR2" Descripcion = "Codigo Concepto" </param>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sv_cservicio := '';
      sv_cconcepto := '';
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := '   SELECT a.cod_servicio,NVL(b.cod_concepto,0)';
      lv_ssql := lv_ssql || ' FROM ga_servsupl a, ga_actuaserv b';
      lv_ssql := lv_ssql || ' WHERE a.cod_servsupl = ' || ev_cservsupl;
      lv_ssql := lv_ssql || '   AND a.cod_nivel = ' || ev_cnivel;
      lv_ssql := lv_ssql || '   AND a.cod_producto = ' || ev_cproducto;
      lv_ssql := lv_ssql || '   AND a.tip_servicio = ' || cv_tipservicio_1;
      lv_ssql := lv_ssql || '   AND a.cod_producto  = b.cod_producto(+)';
      lv_ssql := lv_ssql || '   AND a.cod_servicio  = b.cod_servicio(+)';
      lv_ssql := lv_ssql || '   AND b.cod_actabo(+) = ' || cv_codact_fac;
      lv_ssql := lv_ssql || '   AND b.cod_tipserv(+) = ' || cv_tipservicio_2;

      SELECT a.cod_servicio, NVL (b.cod_concepto, 0)
        INTO sv_cservicio, sv_cconcepto
        FROM ga_servsupl a, ga_actuaserv b
       WHERE a.cod_servsupl = ev_cservsupl AND a.cod_nivel = ev_cnivel AND a.cod_producto = ev_cproducto 
	 --  AND a.ind_comerc = cv_indcomercial 
	   AND a.tip_servicio = cv_tipservicio_1 AND a.cod_producto = b.cod_producto(+) AND a.cod_servicio = b.cod_servicio(+)
             AND b.cod_actabo(+) = cv_codact_fac AND b.cod_tipserv(+) = cv_tipservicio_2;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sv_cservicio := '';
         sv_cconcepto := '';
         sn_cod_retorno := 10523;
         sv_mens_retorno := 'No se obtuvieron los servicios suplementarios por defecto a interfaz con centrales';


         lv_des_error := SUBSTR ('NO_DATA_FOUND:ve_serv_suplem_abo_quiosco_pg.VE_ObtieneSSdeIC_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ObtieneSSdeIC_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10524;
         sv_mens_retorno := 'Error al obtener los servicios suplementarios';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_ObtieneSSdeIC_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ObtieneSSdeIC_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtienessdeic_pr;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION ve_existess_fn (
      ev_abonado        IN              VARCHAR2,
      ev_servicio       IN              VARCHAR2,
      ev_fecha          IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "VE_ExisteSS_FN"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno> BOOLEAN </Retorno>
            <Descripcion>Verifica si existe SS</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_abonado"  Tipo="VARCHAR2" Descripcion = "Numero abonado" </param>
                  <param nom="EV_servicio" Tipo="VARCHAR2" Descripcion = "Codigo de servicio" </param>
                  <param nom="EV_fecha"    Tipo="VARCHAR2" Descripcion = "Fecha de alta" </param>
               </Entrada>
               <Salida>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
      ln_contador    NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := 'SELECT COUNT(1)' || ' FROM ga_servsuplabo a' || ' WHERE a.num_abonado = ' || ev_abonado || ' AND a.cod_servicio = ' || ev_servicio || 'AND ind_estado < 3';-- || ' AND a.FEC_ALTABD = TO_DATE(' || ev_fecha || ',' || cv_formato_fecha_sis || ')';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_servsuplabo a
       WHERE a.num_abonado = ev_abonado AND a.cod_servicio = ev_servicio AND ind_estado < 3;
	   --AND a.fec_altabd = TO_DATE (ev_fecha, cv_formato_fecha_sis);

      IF (ln_contador = 0) THEN
         RETURN FALSE;
      ELSE
         RETURN TRUE;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sn_cod_retorno := 10525;
         sv_mens_retorno := 'No existen servicios suplementarios';

         lv_des_error := SUBSTR ('NO_DATA_FOUND:ve_serv_suplem_abo_quiosco_pg.VE_ExisteSS_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ExisteSS_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
      WHEN OTHERS THEN
         sn_cod_retorno := 10524;
         sv_mens_retorno := 'Error al obtener los servicios suplementarios';


         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_ExisteSS_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ExisteSS_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_existess_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
   PROCEDURE ve_insertassabonado_pr (
      ev_num_abonado        IN              VARCHAR2,
      ev_cod_servicio       IN              VARCHAR2,
      ev_cod_servsupl       IN              VARCHAR2,
      ev_cod_nivel          IN              VARCHAR2,
      ev_cod_producto       IN              VARCHAR2,
      ev_num_terminal       IN              VARCHAR2,
      ev_cod_concepto       IN              VARCHAR2,
      ev_ind_estado         IN              VARCHAR2,
      ev_num_diasnum        IN              VARCHAR2,
      ev_fec_progbaja       IN              VARCHAR2,
      ev_cod_ssprogramado   IN              VARCHAR2,
      ev_fecha_alta         IN              VARCHAR2,
      ev_usuario            IN              VARCHAR2,
      sn_cod_retorno        OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno       OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento         OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "InsertaSSAbonado"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripcion>Inserta servicio suplementario del abonado</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_num_abonado" Tipo="VARCHAR2">Numero del Abonado A Crearle SS</param>
                  <param nom="EV_cod_servicio" Tipo="VARCHAR2">codigo de servicio</param>
                  <param nom="EV_cod_servsupl" Tipo="VARCHAR2">codigo servicio suplementario</param>
                  <param nom="EV_cod_nivel" Tipo="VARCHAR2">codigo nivel</param>
                  <param nom="EV_cod_producto" Tipo="VARCHAR2">codigo producto</param>
                  <param nom="EV_num_terminal" Tipo="VARCHAR2">numero de terminal</param>
                  <param nom="EV_cod_concepto" Tipo="VARCHAR2">codigo de concepto</param>
                  <param nom="EV_ind_estado" Tipo="VARCHAR2">indicador de estado</param>
                  <param nom="EV_num_diasnum" Tipo="VARCHAR2">Número de asociación con dias especiales o friends and family</param>
                  <param nom="EV_fec_progbaja" Tipo="VARCHAR2">Fecha programada para baja del SS</param>
                  <param nom="EV_cod_ssprogramado" Tipo="VARCHAR2">codigo servicio suplementario programado</param>
                  <param nom="EV_fecha_alta" Tipo="VARCHAR2">Fecha de alta del SS</param>
               </Entrada>
               <Salida>
                      <param nom="SN_cod_retorno"  Tipo="NUMBER">Codigo error de negocio Retornado</param>
                      <param nom="SV_mens_retorno" Tipo="VARCHAR2">Mensaje error de negocio Retornado</param>
                      <param nom="SN_num_evento"   Tipo="NUMBER">Nro de evento</param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := '   INSERT INTO GA_SERVSUPLABO (NUM_ABONADO, COD_SERVICIO,FEC_ALTABD,';
      lv_ssql := lv_ssql || 'COD_SERVSUPL,COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,';
      lv_ssql := lv_ssql || 'IND_ESTADO,FEC_ALTACEN,FEC_BAJABD,FEC_BAJACEN,';
      lv_ssql := lv_ssql || 'COD_CONCEPTO,NUM_DIASNUM,FEC_PROGBAJA,COD_SSPROGRAMADO)';
      lv_ssql := lv_ssql || ' VALUES (';
      lv_ssql := lv_ssql || ev_num_abonado || ',' || ev_cod_servicio || ',TO_DATE(' || ev_fecha_alta || ',' || cv_formato_fecha_sis || '),' || ev_cod_servsupl || ',';
      lv_ssql := lv_ssql || ev_cod_nivel || ',' || ev_cod_producto || ',' || ev_num_terminal || ',' || ev_usuario || ',' || ev_ind_estado || ',';
      lv_ssql := lv_ssql || 'NULL, NULL, NULL,' || ev_cod_concepto || ',' || ev_num_diasnum || ',' || ev_fec_progbaja || ',' || ev_cod_ssprogramado || ')';

      INSERT INTO ga_servsuplabo
                  (num_abonado, cod_servicio, fec_altabd, cod_servsupl, cod_nivel, cod_producto, num_terminal, nom_usuarora, ind_estado, fec_altacen, fec_bajabd, fec_bajacen, cod_concepto, num_diasnum
                   )
      VALUES      (ev_num_abonado, ev_cod_servicio, TO_DATE (ev_fecha_alta, cv_formato_fecha_sis), ev_cod_servsupl, ev_cod_nivel, ev_cod_producto, ev_num_terminal, ev_usuario, ev_ind_estado, NULL, NULL, NULL, ev_cod_concepto, ev_num_diasnum
                   );
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno  := 10526;
         sv_mens_retorno := 'Error al insertar servicio suplementario del abonado';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_InsertaSSAbonado_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_InsertaSSAbonado_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_insertassabonado_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   
   FUNCTION ve_obtienenumerodiasnum_fn (
      ev_codservicio      IN              VARCHAR2,
      ev_fecha            IN              VARCHAR2,
      ev_diasespeciales   IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
      RETURN VARCHAR2 IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "VE_ObtieneNumeroDiasNum_FN"
            Lenguaje="PL/SQL"
            Fecha="12-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno> BOOLEAN </Retorno>
            <Descripcion>Obtiene numeros de dias /Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_codservicio" Tipo="VARCHAR2">Codigo de servicio</param>
                  <param nom="EV_fecha"       Tipo="VARCHAR2">Fecha de alta</param>
                  <param nom="EV_diasespeciales"  Tipo="VARCHAR2">numero de dias especiales</param>
               </Entrada>
               <Salida>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>*/
      lv_codesql           ga_errores.cod_sqlcode%TYPE;
      lv_errmsql           ga_errores.cod_sqlerrm%TYPE;
      ln_numevento         NUMBER;
      lv_numdias           VARCHAR2 (5);
      lv_grupotelesp       VARCHAR2 (10);
      lv_pfriendfamily     VARCHAR2 (20);
      lv_des_error         ge_errores_pg.desevent;
      lv_ssql              ge_errores_pg.vquery;
      le_exception_final   EXCEPTION;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      --  OBTENEMOS EL VALOR PARA FRIEND AND FAMILY
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_friendfami, cv_codmodulo_ga, cv_codproducto, lv_pfriendfamily, lv_codesql, lv_errmsql, ln_numevento);

      IF lv_codesql <> 0 THEN
         sn_cod_retorno := lv_codesql;
         sv_mens_retorno := lv_errmsql;
         sn_num_evento := ln_numevento;
         RAISE le_exception_final;
      END IF;

      lv_ssql :=
         'SELECT a.cod_grupo' || ' FROM ga_grupos_servsup a' || ' WHERE a.cod_grupo = ' || lv_pfriendfamily || ' AND TO_DATE(' || ev_fecha || ',' || cv_formato_fecha_sis || ') BETWEEN a.fec_desde AND a.fec_hasta' || ' AND a.cod_servicio = '
         || ev_codservicio;
      lv_grupotelesp := '';

      SELECT a.cod_grupo
        INTO lv_grupotelesp
        FROM ga_grupos_servsup a
       WHERE a.cod_grupo = lv_pfriendfamily AND TO_DATE (ev_fecha, cv_formato_fecha_sis) BETWEEN a.fec_desde AND a.fec_hasta AND a.cod_servicio = ev_codservicio;

      -- DIAS ESPECIALES
      IF ((ev_codservicio = ev_diasespeciales) OR (LENGTH (lv_grupotelesp) > 0)) THEN
         lv_numdias := ve_intermediario_quiosco_pg.ve_obtienenumdiasnum_fn (sn_cod_retorno, sv_mens_retorno, sn_num_evento);

         IF sn_cod_retorno <> 0 THEN
            RAISE le_exception_final;
         END IF;
      ELSE
         lv_numdias := NULL;
      END IF;

      RETURN lv_numdias;
   EXCEPTION
      WHEN le_exception_final THEN
         lv_des_error := SUBSTR ('LE_exception_final:ve_serv_suplem_abo_quiosco_pg.VE_ObtieneNumeroDiasNum_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ObtieneNumeroDiasNum_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN NULL;
      WHEN OTHERS THEN
         sn_cod_retorno := 10527;
         sv_mens_retorno:='Error al obtener número de días';


         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_ObtieneNumeroDiasNum_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ObtieneNumeroDiasNum_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN NULL;
   END ve_obtienenumerodiasnum_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   
   FUNCTION ve_insertassdelplan_fn (
      ev_abonado          IN              VARCHAR2,
      ev_plan             IN              VARCHAR2,
      ev_numterminal      IN              VARCHAR2,
      ev_cproducto        IN              VARCHAR2,
      ev_diasespeciales   IN              VARCHAR2,
      ev_fecha            IN              VARCHAR2,
      ev_usuario          IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "VE_InsertaSSdelPlan_FN"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno> BOOLEAN </Retorno>
            <Descripcion>Obtiene e inserta los servicios suplementarios por defecto al plan</Descripcion>
            <Parametros>
               <Entrada>
      <param nom="EV_abonado" Tipo="VARCHAR2">Numero del Abonado A Crearle SS</param>
                  <param nom="EV_plan"    Tipo="VARCHAR2">Codigo producto</param>
                  <param nom="EV_numterminal" Tipo="VARCHAR2">numero de terminal</param>
                  <param nom="EV_CProducto" Tipo="VARCHAR2">codigo de producto</param>
                  <param nom="EV_diasespeciales" Tipo="VARCHAR2">numero dias especiales</param>
                  <param nom="EV_fecha"   Tipo="VARCHAR2>Fecha de alta</param>
               </Entrada>
               <Salida>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_codesql        ga_errores.cod_sqlcode%TYPE;
      lv_errmsql        ga_errores.cod_sqlerrm%TYPE;
      ln_numevento      NUMBER;
      lv_formatofecha   VARCHAR2 (20);
      lv_cod_servsupl   VARCHAR2 (2);
      lv_cod_nivel      VARCHAR2 (4);
      lv_cconcepto      VARCHAR2 (4);
      lv_cservicio      VARCHAR2 (3);
      lv_tipduracion    VARCHAR2 (2);
      lv_cantdias       VARCHAR2 (5);
      lv_numdias        VARCHAR2 (5);
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;

      CURSOR curssdelplan IS
         SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel, b.cod_concepto
           FROM ga_servsupl a, ga_actuaserv b, gad_servsup_plan c
          WHERE a.ind_comerc = cv_indcomercial
		 -- AND a.tip_servicio = cv_tipservicio_1
		  AND a.cod_producto = ev_cproducto AND a.cod_producto = b.cod_producto(+) AND a.cod_servicio = b.cod_servicio(+) AND b.cod_actabo(+) = cv_codact_fac
                AND b.cod_tipserv(+) = cv_tipservicio_2 AND a.cod_producto = c.cod_producto AND a.cod_servicio = c.cod_servicio AND c.cod_plantarif = ev_plan AND c.tip_relacion = cv_tipo_relacion                                                 --chequear
                AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql :=
         'SELECT' || ' a.cod_servicio,' || ' a.cod_servsupl,' || ' a.cod_nivel,' || ' b.cod_concepto' || ' FROM ga_servsupl a,' || ' ga_actuaserv b,' || ' gad_servsup_plan c' || ' WHERE a.ind_comerc = ' || cv_indcomercial || ' AND a.tip_servicio = '
         || cv_tipservicio_1 || ' AND a.cod_producto = ' || ev_cproducto || ' AND a.cod_producto = b.cod_producto(+)' || ' AND a.cod_servicio = b.cod_servicio(+)' || ' AND b.cod_actabo(+) = ' || cv_codact_fac || ' AND b.cod_tipserv(+) = '
         || cv_tipservicio_2 || ' AND a.cod_producto = c.cod_producto' || ' AND a.cod_servicio = c.cod_servicio' || ' AND c.cod_plantarif = ' || ev_plan || ' AND c.tip_relacion = ' || cv_tipo_relacion || ' AND SYSDATE BETWEEN c.fec_desde AND c.fec_hasta';
      --  OBTENEMOS EL VALOR PARA EL TIPO DE PLAN HIBRIDO
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_formafecha, cv_codmodulo_ge, cv_codproducto, lv_formatofecha, lv_codesql, lv_errmsql, ln_numevento);

      OPEN curssdelplan;

      LOOP
         FETCH curssdelplan
          INTO lv_cservicio, lv_cod_servsupl, lv_cod_nivel, lv_cconcepto;

         EXIT WHEN curssdelplan%NOTFOUND;

         IF (lv_cconcepto = '0') THEN
            lv_cconcepto := NULL;
         END IF;

         IF (NOT ve_existess_fn (ev_abonado, lv_cservicio, ev_fecha, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
            lv_numdias := ve_obtienenumerodiasnum_fn (lv_cservicio, ev_fecha, ev_diasespeciales, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            -- * INSERTAMOS SERV. SUPL. DEL ABONADO
            ve_insertassabonado_pr (ev_abonado, lv_cservicio, lv_cod_servsupl, lv_cod_nivel, cv_codproducto, ev_numterminal, lv_cconcepto, cv_indestado_altbd, lv_numdias, NULL                                                                -- fec_progbaja
                                                                                                                                                                               ,
                                    NULL                                                                                                                                                                                                   -- cod_ssprogramado
                                        ,
                                    ev_fecha, ev_usuario, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
         -- SI DURACION NO ES INFINITA, SE DEBE PROGRAMAR LA DESACTIVACION
         --if (LV_TipDuracion <> CV_DURACION_INFINITA) then
         --  if (not VE_RegistraDesactivacionSS_FN(EV_abonado,LV_CServicio,LV_CantDias,SV_LV_CodeSql,LV_ErrmSql)) then
         --        dbms_output.PUT_LINE('Problemas al registrar desactivacion del servicio: ' || LV_CServicio);
         --   end if;
         --end if;
         END IF;
      END LOOP;

      CLOSE curssdelplan;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10524;
         sv_mens_retorno:='Error al obtener los servicios suplementarios';


         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_InsertaSSdelPlan_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_InsertaSSdelPlan_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_insertassdelplan_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   
   FUNCTION ve_insertassdeic_fn (
      ev_abonado          IN              VARCHAR2,
      ev_numterminal      IN              VARCHAR2,
      ev_servcentrales    IN              VARCHAR2,
      ev_fecha            IN              VARCHAR2,
      ev_diasespeciales   IN              VARCHAR2,
      ev_usuario          IN              VARCHAR2,
      sn_cod_retorno      OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno     OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento       OUT NOCOPY      ge_errores_pg.evento)
      RETURN BOOLEAN IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "VE_InsertaSSdeIC_FN"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno> BOOLEAN </Retorno>
            <Descripcion>Obtiene e inserta los servicios suplementarios por defecto al plan</Descripcion>
            <Parametros>
               <Entrada>
               <param nom="EV_abonado"        Tipo="STRING">Numero del Abonado A Crearle SS</param>
               <param nom="EV_numterminal"    Tipo="STRING">Numero del terminal</param>
               <param nom="EV_servCentrales"  Tipo="STRING">servidor centrales</param>
               <param nom="EV_fecha"          Tipo="STRING">fecha de creacion de los servicios suplementarios</param>
               <param nom="EV_diasespeciales" Tipo="STRING">dias especiales</param>
               <param nom="EV_usuario"        Tipo="STRING">usuario</param>
               </Entrada>
               <Salida>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      li_largostring    INTEGER;
      li_cantservs      INTEGER;
      li_indice         INTEGER;
      lv_cod_servsupl   VARCHAR2 (2);
      lv_cod_nivel      VARCHAR2 (4);
      lv_cconcepto      VARCHAR2 (4);
      lv_cservicio      ga_servsuplabo.cod_servicio%TYPE;
      lv_codesql        ga_errores.cod_sqlcode%TYPE;
      lv_errmsql        ga_errores.cod_sqlerrm%TYPE;
      lv_des_error      ge_errores_pg.desevent;
      lv_ssql           ge_errores_pg.vquery;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := '';
      li_largostring := LENGTH (ev_servcentrales);
      li_cantservs := li_largostring / 6;
      -- * RECORRER CADENA DE SERVICIOS OBTENIDOS DE INTERFAZ CON CENTRALES
      li_indice := 0;

      LOOP
         IF li_indice >= li_cantservs OR li_cantservs IS NULL THEN
            RETURN TRUE;
         END IF;
         lv_cod_servsupl := SUBSTR (ev_servcentrales, 6 * li_indice + 1, 2);
         lv_cod_nivel := SUBSTR (ev_servcentrales, 6 * li_indice + 1 + 2, 4);
         -- * OBETNER SERVICIO SUPLEMENTARIO DE IC
         ve_obtienessdeic_pr (cv_codproducto, lv_cod_servsupl, lv_cod_nivel, lv_cservicio, lv_cconcepto, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

         IF (LENGTH (lv_cservicio) > 0) THEN
            IF (lv_cconcepto = '0') THEN
               lv_cconcepto := NULL;
            END IF;

            IF (NOT ve_existess_fn (ev_abonado, lv_cservicio, ev_fecha, sn_cod_retorno, sv_mens_retorno, sn_num_evento)) THEN
               -- * INSERTAMOS SERV. SUPL. DEL ABONADO
               ve_insertassabonado_pr (ev_abonado, lv_cservicio, lv_cod_servsupl, lv_cod_nivel, cv_codproducto, ev_numterminal, lv_cconcepto, cv_indestado_altbd, NULL,
			                           NULL,NULL,ev_fecha, ev_usuario, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
            END IF;
         END IF;

         li_indice := li_indice + 1;
      END LOOP;

      RETURN TRUE;
   EXCEPTION
      WHEN OTHERS THEN
         sn_cod_retorno := 10524;
         sv_mens_retorno:='Error al obtener los servicios suplementarios';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_InsertaSSdeIC_FN; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_InsertaSSdeIC_FN', lv_ssql, sn_cod_retorno, lv_des_error);
         RETURN FALSE;
   END ve_insertassdeic_fn;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------   
   
   PROCEDURE ve_obtienedatosgenerales_pr (
      sv_cservllamint      OUT NOCOPY   VARCHAR2,
      sv_cservdetllam      OUT NOCOPY   VARCHAR2,
      sv_cusoccontrolada   OUT NOCOPY   VARCHAR2,
      sv_cdiasespeciales   OUT NOCOPY   VARCHAR2,
      sn_cod_retorno       OUT NOCOPY   ge_errores_pg.coderror,
      sv_mens_retorno      OUT NOCOPY   ge_errores_pg.msgerror,
      sn_num_evento        OUT NOCOPY   ge_errores_pg.evento) IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "VE_ObtieneDatosGenerales_PR"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripcion>Obtiene los servicios para cuenta controlada</Descripcion>
            <Parametros>
               <Entrada>NA</Entrada>
               <Salida>
           <param nom="SV_CServLlamInt"     Tipo="VARCHAR2" Descripcion = "Codigo servicio llamada internacional" </param>
           <param nom="SV_CServDetLlam"     Tipo="VARCHAR2" Descripcion = "Codigo servicio detalle de llamadas" </param>
           <param nom="SV_CUSoCControlada"  Tipo="VARCHAR2" Descripcion = "Codigo Uso cuenta controlada" </param>
           <param nom="SV_CDiasEspeciales"  Tipo="VARCHAR2" Descripcion = "Codigo dias especiales" </param>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */
      lv_des_error   ge_errores_pg.desevent;
      lv_ssql        ge_errores_pg.vquery;
   BEGIN
      sv_cservllamint := '';
      sv_cservdetllam := '';
      sv_cusoccontrolada := '';
      sv_cdiasespeciales := '';
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := '   SELECT a.cod_serllaminter,a.cod_detcel,a.cod_usocontrolada,a.cod_diasespcel';
      lv_ssql := lv_ssql || ' FROM ga_datosgener a';

      SELECT a.cod_serllaminter, a.cod_detcel, a.cod_usocontrolada, a.cod_diasespcel
        INTO sv_cservllamint, sv_cservdetllam, sv_cusoccontrolada, sv_cdiasespeciales
        FROM ga_datosgener a;

      sn_cod_retorno := NULL;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         sv_cservllamint := '';
         sv_cservdetllam := '';
         sv_cusoccontrolada := '';
         sv_cdiasespeciales := '';
         sn_cod_retorno := 10528;
         sv_mens_retorno :='No se encontraron los servicios para cuenta controlada';


         lv_des_error := SUBSTR ('NO_DATA_FOUND:ve_serv_suplem_abo_quiosco_pg.VE_ObtieneDatosGenerales_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ObtieneDatosGenerales_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10529;
         sv_mens_retorno:='Error al obtener los servicios para cuenta controlada';


         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_ObtieneDatosGenerales_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ObtieneDatosGenerales_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtienedatosgenerales_pr;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_procesossabonado_pr (
      ev_abonado        IN              VARCHAR2,
      ev_plan           IN              VARCHAR2,
      ev_numterminal    IN              VARCHAR2,
      ev_usuario        IN              VARCHAR2,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*
      <Documentacion
        TipoDoc = "PROCEDURE">
         <Elemento
            Nombre = "ProcesoSSAbonado"
            Lenguaje="PL/SQL"
            Fecha="08-03-2007"
            Version="1.0"
            Dise?ador="wjrc"
            Programador="wjrc"
            Ambiente Desarrollo="BD">
            <Retorno>NA</Retorno>
            <Descripcion>Activar y o Desactivar Servicios Suplementarios Aproviocionados en central</Descripcion>
            <Parametros>
               <Entrada>
                  <param nom="EV_abonado" Tipo="VARCHAR2">Numero del Abonado A Crearle SS</param>
                  <param nom="EV_plan" Tipo="VARCHAR2">codigo de plan</param>
                  <param nom="EV_numterminal" Tipo="VARCHAR2">numero de terminal</param>
               </Entrada>
               <Salida>
                               <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
                               <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
                               <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
               </Salida>
            </Parametros>
         </Elemento>
      </Documentacion>
      */      -- * EXCEPCIONES
      error_parametros   EXCEPTION;
      -- * OTROS
      arrparametros      arregloparametros;
      --              arrParametros(1) -> tipo de plan
      --              arrParametros(2) -> tipo de plan hibrido
      --              arrParametros(3) -> codigo actuacion interfaz centrales
      --              arrParametros(4) -> indicador de autentificacion
      --              arrParametros(5) -> codigo de proceso
      --              arrParametros(6) -> permisos usuarios para el proceso
      scode_error        ga_errores.cod_sqlcode%TYPE;
      sdes_error         ge_errores_pg.desevent;
      lv_des_error       ge_errores_pg.desevent;
      lv_ssql            ge_errores_pg.vquery;
      lv_servcentrales   VARCHAR2 (255);
      lv_cservsupl       ga_servsuplabo.cod_servsupl%TYPE;
      lv_cnivel          ga_servsuplabo.cod_nivel%TYPE;
      lv_codact          VARCHAR2 (2);
      lv_valparametro    VARCHAR2 (20);
      lb_cargass_ic      BOOLEAN;                                                                                                                                                              -- Indica si se deben cargar los SS definidos por Int.Centrales
      lb_permisosok      BOOLEAN;                                                                                                                                                                                      -- permiso del usuario sobre el proceso
      lv_fecha           VARCHAR2 (17);
      par_tip_plan_hh    VARCHAR2 (17);
      par_tip_plan_pre   VARCHAR2 (17);
      par_tip_plan_pos   VARCHAR2 (17);
	  lv_codsistema      VARCHAR2 (17);
	  lv_cod_tecnologia  VARCHAR2 (17);
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_fecha := TO_CHAR (SYSDATE, cv_formato_fecha_sis);
      lv_ssql := '';
      -- OBTENEMOS DATOS GENERALES
      --LV_sSql := 'VE_ObtieneDatosGenerales_PR()';
      ve_obtienedatosgenerales_pr (arrparametros (4), arrparametros (5), arrparametros (6), arrparametros (7), sn_cod_retorno, sv_mens_retorno, sn_num_evento);
-----------------------------------------------------------------------
-- * SERVICIOS SUPLEMENTARIOS POR DEFECTO A INTERFAZ CON CENTRALES * --
-----------------------------------------------------------------------
      lv_codact := cv_codact_ven;

      -- OBTENEMOS EL TIPO DE PLAN, SEGUN EL PLAN TARIFARIO

      --LV_sSql := 'VE_tipoPlan_FN('||EV_plan||','||arrParametros(1)||','||SN_cod_retorno||','||SV_mens_retorno||')';
      IF NOT ve_tipoplan_fn (ev_plan, arrparametros (1), sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
         RAISE error_parametros;
      END IF;

      --  OBTENEMOS EL VALOR PARA EL TIPO DE PLAN HIBRIDO
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_tipplanhib, cv_codmodulo_ga, cv_codproducto, par_tip_plan_hh, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      arrparametros (2) := lv_valparametro;
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_tipplanpre, cv_codmodulo_ga, cv_codproducto, par_tip_plan_pre, sn_cod_retorno, sv_mens_retorno, sn_num_evento);
      ve_intermediario_quiosco_pg.ve_obtiene_valor_parametro_pr (cv_nompar_tipplanpos, cv_codmodulo_ga, cv_codproducto, par_tip_plan_pos, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      --SI EL TIPO DE PLAN ES HIBRIDO, CAMBIA EL CODIGO DE ACTUACION
      IF (arrparametros (1) = par_tip_plan_hh) THEN
         lv_codact := cv_codact_aah;
      ELSIF (arrparametros (1) = par_tip_plan_pre) THEN
         lv_codact := cv_codact_pre;
      ELSIF (arrparametros (1) = par_tip_plan_pos) THEN
         lv_codact := cv_codact_ven;
      ELSE
         RAISE error_parametros;
      END IF;

          -- OBTENEMOS EL CODIGO DE ACTUACION DE INTERFAZ CENTRALES
      --LV_sSql := 'VE_codigoActCentral_FN('||CV_CODPRODUCTO||','||CV_CODMODULO_GA||','||LV_CodAct||',';
          --LV_sSql := LV_sSql||CV_TECNOLOGIA||','||arrParametros(3)||','||SN_cod_retorno||','||SV_mens_retorno||')';
		  
		  
   IF NOT (ve_infoCentralAboando_fn (ev_abonado,lv_codsistema, lv_cod_tecnologia,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
      RAISE error_parametros;
   END IF;
	  		  
      IF NOT ve_codigoactcentral_fn (cv_codproducto, cv_codmodulo_ga, lv_codact, lv_cod_tecnologia, arrparametros (3), sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
         RAISE error_parametros;
      END IF;

      -- SI NO EXISTE CODIGO DE ACTUACION PARA CENTRALES, NO SE DEDE PROSEGUIR CON LA CARGA DE SS DE IC
      IF (LENGTH (arrparametros (3)) > 0) THEN
             -- * OBTENER CADENA CON SERV. SUPL. POR DEFECTO A INTERFAZ CON CENTRALES
         --LV_sSql := 'VE_serviciosCentrales_FN('||CV_CODPRODUCTO||','||CV_CODMODULO_GA||','||arrParametros(3)||',';
             --LV_sSql := LV_sSql||CV_TIPTERMINAL_SIMC||','||CV_SISTEMA||','||LV_servCentrales||','||SN_cod_retorno||','||SV_mens_retorno||')';
         IF NOT ve_servicioscentrales_fn (cv_codproducto, cv_codmodulo_ga, arrparametros (3), lv_cod_tecnologia, lv_codsistema, lv_servcentrales, sn_cod_retorno, sv_mens_retorno, sn_num_evento) THEN
            RAISE error_parametros;
         END IF;

         --LV_sSql := 'VE_InsertaSSdeIC_FN('||EV_abonado||','||EV_numterminal||','||LV_servCentrales||',';
         --LV_sSql := LV_sSql||LV_fecha||','||arrParametros(7)||','||SN_cod_retorno||','||SV_mens_retorno||')';
         IF NOT ve_insertassdeic_fn (ev_abonado,                                                                                                                                                                                          -- codigo del abonado
                                     ev_numterminal,                                                                                                                                                                                     -- numero del terminal
                                     lv_servcentrales,                                                                                                                                                                                   -- cadena con ss de ic
                                     lv_fecha,                                                                                                                                                                                                 -- fecha sistema
                                     arrparametros (7),                                                                                                                                                                               -- codigo dias especiales
                                     ev_usuario,                                                                                                                                                                                                     -- usuario
                                     sn_cod_retorno,                                                                                                                                                                                        -- codigo error sql
                                     sv_mens_retorno,                                                                                                                                                                                  -- descripcion error sql
                                     sn_num_evento) THEN
            RAISE error_parametros;
         END IF;
      END IF;

------------------------------------------------------
-- * SERVICIOS SUPLEMENTARIOS POR DEFECTO AL PLAN * --
------------------------------------------------------
      IF (LENGTH (arrparametros (4)) > 0 AND LENGTH (arrparametros (5)) > 0) THEN
             -- OBETNER SERVICIO SUPLEMENTARIO DEL PLAN
         --LV_sSql := 'VE_InsertaSSdelPlan_FN('||EV_abonado||','||EV_plan||','||EV_numterminal||','||CV_CODPRODUCTO||',';
             --LV_sSql := LV_sSql||arrParametros(7)||','||LV_fecha||','||SN_cod_retorno||','||SV_mens_retorno||')';
         IF NOT ve_insertassdelplan_fn (ev_abonado,ev_plan,
                                        ev_numterminal,                                                                                                                                                                                 -- numero del terminal
                                        cv_codproducto,                                                                                                                                                                                     -- codigo producto
                                        arrparametros (7),                                                                                                                                                                           -- codigo dias especiales
                                        lv_fecha,                                                                                                                                                                                             -- fecha sistema
                                        ev_usuario,                                                                                                                                                                                                 -- usuario
                                        sn_cod_retorno,                                                                                                                                                                                    -- codigo error sql
                                        sv_mens_retorno,                                                                                                                                                                              -- descripcion error sql
                                        sn_num_evento) THEN
            RAISE error_parametros;
         END IF;
      END IF;
   EXCEPTION
      WHEN error_parametros THEN
         sn_cod_retorno := 10530;
         sv_mens_retorno :='Error al insertar parametros generales';

         IF ev_abonado IS NOT NULL THEN
            INSERT INTO ga_errores
                        (cod_actabo, codigo, fec_error, cod_producto, nom_proc, nom_tabla, cod_act, cod_sqlcode, cod_sqlerrm)
            VALUES      ('SS', TO_NUMBER (ev_abonado), SYSDATE, 1, 've_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR', NULL, 'P', sn_cod_retorno, sv_mens_retorno);
         END IF;


         lv_des_error := SUBSTR ('error_parametros:ve_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN NO_DATA_FOUND THEN
         sv_mens_retorno := SUBSTR (SQLERRM, 1, 60);
         sn_cod_retorno := 10531;
         sv_mens_retorno :='Error al activar y/o desactivar servicios suplementarios aprovisionados en central';


         IF ev_abonado IS NOT NULL THEN
            INSERT INTO ga_errores
                        (cod_actabo, codigo, fec_error, cod_producto, nom_proc, nom_tabla, cod_act, cod_sqlcode, cod_sqlerrm)
            VALUES      ('SS', TO_NUMBER (ev_abonado), SYSDATE, 1, 've_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR', NULL, 'F', sn_cod_retorno, sv_mens_retorno);
         END IF;


         lv_des_error := SUBSTR ('NO_DATA_FOUND:ve_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10531;
         sv_mens_retorno :='Error al activar y/o desactivar servicios suplementarios aprovisionados en central';
         IF ev_abonado IS NOT NULL THEN
            INSERT INTO ga_errores
                        (cod_actabo, codigo, fec_error, cod_producto, nom_proc, nom_tabla, cod_act, cod_sqlcode, cod_sqlerrm)
            VALUES      ('SS', TO_NUMBER (ev_abonado), SYSDATE, 1, 've_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR', NULL, 'F', sn_cod_retorno, sv_mens_retorno);
         END IF;



         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_ProcesoSSAbonado_PR', lv_ssql, sn_cod_retorno, lv_des_error);
         ROLLBACK;
   END ve_procesossabonado_pr;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtiene_ss_abonado_pr (
      ev_num_abonado    IN              NUMBER,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
              Elemento Nombre = "VE_obtiene_SS_abonado_PR"
              Lenguaje="PL/SQL"
              Fecha="05-04-2007"
              Version="1.0.0"
              Dise?ador="mats"
              Programador="mats"
              Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
              Recupera ss para el numero de abonado ingresado
      </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EV_num_abonado"     Tipo="NUMBER> numero de abonado </param>
      </Entrada>
      <Salida>
              <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
              <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
              <param nom="SV_mens_retorno" Tipo="VARCHAR2"> glosa mensaje error </param>
              <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      no_data_found_cursor   EXCEPTION;
      lv_des_error           ge_errores_pg.desevent;
      lv_ssql                ge_errores_pg.vquery;
      cod_servicio1          ga_servsuplabo.cod_servicio%TYPE;
      cod_servsupl1          VARCHAR2 (100);
      cod_nivel1             VARCHAR2 (100);
      cod_concepto1          VARCHAR2 (100);
      ln_contador            NUMBER;
   BEGIN
      sn_num_evento := 0;
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      lv_ssql := '   SELECT cod_servicio,cod_servsupl,cod_nivel,cod_concepto';
      lv_ssql := lv_ssql || ' FROM ga_servsuplabo';
      lv_ssql := lv_ssql || ' WHERE num_abonado = ' || ev_num_abonado;
      lv_ssql := lv_ssql || '   AND ind_estado IN( ' || cv_estado_1 || ',' || cv_estado_2 || ')';
      ln_contador := 0;

      SELECT COUNT (1)
        INTO ln_contador
        FROM ga_servsuplabo a
       WHERE a.num_abonado = ev_num_abonado AND a.ind_estado IN (cv_estado_1, cv_estado_2) AND ROWNUM <= 1;

      OPEN sc_cursordatos FOR
         SELECT a.cod_servicio, a.cod_servsupl, a.cod_nivel, a.cod_concepto
           FROM ga_servsuplabo a
          WHERE a.num_abonado = ev_num_abonado AND a.ind_estado IN (cv_estado_1, cv_estado_2);

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 10525;
         sv_mens_retorno:='No existen servicios suplementarios';

         lv_des_error := SUBSTR ('no_data_found_cursor:ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SS_abonado_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SS_abonado_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10524;
         sv_mens_retorno:='Error al obtener los servicios suplementarios';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SS_abonado_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SS_abonado_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_ss_abonado_pr;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtiene_ssabo_paracent_pr (
      en_numabonado     IN              ga_servsuplabo.num_abonado%TYPE,
      en_indestado      IN              ga_servsuplabo.ind_estado%TYPE,
      ev_codproducto    IN              VARCHAR2,
      ev_codmodulo      IN              VARCHAR2,
      ev_codsistema     IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
              Elemento Nombre = "VE_obtiene_SSabo_paracent_PR"
              Lenguaje="PL/SQL"
              Fecha="05-04-2007"
              Version="1.0.0"
              Dise?ador="mats"
              Programador="mats"
              Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
              Recupera ss para el numero de abonado ingresado para el indicador ingresado
      </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EN_numabonado"   Tipo="NUMBER> numero de abonado </param>
              <param nom="EN_indestado"    Tipo="NUMBER> indicador estado</param>
              <param nom="EV_codProducto"  Tipo="STRING"> codigo producto </param>
              <param nom="EV_codModulo"    Tipo="STRING"> codigo modulo </param>
              <param nom="EV_codSistema    Tipo="STRING"> codigo sistema </param>
              <param nom="EV_codActuacion" Tipo="STRING"> codigo actuacion centrales </param>
      </Entrada>
      <Salida>
              <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con abonados seleccionados </param>
              <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
              <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
              <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      le_exception_fin             EXCEPTION;
      no_data_found_cursor         EXCEPTION;
      cn_largosubstring   CONSTANT NUMBER                        := 6;
      cc_char             CONSTANT CHAR                          := ' ';
      la_arreglo                   ve_intermediario_quiosco_pg.tipoarray := ve_intermediario_quiosco_pg.tipoarray ();
      lv_des_error                 ge_errores_pg.desevent;
      lv_ssql                      ge_errores_pg.vquery;
      ln_contador                  NUMBER;
      ln_indice                    NUMBER;
      lv_valparametro              VARCHAR2 (20);
      lv_cadenaservicio            VARCHAR2 (1000);
      lv_condicion                 VARCHAR2 (1000);
      lc_char1                     CHAR;
  	  lv_codsistema      VARCHAR2 (17);
	  lv_cod_tecnologia  VARCHAR2 (17);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;
	  
      IF NOT (ve_infoCentralAboando_fn (en_numabonado,lv_codsistema, lv_cod_tecnologia,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE le_exception_fin;
      END IF;
	 	 
	  IF NOT (ve_rec_cadena_central_fn (ev_codproducto,lv_cod_tecnologia,ev_codsistema,ev_codactuacion,ev_codmodulo,lv_cadenaservicio,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE le_exception_fin;
      END IF;	      

      la_arreglo := ve_intermediario_quiosco_pg.ve_descompone_cadena_fn (lv_cadenaservicio, cn_largosubstring, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

	  lv_ssql := '1';
      lv_condicion := '(';
	  
      FOR ln_indice IN 1 .. la_arreglo.COUNT LOOP
         lv_condicion := lv_condicion || '''' || la_arreglo (ln_indice) || ''',';
      END LOOP;
	  
	  lv_ssql := '2';
	  
      lv_condicion := SUBSTR (lv_condicion, 1, LENGTH (lv_condicion) - 1) || ')';
	  
  	  lv_ssql := '3';
	  
      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

  	  lv_ssql := '4';
	  
      ln_contador := 0;
      lv_ssql := 'SELECT COUNT(1)';
      lv_ssql := lv_ssql || ' FROM ga_servsuplabo a';
      lv_ssql := lv_ssql || ' WHERE a.num_abonado = ' || en_numabonado;
      lv_ssql := lv_ssql || ' AND a.ind_estado = ' || en_indestado;
	  
	  
	  IF (length(lv_condicion) > 4 ) THEN 
	      lv_ssql := lv_ssql || ' AND replace(TO_CHAR(a.cod_servsupl,''09'')||' || 'TO_CHAR(a.cod_nivel, ''0999''),''' || cc_char || ''','''') ' || 'NOT IN' || lv_condicion;
	  END IF;
	  
      

      EXECUTE IMMEDIATE lv_ssql
                   INTO ln_contador;

      lv_ssql := 'SELECT a.cod_servicio,a.cod_servsupl,a.cod_nivel,a.cod_concepto';
      lv_ssql := lv_ssql || ' FROM ga_servsuplabo a';
      lv_ssql := lv_ssql || ' WHERE a.num_abonado = ' || en_numabonado;
      lv_ssql := lv_ssql || ' AND a.ind_estado = ' || en_indestado;
      	  
	  IF (length(lv_condicion) > 4 ) THEN 
	      lv_ssql := lv_ssql || ' AND replace(TO_CHAR(a.cod_servsupl,''09'')||' || 'TO_CHAR(a.cod_nivel, ''0999''),''' || cc_char || ''','''') ' || 'NOT IN' || lv_condicion;
	  END IF;

      OPEN sc_cursordatos FOR lv_ssql;

      IF (ln_contador = 0) THEN
         RAISE no_data_found_cursor;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
	     OPEN sc_cursordatos FOR
      	 SELECT NULL FROM DUAL WHERE rownum < 1;  
        
      WHEN le_exception_fin THEN
         lv_des_error := 'LE_exception_fin: VE_intermediario_quiosco_PG.VE_ObtieneNumeroCelularAut_PR();- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 'VE_intermediario_quiosco_PG.VE_ObtieneNumeroCelularAut_PR', lv_ssql, SQLCODE, lv_des_error);
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 0;
         sv_mens_retorno := 'No existen servicios suplementarios';

         lv_des_error := SUBSTR ('no_data_found_cursor:ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_paracent_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_paracent_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10524;
         sv_mens_retorno :='Error al obtener los servicios suplementarios';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_paracent_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_paracent_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_ssabo_paracent_pr;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   PROCEDURE ve_obtiene_ssabo_nocent_pr (
      en_numabonado     IN              ga_servsuplabo.num_abonado%TYPE,
      en_indestado      IN              ga_servsuplabo.ind_estado%TYPE,
      ev_codproducto    IN              VARCHAR2,
      ev_codmodulo      IN              VARCHAR2,
      ev_codsistema     IN              VARCHAR2,
      ev_codactuacion   IN              VARCHAR2,
      sc_cursordatos    OUT NOCOPY      refcursor,
      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento) IS
      /*--
      <Documentacion TipoDoc = "Procedimiento">
              Elemento Nombre = "VE_obtiene_SSabo_nocent_PR"
              Lenguaje="PL/SQL"
              Fecha="14-10-2007"
              Version="1.0.0"
              Dise?ador="Héctor Hermosilla"
              Programador="Héctor Hermosilla"
              Ambiente="BD"
      <Retorno>NA</Retorno>
      <Descripcion>
              Recupera cadena de ss y nivel del abonado informado
      </Descripcion>
      <Parametros>
      <Entrada>
              <param nom="EN_numabonado"   Tipo="NUMBER> numero de abonado </param>
              <param nom="EN_indestado"    Tipo="NUMBER> indicador estado</param>
              <param nom="EV_codProducto"  Tipo="STRING"> codigo producto </param>
              <param nom="EV_codModulo"    Tipo="STRING"> codigo modulo </param>
              <param nom="EV_codSistema    Tipo="STRING"> codigo sistema </param>
              <param nom="EV_codActuacion" Tipo="STRING"> codigo actuacion centrales </param>
      </Entrada>
      <Salida>
              <param nom="SC_cursordatos"  Tipo="CURSOR"> cursor con nivel y servicio asociado al abonado</param>
              <param nom="SN_cod_retorno"  Tipo="NUMBER"> codigo retorno </param>
              <param nom="SV_mens_retorno" Tipo="STRING"> glosa mensaje error </param>
              <param nom="SN_num_evento"   Tipo="NUMBER"> numero de evento </param>
      </Salida>
      </Parametros>
      </Elemento>
      </Documentacion>
      --*/
      le_exception_fin             EXCEPTION;
      no_data_found_cursor         EXCEPTION;
      cn_largosubstring   CONSTANT NUMBER                        := 6;
      cc_char             CONSTANT CHAR                          := ' ';
      la_arreglo                   ve_intermediario_quiosco_pg.tipoarray := ve_intermediario_quiosco_pg.tipoarray ();
      lv_des_error                 ge_errores_pg.desevent;
      lv_ssql                      ge_errores_pg.vquery;
      ln_contador                  NUMBER;
      ln_indice                    NUMBER;
      lv_valparametro              VARCHAR2 (20);
      lv_cadenaservicio            VARCHAR2 (1000);
      lv_condicion                 VARCHAR2 (1000);
      lc_char1                     CHAR;
	  lv_codsistema      VARCHAR2 (17);
	  lv_cod_tecnologia  VARCHAR2 (17);
   BEGIN
      sn_cod_retorno := 0;
      sv_mens_retorno := '';
      sn_num_evento := 0;
	  
      IF NOT (ve_infoCentralAboando_fn (en_numabonado,lv_codsistema, lv_cod_tecnologia,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE le_exception_fin;
      END IF;

	  IF NOT (ve_rec_cadena_central_fn (ev_codproducto,lv_cod_tecnologia,ev_codsistema,ev_codactuacion,ev_codmodulo,lv_cadenaservicio,sn_cod_retorno,sv_mens_retorno,sn_num_evento)) THEN
         RAISE le_exception_fin;
      END IF;

      la_arreglo := ve_intermediario_quiosco_pg.ve_descompone_cadena_fn (lv_cadenaservicio, cn_largosubstring, sn_cod_retorno, sv_mens_retorno, sn_num_evento);

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

      lv_condicion := '(';

      FOR ln_indice IN 1 .. la_arreglo.COUNT LOOP
         lv_condicion := lv_condicion || '''' || la_arreglo (ln_indice) || ''',';
      END LOOP;

      lv_condicion := SUBSTR (lv_condicion, 1, LENGTH (lv_condicion) - 1) || ')';

      IF (sn_cod_retorno <> 0) THEN
         RAISE le_exception_fin;
      END IF;

	  
	  IF (length(lv_condicion) > 4 ) THEN 
	  
         ln_contador := 0;
         --Inicio INC148452 [JST Soporte Ventas 17-11-2010]
         --lv_ssql := 'SELECT COUNT(1)';
         lv_ssql := 'SELECT /*+ index(a PK_GA_SERVSUPLABO) */ COUNT(1)';
         --Fin INC148452 [JST Soporte Ventas 17-11-2010]
         lv_ssql := lv_ssql || ' FROM ga_servsuplabo a';
         lv_ssql := lv_ssql || ' WHERE a.num_abonado = ' || en_numabonado;
         lv_ssql := lv_ssql || ' AND a.ind_estado = ' || en_indestado;
         lv_ssql := lv_ssql || ' AND replace(TO_CHAR(a.cod_servsupl,''09'')||' || 'TO_CHAR(a.cod_nivel, ''0999''),''' || cc_char || ''','''') ' || 'IN' || lv_condicion;
	  
         EXECUTE IMMEDIATE lv_ssql INTO ln_contador;

         --Inicio INC148452 [JST Soporte Ventas 17-11-2010]
				 --lv_ssql := 'SELECT replace(TO_CHAR(a.cod_servsupl,''09'')||';
         lv_ssql := 'SELECT /*+ index(a PK_GA_SERVSUPLABO) */ replace(TO_CHAR(a.cod_servsupl,''09'')||';
         --Fin INC148452 [JST Soporte Ventas 17-11-2010]
         lv_ssql := lv_ssql || 'TO_CHAR(a.cod_nivel, ''0999''),''' || cc_char || ''','''') ';
         lv_ssql := lv_ssql || ' FROM ga_servsuplabo a';
         lv_ssql := lv_ssql || ' WHERE a.num_abonado = ' || en_numabonado;
         lv_ssql := lv_ssql || ' AND a.ind_estado = ' || en_indestado;	 
         lv_ssql := lv_ssql || ' AND replace(TO_CHAR(a.cod_servsupl,''09'')||' || 'TO_CHAR(a.cod_nivel, ''0999''),''' || cc_char || ''','''') ' || 'IN' || lv_condicion;
		 
		 OPEN sc_cursordatos FOR lv_ssql;
		 
         IF (ln_contador = 0) THEN
            RAISE no_data_found_cursor;
         END IF;
		 		 
	  ELSE
	  
         OPEN sc_cursordatos FOR SELECT NULL FROM DUAL WHERE rownum < 1; 

	  END IF;

      


	  
	  
   EXCEPTION      		    
      WHEN le_exception_fin THEN
         lv_des_error := 'LE_exception_fin: ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_nocent_PR;- ' || SQLERRM;
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_nocent_PR', lv_ssql, SQLCODE, lv_des_error);
      WHEN no_data_found_cursor THEN
         sn_cod_retorno := 10532;
         sv_mens_retorno :='No existe cadena de servicios suplementarios';

         lv_des_error := SUBSTR ('no_data_found_cursor:ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_nocent_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_nocent_PR', lv_ssql, sn_cod_retorno, lv_des_error);
      WHEN OTHERS THEN
         sn_cod_retorno := 10533;
         sv_mens_retorno := 'Error al obtener cadena de servicios suplementarios';

         lv_des_error := SUBSTR ('OTHERS:ve_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_nocent_PR; - ' || SQLERRM, 1, cn_largoerrtec);
         sv_mens_retorno := SUBSTR (sv_mens_retorno, 1, cn_largodesc);
         sn_num_evento := ge_errores_pg.grabarpl (sn_num_evento, cv_cod_modulo, sv_mens_retorno, '1.0', USER, 've_serv_suplem_abo_quiosco_pg.VE_obtiene_SSabo_nocent_PR', lv_ssql, sn_cod_retorno, lv_des_error);
   END ve_obtiene_ssabo_nocent_pr;
   
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   
END ve_serv_suplem_abo_quiosco_pg;
/
SHOW ERRORS
