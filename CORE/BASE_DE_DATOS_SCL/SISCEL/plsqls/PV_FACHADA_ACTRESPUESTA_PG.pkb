CREATE OR REPLACE package body PV_FACHADA_ACTRESPUESTA_PG
as
     procedure PV_CARGA_MOVI_PR(V_PARAM_ENTRADA IN ICC_MOVIMIENTO%ROWTYPE,
                                                                  V_CODERROR OUT NOCOPY VARCHAR2,
                                                                  V_DESERROR OUT NOCOPY VARCHAR2)
    is

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_CARGA_MOVI_PR"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="Oscar Jorquera P."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="V_PARAM_ENTRADA"   Tipo="ICC_MOVIMIENTO%ROWTYPE">campos de la tabla ICC_MOVIMIENTO</param>
             </Entrada>
         <Salida>
            <param nom="V_CODERROR"     Tipo="VARCHAR2">V_CODERROR implica que no existe error</param>
            <param nom="V_DESERROR"     Tipo="VARCHAR2"></param>
                 </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

        V_CMOV         ICC_MOVIMIENTO%ROWTYPE;
--      V_COD_PRD      GE_DATOSGENER.PROD_CELULAR%TYPE;
        V_SEQ_TRANS    GA_TRANSACABO.NUM_TRANSACCION%TYPE;
        V_RETORNO      GA_TRANSACABO.COD_RETORNO%TYPE;
        V_VALPARAMETRO GED_PARAMETROS.NOM_PARAMETRO%TYPE;

    LV_fecha_ingreso ICC_MOVIMIENTO.FEC_INGRESO%TYPE;

        LV_sSql        ge_errores_pg.vQuery;
        LV_MotivoError varchar2(255);
        LV_CodError    number;
        ERROR_PROCESO EXCEPTION ;

        BEGIN
          V_CODERROR := 0;
          V_DESERROR := '';



        IF V_PARAM_ENTRADA.FEC_INGRESO IS NULL THEN

                   LV_fecha_ingreso := SYSDATE;

                ELSE

                  LV_fecha_ingreso := V_PARAM_ENTRADA.FEC_INGRESO;

                END IF;

          -- DATOS OBLIGATORIOS
          IF V_PARAM_ENTRADA.NUM_MOVIMIENTO IS NOT NULL AND V_PARAM_ENTRADA.NUM_ABONADO IS NOT NULL AND
             V_PARAM_ENTRADA.COD_ESTADO IS NOT NULL AND V_PARAM_ENTRADA.COD_ACTABO IS NOT NULL AND
             V_PARAM_ENTRADA.COD_MODULO IS NOT NULL AND V_PARAM_ENTRADA.NUM_INTENTOS IS NOT NULL AND
             V_PARAM_ENTRADA.COD_ACTUACION IS NOT NULL AND V_PARAM_ENTRADA.NOM_USUARORA IS NOT NULL AND
                 V_PARAM_ENTRADA.TIP_TERMINAL IS NOT NULL AND
                 V_PARAM_ENTRADA.COD_CENTRAL IS NOT NULL AND V_PARAM_ENTRADA.IND_BLOQUEO IS NOT NULL AND
                 V_PARAM_ENTRADA.NUM_CELULAR IS NOT NULL AND V_PARAM_ENTRADA.NUM_SERIE IS NOT NULL AND
                 V_PARAM_ENTRADA.DES_RESPUESTA IS NOT NULL THEN

                  BEGIN
                          LV_sSql:=' SELECT PROD_CELULAR';
                          LV_sSql:= LV_sSql || ' INTO V_COD_PRD';
                          LV_sSql:= LV_sSql || ' FROM GE_DATOSGENER';

--                        SELECT PROD_CELULAR
--                    INTO V_COD_PRD
--                    FROM GE_DATOSGENER;

                          EXCEPTION WHEN NO_DATA_FOUND THEN
                          LV_CodError    := 2;
                          LV_MotivoError := 'No existe codigo de Producto';
                  RAISE ERROR_PROCESO;
                  END;

                  V_VALPARAMETRO:='';
                  LV_sSql:= LV_sSql || '    SELECT VAL_PARAMETRO INTO '||V_VALPARAMETRO;
                  LV_sSql:= LV_sSql || '          FROM   GED_PARAMETROS';
                  LV_sSql:= LV_sSql || '          where  COD_MODULO    = ' || CV_MODULO;
                  LV_sSql:= LV_sSql || '          and    NOM_PARAMETRO = ' || CV_APAGADO_HIBRIDO;
--                LV_sSql:= LV_sSql || '          AND    COD_PRODUCTO  = ' ||V_COD_PRD;

                  BEGIN


                          SELECT VAL_PARAMETRO INTO V_VALPARAMETRO
                                  FROM   GED_PARAMETROS
                                  where  COD_MODULO    = CV_MODULO
                                  and    NOM_PARAMETRO = CV_APAGADO_HIBRIDO;
