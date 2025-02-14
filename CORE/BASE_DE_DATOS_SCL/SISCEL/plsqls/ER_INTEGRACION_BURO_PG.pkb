CREATE OR REPLACE PACKAGE BODY er_integracion_buro_pg IS

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_parse_reg_00_fn (
      EC_TRAMA          IN          CLOB,
      so_objeto         IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error            ge_errores_pg.desevent;
       LV_sql                  ge_errores_pg.vquery;
       v_tip_identificacion    VARCHAR2(1);
       v_Tip_ident_ciu         VARCHAR2(1);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;


       SELECT TO_NUMBER(TRIM(VAL_PARAMETRO))
       INTO  v_Tip_ident_ciu
       FROM GED_PARAMETROS WHERE COD_PRODUCTO = 1
       AND COD_MODULO = 'GA'
       AND NOM_PARAMETRO = 'COD_TIPIDENT';

       v_tip_identificacion := substr(EC_TRAMA, 17, 1);

       IF v_tip_identificacion = '2' Or v_tip_identificacion = '4' or v_tip_identificacion = '3'  THEN
       --LLenar Los campos para Extranjeria
          so_objeto.REGISTRO00EXT.TIPO_REGISTRO:=SUBSTR(EC_TRAMA,1,2);
          so_objeto.REGISTRO00EXT.COD_SUSCRIPTOR:=SUBSTR(EC_TRAMA,3,6);
          so_objeto.REGISTRO00EXT.FECHA_CONSULTA:=SUBSTR(EC_TRAMA,9,8);
          so_objeto.REGISTRO00EXT.TIPO_IDENTIFICACION:=SUBSTR(EC_TRAMA,17,1);
          so_objeto.REGISTRO00EXT.NOMBRE:=SUBSTR(EC_TRAMA,18,45);
          so_objeto.REGISTRO00EXT.NUM_IDENT:=SUBSTR(EC_TRAMA,63,11);
          so_objeto.REGISTRO00EXT.ESPACIO_FUTURO1:=SUBSTR(EC_TRAMA,74,8);
          so_objeto.REGISTRO00EXT.ESPACIO_FUTURO2:=SUBSTR(EC_TRAMA,97,64);
          so_objeto.REGISTRO00EXT.NACIONALIDAD:=SUBSTR(EC_TRAMA,82,15);

       DBMS_OUTPUT.Put_Line('*****************************REGISTRO 00 EXTRANJERIA******************************************');
       DBMS_OUTPUT.Put_Line('TIPO REGISTRO: '        || so_objeto.REGISTRO00EXT.TIPO_REGISTRO);
       DBMS_OUTPUT.Put_Line('CODIGO SUSCRIPTOR: '    || so_objeto.REGISTRO00EXT.COD_SUSCRIPTOR);
       DBMS_OUTPUT.Put_Line('FECHA CONSULTA: '       || so_objeto.REGISTRO00EXT.FECHA_CONSULTA);
       DBMS_OUTPUT.Put_Line('TIPO IDENTIFICACION:'   || so_objeto.REGISTRO00EXT.TIPO_IDENTIFICACION);
       DBMS_OUTPUT.Put_Line('NOMBRE: '               || so_objeto.REGISTRO00EXT.NOMBRE);
       DBMS_OUTPUT.Put_Line('NUMERO IDENTFICACION: ' || so_objeto.REGISTRO00EXT.NUM_IDENT);
       DBMS_OUTPUT.Put_Line('ESPACIO FUTURO:  '      || so_objeto.REGISTRO00EXT.ESPACIO_FUTURO1);
       DBMS_OUTPUT.Put_Line('ESPACIO FUTURO2: '      || so_objeto.REGISTRO00EXT.ESPACIO_FUTURO2);
       DBMS_OUTPUT.Put_Line('NACIONALIDAD: '         || so_objeto.REGISTRO00EXT.NACIONALIDAD);


       ELSIF v_tip_identificacion =v_Tip_ident_ciu THEN
          so_objeto.REGISTRO00CIU.TIPO_REGISTRO:=SUBSTR(EC_TRAMA,1,2);
          so_objeto.REGISTRO00CIU.COD_SUSCRIPTOR:=SUBSTR(EC_TRAMA,3,6);
          so_objeto.REGISTRO00CIU.FECHA_CONSULTA:=SUBSTR(EC_TRAMA,9,8);
          so_objeto.REGISTRO00CIU.COD_TIPIDENT:=SUBSTR(EC_TRAMA,17,1);
          so_objeto.REGISTRO00CIU.NOMBRE_COMPLETO:=SUBSTR(EC_TRAMA,18,45);
          so_objeto.REGISTRO00CIU.NUM_IDENT:=SUBSTR(EC_TRAMA,63,11);
          so_objeto.REGISTRO00CIU.VIGENCIA:= SUBSTR(EC_TRAMA, 74, 2);
          so_objeto.REGISTRO00CIU.FECHA_EXPEDICION:=SUBSTR(EC_TRAMA, 76, 6);
          so_objeto.REGISTRO00CIU.CIUDAD:=SUBSTR(EC_TRAMA,82,15);
          so_objeto.REGISTRO00CIU.DEPARTAMENTO:=SUBSTR(EC_TRAMA,97,10);
          so_objeto.REGISTRO00CIU.PRIMER_APELLIDO:=SUBSTR(EC_TRAMA,107,16);
          so_objeto.REGISTRO00CIU.SEGUNDO_APELLIDO:=SUBSTR(EC_TRAMA,123,16);
          so_objeto.REGISTRO00CIU.NOMBRE:=SUBSTR(EC_TRAMA,139,20);
          so_objeto.REGISTRO00CIU.GENERO:=SUBSTR(EC_TRAMA,159,1);
          so_objeto.REGISTRO00CIU.RANGO_EDAD:=SUBSTR(EC_TRAMA,160,1);

       DBMS_OUTPUT.Put_Line('*****************************REGISTRO CIUDADANIA******************************************');
       DBMS_OUTPUT.Put_Line('TIPO REGISTRO: '        || so_objeto.REGISTRO00CIU.TIPO_REGISTRO);
       DBMS_OUTPUT.Put_Line('CODIGO SUSCRIPTOR: '    || so_objeto.REGISTRO00CIU.COD_SUSCRIPTOR);
       DBMS_OUTPUT.Put_Line('FECHA CONSULTA: '       || so_objeto.REGISTRO00CIU.FECHA_CONSULTA);
       DBMS_OUTPUT.Put_Line('TIPO IDENTIFICACION: '  || so_objeto.REGISTRO00CIU.COD_TIPIDENT);
       DBMS_OUTPUT.Put_Line('NOMBRE COMPLETO: '      || so_objeto.REGISTRO00CIU.NOMBRE_COMPLETO);
       DBMS_OUTPUT.Put_Line('NUMERO IDENTFICACION: ' || so_objeto.REGISTRO00CIU.NUM_IDENT);
       DBMS_OUTPUT.Put_Line('VIGENCIA: '             || so_objeto.REGISTRO00CIU.VIGENCIA);
       DBMS_OUTPUT.Put_Line('FECHA EXPEDICION: '     || so_objeto.REGISTRO00CIU.FECHA_EXPEDICION);
       DBMS_OUTPUT.Put_Line('CIUDAD: '               || so_objeto.REGISTRO00CIU.CIUDAD);
       DBMS_OUTPUT.Put_Line('DEPARTAMENTO: '         || so_objeto.REGISTRO00CIU.DEPARTAMENTO);
       DBMS_OUTPUT.Put_Line('PRIMER APELLIDO: '      || so_objeto.REGISTRO00CIU.PRIMER_APELLIDO);
       DBMS_OUTPUT.Put_Line('SEGUNDO APELLIDO: '     || so_objeto.REGISTRO00CIU.SEGUNDO_APELLIDO);
       DBMS_OUTPUT.Put_Line('NOMBRE: '               || so_objeto.REGISTRO00CIU.NOMBRE);
       DBMS_OUTPUT.Put_Line('GENERO: '               || so_objeto.REGISTRO00CIU.GENERO);
       DBMS_OUTPUT.Put_Line('RANGO EDAD: '           || so_objeto.REGISTRO00CIU.RANGO_EDAD);
       END IF;

       RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 427;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 00';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_00_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_parse_reg_01_fn (
      LV_TRAZA80          IN VARCHAR2,
      LN_INDICE_REG01   IN NUMBER,
      so_objeto         OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           --v_tip_reg            VARCHAR2(2);
           --v_cod_suscriptor     VARCHAR2(6);
           --v_fec_consulta       VARCHAR2(8);
           --v_tip_identificacion VARCHAR2(1);
           --v_nombre             VARCHAR2(45);
           --v_num_identificacion VARCHAR2(11);
           --v_espacio_futuro_1   VARCHAR2(7);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           --v_tip_reg            := substr(ev_reg01, 1, 2);
           --v_cod_suscriptor     := substr(ev_reg01, 3, 6);
           --v_fec_consulta       := substr(ev_reg01, 7, 8);
           --v_tip_identificacion := substr(ev_reg01,17, 1);
           --v_nombre             := substr(ev_reg01,18,45);
           --v_num_identificacion := substr(ev_reg01,63,11);
           --v_espacio_futuro_1   := substr(ev_reg01,74, 7);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 01';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_01_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_02_fn (
      ev_reg02          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg            VARCHAR2(2);
           v_cod_estado         VARCHAR2(2);
           v_espacio_futuro_1   VARCHAR2(2);
           v_descrip_estado     VARCHAR2(15);
           v_tipo_cuenta        VARCHAR2(3);
           v_cod_suscriptor     VARCHAR2(6);
           v_nom_suscriptor     VARCHAR2(14);
           v_fec_actualizacion  VARCHAR2(6);
           v_num_obligacion     VARCHAR2(9);
           v_fec_apertura       VARCHAR2(6);
           v_oficina            VARCHAR2(12);
           v_ciudad             VARCHAR2(3);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg02, 1, 2);
           v_cod_estado         := substr(ev_reg02, 3, 2);
           v_espacio_futuro_1   := substr(ev_reg02, 5, 2);
           v_descrip_estado     := substr(ev_reg02, 7,15);
           v_tipo_cuenta        := substr(ev_reg02,22, 3);
           v_cod_suscriptor     := substr(ev_reg02,25, 6);
           v_nom_suscriptor     := substr(ev_reg02,31,14);
           v_fec_actualizacion  := substr(ev_reg02,45, 6);
           v_num_obligacion     := substr(ev_reg02,51, 9);
           v_fec_apertura       := substr(ev_reg02,60, 6);
           v_oficina            := substr(ev_reg02,66,12);
           v_ciudad             := substr(ev_reg02,78, 3);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 02';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_02_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_03_fn (
      LV_TRAZA80             IN              VARCHAR2,
      LN_INDICE_REG03        IN              NUMBER,
      so_objeto              IN OUT NOCOPY   ER_DATOSBURO_OT,
      sn_codretorno          OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno          OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento           OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           REGISTRO03             ER_REG03_OT;


   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;
           REGISTRO03    := NEW ER_REG03_OT();

       REGISTRO03.TIPO_REGISTRO:=substr(LV_TRAZA80,1,2);
       REGISTRO03.COD_ESTADO:=substr(LV_TRAZA80, 3, 2);
       REGISTRO03.ESPACIO_FUTURO:=substr(LV_TRAZA80, 5, 2);
       REGISTRO03.DESCRIPCION_ESTADO:=substr(LV_TRAZA80, 7,15);
       REGISTRO03.IND_VALORES:=substr(LV_TRAZA80,22, 8);
       REGISTRO03.TIP_CUENTA:=substr(LV_TRAZA80,30, 3);
       REGISTRO03.COD_SUSCRIPTOR:=substr(LV_TRAZA80,33, 6);
       REGISTRO03.NOM_SUSCRIPTOR:=substr(LV_TRAZA80,39,14);
       REGISTRO03.FECHA_ACTUALIZACION:=substr(LV_TRAZA80,53, 6);
       REGISTRO03.NUM_OBLIGACION:=substr(LV_TRAZA80,59, 9);
       REGISTRO03.FECHA_APERTURA:=substr(LV_TRAZA80,68, 6);
       REGISTRO03.FECHA_VENCIMIENTO:=substr(LV_TRAZA80,74, 6);
       REGISTRO03.ESPACIO_FUTURO2:=substr(LV_TRAZA80,80, 1);

       so_objeto.REGISTRO03.extend(1);
       so_objeto.REGISTRO03(LN_INDICE_REG03):=REGISTRO03;



       DBMS_OUTPUT.Put_Line('************************REGISTRO 03*************************');
       DBMS_OUTPUT.Put_Line('ARRAY ' || so_objeto.REGISTRO03.COUNT);
       DBMS_OUTPUT.Put_Line('TIPO REGISTRO: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).TIPO_REGISTRO);
       DBMS_OUTPUT.Put_Line('COD_ESTADO: '    || so_objeto.REGISTRO03(LN_INDICE_REG03).COD_ESTADO);
       DBMS_OUTPUT.Put_Line('ESPACIO_FUTURO: '|| so_objeto.REGISTRO03(LN_INDICE_REG03).ESPACIO_FUTURO);
       DBMS_OUTPUT.Put_Line('DESCRIPCION_ESTADO: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).DESCRIPCION_ESTADO);
       DBMS_OUTPUT.Put_Line('IND_VALORES: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).IND_VALORES);
       DBMS_OUTPUT.Put_Line('TIP_CUENTA: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).TIP_CUENTA);
       DBMS_OUTPUT.Put_Line('COD_SUSCRIPTOR: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).COD_SUSCRIPTOR);
       DBMS_OUTPUT.Put_Line('NOM_SUSCRIPTOR: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).NOM_SUSCRIPTOR);
       DBMS_OUTPUT.Put_Line('FECHA_ACTUALIZACION: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).FECHA_ACTUALIZACION);
       DBMS_OUTPUT.Put_Line('NUM_OBLIGACION: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).NUM_OBLIGACION);
       DBMS_OUTPUT.Put_Line('FECHA_APERTURA: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).FECHA_APERTURA);
       DBMS_OUTPUT.Put_Line('FECHA_VENCIMIENTO: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).FECHA_VENCIMIENTO);
       DBMS_OUTPUT.Put_Line('ESPACIO_FUTURO2: ' || so_objeto.REGISTRO03(LN_INDICE_REG03).ESPACIO_FUTURO2);

       RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 428;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 03';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_03_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_04_fn (
      ev_reg04          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg              VARCHAR2(2);
           v_cod_adjetivo         VARCHAR2(2);
           v_des_adjetivo         VARCHAR2(15);
           v_fecha_adjetivo       VARCHAR2(6);
           v_espacio_futuro_1     VARCHAR2(55);


   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg04, 1, 2);
           v_cod_adjetivo       := substr(ev_reg04, 3, 2);
           v_des_adjetivo       := substr(ev_reg04, 5,15);
           v_fecha_adjetivo     := substr(ev_reg04,20, 6);
           v_espacio_futuro_1   := substr(ev_reg04,26,55);


           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 04';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_04_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



/**************************************************************************************************************************************************************************************************************************************************************************************/
   FUNCTION er_parse_reg_05_fn (
      ev_reg05          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg            VARCHAR2(2);
           v_valor_fijo         VARCHAR2(2);
           v_fec_consulta       VARCHAR2(8);
           v_tip_cta_asoc_suscr VARCHAR2(3);
           v_nom_suscriptor     VARCHAR2(14);
           v_oficina            VARCHAR2(18);
           v_cuidad             VARCHAR2(12);
           v_cod_suscriptor     VARCHAR2(6);
           v_razon_consulta     VARCHAR2(2);
           v_numero_consulta    VARCHAR2(2);
           v_espacio_futuro_1   VARCHAR2(11);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg05, 1, 2);
           v_valor_fijo         := substr(ev_reg05, 3, 2);
           v_fec_consulta       := substr(ev_reg05, 5, 8);
           v_tip_cta_asoc_suscr := substr(ev_reg05,13, 3);
           v_nom_suscriptor     := substr(ev_reg05,16,14);
           v_oficina            := substr(ev_reg05,30,18);
           v_cuidad             := substr(ev_reg05,48,12);
           v_cod_suscriptor     := substr(ev_reg05,60, 6);
           v_razon_consulta     := substr(ev_reg05,66, 2);
           v_numero_consulta    := substr(ev_reg05,68, 2);
           v_espacio_futuro_1   := substr(ev_reg05,70,11);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 05';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_05_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_06_fn (
      ev_reg06          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg            VARCHAR2(2);
           v_det_reclamo        VARCHAR2(14);
           v_fec_reclamo        VARCHAR2(6);
           v_espacio_futuro_1   VARCHAR2(1);
           v_coment_ciudadano   VARCHAR2(50);
           v_espacio_futuro_2   VARCHAR2(7);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg06, 1, 2);
           v_det_reclamo        := substr(ev_reg06, 3,14);
           v_fec_reclamo        := substr(ev_reg06,17, 6);
           v_espacio_futuro_1   := substr(ev_reg06,23, 1);
           v_coment_ciudadano   := substr(ev_reg06,24,50);
           v_espacio_futuro_2   := substr(ev_reg06,74, 7);


           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 06';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_06_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_07_fn (
      ev_reg07          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg            VARCHAR2(2);
           v_nom_suscriptor     VARCHAR2(14);
           v_espacio_futuro_1   VARCHAR2(64);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg07, 1, 2);
           v_nom_suscriptor     := substr(ev_reg07, 3,14);
           v_espacio_futuro_1   := substr(ev_reg07,17,64);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 07';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_07_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_08_fn (
       LV_TRAZA80                IN          VARCHAR2,
       LN_INDICE_REG08           IN          NUMBER,
       so_objeto                 IN OUT NOCOPY  ER_DATOSBURO_OT,
       sn_codretorno             OUT NOCOPY  ge_errores_pg.coderror,
       sv_menretorno             OUT NOCOPY  ge_errores_pg.msgerror,
       sn_numevento              OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           REGISTRO08             ER_REG08_OT;


   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;


       REGISTRO08:= NEW ER_REG08_OT();
       REGISTRO08.TIPO_REGISTRO:=SUBSTR(LV_TRAZA80, 1, 2);
       REGISTRO08.VECTOR_COMPORTAMIENTO:=SUBSTR(LV_TRAZA80, 3,24);
       REGISTRO08.GARANTE:=SUBSTR(LV_TRAZA80,27, 2);
       REGISTRO08.DESC_GARANTE:=SUBSTR(LV_TRAZA80,29, 9);
       REGISTRO08.INDICADOR_VALORES:=SUBSTR(LV_TRAZA80,38, 1);
       REGISTRO08.VALOR_INICIAL:=SUBSTR(LV_TRAZA80,39, 7);
       REGISTRO08.SALDO_ACTUAL:=SUBSTR(LV_TRAZA80,46, 7);
       REGISTRO08.SALDO_MORA:=SUBSTR(LV_TRAZA80,53, 7);
       REGISTRO08.CUOTA:=SUBSTR(LV_TRAZA80,60, 7);
       REGISTRO08.CUOTAS_CANCELADAS:=SUBSTR(LV_TRAZA80,67, 3);
       REGISTRO08.TOTAL_CUOTAS:=SUBSTR(LV_TRAZA80,70, 3);
       REGISTRO08.PERIODO_PAGO:=SUBSTR(LV_TRAZA80,73, 1);
       REGISTRO08.TIPO_OBLIGACION:=SUBSTR(LV_TRAZA80,74, 1);
       REGISTRO08.FORMA_PAGO_TOTAL:=SUBSTR(LV_TRAZA80,75, 1);
       REGISTRO08.SENAL_ALIVIO:=SUBSTR(LV_TRAZA80,76, 1);
       REGISTRO08.NOVEDAD_ALIVIADA:=SUBSTR(LV_TRAZA80,77, 2);
       REGISTRO08.POSISCION_ALIVIO:=SUBSTR(LV_TRAZA80,79, 2);

       DBMS_OUTPUT.Put_Line('********************************Registro 08***************************');
       DBMS_OUTPUT.put_LINE('TIPO REGISTRO: ' || REGISTRO08.TIPO_REGISTRO);
       DBMS_OUTPUT.put_LINE('VECTOR COMPORTAMIENTO: ' || REGISTRO08.VECTOR_COMPORTAMIENTO);
       DBMS_OUTPUT.put_LINE('GARANTE: ' || REGISTRO08.GARANTE);
       DBMS_OUTPUT.put_LINE('DESC_GARANTE: ' || REGISTRO08.DESC_GARANTE);
       DBMS_OUTPUT.put_LINE('INDICADOR VALORES: ' || REGISTRO08.INDICADOR_VALORES);
       DBMS_OUTPUT.put_LINE('VALOR INICIAL: ' || REGISTRO08.VALOR_INICIAL);
       DBMS_OUTPUT.put_LINE('SALDO ACTUAL: ' || REGISTRO08.SALDO_ACTUAL);
       DBMS_OUTPUT.put_LINE('SALDO MORA: ' || REGISTRO08.SALDO_MORA);
       DBMS_OUTPUT.put_LINE('CUOTA: ' || REGISTRO08.CUOTA);
       DBMS_OUTPUT.put_LINE('CUOTAS CANCELADAS: ' || REGISTRO08.CUOTAS_CANCELADAS);
       DBMS_OUTPUT.put_LINE('TOTAL_CUOTAS: ' || REGISTRO08.TOTAL_CUOTAS);
       DBMS_OUTPUT.put_LINE('PERIODO PAGO: ' || REGISTRO08.PERIODO_PAGO);
       DBMS_OUTPUT.put_LINE('TIPO OBLIGACION: ' || REGISTRO08.TIPO_OBLIGACION);
       DBMS_OUTPUT.put_LINE('FORMA PAGO TOTAL: ' || REGISTRO08.FORMA_PAGO_TOTAL);
       DBMS_OUTPUT.put_LINE('SENAL ALIVIO: ' || REGISTRO08.SENAL_ALIVIO);
       DBMS_OUTPUT.put_LINE('NOVEDAD ALIVIADA: ' || REGISTRO08.NOVEDAD_ALIVIADA);
       DBMS_OUTPUT.put_LINE('POSICION ALIVIO: ' || REGISTRO08.POSISCION_ALIVIO);






       so_objeto.REGISTRO08.extend(1);
       so_objeto.REGISTRO08(LN_INDICE_REG08):=REGISTRO08;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 429;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 08';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_08_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_10_fn (
      ev_reg10          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg            VARCHAR2( 2);
           v_calificacion       VARCHAR2( 1);
           v_saldo_cargo        VARCHAR2(17);
           v_tip_credito        VARCHAR2( 3);
           v_tip_moneda         VARCHAR2( 2);
           v_num_creditos       VARCHAR2( 3);
           v_fec_trim_report    VARCHAR2( 6);
           v_entidad            VARCHAR2(30);
           v_garantia           VARCHAR2( 6);
           v_espacio_futuro_1   VARCHAR2(10);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg10, 1, 2);
           v_calificacion       := substr(ev_reg10, 3, 1);
           v_saldo_cargo        := substr(ev_reg10, 4,17);
           v_tip_credito        := substr(ev_reg10,21, 3);
           v_tip_moneda         := substr(ev_reg10,24, 2);
           v_num_creditos       := substr(ev_reg10,26, 3);
           v_fec_trim_report    := substr(ev_reg10,29, 6);
           v_entidad            := substr(ev_reg10,35,30);
           v_garantia           := substr(ev_reg10,65, 6);
           v_espacio_futuro_1   := substr(ev_reg10,71,10);


           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 10';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_10_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_16_fn (
      ev_reg16          IN          VARCHAR2,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;

           v_tip_reg            VARCHAR2( 2);
           v_tip_reclamo        VARCHAR2( 2);
           v_fec_reclamo        VARCHAR2( 8);
           v_fec_actualizacion  VARCHAR2( 8);
           v_text_reclamo       VARCHAR2(45);
           v_espacio_futuro_1   VARCHAR2(15);

   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           v_tip_reg            := substr(ev_reg16, 2);
           v_tip_reclamo        := substr(ev_reg16, 2);
           v_fec_reclamo        := substr(ev_reg16, 8);
           v_fec_actualizacion  := substr(ev_reg16, 8);
           v_text_reclamo       := substr(ev_reg16,45);
           v_espacio_futuro_1   := substr(ev_reg16,15);


           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 80002;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 16';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_16_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_20_fn (
      LV_TRAZA80        IN          VARCHAR2,
      so_objeto         IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
       REGISTRO20             ER_REG20_OT;
       error_clasificacion    EXCEPTION;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;


       REGISTRO20:=new ER_REG20_OT;

       so_objeto.REGISTRO20.TIPO_REGISTRO:=SUBSTR(LV_TRAZA80, 1, 2);
       so_objeto.REGISTRO20.TIPO_SCORE:=SUBSTR(LV_TRAZA80, 3, 2);
       so_objeto.REGISTRO20.CALIFICACION:=SUBSTR(LV_TRAZA80, 5, 7);
       so_objeto.REGISTRO20.CLASIFICACION:=SUBSTR(LV_TRAZA80,12, 1);
       so_objeto.REGISTRO20.RAZON1:=SUBSTR(LV_TRAZA80,13, 5);
       so_objeto.REGISTRO20.RAZON2:=SUBSTR(LV_TRAZA80,18, 5);
       so_objeto.REGISTRO20.RAZON3:=SUBSTR(LV_TRAZA80,23, 5);
       so_objeto.REGISTRO20.RAZON4:=SUBSTR(LV_TRAZA80,28, 5);
       so_objeto.REGISTRO20.RAZON5:=SUBSTR(LV_TRAZA80,33, 5);
       so_objeto.REGISTRO20.RAZON6:=SUBSTR(LV_TRAZA80,38, 5);
       so_objeto.REGISTRO20.RAZON7:=SUBSTR(LV_TRAZA80,43, 5);
       so_objeto.REGISTRO20.RAZON8:=SUBSTR(LV_TRAZA80,48, 5);
       so_objeto.REGISTRO20.GCC:=SUBSTR(LV_TRAZA80,53, 5); --GCC
       so_objeto.REGISTRO20.GAMA:=SUBSTR(LV_TRAZA80,58, 5);--GAMA
       so_objeto.REGISTRO20.ESPACIO_FUTURO:=SUBSTR(LV_TRAZA80,63, 18);

       DBMS_OUTPUT.Put_Line('****************************************************REGISTRO 20**********************************************');
       DBMS_OUTPUT.Put_Line('TIPO REGISTRO: ' || so_objeto.REGISTRO20.TIPO_REGISTRO);
       DBMS_OUTPUT.Put_Line('TIPO SCORE: ' || so_objeto.REGISTRO20.TIPO_SCORE );
       DBMS_OUTPUT.Put_Line('CALIFICACION: ' || so_objeto.REGISTRO20.CALIFICACION );
       DBMS_OUTPUT.Put_Line('CLASIFICACION: ' || so_objeto.REGISTRO20.CLASIFICACION );
       DBMS_OUTPUT.Put_Line('RAZON1: ' || so_objeto.REGISTRO20.RAZON1 );
       DBMS_OUTPUT.Put_Line('RAZON2: ' || so_objeto.REGISTRO20.RAZON2 );
       DBMS_OUTPUT.Put_Line('RAZON3: ' || so_objeto.REGISTRO20.RAZON3 );
       DBMS_OUTPUT.Put_Line('RAZON4: ' || so_objeto.REGISTRO20.RAZON4 );
       DBMS_OUTPUT.Put_Line('RAZON5: ' || so_objeto.REGISTRO20.RAZON5 );
       DBMS_OUTPUT.Put_Line('RAZON6: ' || so_objeto.REGISTRO20.RAZON6 );
       DBMS_OUTPUT.Put_Line('RAZON7: ' || so_objeto.REGISTRO20.RAZON7 );
       DBMS_OUTPUT.Put_Line('RAZON8: ' || so_objeto.REGISTRO20.RAZON8 );
       DBMS_OUTPUT.Put_Line('GCC: ' || so_objeto.REGISTRO20.GCC );
       DBMS_OUTPUT.Put_Line('GAMA: ' || so_objeto.REGISTRO20.GAMA );
       DBMS_OUTPUT.Put_Line('ESPACIO FUTURO: ' || so_objeto.REGISTRO20.ESPACIO_FUTURO);


	   IF (TRIM(so_objeto.REGISTRO20.CLASIFICACION) IS NULL) THEN
	      RAISE error_clasificacion;
	   END IF;

       RETURN TRUE;

   EXCEPTION
     WHEN error_clasificacion THEN
        SN_codRetorno := 513;
        LV_des_error  := 'error_clasificacion: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'No fue posible obtener el valor de la clasificacion del cliente';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
     WHEN OTHERS THEN
        SN_codRetorno := 430;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 20';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_20_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   FUNCTION er_parse_reg_99_fn (
      LV_TRAZA80        IN          VARCHAR2,
      so_objeto         IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno     OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno     OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento      OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;


   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

       so_objeto.REGISTRO99.TIPO_REGISTRO := SUBSTR(LV_TRAZA80,1, 2);
           so_objeto.REGISTRO99.COD_RESPUESTA := SUBSTR(LV_TRAZA80,3, 2);
           so_objeto.REGISTRO99.MENSAJE      := SUBSTR(LV_TRAZA80,5,76);

       DBMS_OUTPUT.Put_Line('*****************************************REGISTRO 99**************************');
       DBMS_OUTPUT.Put_Line('TIPO REGISTRO: ' || so_objeto.REGISTRO99.TIPO_REGISTRO);
       DBMS_OUTPUT.Put_Line('COD_RESPUESTA: ' || so_objeto.REGISTRO99.COD_RESPUESTA);
       DBMS_OUTPUT.Put_Line('MENSAJE: '       || so_objeto.REGISTRO99.MENSAJE);


           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 431;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al parsear registro 99';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_parse_reg_99_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_hist_trama_buro_fn (
      ev_num_ident            IN          ert_datos_detalle_to.num_ident%TYPE,
          ev_cod_tipident         IN          ert_datos_detalle_to.cod_tipident%TYPE,
          en_ind_tipo_solicitud   IN          ert_datos_detalle_to.ind_tipo_solicitud%TYPE,
      sn_codretorno           OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error    ge_errores_pg.desevent;
       LV_sql          ge_errores_pg.vquery;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           LV_sql := 'INSERT INTO ert_datos_consulta_th (num_linea, fecha_actualizacion, num_ident, trama_externa) (SELECT a.num_linea, a.fecha_actualizacion, a.num_ident, a.trama_externa FROM ert_datos_consulta_to a'
              || ' WHERE a.num_ident = '||ev_num_ident
              || ' AND a.cod_tipident = '||ev_cod_tipident
              || ' AND a.ind_tipo_solicitud = '||en_ind_tipo_solicitud||')';

       INSERT INTO ert_datos_consulta_th
                   (num_linea, fecha_actualizacion, num_ident, trama_externa)
          (SELECT a.num_linea, a.fecha_actualizacion, a.num_ident, a.trama_externa
             FROM ert_datos_consulta_to a
            WHERE a.num_ident = ev_num_ident
              AND a.cod_tipident = ev_cod_tipident
              AND a.ind_tipo_solicitud = en_ind_tipo_solicitud);

           LV_sql := 'DELETE FROM ert_datos_consulta_to'
              || ' WHERE num_ident = '||ev_num_ident
                      || ' AND cod_tipident = '||ev_cod_tipident
                      || ' AND ind_tipo_solicitud = '||en_ind_tipo_solicitud;

       DELETE FROM ert_datos_consulta_to
        WHERE num_ident = ev_num_ident
                  AND cod_tipident = ev_cod_tipident
                  AND ind_tipo_solicitud = en_ind_tipo_solicitud;

           LV_sql := 'DELETE FROM ert_datos_detalle_to'
              || ' WHERE num_ident = '||ev_num_ident
                      || ' AND cod_tipident = '||ev_cod_tipident;

       DELETE FROM ert_datos_detalle_to
        WHERE num_ident = ev_num_ident
                  AND cod_tipident = ev_cod_tipident;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 432;
        LV_des_error  := 'OTHERS: er_integracion_buro_pg.er_hist_trama_buro_fn('||ev_num_ident||','||ev_cod_tipident||','||en_ind_tipo_solicitud||');- ' || SQLERRM;
        SV_menRetorno := 'Se genero un error en el traspaso a historico de la trama';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_hist_trama_buro_fn;

-------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_recuperar_trama_fn (
      ev_num_ident          IN          ert_datos_consulta_to.num_ident%TYPE ,
      ev_cod_tipident       IN          ert_datos_consulta_to.cod_tipident%TYPE,
          sv_trama              OUT NOCOPY  CLOB,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           LC_TRAMA                  CLOB;

           CURSOR Tramas IS
       SELECT a.trama_externa
         FROM ert_datos_consulta_to a
        WHERE a.num_ident = ev_num_ident
          AND a.cod_tipident = ev_cod_tipident
                  AND a.ind_tipo_solicitud = 1
          ORDER BY NUM_LINEA;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;



   OPEN Tramas;
        LOOP
        FETCH Tramas into LC_TRAMA ;
                EXIT WHEN Tramas%NOTFOUND;
           sv_trama := sv_trama || LC_TRAMA;
        END LOOP;

   CLOSE Tramas;

   RETURN TRUE;

   EXCEPTION

     WHEN NO_DATA_FOUND THEN
        SN_codRetorno := 433;
        LV_des_error   := 'NO_EXISTE_TRAMA: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Registros de Evaluación no están vigentes';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        SN_codRetorno := 434;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Error al Recuperar Trama en ERT_DATOS_CONSULTA_TO ';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_recuperar_trama_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_rec_registros_trama_fn (
          ec_trama              IN          CLOB,
          sv_tip_reg            OUT NOCOPY  VARCHAR2,
          sc_reg                OUT NOCOPY  VARCHAR2,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           tip_reg                VARCHAR2(2);
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           tip_reg := dbms_lob.substr(ec_trama,2,1);

       CASE tip_reg
           WHEN '00' THEN
                       sc_reg := dbms_lob.substr(ec_trama,160,1);
           ELSE
                       sc_reg := dbms_lob.substr(ec_trama,80,1);
           END CASE;

           RETURN TRUE;

   EXCEPTION

     WHEN NO_DATA_FOUND THEN
        SN_codRetorno := 435;
        LV_des_error   := 'NO_EXISTE_TRAMA: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Registros de Evaluación no están vigentes';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        SN_codRetorno := 436;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Error al Recuperar Trama en ERT_DATOS_CONSULTA_TO';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_rec_registros_trama_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_corta_registro_trama_fn (
          ec_trama              IN          CLOB,
          sv_tip_reg            IN          VARCHAR2,
          sc_trama              OUT NOCOPY  CLOB,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           tip_reg                VARCHAR2(2);
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           tip_reg := dbms_lob.substr(ec_trama,2,1);

       CASE tip_reg
           WHEN '00' THEN
                       sc_trama := dbms_lob.substr(ec_trama,dbms_lob.getlength(ec_trama)-160,160);
           ELSE
                       sc_trama := dbms_lob.substr(ec_trama,dbms_lob.getlength(ec_trama)-80,80);
           END CASE;

           RETURN TRUE;

   EXCEPTION

     WHEN NO_DATA_FOUND THEN
        SN_codRetorno := 435;
        LV_des_error   := 'NO_EXISTE_TRAMA: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Registros de Evaluación no están vigentes';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        SN_codRetorno := 436;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Error al Recuperar Trama en ERT_DATOS_CONSULTA_TO';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_corta_registro_trama_fn;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


   FUNCTION er_arma_objeto_trama_fn (
          ec_trama              IN          CLOB,
          so_objeto             IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           v_tip_reg              VARCHAR2(2);
           v_reg                  VARCHAR2(160);
           c_trama                CLOB;
       LN_VALOR_TRAMA         NUMBER(8);
       LN_POSICION            NUMBER(10);
       LV_TRAZA80             VARCHAR2(80);
       LV_TRAZA80_01          CLOB;
       LV_TIPO_REGISTRO       VARCHAR2(2);
       LN_CARACTERESDOS       NUMBER(1);
       LN_CARACTERES80        NUMBER(2);
       LN_INDICE_REG00        NUMBER(5);
       LN_INDICE_REG01        NUMBER(5);
       LN_INDICE_REG03        NUMBER(5);
       LN_INDICE_REG08        NUMBER(5);
       LN_INDICE_REG20        NUMBER(5);
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;
           LN_POSICION:=1;
       LN_CARACTERESDOS:=2;
       LN_CARACTERES80:=80;
       LN_INDICE_REG01:=0;
       LN_INDICE_REG03:=0;
       LN_INDICE_REG08:=0;
       LN_INDICE_REG20:=0;


          c_trama := ec_trama;
      LN_VALOR_TRAMA:= LENGTH(ec_trama);
      DBMS_OUTPUT.Put_Line('ARRAY' || so_objeto.REGISTRO03.COUNT);
       WHILE LN_POSICION <= LN_VALOR_TRAMA LOOP

            LV_TIPO_REGISTRO := SUBSTR(ec_trama, LN_POSICION, LN_CARACTERESDOS);
            LV_TRAZA80 := SUBSTR(ec_trama, LN_POSICION, LN_CARACTERES80);

                CASE LV_TIPO_REGISTRO
                     WHEN '00' THEN

                 IF NOT ER_PARSE_REG_00_FN(ec_trama,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
                    NULL;
                 END IF;

                 LN_POSICION:=LN_POSICION+LN_CARACTERES80;

                     WHEN '01' THEN
                         LV_TRAZA80_01:=LV_TRAZA80;
                 IF NOT ER_PARSE_REG_00_FN(LV_TRAZA80_01,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
                    NULL;
                 END IF;

                     WHEN '03' THEN

                 LN_INDICE_REG03:= LN_INDICE_REG03 +1;

                 IF NOT ER_PARSE_REG_03_FN(LV_TRAZA80,LN_INDICE_REG03,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
                    NULL;
                 END IF;


                 WHEN '08' THEN

                 LN_INDICE_REG08:=LN_INDICE_REG08 +1;

                 IF NOT ER_PARSE_REG_08_FN(LV_TRAZA80,LN_INDICE_REG08,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
                    NULL;
                 END IF;

--                 WHEN '20' THEN
--
--                 LN_INDICE_REG20:=LN_INDICE_REG20+1;
--
--                 IF NOT ER_PARSE_REG_20_FN(LV_TRAZA80,LN_INDICE_REG20,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
--                    NULL;
--                 END IF;

                 ELSE
                         NULL;
                END CASE;

            LN_POSICION:=LN_POSICION+LN_CARACTERES80;

       END LOOP;
   DBMS_OUTPUT.Put_Line('ARRAY' || so_objeto.REGISTRO03.COUNT);
   RETURN TRUE;

   EXCEPTION

     WHEN NO_DATA_FOUND THEN
        SN_codRetorno := 437;
        LV_des_error   := 'NO_EXISTE_TRAMA: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Error al Parsear Trama de los Registros 00,01,03,08';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;

     WHEN OTHERS THEN
        SN_codRetorno := 437;
        LV_des_error   := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Error al Parsear Trama de los Registros 00,01,03,08';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_arma_objeto_trama_fn;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_arma_objeto_trama2099_fn (
          ec_trama              IN          CLOB,
          so_objeto             IN OUT NOCOPY  ER_DATOSBURO_OT,
      sn_codretorno         OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error           ge_errores_pg.desevent;
       LV_sql                 ge_errores_pg.vquery;
           v_tip_reg              VARCHAR2(2);
           v_reg                  VARCHAR2(160);
           c_trama                CLOB;
       LN_VALOR_TRAMA         NUMBER(8);
       LN_POSICION            NUMBER(10);
       LV_TRAZA80             VARCHAR2(80);
       LV_TRAZA80_01          CLOB;
       LV_TIPO_REGISTRO       VARCHAR2(2);
       LN_CARACTERESDOS       NUMBER(1);
       LN_CARACTERES80        NUMBER(2);
       LN_INDICE_REG00        NUMBER(5);
       LN_INDICE_REG01        NUMBER(5);
       LN_INDICE_REG03        NUMBER(5);
       LN_INDICE_REG08        NUMBER(5);
       LN_INDICE_REG20        NUMBER(5);
       LN_SW                  NUMBER(1);
       error_trama            EXCEPTION;
	   error_ejecucion        EXCEPTION;
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;
           LN_POSICION:=1;
       LN_CARACTERESDOS:=2;
       LN_CARACTERES80:=80;
       LN_INDICE_REG01:=0;
       LN_INDICE_REG03:=0;
       LN_INDICE_REG08:=0;
       LN_INDICE_REG20:=0;
       LN_SW:=0;

          c_trama := ec_trama;
      LN_VALOR_TRAMA:= LENGTH(ec_trama);

       WHILE LN_POSICION <= LN_VALOR_TRAMA LOOP

            LV_TIPO_REGISTRO := SUBSTR(ec_trama, LN_POSICION, LN_CARACTERESDOS);
            LV_TRAZA80 := SUBSTR(ec_trama, LN_POSICION, LN_CARACTERES80);
            --DBMS_OUTPUT.Put_Line('TIPO REGISTRO: ' || LV_TIPO_REGISTRO);
                --DBMS_OUTPUT.Put_Line('POSICION: ' || LN_POSICION);

            CASE LV_TIPO_REGISTRO

                 WHEN '00' THEN
                   LN_POSICION := LN_POSICION + LN_CARACTERES80;

                 WHEN '20' THEN

                 LN_INDICE_REG20:=1;
                 IF LN_SW=0 THEN
                    IF NOT ER_PARSE_REG_20_FN(LV_TRAZA80,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
                       RAISE error_ejecucion;
                    END IF;
                 LN_SW:=1;
                 END IF;


                 WHEN '99' THEN
                 IF NOT ER_PARSE_REG_99_FN(LV_TRAZA80,so_objeto,sn_codretorno,sv_menretorno,sn_numevento) THEN
                    RAISE error_ejecucion;
                 END IF;
                 ELSE
                            NULL;
                END CASE;

            LN_POSICION:=LN_POSICION+LN_CARACTERES80;

       END LOOP;

       IF (so_objeto.REGISTRO99.TIPO_REGISTRO IS NULL OR so_objeto.REGISTRO99.COD_RESPUESTA IS NULL) THEN
          DBMS_OUTPUT.Put_Line('ERROR NULO REG99');
		  RAISE error_trama;
       END IF;


   RETURN TRUE;

   EXCEPTION
     WHEN error_ejecucion THEN
        LV_des_error  := 'ERROR EN LA TRAMA: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
        RETURN FALSE;

     WHEN ERROR_TRAMA THEN
        SN_codRetorno := 438;
        LV_des_error  := 'ERROR EN LA TRAMA: ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al Parsear Trama de los Registros 20 y 99';
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
        RETURN FALSE;

     WHEN OTHERS THEN
        SN_codRetorno := 438;
        LV_des_error  := 'OTHERS:ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN();- ' || SQLERRM;
        SV_menRetorno := 'Error al Parsear Trama de los Registros 20 y 99';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_servicios_evalriesgo_web_PG.VE_cierre_solicitud_FN',LV_Sql, SQLCODE, LV_des_error);
         RETURN FALSE;
   END er_arma_objeto_trama2099_fn;
 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


   FUNCTION er_inst_det_trama_buro_fn (
      ev_num_ident            IN          ert_datos_detalle_to.num_ident%TYPE,
          ev_cod_tipident         IN          ert_datos_detalle_to.cod_tipident%TYPE,
          en_ind_tipo_solicitud   IN          ert_datos_detalle_to.ind_tipo_solicitud%TYPE,
          ev_apellido             IN          ert_datos_detalle_to.apellido%TYPE,
          en_ingresos             IN          ert_datos_detalle_to.ingresos%TYPE,
          ev_cod_respuesta_reg99  IN          ert_datos_detalle_to.cod_respuesta_reg99%TYPE,
          ev_calificacion_reg20   IN          ert_datos_detalle_to.calificacion_reg20%TYPE,
          ev_clasificacion_reg20  IN          ert_datos_detalle_to.clasificacion_reg20%TYPE,
          ev_gcc_reg20            IN          ert_datos_detalle_to.gcc_reg20%TYPE,
          ev_gama_reg20           IN          ert_datos_detalle_to.gama_reg20%TYPE,
      sn_codretorno           OUT NOCOPY  ge_errores_pg.coderror,
      sv_menretorno           OUT NOCOPY  ge_errores_pg.msgerror,
      sn_numevento            OUT NOCOPY  ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error    ge_errores_pg.desevent;
       LV_sql          ge_errores_pg.vquery;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           LV_sql := 'INSERT INTO ert_datos_detalle_to (num_ident, cod_tipident, fecha_actualizacion, ind_tipo_solicitud, apellido, ingresos, cod_respuesta_reg99, calificacion_reg20, clasificacion_reg20, gcc_reg20, gama_reg20) VALUES ('
                  || ev_num_ident||', '||ev_cod_tipident||', '||SYSDATE||', '||en_ind_tipo_solicitud||', '||ev_apellido||', '||en_ingresos||', '||ev_cod_respuesta_reg99||', '||ev_calificacion_reg20||', '||ev_clasificacion_reg20||', '||ev_gcc_reg20||', '||ev_gama_reg20||')';

       INSERT INTO ert_datos_detalle_to
                   (num_ident, cod_tipident, fecha_actualizacion, ind_tipo_solicitud, apellido, ingresos, cod_respuesta_reg99, calificacion_reg20, clasificacion_reg20, gcc_reg20, gama_reg20)
            VALUES (ev_num_ident, ev_cod_tipident, SYSDATE, en_ind_tipo_solicitud, ev_apellido, en_ingresos, ev_cod_respuesta_reg99, ev_calificacion_reg20, ev_clasificacion_reg20, ev_gcc_reg20, ev_gama_reg20);

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno :=439 ;
        LV_des_error  := 'OTHERS: er_integracion_buro_pg.er_inst_det_trama_buro_fn('||ev_num_ident||', '||ev_cod_tipident||', '||en_ind_tipo_solicitud||', '||ev_apellido||', '||en_ingresos||', '||ev_cod_respuesta_reg99||', '||ev_calificacion_reg20||', '||ev_clasificacion_reg20||', '||ev_gcc_reg20||', '||ev_gama_reg20||');- ' || SQLERRM;
        SV_menRetorno := 'Se genero un error al agregar un registro al detalle de la trama';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_buro_pg.er_inst_det_trama_buro_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_inst_det_trama_buro_fn;

-------------------------------------------------------------------------------------------------------------------------------------------
   FUNCTION er_inserta_trama_buro_fn (
      ev_num_ident          IN VARCHAR2,
      ev_cod_tipident       IN VARCHAR2,
      ev_cadena_sal         IN CLOB,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   ) RETURN BOOLEAN
   IS
       LV_des_error    ge_errores_pg.desevent;
       LV_sql          ge_errores_pg.vquery;
           ciclos          NUMBER;
           pos             NUMBER;
           VAR2            VARCHAR2(1000);
   BEGIN

       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           ciclos  := ceil(dbms_lob.getlength(ev_cadena_sal)/1000);
           pos := 1;

           FOR i IN 1..ciclos LOOP
                   VAR2 := dbms_lob.substr(ev_cadena_sal,1000,pos);

                   LV_sql := 'INTO ert_datos_consulta_to (NUM_LINEA,FECHA_ACTUALIZACION,NUM_IDENT,TRAMA_EXTERNA,IND_TIPO_SOLICITUD,COD_TIPIDENT) VALUES '
                          || '('||i||','||sysdate||','||ev_num_ident||','||VAR2||','||1||','||ev_cod_tipident||')';

           INSERT INTO ert_datos_consulta_to
                       (num_linea, fecha_actualizacion, num_ident, trama_externa, ind_tipo_solicitud, cod_tipident)
                VALUES (i, SYSDATE, ev_num_ident, var2, 1, ev_cod_tipident);

                   pos := pos + 1000;
       END LOOP;

           RETURN TRUE;

   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 440;
        LV_des_error  := 'OTHERS: er_integracion_buro_pg.er_inserta_trama_buro_fn('||ev_num_ident||', '||ev_cod_tipident||');- ' || SQLERRM;
        SV_menRetorno := 'Se genero un error al registrar la trama';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_buro_pg.er_inserta_trama_buro_fn',LV_Sql, SQLCODE, LV_des_error);
            RETURN FALSE;
   END er_inserta_trama_buro_fn;

-------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE er_registra_trama_buro_pr (
      ev_num_ident          IN VARCHAR2,
      ev_cod_tipident       IN VARCHAR2,
      ev_apellido           IN VARCHAR2,
      ev_ingresos           IN VARCHAR2,
      ev_cod_respta_dc      IN VARCHAR2,
      ev_cadena_sal         IN CLOB,
      ev_clasificacion_dc   IN VARCHAR2,
      ev_calificacion_dc    IN VARCHAR2,
      ev_gasto_cc_dc        IN VARCHAR2,
      ev_gama_dc            IN VARCHAR2,
      sn_codretorno         OUT NOCOPY      ge_errores_pg.coderror,
      sv_menretorno         OUT NOCOPY      ge_errores_pg.msgerror,
      sn_numevento          OUT NOCOPY      ge_errores_pg.evento
   )
   IS PRAGMA AUTONOMOUS_TRANSACTION;
       LV_des_error    ge_errores_pg.desevent;
       LV_sql          ge_errores_pg.vquery;
           largo           NUMBER;
           ciclos          NUMBER;
           error_ejecucion EXCEPTION;
   BEGIN
       SN_codRetorno := 0;
       SV_menRetorno  := NULL;
       SN_numEvento := 0;

           IF NOT (er_hist_trama_buro_fn (ev_num_ident,ev_cod_tipident,cn_tipo_soliciutd_1,sn_codretorno,sv_menretorno,sn_numevento)) THEN
              RAISE error_ejecucion;
           END IF;

           IF NOT (er_inserta_trama_buro_fn (ev_num_ident,ev_cod_tipident,ev_cadena_sal,sn_codretorno,sv_menretorno,sn_numevento)) THEN
              RAISE error_ejecucion;
           END IF;

       IF NOT (er_inst_det_trama_buro_fn (ev_num_ident,ev_cod_tipident,cn_tipo_soliciutd_1,ev_apellido,to_number(ev_ingresos),ev_cod_respta_dc,ev_calificacion_dc,ev_clasificacion_dc,ev_gasto_cc_dc,ev_gama_dc,sn_codretorno,sv_menretorno,sn_numevento)) THEN
              RAISE error_ejecucion;
           END IF;

       COMMIT;


   EXCEPTION
     WHEN OTHERS THEN
        SN_codRetorno := 441;
        LV_des_error  := 'OTHERS: er_integracion_buro_pg.er_registra_trama_buro_pr('||ev_num_ident||', '||ev_cod_tipident||', '||ev_apellido||', '||ev_ingresos||', '||ev_cod_respta_dc||', '||ev_clasificacion_dc||', '||ev_calificacion_dc||', '||ev_gasto_cc_dc||', '||ev_gama_dc||');- ' || SQLERRM;
        SV_menRetorno := 'Se genero un error en el proceso de registrar la trama';
        SN_numEvento  := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'er_integracion_buro_pg.er_registra_trama_buro_pr',LV_Sql, SQLCODE, LV_des_error);
   END er_registra_trama_buro_pr;
-------------------------------------------------------------------------------------------------------------------------------------------
END er_integracion_buro_pg;
/
SHOW ERRORS