--                                AND    COD_PRODUCTO  = V_COD_PRD;



                  EXCEPTION WHEN NO_DATA_FOUND THEN
                          LV_CodError    := 3;
                          LV_MotivoError := 'Problemas al obtener valor GED_PARAMETROS';
                  RAISE ERROR_PROCESO;

                  END;


                  BEGIN
                          LV_sSql:=' SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO V_SEQ_TRANS FROM DUAL';

                          SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO V_SEQ_TRANS FROM DUAL ;

                          EXCEPTION WHEN NO_DATA_FOUND THEN
                          LV_CodError    := 4;
                          LV_MotivoError := 'Problemas al generar secuencia TRANSACABO';
                  RAISE ERROR_PROCESO;
                  END;

                  IF V_PARAM_ENTRADA.NUM_MOVIMIENTO IS NULL OR V_PARAM_ENTRADA.NUM_MOVIMIENTO = 0 THEN
                 V_CMOV.NUM_MOVIMIENTO   :=  V_SEQ_TRANS;
                  ELSE
                     V_CMOV.NUM_MOVIMIENTO   :=  V_PARAM_ENTRADA.NUM_MOVIMIENTO;
                  END IF;

                  V_CMOV.NUM_ABONADO      :=  V_PARAM_ENTRADA.NUM_ABONADO;

                  V_CMOV.COD_ESTADO       :=  V_PARAM_ENTRADA.COD_ESTADO;
                  V_CMOV.COD_ACTABO       :=  V_PARAM_ENTRADA.COD_ACTABO;
                  V_CMOV.COD_MODULO       :=  V_PARAM_ENTRADA.COD_MODULO;
                  V_CMOV.NUM_INTENTOS     :=  V_PARAM_ENTRADA.NUM_INTENTOS ;
                  V_CMOV.COD_ACTUACION    :=  V_PARAM_ENTRADA.COD_ACTUACION;
                  V_CMOV.NOM_USUARORA     :=  V_PARAM_ENTRADA.NOM_USUARORA;
                  V_CMOV.FEC_INGRESO      :=  LV_fecha_ingreso; --V_PARAM_ENTRADA.FEC_INGRESO;     --  DATE
                  V_CMOV.TIP_TERMINAL     :=  V_PARAM_ENTRADA.TIP_TERMINAL ;
                  V_CMOV.COD_CENTRAL      :=  V_PARAM_ENTRADA.COD_CENTRAL;
                  V_CMOV.IND_BLOQUEO      :=  V_PARAM_ENTRADA.IND_BLOQUEO;
                  V_CMOV.NUM_CELULAR      :=  V_PARAM_ENTRADA.NUM_CELULAR;
                  V_CMOV.NUM_SERIE        :=  V_PARAM_ENTRADA.NUM_SERIE;
                  V_CMOV.DES_RESPUESTA    :=  V_PARAM_ENTRADA.DES_RESPUESTA;

                  V_CMOV.COD_CENTRAL_NUE  :=  V_PARAM_ENTRADA.COD_CENTRAL_NUE ;
                  V_CMOV.FEC_LECTURA      :=  V_PARAM_ENTRADA.FEC_LECTURA;      -- DATE,
                  V_CMOV.FEC_EJECUCION    :=  V_PARAM_ENTRADA.FEC_EJECUCION;    -- DATE,
                  V_CMOV.TIP_TERMINAL_NUE :=  V_PARAM_ENTRADA.TIP_TERMINAL_NUE;
                  V_CMOV.NUM_MOVANT       :=  V_PARAM_ENTRADA.NUM_MOVANT;
                  V_CMOV.NUM_MOVPOS       :=  V_PARAM_ENTRADA.NUM_MOVPOS;
                  V_CMOV.NUM_PERSONAL     :=  V_PARAM_ENTRADA.NUM_PERSONAL;
                  V_CMOV.NUM_CELULAR_NUE  :=  V_PARAM_ENTRADA.NUM_CELULAR_NUE;
                  V_CMOV.NUM_SERIE_NUE    :=  V_PARAM_ENTRADA.NUM_SERIE_NUE;
                  V_CMOV.NUM_PERSONAL_NUE :=  V_PARAM_ENTRADA.NUM_PERSONAL_NUE;
                  V_CMOV.NUM_MSNB         :=  V_PARAM_ENTRADA.NUM_MSNB;
                  V_CMOV.NUM_MSNB_NUE     :=  V_PARAM_ENTRADA.NUM_MSNB_NUE;
                  V_CMOV.COD_SUSPREHA     :=  V_PARAM_ENTRADA.COD_SUSPREHA;
                  V_CMOV.COD_SERVICIOS    :=  V_PARAM_ENTRADA.COD_SERVICIOS;
                  V_CMOV.NUM_MIN                  :=  V_PARAM_ENTRADA.NUM_MIN;
                  V_CMOV.NUM_MIN_NUE      :=  V_PARAM_ENTRADA.NUM_MIN_NUE;
                  V_CMOV.STA                      :=  V_PARAM_ENTRADA.STA;
                  V_CMOV.COD_MENSAJE      :=  V_PARAM_ENTRADA.COD_MENSAJE;
                  V_CMOV.PARAM1_MENS      :=  V_PARAM_ENTRADA.PARAM1_MENS;
                  V_CMOV.PARAM2_MENS      :=  V_PARAM_ENTRADA.PARAM2_MENS;
                  V_CMOV.PARAM3_MENS      :=  V_PARAM_ENTRADA.PARAM3_MENS;
                  V_CMOV.PLAN                     :=  V_PARAM_ENTRADA.PLAN;
                  V_CMOV.CARGA                    :=  V_PARAM_ENTRADA.CARGA;
                  V_CMOV.VALOR_PLAN       :=  V_PARAM_ENTRADA.VALOR_PLAN;
                  V_CMOV.PIN                      :=  V_PARAM_ENTRADA.PIN;
                  V_CMOV.FEC_EXPIRA       :=  V_PARAM_ENTRADA.FEC_EXPIRA;   --     DATE,
                  V_CMOV.DES_MENSAJE      :=  V_PARAM_ENTRADA.DES_MENSAJE;
                  V_CMOV.COD_PIN          :=  V_PARAM_ENTRADA.COD_PIN;
                  V_CMOV.COD_IDIOMA       :=  V_PARAM_ENTRADA.COD_IDIOMA;
                  V_CMOV.COD_ENRUTAMIENTO :=  V_PARAM_ENTRADA.COD_ENRUTAMIENTO;
                  V_CMOV.TIP_ENRUTAMIENTO :=  V_PARAM_ENTRADA.TIP_ENRUTAMIENTO;
                  V_CMOV.DES_ORIGEN_PIN   :=  V_PARAM_ENTRADA.DES_ORIGEN_PIN;
                  V_CMOV.NUM_LOTE_PIN     :=  V_PARAM_ENTRADA.NUM_LOTE_PIN;
                  V_CMOV.NUM_SERIE_PIN    :=  V_PARAM_ENTRADA.NUM_SERIE_PIN;
                  V_CMOV.TIP_TECNOLOGIA   :=  V_PARAM_ENTRADA.TIP_TECNOLOGIA;
                  V_CMOV.IMSI                     :=  V_PARAM_ENTRADA.IMSI;
                  V_CMOV.IMSI_NUE         :=  V_PARAM_ENTRADA.IMSI_NUE;
                  V_CMOV.IMEI                     :=  V_PARAM_ENTRADA.IMEI;
                  V_CMOV.IMEI_NUE         :=  V_PARAM_ENTRADA.IMEI_NUE;
                  V_CMOV.ICC                      :=  V_PARAM_ENTRADA.ICC;
                  V_CMOV.ICC_NUE          :=  V_PARAM_ENTRADA.ICC_NUE;



                    LV_sSql:='IC_ACTRESPUESTAS_PG.IC_PRINCIPAL_PR(V_COD_PRD,V_CMOV)';

                    IC_ACTRESPUESTAS_PG.IC_PRINCIPAL_PR(1,V_CMOV);

                        BEGIN

                          -- Controlamos si el procedimiento volvio con Error CEM
                          LV_sSql:=' SELECT COD_RETORNO';
                          LV_sSql:= LV_sSql || ' INTO V_RETORNO';
                          LV_sSql:= LV_sSql || ' FROM GA_TRANSACABO';
                          LV_sSql:= LV_sSql || ' WHERE NUM_TRANSACCION = V_CMOV.NUM_MOVIMIENTO';

                          SELECT COD_RETORNO
                            INTO V_RETORNO
                        FROM GA_TRANSACABO
                           WHERE NUM_TRANSACCION = V_CMOV.NUM_MOVIMIENTO;

                          EXCEPTION WHEN NO_DATA_FOUND THEN
                                V_RETORNO:=0;

                        END ;

                        IF V_RETORNO = 4 THEN
                             V_CODERROR := V_RETORNO;
                                 V_DESERROR := 'PROCEDIMIENTO VUELVE CON ERROR';
                        END IF;

          ELSE
                    V_CODERROR := 1;
                        V_DESERROR := 'EXISTE UNO O MAS DATOS OBLIGATORIOS QUE VIENEN VACIOS';
          END IF;


EXCEPTION

WHEN ERROR_PROCESO THEN

                 V_CODERROR := LV_CodError;
                 V_DESERROR := LV_MotivoError;
                 GN_EVENTO  := GE_ERRORES_PG.GRABARPL(0,'PV',V_DESERROR,'1', USER, 'PV_FACHADA_ACTRESPUESTA_PG', LV_sSql, sqlcode, SQLERRM);

WHEN OTHERS THEN

                IF TRIM(V_VALPARAMETRO)='TRUE'  OR TRIM(V_VALPARAMETRO)='' THEN
                   V_CODERROR := SQLCODE;
                   V_DESERROR := 'Error en llamada IC_ACTRESPUESTAS_PG.IC_PRINCIPAL_PR(V_COD_PRD,V_CMOV)';
                   GN_EVENTO  :=GE_ERRORES_PG.GRABARPL(0,'PV',V_DESERROR,'1', USER, 'PV_FACHADA_ACTRESPUESTA_PG', LV_sSql, sqlcode, SQLERRM);
            END IF;


end PV_CARGA_MOVI_PR;




procedure PV_FACHADA_UNIX_PR    (EN_num_os                IN pv_iorserv.num_os%TYPE,
                                                                 EN_COD_ACTABO    IN PV_CAMCOM.COD_ACTABO%TYPE,
                                                                 EN_NUM_ABONADO   IN PV_CAMCOM.NUM_ABONADO%TYPE,
                                                                 EN_COD_SERVICIOS IN ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
                                                                 EN_PLAN          IN ICC_MOVIMIENTO.PLAN%TYPE,
                                                                 EN_TIP_TECNO     IN ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                                 EN_NOM_USUA      IN ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                                                             SV_CODERROR OUT NOCOPY VARCHAR2,
                                                                 SV_DESERROR OUT NOCOPY VARCHAR2)
    is

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_FACHADA_UNIX_PR"
      Lenguaje="PL/SQL"
      Fecha="03-07-2006"
      Versión="1.0"
      Diseñador="Ricardo Rocco"
      Programador="ORLANDO CABEZAS."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_COD_ACTABO"   Tipo="varchar2">actabo</param>
                        <param nom="EN_NUM_ABONADO"   Tipo="numerico">abonado</param>
                        <param nom="EN_COD_SERVICIOS"   Tipo="varchar2">cadena de servicio donde aloja el plan antiguo</param>
                        <param nom="EN_TIP_TECNO   Tipo="varchar2">tecnologia</param>
                        <param nom="EN_NOM_USUA   Tipo="varchar2">usuario</param>

             </Entrada>
         <Salida>
            <param nom="SV_CODERROR"     Tipo="VARCHAR2">SV_CODERROR implica que no existe error</param>
            <param nom="SV_DESERROR"     Tipo="VARCHAR2"></param>
                 </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

        V_CMOV                        ICC_MOVIMIENTO%ROWTYPE;
--      V_COD_PRD                     GE_DATOSGENER.PROD_CELULAR%TYPE;

        LV_PARAM_ENTRADA_TIP_TERMINAL GA_ABOCEL.TIP_TERMINAL%TYPE;
        LV_PARAM_ENTRADA_NUM_CELULAR  GA_ABOCEL.NUM_CELULAR%TYPE;
        LV_PARAM_ENTRADA_NUM_SERIE    GA_ABOCEL.NUM_SERIE%TYPE;

        LV_CODERROR     VARCHAR2(1);
        LV_DESERROR     VARCHAR2(255);
        lv_valor_texto  varchar2(250);
        LV_sSql          ge_errores_pg.vQuery;

        LN_carga                 pv_movimientos.carga%TYPE;

        ERROR_PROCESO EXCEPTION ;

        BEGIN
          SV_CODERROR := 0;
          SV_DESERROR := '';
          ---V_COD_PRD  := 1;

          BEGIN

                  LV_sSql:='SELECT  TIP_TERMINAL,NUM_CELULAR,NUM_SERIE';
                  LV_sSql:= LV_sSql || ' INTO ' || LV_PARAM_ENTRADA_TIP_TERMINAL||','||LV_PARAM_ENTRADA_NUM_CELULAR||','||LV_PARAM_ENTRADA_NUM_SERIE;
                  LV_sSql:= LV_sSql || 'FROM GA_ABOCEL ';
                  LV_sSql:= LV_sSql || ' WHERE ';
                  LV_sSql:= LV_sSql || ' NUM_ABONADO = ' ||EN_NUM_ABONADO;
                  LV_sSql:= LV_sSql || ' UNION';
                  LV_sSql:= LV_sSql || ' SELECT  TIP_TERMINAL,NUM_CELULAR,NUM_SERIE';
                  LV_sSql:= LV_sSql || ' FROM GA_ABOAMIST ';
                  LV_sSql:= LV_sSql || ' WHERE' ;
                  LV_sSql:= LV_sSql || ' NUM_ABONADO = ' || EN_NUM_ABONADO;


                  SELECT  TIP_TERMINAL,NUM_CELULAR,NUM_SERIE
                  INTO LV_PARAM_ENTRADA_TIP_TERMINAL,LV_PARAM_ENTRADA_NUM_CELULAR,LV_PARAM_ENTRADA_NUM_SERIE
                  FROM GA_ABOCEL
                  WHERE
                  NUM_ABONADO = EN_NUM_ABONADO;
--                UNION
--                SELECT  TIP_TERMINAL,NUM_CELULAR,NUM_SERIE
--                FROM GA_ABOAMIST
--                WHERE
--                NUM_ABONADO = EN_NUM_ABONADO;

          EXCEPTION WHEN NO_DATA_FOUND THEN
             SV_DESERROR := 'Abonado no existe';
         RAISE ERROR_PROCESO;

          END;

          BEGIN

                  LV_sSql:= LV_sSql || ' select valor_texto';
                  LV_sSql:= LV_sSql || ' INTO ' ||   lv_valor_texto;
              LV_sSql:= LV_sSql || ' from   ga_parametros_sistema_vw ';
              LV_sSql:= LV_sSql || ' where  nom_parametro = MODULO_ESPECIAL ';
--            LV_sSql:= LV_sSql || ' and    cod_operadora = ge_fn_operadora_scl()';


                  select valor_texto
                  INTO   lv_valor_texto
              from   GA_PARAMETROS_SIMPLES_VW
              where  nom_parametro = 'MODULO_ESPECIAL';
--            and    cod_operadora = 'TMM';--ge_fn_operadora_scl();


          EXCEPTION WHEN NO_DATA_FOUND THEN
             SV_DESERROR := 'PARAMETRO MODULO_ESPECIAL NO EXISTE';
         RAISE ERROR_PROCESO;

          END;


          BEGIN
                   SELECT NVL(carga,0) INTO LN_carga
                   FROM pv_movimientos
                   WHERE num_os = EN_num_os
                   AND cod_actabo = EN_COD_ACTABO;
          EXCEPTION
                           WHEN no_data_found THEN
                                        LN_carga := 0;
          END;

      V_CMOV.NUM_MOVIMIENTO   :=  0;
          V_CMOV.NUM_ABONADO      :=  EN_NUM_ABONADO;
          V_CMOV.COD_ESTADO       :=  1;
          V_CMOV.COD_ACTABO       :=  EN_COD_ACTABO ;
          V_CMOV.COD_MODULO       :=  lv_valor_texto;
          V_CMOV.NUM_INTENTOS     :=  0 ;
          V_CMOV.COD_ACTUACION    :=  0;
          V_CMOV.NOM_USUARORA     :=  EN_NOM_USUA;
          V_CMOV.FEC_INGRESO      :=  SYSDATE;
          V_CMOV.TIP_TERMINAL     :=  LV_PARAM_ENTRADA_TIP_TERMINAL ;
          V_CMOV.COD_CENTRAL      :=  0;
          V_CMOV.IND_BLOQUEO      :=  0;
          V_CMOV.NUM_CELULAR      :=  LV_PARAM_ENTRADA_NUM_CELULAR;
          V_CMOV.NUM_SERIE        :=  LV_PARAM_ENTRADA_NUM_SERIE;
          V_CMOV.DES_RESPUESTA    :=  'PENDIENTE';
      V_CMOV.COD_CENTRAL_NUE  :=  0;
          V_CMOV.FEC_LECTURA      :=  '';      -- DATE,
          V_CMOV.FEC_EJECUCION    :=  '';    -- DATE,
          V_CMOV.TIP_TERMINAL_NUE :=  '';
          V_CMOV.NUM_MOVANT       :=  0;
          V_CMOV.NUM_MOVPOS       :=  0;
          V_CMOV.NUM_PERSONAL     :=  '';
          V_CMOV.NUM_CELULAR_NUE  :=  0;
          V_CMOV.NUM_SERIE_NUE    :=  '';
          V_CMOV.NUM_PERSONAL_NUE :=  '';
          V_CMOV.NUM_MSNB         :=  0;
          V_CMOV.NUM_MSNB_NUE     :=  0;
          V_CMOV.COD_SUSPREHA     :=  '';
          V_CMOV.COD_SERVICIOS    :=  EN_COD_SERVICIOS ;
          V_CMOV.NUM_MIN                  :=  '';
          V_CMOV.NUM_MIN_NUE      :=  '';
          V_CMOV.STA                      :=  '';
          V_CMOV.COD_MENSAJE      :=  '';
          V_CMOV.PARAM1_MENS      :=  '';
          V_CMOV.PARAM2_MENS      :=  '';
          V_CMOV.PARAM3_MENS      :=  '';
          V_CMOV.PLAN                     :=  EN_PLAN;
          V_CMOV.CARGA                    :=  LN_carga;
          V_CMOV.VALOR_PLAN       :=  0;
          V_CMOV.PIN                      :=  0;
          V_CMOV.FEC_EXPIRA       :=  '';   --     DATE,
          V_CMOV.DES_MENSAJE      :=  '';
          V_CMOV.COD_PIN          :=  TO_CHAR(EN_num_os);
          V_CMOV.COD_IDIOMA       :=  '';
          V_CMOV.COD_ENRUTAMIENTO :=  0;
          V_CMOV.TIP_ENRUTAMIENTO :=  0;
          V_CMOV.DES_ORIGEN_PIN   :=  '';
          V_CMOV.NUM_LOTE_PIN     :=  0;
          V_CMOV.NUM_SERIE_PIN    :=  '';
          V_CMOV.TIP_TECNOLOGIA   :=  EN_TIP_TECNO;
          V_CMOV.IMSI                     :=  '';
          V_CMOV.IMSI_NUE         :=  '';
          V_CMOV.IMEI                     :=  '';
          V_CMOV.IMEI_NUE         :=  '';
          V_CMOV.ICC                      :=  '';
          V_CMOV.ICC_NUE          :=  '';

          LV_CODERROR := 0;
          LV_DESERROR := '';

          LV_sSql:='PV_FACHADA_ACTRESPUESTA_PG.PV_CARGA_MOVI_PR(V_CMOV,LV_CODERROR,LV_DESERROR)';

          PV_FACHADA_ACTRESPUESTA_PG.PV_CARGA_MOVI_PR(V_CMOV,LV_CODERROR,LV_DESERROR);

          SV_CODERROR := LV_CODERROR;
          SV_DESERROR := LV_DESERROR;

EXCEPTION

WHEN ERROR_PROCESO THEN

                 SV_CODERROR := 4;

                 GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(0,'PV',SV_DESERROR,'1', USER, 'PV_FACHADA_ACTRESPUESTA_PG', LV_sSql, sqlcode, SQLERRM);



WHEN OTHERS THEN

                 SV_CODERROR := 4;
                 SV_DESERROR := 'Error en llamada PV_FACHADA_ACTRESPUESTA_PG.PV_CARGA_MOVI_PR';
                 GN_EVENTO        :=GE_ERRORES_PG.GRABARPL(0,'PV',SV_DESERROR,'1', USER, 'PV_FACHADA_ACTRESPUESTA_PG', LV_sSql, sqlcode, SQLERRM);



end  PV_FACHADA_UNIX_PR ;


PROCEDURE PV_FACHADA_VB_PR(EN_NUM_MOVIMIENTO              IN  ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE,
                                                   EN_NUM_ABONADO                 IN  ICC_MOVIMIENTO.NUM_ABONADO%TYPE,
                                                   EN_COD_ESTADO                  IN  ICC_MOVIMIENTO.COD_ESTADO%TYPE,
                                                   EV_COD_ACTABO                  IN  ICC_MOVIMIENTO.COD_ACTABO%TYPE,
                                                   EV_COD_MODULO                  IN  ICC_MOVIMIENTO.COD_MODULO%TYPE,
                                                   EN_NUM_INTENTOS                IN  ICC_MOVIMIENTO.NUM_INTENTOS%TYPE,
                                                   EN_COD_CENTRAL_NUE             IN  ICC_MOVIMIENTO.COD_CENTRAL_NUE%TYPE,
                                                   EV_DES_RESPUESTA           IN  ICC_MOVIMIENTO.DES_RESPUESTA%TYPE,
                                                   EN_COD_ACTUACION           IN  ICC_MOVIMIENTO.COD_ACTUACION%TYPE,
                                                   EV_NOM_USUARORA            IN  ICC_MOVIMIENTO.NOM_USUARORA%TYPE,
                                                   EV_FEC_INGRESO                         IN  ICC_MOVIMIENTO.FEC_INGRESO%TYPE,
                                                   EV_TIP_TERMINAL                        IN  ICC_MOVIMIENTO.TIP_TERMINAL%TYPE,
                                                   EN_COD_CENTRAL                         IN  ICC_MOVIMIENTO.COD_CENTRAL%TYPE,
                                                   EV_FEC_LECTURA                         IN  ICC_MOVIMIENTO.FEC_LECTURA%TYPE,
                                                   EN_IND_BLOQUEO                         IN  ICC_MOVIMIENTO.IND_BLOQUEO%TYPE,
                                                   EV_FEC_EJECUCION               IN  ICC_MOVIMIENTO.FEC_EJECUCION%TYPE,
                                                   EV_TIP_TERMINAL_NUE            IN  ICC_MOVIMIENTO.TIP_TERMINAL_NUE%TYPE,
                                                   EN_NUM_MOVANT                          IN  ICC_MOVIMIENTO.NUM_MOVANT%TYPE,
                                                   EN_NUM_CELULAR                         IN  ICC_MOVIMIENTO.NUM_CELULAR%TYPE,
                                                   EN_NUM_MOVPOS                          IN  ICC_MOVIMIENTO.NUM_MOVPOS%TYPE,
                                                   EV_NUM_SERIE                           IN  ICC_MOVIMIENTO.NUM_SERIE%TYPE,
                                                   EV_NUM_PERSONAL                        IN  ICC_MOVIMIENTO.NUM_PERSONAL%TYPE,
                                                   EN_NUM_CELULAR_NUE             IN  ICC_MOVIMIENTO.NUM_CELULAR_NUE%TYPE,
                                                   EV_NUM_SERIE_NUE                       IN  ICC_MOVIMIENTO.NUM_SERIE_NUE%TYPE,
                                                   EV_NUM_PERSONAL_NUE            IN  ICC_MOVIMIENTO.NUM_PERSONAL_NUE%TYPE,
                                                   EV_NUM_MSNB                            IN  ICC_MOVIMIENTO.NUM_MSNB%TYPE,
                                                   EV_NUM_MSNB_NUE                        IN  ICC_MOVIMIENTO.NUM_MSNB_NUE%TYPE,
                                                   EV_COD_SUSPREHA                        IN  ICC_MOVIMIENTO.COD_SUSPREHA%TYPE,
                                                   EV_COD_SERVICIOS                       IN  ICC_MOVIMIENTO.COD_SERVICIOS%TYPE,
                                                   EV_NUM_MIN                             IN  ICC_MOVIMIENTO.NUM_MIN%TYPE,
                                                   EV_NUM_MIN_NUE                         IN  ICC_MOVIMIENTO.NUM_MIN%TYPE,
                                                   EV_STA                                         IN  ICC_MOVIMIENTO.STA%TYPE,
                                                   EN_COD_MENSAJE                         IN  ICC_MOVIMIENTO.COD_MENSAJE%TYPE,
                                                   EV_PARAM1_MENS                         IN  ICC_MOVIMIENTO.PARAM1_MENS%TYPE,
                                                   EV_PARAM2_MENS                         IN  ICC_MOVIMIENTO.PARAM2_MENS%TYPE,
                                                   EV_PARAM3_MENS                         IN  ICC_MOVIMIENTO.PARAM3_MENS%TYPE,
                                                   EV_PLAN                                        IN  ICC_MOVIMIENTO.PLAN%TYPE,
                                                   EN_CARGA                                       IN  ICC_MOVIMIENTO.CARGA%TYPE,
                                                   EN_VALOR_PLAN                          IN  ICC_MOVIMIENTO.VALOR_PLAN%TYPE,
                                                   EV_PIN                                         IN  ICC_MOVIMIENTO.PIN%TYPE,
                                                   EV_FEC_EXPIRA                          IN  ICC_MOVIMIENTO.FEC_EXPIRA%TYPE,
                                                   EV_DES_MENSAJE                         IN  ICC_MOVIMIENTO.DES_MENSAJE%TYPE,
                                                   EV_COD_PIN                             IN  ICC_MOVIMIENTO.COD_PIN%TYPE,
                                                   EV_COD_IDIOMA                          IN  ICC_MOVIMIENTO.COD_IDIOMA%TYPE,
                                                   EN_COD_ENRUTAMIENTO            IN  ICC_MOVIMIENTO.COD_ENRUTAMIENTO%TYPE,
                                                   EN_TIP_ENRUTAMIENTO            IN  ICC_MOVIMIENTO.TIP_ENRUTAMIENTO%TYPE,
                                                   EV_DES_ORIGEN_PIN              IN  ICC_MOVIMIENTO.DES_ORIGEN_PIN%TYPE,
                                                   EN_NUM_LOTE_PIN                        IN  ICC_MOVIMIENTO.NUM_LOTE_PIN%TYPE,
                                                   EV_NUM_SERIE_PIN                       IN  ICC_MOVIMIENTO.NUM_SERIE_PIN%TYPE,
                                                   EV_TIP_TECNOLOGIA              IN  ICC_MOVIMIENTO.TIP_TECNOLOGIA%TYPE,
                                                   EV_IMSI                                        IN  ICC_MOVIMIENTO.IMSI%TYPE,
                                                   EV_IMSI_NUE                            IN  ICC_MOVIMIENTO.IMSI_NUE%TYPE,
                                                   EV_IMEI                                        IN  ICC_MOVIMIENTO.IMEI%TYPE,
                                                   EV_IMEI_NUE                            IN  ICC_MOVIMIENTO.IMEI_NUE%TYPE,
                                                   EV_ICC                                         IN  ICC_MOVIMIENTO.ICC%TYPE,
                                                   EV_ICC_NUE                             IN  ICC_MOVIMIENTO.ICC_NUE%TYPE)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_FACHADA_VB_PR".
      Lenguaje="PL/SQL"
      Fecha="29-02-2007"
      Versión="1.0"
      Diseñador="Patricio Gallegos"
      Programador="Yury Alvarez T."
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
              <Descripción></Descripción>
       <Parámetros>
         <Entrada>
                        <param nom="EN_NUM_MOVIMIENTO            Tipo="NUMERICO">numero movimiento</param>
                        <param nom="EN_NUM_ABONADO                       Tipo="varchar2">codigo actuacion comercial</param>
                        <param nom="EN_COD_ESTADO                        Tipo="NUMERICO">codigo producto</param>
                        <param nom="EV_COD_ACTABO                        Tipo="varchar2">codigo tecnologia</param>
                        <param nom="EV_COD_MODULO                        Tipo="NUMERICO">tipo pantalla</param>
                        <param nom="EN_NUM_INTENTOS                      Tipo="NUMERICO">codigo concepto</param>
                        <param nom="EN_COD_CENTRAL_NUE                   Tipo="varchar2">codigo modulo</param>
                        <param nom="EV_DES_RESPUESTA             Tipo="varchar2">plan nuevo</param>
                        <param nom="EN_COD_ACTUACION             Tipo="varchar2">plan antiguo</param>
                        <param nom="EV_NOM_USUARORA              Tipo="NUMERICO">tipo abonado</param>
                        <param nom="EV_FEC_INGRESO                               Tipo="varchar2">codigo ooss</param>
                        <param nom="EV_TIP_TERMINAL                              Tipo="NUMERICO">codigo cliente</param>
                        <param nom="EN_COD_CENTRAL                               Tipo="NUMERICO">numero abonado</param>
                        <param nom="EV_FEC_LECTURA                      Tipo="NUMERICO">indicador de facturaci¾n</param>
                        <param nom="EN_IND_BLOQUEO                      Tipo="varchar2">codigo plan de servicio</param>
                        <param nom="EV_FEC_EJECUCION             Tipo="varchar2">codigo de operacion</param>
                        <param nom="EV_TIP_TERMINAL_NUE          Tipo="varchar2">codigo tipo contrato</param>
                        <param nom="EN_NUM_MOVANT                       Tipo="NUMERICO">TIPO CELULAR</param>
                        <param nom="EN_NUM_CELULAR                      Tipo="NUMERICO">NUMERO DE MESES</param>
                        <param nom="EN_NUM_MOVPOS                       Tipo="varchar2">CODIGO ANTIGUEDAD</param>
                        <param nom="EV_NUM_SERIE                        Tipo="NUMERICO">CODIGO CICLO</param>
                        <param nom="EV_NUM_PERSONAL                     Tipo="NUMERICO">NUMERO CELULAR</param>
                        <param nom="EN_NUM_CELULAR_NUE           Tipo="NUMERICO">TIPO SERVICIO</param>
                        <param nom="EV_NUM_SERIE_NUE             Tipo="NUMERICO">CODIGO PLAN COMERCIAL</param>
                        <param nom="EV_NUM_PERSONAL_NUE          Tipo="varchar2">PARAMETRO DE MENSAJE 1</param>
                        <param nom="EV_NUM_MSNB                  Tipo="varchar2">PARAMETRO DE MENSAJE 2</param>
                        <param nom="EV_NUM_MSNB_NUE                     Tipo="varchar2">PARAMETRO DE MENSAJE 3</param>
                        <param nom="EV_COD_SUSPREHA
                        <param nom="EV_COD_SERVICIOS
                        <param nom="EV_NUM_MIN
                        <param nom="EV_NUM_MIN_NUE
                        <param nom="EV_STA
                        <param nom="EN_COD_MENSAJE
                        <param nom="EV_PARAM1_MENS
                        <param nom="EV_PARAM2_MENS
                        <param nom="EV_PARAM3_MENS
                        <param nom="EV_PLAN
                        <param nom="EN_CARGA
                        <param nom="EN_VALOR_PLAN
                        <param nom="EV_PIN
                        <param nom="EV_FEC_EXPIRA
                        <param nom="EV_DES_MENSAJE
                        <param nom="EV_COD_PIN
                        <param nom="EV_COD_IDIOMA
                        <param nom="EN_COD_ENRUTAMIENTO
                        <param nom="EN_TIP_ENRUTAMIENTO
                        <param nom="EV_DES_ORIGEN_PIN
                        <param nom="EN_NUM_LOTE_PIN
                        <param nom="EV_NUM_SERIE_PIN
                        <param nom="EV_TIP_TECNOLOGIA
                        <param nom="EV_IMSI
                        <param nom="EV_IMSI_NUE
                        <param nom="EV_IMEI
                        <param nom="EV_IMEI_NUE
                        <param nom="EV_ICC
                        <param nom="EV_ICC_NUE
             </Entrada>
         <Salida>
                <param nom="SN_cod_retorno"           Tipo=""</param>
                        <param nom="SV_mens_retorno"          Tipo=""</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

LV_REGISTRO    icc_movimiento%ROWTYPE;
LV_sSql        ge_errores_pg.vQuery;


LN_CodError    NUMBER;
LV_MotivoError VARCHAR2(255);

LN_cod_retorno  NUMBER;
LV_mens_retorno VARCHAR2(255);

ERROR_PROCESO EXCEPTION ;

BEGIN

        LN_cod_retorno := 0;
    LV_mens_retorno := '';

        LV_REGISTRO.NUM_MOVIMIENTO        :=       EN_NUM_MOVIMIENTO;
        LV_REGISTRO.NUM_ABONADO           :=       EN_NUM_ABONADO;
        LV_REGISTRO.COD_ESTADO            :=       EN_COD_ESTADO;
        LV_REGISTRO.COD_ACTABO            :=       EV_COD_ACTABO;
        LV_REGISTRO.COD_MODULO            :=       EV_COD_MODULO;
        LV_REGISTRO.NUM_INTENTOS          :=       EN_NUM_INTENTOS;
        LV_REGISTRO.COD_CENTRAL_NUE       :=       EN_COD_CENTRAL_NUE;
        LV_REGISTRO.DES_RESPUESTA         :=       EV_DES_RESPUESTA;
        LV_REGISTRO.COD_ACTUACION         :=       EN_COD_ACTUACION;
        LV_REGISTRO.NOM_USUARORA          :=       EV_NOM_USUARORA;
        LV_REGISTRO.FEC_INGRESO           :=       EV_FEC_INGRESO;
        LV_REGISTRO.TIP_TERMINAL          :=       EV_TIP_TERMINAL;
        LV_REGISTRO.COD_CENTRAL           :=       EN_COD_CENTRAL;
        LV_REGISTRO.FEC_LECTURA           :=       EV_FEC_LECTURA;
        LV_REGISTRO.IND_BLOQUEO           :=       EN_IND_BLOQUEO;
        LV_REGISTRO.FEC_EJECUCION                 :=       EV_FEC_EJECUCION;
        LV_REGISTRO.TIP_TERMINAL_NUE      :=       EV_TIP_TERMINAL_NUE;
        LV_REGISTRO.NUM_MOVANT            :=       EN_NUM_MOVANT;
        LV_REGISTRO.NUM_CELULAR           :=       EN_NUM_CELULAR;
        LV_REGISTRO.NUM_MOVPOS            :=       EN_NUM_MOVPOS;
        LV_REGISTRO.NUM_SERIE             :=       EV_NUM_SERIE;
        LV_REGISTRO.NUM_PERSONAL          :=       EV_NUM_PERSONAL;
        LV_REGISTRO.NUM_CELULAR_NUE       :=       EN_NUM_CELULAR_NUE;
        LV_REGISTRO.NUM_SERIE_NUE         :=       EV_NUM_SERIE_NUE;
        LV_REGISTRO.NUM_PERSONAL_NUE      :=       EV_NUM_PERSONAL_NUE;
        LV_REGISTRO.NUM_MSNB                      :=       EV_NUM_MSNB;
        LV_REGISTRO.NUM_MSNB_NUE          :=       EV_NUM_MSNB_NUE;
        LV_REGISTRO.COD_SUSPREHA                  :=       EV_COD_SUSPREHA;
        LV_REGISTRO.COD_SERVICIOS                 :=       EV_COD_SERVICIOS;
        LV_REGISTRO.NUM_MIN               :=       EV_NUM_MIN;
        LV_REGISTRO.NUM_MIN_NUE           :=       EV_NUM_MIN_NUE;
        LV_REGISTRO.STA                   :=       EV_STA;
        LV_REGISTRO.COD_MENSAJE           :=       EN_COD_MENSAJE;
        LV_REGISTRO.PARAM1_MENS           :=       EV_PARAM1_MENS;
        LV_REGISTRO.PARAM2_MENS           :=       EV_PARAM2_MENS;
        LV_REGISTRO.PARAM3_MENS           :=       EV_PARAM3_MENS;
        LV_REGISTRO.PLAN                  :=       EV_PLAN;
        LV_REGISTRO.CARGA                 :=       EN_CARGA;
        LV_REGISTRO.VALOR_PLAN            :=       EN_VALOR_PLAN;
        LV_REGISTRO.PIN                   :=       EV_PIN;
        LV_REGISTRO.FEC_EXPIRA            :=       EV_FEC_EXPIRA;
        LV_REGISTRO.DES_MENSAJE           :=       EV_DES_MENSAJE;
        LV_REGISTRO.COD_PIN               :=       EV_COD_PIN;
        LV_REGISTRO.COD_IDIOMA            :=       EV_COD_IDIOMA;
        LV_REGISTRO.COD_ENRUTAMIENTO      :=       EN_COD_ENRUTAMIENTO;
        LV_REGISTRO.TIP_ENRUTAMIENTO      :=       EN_TIP_ENRUTAMIENTO;
        LV_REGISTRO.DES_ORIGEN_PIN        :=       EV_DES_ORIGEN_PIN;
        LV_REGISTRO.NUM_LOTE_PIN          :=       EN_NUM_LOTE_PIN;
        LV_REGISTRO.NUM_SERIE_PIN         :=       EV_NUM_SERIE_PIN;
        LV_REGISTRO.TIP_TECNOLOGIA        :=       EV_TIP_TECNOLOGIA;
        LV_REGISTRO.IMSI                  :=       EV_IMSI;
        LV_REGISTRO.IMSI_NUE              :=       EV_IMSI_NUE;
        LV_REGISTRO.IMEI                  :=       EV_IMEI;
        LV_REGISTRO.IMEI_NUE              :=       EV_IMEI_NUE;
        LV_REGISTRO.ICC                   :=       EV_ICC;
        LV_REGISTRO.ICC_NUE               :=       EV_ICC_NUE;


        LV_sSql:='PV_FACHADA_ACTRESPUESTA_PG.PV_CARGA_MOVI_PR(V_CMOV,LV_CODERROR,LV_DESERROR)';
        PV_FACHADA_ACTRESPUESTA_PG.PV_CARGA_MOVI_PR(LV_REGISTRO,LN_CodError,LV_MotivoError);


          IF  LN_CodError <> 0 THEN
              RAISE ERROR_PROCESO ;
          END IF;

          LN_cod_retorno   := 0;
          LV_mens_retorno  := 'OK';


 EXCEPTION

                WHEN ERROR_PROCESO THEN

                 LN_cod_retorno  := 4;
                 LV_mens_retorno := LV_MotivoError;
                 GN_EVENTO       := GE_ERRORES_PG.GRABARPL(0,'PV',LV_mens_retorno,'1', USER, 'PV_FACHADA_ACTRESPUESTA_PG', LV_sSql, sqlcode, SQLERRM);

                WHEN OTHERS THEN

                 LN_cod_retorno  := 4;
                 LV_mens_retorno := 'Error en llamada PV_FACHADA_ACTRESPUESTA_PG.PV_CARGA_MOVI_PR';
                 GN_EVENTO       := GE_ERRORES_PG.GRABARPL(0,'PV',LV_mens_retorno,'1', USER, 'PV_FACHADA_ACTRESPUESTA_PG', LV_sSql, sqlcode, SQLERRM);


END PV_FACHADA_VB_PR;



end PV_FACHADA_ACTRESPUESTA_PG;
/
SHOW ERRORS
