CREATE OR REPLACE PACKAGE BODY Ra_Reportes_Tributarios_Pg AS


FUNCTION RA_FORMATO_FECHA RETURN VARCHAR2
IS
  LV_FormatoFecha VARCHAR2(45);
BEGIN
         SELECT a.val_parametro||' '||b.val_parametro
         INTO  LV_FormatoFecha
         FROM ged_parametros a,  ged_parametros b
         WHERE a.nom_parametro='FORMATO_SEL2'
         AND a.cod_modulo='GE'
         AND a.cod_producto=1
         AND b.nom_parametro='FORMATO_SEL7'
         AND b.cod_modulo='GE'
         AND b.cod_producto=1  ;

     RETURN LV_FormatoFecha;
        EXCEPTION
        WHEN OTHERS THEN
           RETURN null;
END;


FUNCTION ra_consulta_parametro_fn(
                 EV_parametro IN GED_PARAMETROS.NOM_PARAMETRO%TYPE,
                 EV_modulo        IN GED_PARAMETROS.COD_MODULO%TYPE
                 )
RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_consulta_parametro_fn"
      Lenguaje="PL/SQL"
      Fecha creación="8-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Error</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_parametro" Tipo="CARACTER">parametro que se desea consultar</param>
            <param nom="EV_modulo" Tipo="CARACTER">codigo de Modulo</param>
         <Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS
    LV_valor VARCHAR2(30);
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN

        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;


        LV_sSql :=  'SELECT a.val_parametro FROM GED_PARAMETROS a WHERE a.nom_parametro =' || EV_parametro||
                    'AND a.cod_modulo = '|| EV_modulo ||
                                'AND a.cod_producto ='|| CN_uno;

         SELECT a.val_parametro
           INTO LV_valor
           FROM GED_PARAMETROS a
          WHERE a.nom_parametro = EV_parametro
            AND a.cod_modulo = EV_modulo
            AND a.cod_producto = CN_uno;


      RETURN LV_valor;

EXCEPTION
         WHEN OTHERS THEN


                LN_cod_retorno := 624;--Error al Obtener Parametro
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno :=  CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:RA_CONSULTA_PARAMETRO_FN ('||EV_parametro ||','||EV_modulo||')- '||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo  ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CONSULTA_PARAMETRO_FN',
                                              LV_sSql , SQLCODE, LV_des_error );
                RETURN  LV_mens_retorno;


END ra_consulta_parametro_fn;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ra_consultaUsuario_pr(
    tUsuario               OUT NOCOPY refcursor,
    SV_mens_retorno    OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "rt_consultaUsuario_pr"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Usuario</) escripción>
      <Parámetros>
         <Salida>
            <param nom="tUsuario" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;

BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;


        LV_sSql := 'SELECT a.nom_usuario, a.nom_operador  FROM ge_seg_usuario a';

    OPEN tUsuario FOR
    SELECT a.nom_usuario, a.nom_operador
          FROM ge_seg_usuario a;

   EXCEPTION

      WHEN OTHERS THEN

                   LN_cod_retorno := 625;--Error al recuperar Usuarios
           IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                  LV_mens_retorno := CV_error_no_clasif;
           END IF;
           LV_des_error:='error_ejec_omensaje:RA_CONSULTAUSUARIO_PR- '||sqlerrm;
           LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CONSULTAUSUARIO_PR',
                                                 LV_sSql , SQLCODE, LV_des_error );
                   SV_mens_retorno := LV_mens_retorno;


END ra_consultaUsuario_pr;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ra_consultaoficina_pr (
    tOficina          OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "rt_consultaoficina_pr"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Oficina</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tOficina" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
                 </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql := 'SELECT a.cod_oficina, a.des_oficina  FROM ge_oficinas a WHERE ind_oficina = '|| CN_cero;


     OPEN tOficina FOR
         SELECT a.cod_oficina, a.des_oficina
           FROM ge_oficinas a
          WHERE ind_oficina = CN_cero;

EXCEPTION

         WHEN OTHERS THEN

                   LN_cod_retorno := 626;--Error al Recuperar Oficinas
           IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                  LV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error:='error_ejec_omensaje:RA_CONSULTAOFICINA_PR - '||sqlerrm;
           LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CONSULTAOFICINA_PR',
                                                 LV_sSql , SQLCODE, LV_des_error );

                   SV_mens_retorno := LV_mens_retorno;

END ra_consultaoficina_pr ;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

FUNCTION ra_consultasysdate_pr (
    EV_formato          IN  VARCHAR2,
    EV_dias         IN  VARCHAR2,
        EV_FecDesde     IN  VARCHAR2
)
RETURN VARCHAR2

/*
<Documentación
  TipoDoc = "Function">
   <Elemento
      Nombre = "ra_consultasysdate_pr"
      Lenguaje="PL/SQL"
      Fecha creación="03-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera fecha actual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_formato" Tipo="CARACTER">formato de Fecha</param>
            <param nom="EV_dias" Tipo="CARACTER">dias que se quieren restar</param>
            <param nom="EV_FecDesde" Tipo="CARACTER">Fecha Desde</param>
         </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        SD_sysdate VARCHAR2(30);

BEGIN

        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;
        LV_sSql := '';


        IF EV_FecDesde =  '' or  EV_FecDesde is NULL   THEN
        SD_sysdate := TO_CHAR(SYSDATE - EV_dias ,EV_FORMATO);
        ELSE
            SD_sysdate := TO_CHAR(TO_DATE(EV_FecDesde ,EV_formato) + EV_dias, EV_formato);
        END IF;


        RETURN SD_sysdate;


EXCEPTION
       WHEN OTHERS THEN

                   LN_cod_retorno := 627;--Error al recuperar Fecha
           IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                  LV_mens_retorno := CV_error_no_clasIF;
           END IF;
           LV_des_error:='error_ejec_omensaje:RA_CONSULTASYSDATE_PR ('|| EV_formato || ',' ||EV_dias||',' ||EV_FecDesde ||')- '||sqlerrm;
           LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CONSULTASYSDATE_PR',
                                                 LV_sSql , SQLCODE, LV_des_error );

                   RETURN LV_mens_retorno;

END ra_consultasysdate_pr ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ra_Ingresa_Auditoria_pr(
        EV_tip_audit     IN  VARCHAR2,
        EV_valor_ant     IN      RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue     IN  RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso               IN      RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit    IN      VARCHAR2,
        EV_correlativo   IN      VARCHAR2,
    SV_mens_retorno  OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "rt_IngresaAuditoria_pr"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Ingresa Auditoria</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EN_proc_audit"  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EN_correlativo"  Tipo="CARACTER">Proceso que se ejecuta</param>
         </Entrada>
         <Salida>
            <param nom="SV_retorno" Tipo="NUMERICO">Codigo de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
AS
        ERROR_PROCESO EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
BEGIN

        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

    LV_sSql := 'INSERT INTO RA_AUDITORIA_TRIBUTARIA_TO (id_audit, fec_audit, nom_usuario, tip_audit, valor_ant, valor_nue, proceso_audit, proc_audit, correlativo ) VALUES ('
                                || 'ra_reporte_auditoria_sq.NEXTVAL ,' || SYSDATE ||' ,' || USER||','|| EV_tip_audit|| ','
                                || EV_valor_ant ||',' || EV_valor_nue ||','|| EV_proceso||','|| EV_proc_audit||',' ||EV_correlativo||')';

        INSERT INTO RA_AUDITORIA_TRIBUTARIA_TO
                    (id_audit, fec_audit, nom_usuario, tip_audit, valor_ant,
                     valor_nue, proceso_audit, proc_audit, correlativo
                    )
             VALUES (ra_reporte_auditoria_sq.NEXTVAL, SYSDATE, USER, EV_tip_audit, EV_valor_ant,
                     EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo
                    );


   EXCEPTION
       WHEN OTHERS THEN

                   LN_cod_retorno := 628;--Error al Ingresar Auditoria
           IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                  LV_mens_retorno := CV_error_no_clasIF;
           END IF;
               LV_des_error:='error_ejec_omensaje:RA_INGRESA_AUDITORIA_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||',' || EV_proceso ||') - '||sqlerrm;
           LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                 CV_version||'.'||CV_subversion,
                                                 USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_INGRESA_AUDITORIA_PR',
                                                 LV_sSql , SQLCODE, LV_des_error );

                   SV_mens_retorno := LV_mens_retorno;


END ra_Ingresa_Auditoria_pr;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ra_ingreso_caja_total_pr (
        EV_tip_audit   IN VARCHAR2,
        EV_valor_ant   IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue   IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso         IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tCaja           OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2

)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_ingreso_caja_total_pr"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte Caja Total</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit"  Tipo="CARACTER">codigo de Proceso Auditado</param>
            <param nom="EV_correlativo "  Tipo="CARACTER">correlativo</param>
            <param nom="EV_usuario "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_oficina "  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formarto "  Tipo="CARACTER">Formato Fecha</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS
        ERROR_PROCESO EXCEPTION;
        NO_HAY_DATOS  EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count        NUMBER;
        LV_retorno  NUMBER;

BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql := 'SELECT   a.oficina OFICINA, a.des_caja CAJA, a.nom_usuarora USUARIO, a.des_movcaja MOVIMIENTO_CAJA, a.des_valor TIPO,'
                         ||' a.num_secuencipag SECUENCIA_PAGO, a.cod_cliente CLIENTE, a.cod_banco BANCO,'
                         ||' a.num_cheque NRO_CHEQUE, a.des_tiptarjeta TIPO_TARJETA, a.num_tarjeta NRO_TARJETA,'
                         ||' a.cod_autoriza AUTORIZACION, a.ind_deposito IND_DEPOSITO, a.ind_erroneo IND_ERRONEO,'
                         ||'TRUNC (a.fec_efectividad) FECHA, SUM (a.importe) IMPORTE'
                         ||' FROM CO_VIEWHISTMOVI a'
                         ||'WHERE TRUNC(a.fec_efectividad) >= TO_DATE(' ||EV_fecdesde|| ','|| EV_formato||' )'
                         ||'  AND  TRUNC(a.fec_efectividad) <= TO_DATE('||EV_fechasta||',' ||EV_formato|| ' )'
                         ||'  AND a.cod_oficina = DECODE ('||EV_oficina||', NULL, a.cod_oficina,'|| EV_oficina||')'
                         ||'  AND a.nom_usuarora = DECODE ('||EV_usuario||', NULL, a.nom_usuarora,'|| EV_usuario||')'
                         ||' GROUP BY a.oficina, a.des_caja,a.nom_usuarora, a.des_movcaja,a.des_valor,a.num_secuencipag,'
                         ||' a.cod_cliente, a.cod_banco, a.num_cheque, a.des_tiptarjeta,a.num_tarjeta,a.cod_autoriza,'
                         ||' a.ind_deposito, a.ind_erroneo,TRUNC (a.fec_efectividad)';


         ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso,EV_proc_audit, EV_correlativo, LV_retorno );
         IF LV_retorno = '' or LV_retorno IS NULL  THEN

                                OPEN tCaja FOR
                                SELECT   a.oficina OFICINA, a.des_caja CAJA, a.nom_usuarora USUARIO,
                                         a.des_movcaja MOVIMIENTO_CAJA, a.des_valor TIPO,
                                         a.num_secuencipag SECUENCIA_PAGO, a.cod_cliente CLIENTE, a.cod_banco BANCO,
                                         a.num_cheque NRO_CHEQUE, a.des_tiptarjeta TIPO_TARJETA,
                                         a.num_tarjeta NRO_TARJETA, a.cod_autoriza AUTORIZACION,
                                         a.ind_deposito IND_DEPOSITO, a.ind_erroneo IND_ERRONEO,
                                         TRUNC (a.fec_efectividad) FECHA, SUM (a.importe) IMPORTE
                                    FROM CO_VIEWHISTMOVI a
                                        WHERE TRUNC(a.fec_efectividad) >= TO_DATE(EV_fecdesde, EV_formato )
                                     AND  TRUNC(a.fec_efectividad) <= TO_DATE(EV_fechasta, EV_formato )
                                     AND a.cod_oficina = DECODE (EV_oficina, NULL, a.cod_oficina, EV_oficina)
                                     AND a.nom_usuarora = DECODE (EV_usuario, NULL, a.nom_usuarora, EV_usuario)
                                GROUP BY a.oficina,
                                                 a.des_caja,
                                         a.nom_usuarora,
                                         a.des_movcaja,
                                         a.des_valor,
                                         a.num_secuencipag,
                                         a.cod_cliente,
                                         a.cod_banco,
                                         a.num_cheque,
                                         a.des_tiptarjeta,
                                         a.num_tarjeta,
                                         a.cod_autoriza,
                                         a.ind_deposito,
                                         a.ind_erroneo,
                                         TRUNC (a.fec_efectividad);

         ELSE
                 RAISE  ERROR_PROCESO;
         END IF;

EXCEPTION
         WHEN ERROR_PROCESO THEN
                SV_mens_retorno := LV_retorno;

     WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Datos
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                         LV_mens_retorno := CV_error_no_clasIF;
              END IF;
              LV_des_error:='error_ejec_omensaje:RA_INGRESO_CAJA_TOTAL_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
                  || EV_proceso ||',' || EV_proc_audit ||','|| EV_correlativo ||',' || EV_usuario ||',' || EV_oficina ||',' || EV_fecdesde ||',' || EV_fechasta ||') - '||sqlerrm;
                    LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                          CV_version||'.'||CV_subversion,
                                                          USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_INGRESO_CAJA_TOTAL_PR',
                                                          LV_sSql , SQLCODE, LV_des_error );
                  SV_mens_retorno := LN_cod_retorno;

END ra_ingreso_caja_total_pr ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ra_consolidado_mensual_caja_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit IN VARCHAR2,
        EV_correlativo   IN      VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tCaja         OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "rt_consolidado_mensual_caja_pr"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit"  Tipo="CARACTER">codigo de Proceso Auditado</param>
            <param nom="EV_correlativo "  Tipo="CARACTER">correlativo</param>
            <param nom="EV_usuario "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_oficina "  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formarto "  Tipo="CARACTER">Formato Fecha</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);


BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql := ' SELECT  TO_CHAR (a.fec_efectividad, ''MM'') MES, a.oficina OFICINA, a.des_caja CAJA, a.nom_usuarora USUARIO,'
                         ||' a.des_movcaja MOVIMIENTO_CAJA, a.des_valor TIPO, SUM (a.importe) IMPORTE'
                         ||'    FROM CO_VIEWHISTMOVI a'
                         ||'   WHERE TRUNC(a.fec_efectividad) >= TO_DATE('||EV_fecdesde||','||EV_formato||')'
                         ||'     AND TRUNC(a.fec_efectividad) <= TO_DATE('||EV_fechasta||',' ||EV_formato||')'
                         ||'     AND a.cod_oficina = DECODE ('||EV_oficina||', NULL, a.cod_oficina,'|| EV_oficina||')'
                         ||'     AND a.nom_usuarora = DECODE (EV_usuario, NULL, a.nom_usuarora, EV_usuario)'
                         ||'GROUP BY a.fec_efectividad,a.oficina,a.des_caja, a.nom_usuarora, a.des_movcaja, a.des_valor';

         ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
         IF LV_retorno = '' or LV_retorno IS NULL  THEN

                        OPEN tCaja FOR
                                SELECT   TO_CHAR (a.fec_efectividad, 'MM') MES, a.oficina OFICINA, a.des_caja CAJA, a.nom_usuarora USUARIO,
                                         a.des_movcaja MOVIMIENTO_CAJA, a.des_valor TIPO, SUM (a.importe) IMPORTE
                                    FROM CO_VIEWHISTMOVI a
                                   WHERE TRUNC(a.fec_efectividad) >= TO_DATE(EV_fecdesde, EV_formato)
                                         AND TRUNC(a.fec_efectividad) <= TO_DATE(EV_fechasta, EV_formato)
                                     AND a.cod_oficina = DECODE (EV_oficina, NULL, a.cod_oficina, EV_oficina)
                                     AND a.nom_usuarora = DECODE (EV_usuario, NULL, a.nom_usuarora, EV_usuario)
                                GROUP BY a.fec_efectividad,
                                         a.oficina,
                                         a.des_caja,
                                         a.nom_usuarora,
                                         a.des_movcaja,
                                         a.des_valor;

         ELSE
                 RAISE  ERROR_PROCESO;
         END IF;

EXCEPTION
         WHEN ERROR_PROCESO THEN
                SV_mens_retorno := LV_retorno;
     WHEN OTHERS THEN

                LN_cod_retorno := 629;--Error al Obtener Datos
                IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                       LV_mens_retorno := CV_error_no_clasIF;
                END IF;
        LV_des_error:='error_ejec_omensaje:RA_CONSOLIDADO_MENSUAL_CAJA_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
                  || EV_proceso ||',' || EV_usuario ||',' || EV_oficina ||',' || EV_fecdesde ||',' || EV_fechasta ||') - '||sqlerrm;
                LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                      CV_version||'.'||CV_subversion,
                                                      USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CONSOLIDADO_MENSUAL_CAJA_PR',
                                                      LV_sSql , SQLCODE, LV_des_error );
            SV_mens_retorno := LN_cod_retorno;


END ra_consolidado_mensual_caja_pr ;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ra_menu_pr (
        EV_cod_programa   IN  ge_seg_perfiles.cod_programa%TYPE,
        EN_num_version    IN  ge_seg_perfiles.num_version%TYPE,
        EV_nom_usuario    IN  ge_seg_grpusuario.nom_usuario%TYPE,
        tMenu             OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_menu_pr"
      Lenguaje="PL/SQL"
      Fecha creación="31-10-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera los valores deL Menu Visual Basic</Descripción>
      <Parámetros>
                 <Entrada>
            <param nom="EV_cod_programa" Tipo="CARACTER">codigo del Programa</param>
            <param nom="EN_num_version" Tipo="NUMBER">Numero de Version</param>
            <param nom="EV_nom_usuario" Tipo="CARACTER">Nombre Ususrio</param>
                 <Entrada>
         <Salida>
            <param nom="tMenu " Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        LN_retorno  NUMBER;
        ERROR_PROCESO EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;


BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;


        LV_sSql := ' SELECT c.menu FROM GE_SEG_GRPUSUARIo a, GE_SEG_PERFILES b, GE_SEG_PROCPROG c'
                         ||' WHERE a.cod_grupo = b.cod_grupo '
                     ||' AND b.cod_programa = c.cod_programa'
                     ||' AND b.num_version = c.num_version'
                     ||' AND b.cod_proceso = c.cod_proceso'
                     ||' AND b.cod_programa = '|| EV_cod_programa
                     ||' AND b.num_version = '|| EN_num_version
                     ||' AND a.nom_usuario = '||EV_nom_usuario;

        OPEN tMenu FOR
                SELECT c.menu
                  FROM GE_SEG_GRPUSUARIo a, GE_SEG_PERFILES b, GE_SEG_PROCPROG c
                 WHERE a.cod_grupo = b.cod_grupo
                   AND b.cod_programa = c.cod_programa
                   AND b.num_version = c.num_version
                   AND b.cod_proceso = c.cod_proceso
                   AND b.cod_programa = EV_cod_programa
                   AND b.num_version = EN_num_version
                   AND a.nom_usuario = EV_nom_usuario;


EXCEPTION


     WHEN OTHERS THEN

                LN_cod_retorno := 630;--Error al obtener valores Menú
                IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                       LV_mens_retorno := CV_error_no_clasIF;
                END IF;
        LV_des_error:='error_ejec_omensaje:RA_MENU_PR('|| EV_cod_programa || ',' || EN_num_version ||',' || EV_nom_usuario ||') - '||sqlerrm;
                LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                      CV_version||'.'||CV_subversion,
                                                      USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_MENU_PR',
                                                      LV_sSql , SQLCODE, LV_des_error );
        SV_mens_retorno := LN_cod_retorno;


END ra_menu_pr ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ra_con_TipAuditoria_pr (
        EV_dominio        IN VARCHAR2,
        tTipAuditoria     OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_con_TipAuditoria_pr"
      Lenguaje="PL/SQL"
      Fecha creación="29-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera los valores del tipo de auditoria</Descripción>
      <Parámetros>
             <Entrada>
            <param nom="EV_dominio" Tipo="CARACTER">Tipo Descripcion de Dominio</param>
                 <Entrada>
         <Salida>
            <param nom="tTipAuditoria " Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO    EXCEPTION;
        CV_tipAuditoria  CONSTANT VARCHAR (20) := 'TIPO_AUDITORIA';
        CV_procAuditoria CONSTANT VARCHAR (20) := 'PROCESO_AUDITORIA';
    CV_cero                 CONSTANT VARCHAR2 (1)   := '0';
    CV_uno                  CONSTANT VARCHAR2 (1)   := '1';
    CV_dos                  CONSTANT VARCHAR2 (1)   := '2';
    CV_once                 CONSTANT VARCHAR2 (2)   := '11';
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;



        IF CV_tipAuditoria = EV_dominio THEN
        LV_sSql := 'SELECT a.valor, a.descripcion_valor'
                        || 'FROM RA_TIPO_AUDITORIA_VW a'
                    || 'WHERE a.cod_dominio ='|| EV_dominio
                || 'AND a.valor in ('||CV_cero||','|| CV_uno||','|| CV_dos||')';


                OPEN tTipAuditoria FOR
                SELECT a.valor, a.descripcion_valor
                  FROM RA_TIPO_AUDITORIA_VW a
                 WHERE a.cod_dominio = EV_dominio
               AND a.valor in (CV_cero , CV_uno, CV_dos);
        END IF;

        IF CV_procAuditoria = EV_dominio THEN
                        OPEN tTipAuditoria FOR
                        SELECT a.valor, a.descripcion_valor
                          FROM RA_PROCESO_AUDITORIA_VW a
                         WHERE a.cod_dominio = EV_dominio
                       AND a.valor in (CV_cero , CV_uno, CV_once);
    END IF;

EXCEPTION
         WHEN OTHERS THEN


                LN_cod_retorno := 631;--Error al Obtener valores de Auditoria
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno :=  CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:RA_CON_TIPAUDITORIA_PR('|| EV_dominio ||') - '||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CON_TIPAUDITORIA_PR',
                                              LV_sSql , SQLCODE, LV_des_error );
                SV_mens_retorno := LV_mens_retorno;



END ra_con_TipAuditoria_pr ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ra_con_programas_pr (
        tProgramas        OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_con_programas_pr"
      Lenguaje="PL/SQL"
      Fecha creación="29-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera el codigo y nombre de ejecutables</Descripción>
      <Parámetros>

         <Salida>
            <param nom="tProgramas " Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO    EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;


        LV_sSql := ' SELECT a.des_programa ,a.cod_programa, max(a.num_version)'
                     ||' FROM GE_PROGRAMAS a'
                         ||' GROUP BY a.cod_programa, a.des_programa';


        OPEN tProgramas FOR
          SELECT a.des_programa ,a.cod_programa, max(a.num_version)
                FROM GE_PROGRAMAS a
           GROUP BY a.cod_programa, a.des_programa;

EXCEPTION
         WHEN OTHERS THEN


                LN_cod_retorno := 632;--Error al obtener Descripcion de Programas
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno :=  CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:RA_CON_PROGRAMAS_PR  - '||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CON_PROGRAMAS_PR',
                                              LV_sSql , SQLCODE, LV_des_error );
                SV_mens_retorno := LV_mens_retorno;



END ra_con_programas_pr ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ra_con_tipDocumento_pr (
        tDocumentos       OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_con_tipDocumento_pr"
      Lenguaje="PL/SQL"
      Fecha creación="29-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Tipos De documentos</Descripción>
      <Parámetros>
         <Salida>
            <param nom="tDocumentos " Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        CN_18              CONSTANT PLS_INTEGER   := 18;
        CN_25              CONSTANT PLS_INTEGER   := 25;
        CN_35              CONSTANT PLS_INTEGER   := 35;
        CN_69              CONSTANT PLS_INTEGER   := 69;
        CN_70              CONSTANT PLS_INTEGER   := 70;
BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql := 'SELECT a.cod_tipdocum, a.des_tipdocum  FROM GE_TIPDOCUMEN a'
                         ||'WHERE  cod_tipdocum in  ('|| CN_uno||','||CN_dos||','||CN_18||','||CN_25||','||CN_35||','||CN_69||','||CN_70||')';


        OPEN tDocumentos FOR
        SELECT a.cod_tipdocum, a.des_tipdocum
          FROM GE_TIPDOCUMEN a
        WHERE  cod_tipdocum in  ( CN_uno,CN_dos,CN_18,CN_25,CN_35,CN_69,CN_70);


EXCEPTION
         WHEN OTHERS THEN


                LN_cod_retorno := 633;--Error al obtener los tipos de Documentos
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno :=  CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:ra_con_tipDocumento_pr'||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.ra_con_tipDocumento_pr',
                                              LV_sSql , SQLCODE, LV_des_error );
                SV_mens_retorno := LV_mens_retorno;



END ra_con_tipDocumento_pr ;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE ra_con_UsuarioOficina_pr (
        EV_codprograma    IN  GE_PROGRAMAS.COD_PROGRAMA%TYPE,
        EV_version        IN  VARCHAR2,
        tUsuario          OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_con_UsuarioOficina_pr
      Lenguaje="PL/SQL"
      Fecha creación="29-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera el codigo y nombre de ejecutables</Descripción>
      <Parámetros>
                 <Entrada>
            <param nom="EV_codprograma" Tipo="CARACTER">codigo de programa</param>
                    <param nom="EN_version" Tipo="NUMERICO">Numero de version</param>
         <Entrada>
         <Salida>
            <param nom="tUsuario " Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO    EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_Pos1             INTEGER;
        LV_Grupo            VARCHAR2(100);
        LV_CodGrupo                     VARCHAR2(100);
        LV_Grp                          VARCHAR2(100);


BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;


        LV_sSql := 'SELECT  c.nom_usuario, c.nom_operador, d.cod_oficina, d.des_oficina'
                || ' FROM  GE_OFICINAS d, GE_SEG_GRPUSUARIO b, GE_SEG_USUARIO c'
                || 'WHERE  c.cod_oficina = d.cod_oficina'
                        || ' AND  c.nom_usuario=b.nom_usuario  AND  exists  (SELECT 1'
                        || ' FROM GE_SEG_PERFILES a '
                        || 'WHERE a.cod_programa ='|| EV_codprograma
                        || '  AND a.num_version  ='|| EV_version
                        || 'AND b.cod_grupo=a.cod_grupo)';


        OPEN tUsuario FOR
        SELECT  c.nom_usuario, c.nom_operador, d.cod_oficina, d.des_oficina
      FROM  GE_OFICINAS d, GE_SEG_GRPUSUARIO b, GE_SEG_USUARIO c
     WHERE  c.cod_oficina = d.cod_oficina
           AND  c.nom_usuario=b.nom_usuario
           AND  exists  (SELECT 1
                                           FROM GE_SEG_PERFILES a
                                          WHERE a.cod_programa = EV_codprograma
                                            AND a.num_version  = EV_version
                                                AND b.cod_grupo=a.cod_grupo);


EXCEPTION
         WHEN OTHERS THEN


                LN_cod_retorno := 629;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno := CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:ra_con_UsuarioOficina_pr'||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.ra_con_UsuarioOficina_pr',
                                              LV_sSql , SQLCODE, LV_des_error );
                SV_mens_retorno := LV_mens_retorno;



END ra_con_UsuarioOficina_pr ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ra_DocTributario_mensual_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        EV_foliodesde IN VARCHAR2,
        EV_foliohasta IN VARCHAR2,
        EV_tipoDoc    IN VARCHAR2,
        tTributario     OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_DocTributario_mensual_pr"
      Lenguaje="PL/SQL"
      Fecha creación="02-12-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit"  Tipo="CARACTER">codigo de Proceso Auditado</param>
            <param nom="EV_correlativo "  Tipo="CARACTER">correlativo</param>
            <param nom="EV_usuario "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_oficina "  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formarto "  Tipo="CARACTER">Formato Fecha</param>
            <param nom="EV_foliodesde "  Tipo="CARACTER">folio desde</param>
            <param nom="EV_foliohasta "  Tipo="CARACTER">folio Hasta</param>
            <param nom="EV_tipoDoc "  Tipo="CARACTER">fecha desde</param>
         </Entrada>
         <Salida>
            <param nom="tTributario" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);



BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;


        LV_sSql  := 'SELECT TO_CHAR(a.fec_emision, ''MM'') MES, ra_autoriza_fn(TO_CHAR(a.fec_emision,DD-MM-YYYY) , EV_formato )NRO_AUTORIZACION,'
                         ||' a.num_folio NRO_COMPROBANTE, a.cod_tipdocum TIPO_DOCUMENTO, f.des_tipdocum DOCUMENTO, a.cod_cliente CLIENTE,'
             ||' b.nom_cliente || ||b.nom_apeclien1|| ||b.nom_apeclien2  NOMBRE, b.num_ident  NRO_IDENTIFICACION,  b.cod_tipident ,'
                         ||' g.des_tipident TIPO_IDENTIFICACION, a.acum_netograv BASE_IMPONIBLE, a.ACUM_IVA IMPUESTO, a.tot_descuento TOTAL_DESCUENTOS,'
                         ||' a.fec_emision FECHA_EMISION, a.fec_vencimie FECHA_VENCIMIENTO, a.nom_usuarora USUARIO_GENERACION, d.nom_operador NOM_USUARIO_GENERACION,'
                         ||' a.cod_vendedor USUARIO_SOLICITADOC, c.nom_vendedor NOMUSUARIO_SOLICITADOC, a.cod_oficina,  e.des_oficina OFICINA'
                         ||' FROM fa_histdocu a, ge_clientes b, ve_vendedores c, ge_seg_usuario d,ge_oficinas e, ge_tipdocumen f, ge_tipident g'
                         ||' WHERE a.num_secuenci >0'
                         ||' AND f.cod_tipdocum=a.cod_tipdocum'
                         ||' AND a.cod_tipdocum = DECODE (EV_tipoDoc, NULL, a.cod_tipdocum, EV_tipoDoc)'
                         ||' AND c.cod_vendedor=a.COD_VENDEDOR_AGENTE'
                         ||' AND TRUNC(a.fec_emision) >= TO_DATE('||EV_fecdesde||','|| EV_formato||')'
                         ||' AND TRUNC(a.fec_emision) <= TO_DATE('||EV_fechasta||','|| EV_formato||')'
                         ||' AND a.num_folio >= DECODE ('||EV_foliodesde||', NULL, a.num_folio,'|| EV_foliodesde||')'
                         ||' AND a.num_folio <= DECODE ('||EV_foliohasta||', NULL,a.num_folio, '||EV_foliohasta||')'
                         ||' AND a.nom_usuarora = DECODE ('||EV_usuario||', NULL, a.nom_usuarora,'|| EV_usuario||')'
                         ||' AND b.cod_cliente=a.cod_cliente'
                         ||' AND e.cod_oficina= DECODE ('||EV_oficina||', NULL, a.cod_oficina,'|| EV_oficina||')'
                         ||' AND e.cod_oficina=a.cod_oficina'
                         ||' AND d.nom_usuario= a.nom_usuarora'
                         ||' AND g.cod_tipident=b.cod_tipident';




        ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
        IF LV_retorno = '' or LV_retorno IS NULL  THEN
        OPEN tTributario FOR


                                SELECT TO_CHAR(a.fec_emision, 'MM') MES,
                                       ra_autoriza_fn(TO_CHAR(a.fec_emision,'DD-MM-YYYY') , EV_formato )NRO_AUTORIZACION,
                                           a.num_folio NRO_COMPROBANTE,
                                       a.cod_tipdocum TIPO_DOCUMENTO,
                                           f.des_tipdocum DOCUMENTO,
                                           a.cod_cliente CLIENTE,
                                           b.nom_cliente||' '||b.nom_apeclien1||' '||b.nom_apeclien2  NOMBRE,
                                           b.num_ident  NRO_IDENTIFICACION,
                                           b.cod_tipident ,
                                           g.des_tipident TIPO_IDENTIFICACION,
                                           a.acum_netograv BASE_IMPONIBLE,
                                           a.ACUM_IVA IMPUESTO,
                                           a.tot_descuento TOTAL_DESCUENTOS,
                                           a.fec_emision FECHA_EMISION,
                                           a.fec_vencimie FECHA_VENCIMIENTO ,
                                           a.nom_usuarora USUARIO_GENERACION,
                                           d.nom_operador NOM_USUARIO_GENERACION,
                                           a.cod_vendedor USUARIO_SOLICITADOC,
                                           c.nom_vendedor NOMUSUARIO_SOLICITADOC,
                                           a.cod_oficina,
                                           e.des_oficina OFICINA
                                FROM fa_histdocu a, ge_clientes b, ve_vendedores c, ge_seg_usuario d,
                                ge_oficinas e, ge_tipdocumen f, ge_tipident g
                                WHERE a.num_secuenci > CN_cero
                                AND f.cod_tipdocum=a.cod_tipdocum
                                AND a.cod_tipdocum = DECODE (EV_tipoDoc, NULL, a.cod_tipdocum, EV_tipoDoc)
                                AND c.cod_vendedor=a.COD_VENDEDOR_AGENTE
                                AND TRUNC(a.fec_emision) >= TO_DATE(EV_fecdesde, EV_formato)
                                AND TRUNC(a.fec_emision) <= TO_DATE(EV_fechasta, EV_formato)
                                AND a.num_folio >= DECODE (EV_foliodesde, NULL, a.num_folio, EV_foliodesde)
                                AND a.num_folio <= DECODE (EV_foliohasta, NULL,a.num_folio, EV_foliohasta)
                            AND a.nom_usuarora = DECODE (EV_usuario, NULL, a.nom_usuarora, EV_usuario)
                                AND b.cod_cliente=a.cod_cliente
                            AND e.cod_oficina= DECODE (EV_oficina, NULL, a.cod_oficina, EV_oficina)
                                AND e.cod_oficina=a.cod_oficina
                                AND d.nom_usuario= a.nom_usuarora
                                AND g.cod_tipident=b.cod_tipident;
        ELSE
                RAISE ERROR_PROCESO;
        END IF;



   EXCEPTION
      WHEN ERROR_PROCESO THEN
                   SV_mens_retorno := LV_retorno;

            WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Información
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_error_no_clasIF;
          END IF;

                  LV_des_error:='error_ejec_omensaje:RA_DOCTRIBUTARIO_MENSUAL_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
              || EV_proceso ||',' || EV_usuario ||',' || EV_oficina ||',' || EV_fecdesde ||',' || EV_fechasta || ',' ||EV_formato||','||EV_foliodesde||','||EV_foliohasta|| ','
                  ||EV_tipoDoc||') - '||sqlerrm;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_DOCTRIBUTARIO_MENSUAL_PR',
                                                LV_sSql , SQLCODE, LV_des_error );

                  SV_mens_retorno := LN_cod_retorno;


END ra_DocTributario_mensual_pr ;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE ra_DocTributario_total_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_oficina    IN ge_oficinas.cod_oficina%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        EV_foliodesde IN VARCHAR2,
        EV_foliohasta IN VARCHAR2,
        EV_tipoDoc    IN VARCHAR2,
        tTributario     OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "rt_consolidado_mensual_caja_pr"
      Lenguaje="PL/SQL"
      Fecha creación="02-12-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_usuario "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_oficina "  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);



BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

                LV_sSql  := 'SELECT  ra_autoriza_fn(TO_CHAR(a.fec_emision,DD-MM-YYYY) , EV_formato )NRO_AUTORIZACION,'
                         ||' a.num_folio NRO_COMPROBANTE, a.cod_tipdocum TIPO_DOCUMENTO, f.des_tipdocum DOCUMENTO, a.cod_cliente CLIENTE,'
             ||' b.nom_cliente||||b.nom_apeclien1||||b.nom_apeclien2  NOMBRE, b.num_ident  NRO_IDENTIFICACION,  b.cod_tipident ,'
                         ||' g.des_tipident TIPO_IDENTIFICACION, a.acum_netograv BASE_IMPONIBLE, a.ACUM_IVA IMPUESTO, a.tot_descuento TOTAL_DESCUENTOS,'
                         ||' a.fec_emision FECHA_EMISION, a.fec_vencimie FECHA_VENCIMIENTO, a.nom_usuarora USUARIO_GENERACION, d.nom_operador NOM_USUARIO_GENERACION,'
                         ||' a.cod_vendedor USUARIO_SOLICITADOC, c.nom_vendedor NOMUSUARIO_SOLICITADOC, a.cod_oficina,  e.des_oficina OFICINA'
                         ||' FROM fa_histdocu a, ge_clientes b, ve_vendedores c, ge_seg_usuario d,ge_oficinas e, ge_tipdocumen f, ge_tipident g'
                         ||' WHERE a.num_secuenci >0'
                         ||' AND f.cod_tipdocum=a.cod_tipdocum'
                         ||' AND a.cod_tipdocum = DECODE (EV_tipoDoc, NULL, a.cod_tipdocum, EV_tipoDoc)'
                         ||' AND c.cod_vendedor=a.COD_VENDEDOR_AGENTE'
                         ||' AND TRUNC(a.fec_emision) >= TO_DATE('||EV_fecdesde||','|| EV_formato||')'
                         ||' AND TRUNC(a.fec_emision) <= TO_DATE('||EV_fechasta||','|| EV_formato||')'
                         ||' AND a.num_folio >= DECODE ('||EV_foliodesde||', NULL, a.num_folio,'|| EV_foliodesde||')'
                         ||' AND a.num_folio <= DECODE ('||EV_foliohasta||', NULL,a.num_folio, '||EV_foliohasta||')'
                         ||' AND a.nom_usuarora = DECODE ('||EV_usuario||', NULL, a.nom_usuarora,'|| EV_usuario||')'
                         ||' AND b.cod_cliente=a.cod_cliente'
                         ||' AND e.cod_oficina= DECODE ('||EV_oficina||', NULL, a.cod_oficina,'|| EV_oficina||')'
                         ||' AND e.cod_oficina=a.cod_oficina'
                         ||' AND d.nom_usuario= a.nom_usuarora'
                         ||' AND g.cod_tipident=b.cod_tipident';


        ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
        IF LV_retorno = '' or LV_retorno IS NULL  THEN
        OPEN tTributario FOR


                                SELECT ra_autoriza_fn(TO_CHAR(a.fec_emision,'DD-MM-YYYY') , EV_formato )NRO_AUTORIZACION,
                                           a.num_folio NRO_COMPROBANTE,
                                       a.cod_tipdocum TIPO_DOCUMENTO,
                                           f.des_tipdocum DOCUMENTO,
                                           a.cod_cliente CLIENTE,
                                           b.nom_cliente||' '||b.nom_apeclien1||' '||b.nom_apeclien2  NOMBRE,
                                           b.num_ident  NRO_IDENTIFICACION,
                                           b.cod_tipident ,
                                           g.des_tipident TIPO_IDENTIFICACION,
                                           a.acum_netograv BASE_IMPONIBLE,
                                           a.ACUM_IVA IMPUESTO,
                                           a.tot_descuento TOTAL_DESCUENTOS,
                                           a.fec_emision FECHA_EMISION,
                                           a.fec_vencimie FECHA_VENCIMIENTO ,
                                           a.nom_usuarora USUARIO_GENERACION,
                                           d.nom_operador NOM_USUARIO_GENERACION,
                                           a.cod_vendedor USUARIO_SOLICITADOC,
                                           c.nom_vendedor NOMUSUARIO_SOLICITADOC,
                                           a.cod_oficina,
                                           e.des_oficina OFICINA
                                FROM fa_histdocu a, ge_clientes b, ve_vendedores c, ge_seg_usuario d,
                                ge_oficinas e, ge_tipdocumen f, ge_tipident g
                                WHERE a.num_secuenci > 0
                                AND f.cod_tipdocum=a.cod_tipdocum
                                AND a.cod_tipdocum = DECODE (EV_tipoDoc, NULL, a.cod_tipdocum, EV_tipoDoc)
                                AND c.cod_vendedor=a.COD_VENDEDOR_AGENTE
                                AND TRUNC(a.fec_emision) >= TO_DATE(EV_fecdesde, EV_formato)
                                AND TRUNC(a.fec_emision) <= TO_DATE(EV_fechasta, EV_formato)
                                aND a.num_folio >= DECODE (EV_foliodesde, NULL, a.num_folio, EV_foliodesde)
                                AND a.num_folio <= DECODE (EV_foliohasta, NULL,a.num_folio, EV_foliohasta)
                            AND a.nom_usuarora = DECODE (EV_usuario, NULL, a.nom_usuarora, EV_usuario)
                                aND b.cod_cliente=a.cod_cliente
                            AND e.cod_oficina= DECODE (EV_oficina, NULL, a.cod_oficina, EV_oficina)
                                AND e.cod_oficina=a.cod_oficina
                                AND d.nom_usuario= a.nom_usuarora
                                AND g.cod_tipident=b.cod_tipident;
        ELSE
                RAISE ERROR_PROCESO;
        END IF;



   EXCEPTION
      WHEN ERROR_PROCESO THEN
                   SV_mens_retorno := LV_retorno;

            WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Información
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_error_no_clasIF;
          END IF;
                  LV_des_error:='error_ejec_omensaje:RA_DOCTRIBUTARIO_TOTAL_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
              || EV_proceso ||',' || EV_usuario ||',' || EV_oficina ||',' || EV_fecdesde ||',' || EV_fechasta || ',' ||EV_formato||','||EV_foliodesde||','||EV_foliohasta|| ','
                  ||EV_tipoDoc||') - '||sqlerrm;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_DOCTRIBUTARIO_TOTAL_PR',
                                                LV_sSql , SQLCODE, LV_des_error );

                  SV_mens_retorno := LN_cod_retorno;


END ra_DocTributario_total_pr ;

FUNCTION ra_autoriza_fn(
                 EV_fechaEmision    IN VARCHAR2,
                 EV_formato         IN VARCHAR2
                 )
RETURN AL_AUTORIZACION_FOLIO_TD.COD_AUTORIZACION%TYPE
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_consulta_parametro_fn"
      Lenguaje="PL/SQL"
      Fecha creación="8-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Error</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EV_parametro" Tipo="CARACTER">parametro que se desea consultar</param>
         <Entrada>
         <Salida>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

IS
        LV_autorizacion     AL_AUTORIZACION_FOLIO_TD.COD_AUTORIZACION%TYPE;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;


BEGIN

        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql := '  SELECT a.cod_autorizacion FROM AL_AUTORIZACION_FOLIO_TD a'
                         ||'   WHERE  a.fec_desde <=  TO_DATE ('||EV_fechaEmision||','|| EV_formato||' )'
                         ||'     AND   a.fec_termino >= TO_DATE ('||EV_fechaEmision||','||EV_formato||' )';

  SELECT a.cod_autorizacion
        INTO LV_autorizacion
        FROM AL_AUTORIZACION_FOLIO_TD a
   WHERE  a.fec_desde <=  TO_DATE (EV_fechaEmision, EV_formato )
         AND   a.fec_termino >= TO_DATE (EV_fechaEmision,EV_formato );

    RETURN LV_autorizacion;

EXCEPTION
         WHEN OTHERS THEN

                LN_cod_retorno := 634;--Error en obtener Codigo de Autorizacion
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno :=  CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:RA_AUTORIZA_FN (' ||EV_fechaEmision || ') - '||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo  ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_AUTORIZA_FN',
                                              LV_sSql , SQLCODE, LV_des_error );
                RETURN  LV_mens_retorno;


END ra_autoriza_fn;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------


PROCEDURE ra_Parametro_impuesto_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_tipo        IN VARCHAR2,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tImpuesto     OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_Parametros_tributarios_pr"
      Lenguaje="PL/SQL"
      Fecha creación="02-12-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_correlativo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_proc"  Tipo="CARACTER">oficina</param>
            <param nom="EV_tipo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formato "  Tipo="CARACTER">fecha Hasta</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);
        LV_FormatoFecha     VARCHAR2(45);



BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

    LV_FormatoFecha:=ra_formato_fecha;


        LV_sSql := 'SELECT TO_CHAR(a.fec_audit,EV_formato) FECHA_AUDITORIA, a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,'
                         ||'DECODE(a.proc_audit,0,INTERESES,1,IMPUESTOS) PROCESO_AUDITADO,'
                         ||'DECODE(a.tip_audit,0,INGRESAR,1,ELIMINAR,2,MODIFICAR) ACCION,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1) C1,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2) C2,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3) C3,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4) C4,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,5) C5,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,6) C6,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,7) C7,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,8) C8,'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,9) C9'
                         ||'FROM RA_AUDITORIA_TRIBUTARIA_TO a, GE_SEG_USUARIo b  '
                         ||'WHERE a.proc_audit=1'
                         ||'AND a.tip_audit in (0, 1,2)'
                         ||'AND a.tip_audit = DECODE ('||EV_tipo||', NULL, a.tip_audit,'|| EV_tipo||')'
                         ||'AND TRUNC(a.fec_audit) >= TO_DATE('||EV_fecdesde||', '||EV_formato||')'
                         ||'AND TRUNC(a.fec_audit) <= TO_DATE('||EV_fechasta||', '||EV_formato||')'
                         ||'AND a.nom_usuario=b.nom_usuario'
                     ||'ORDER BY ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1),'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2),'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3),'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4),'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,5),'
                         ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,6), a.fec_audit,a.correlativo';

        ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
        IF LV_retorno = '' or LV_retorno IS NULL  THEN
        OPEN tImpuesto  FOR


                        SELECT TO_CHAR(a.fec_audit,LV_FormatoFecha) FECHA_AUDITORIA,
                               a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,
                               DECODE(a.proc_audit,0,'INTERESES',1,'IMPUESTOS') PROCESO_AUDITADO,
                               DECODE(a.tip_audit,0,'INGRESAR',1,'ELIMINAR',2,'MODIFICAR') ACCION,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1) C1,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2) C2,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3) C3,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4) C4,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,5) C5,
                                   SUBSTR(ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,6),1,10) C6,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,7) C7,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,8) C8,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,9) C9
                        FROM RA_AUDITORIA_TRIBUTARIA_TO a, GE_SEG_USUARIO b
                        WHERE a.proc_audit=CN_uno
                        AND a.tip_audit in (CN_cero, CN_uno,CN_dos)
                        AND a.tip_audit = DECODE (EV_tipo, NULL, a.tip_audit, EV_tipo)
                        AND TRUNC(a.fec_audit) >= TO_DATE(EV_fecdesde, EV_formato)
                        AND TRUNC(a.fec_audit) <= TO_DATE(EV_fechasta, EV_formato)
                        AND a.nom_usuario=b.nom_usuario
                        ORDER BY ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1),
                                 ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2),
                                 ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3),
                                 ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4),
                                 ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,5),
                                 ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,6),
                                         a.fec_audit,a.correlativo;

        ELSE
                RAISE ERROR_PROCESO;
        END IF;



   EXCEPTION
      WHEN ERROR_PROCESO THEN
                   SV_mens_retorno := LV_retorno;

            WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Información
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_error_no_clasIF;
          END IF;

                  LV_des_error:='error_ejec_omensaje:RA_PARAMETRO_IMPUESTO_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
              || EV_proceso ||',' ||EV_proc_audit||',' || EV_correlativo ||',' || EV_proc ||',' || EV_tipo ||',' || EV_fecdesde ||',' || EV_fechasta || ',' ||EV_formato||
                  ') - '||sqlerrm;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_PARAMETRO_IMPUESTO_PR',
                                                LV_sSql , SQLCODE, LV_des_error );

                  SV_mens_retorno := LN_cod_retorno;


END ra_Parametro_impuesto_pr  ;



PROCEDURE ra_Parametro_interes_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_tipo        IN VARCHAR2,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tInteres      OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_Parametro_interes_pr"
      Lenguaje="PL/SQL"
      Fecha creación="02-12-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_correlativo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_proc"  Tipo="CARACTER">oficina</param>
            <param nom="EV_tipo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formato "  Tipo="CARACTER">fecha Hasta</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);
        LV_FormatoFecha     VARCHAR2(45);



BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

    LV_FormatoFecha:=ra_formato_fecha;


        LV_sSql :='SELECT TO_CHAR(a.fec_audit,EV_formato) FECHA_AUDITORIA,'
                        ||'a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,'
                        ||'DECODE(a.proc_audit,0,INTERESES,1,IMPUESTOS) PROCESO_AUDITADO,'
                        ||'DECODE(a.tip_audit,0,INGRESAR,1,ELIMINAR,2,MODIFICAR) ACCION,'
                        ||'c.des_tasa TASA_DE_INTERES,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1) C1,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2) C2,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3) C3,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4) C4,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,5) C5,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,6) C6,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,7) C7,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,8) C8,'
                        ||'ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,9) C9'
                        ||'FROM ra_auditoria_tributaria_to a, ge_seg_usuario b , co_tasas_td c'
                        ||'WHERE a.proc_audit=0'
                        ||'AND a.tip_audit in (0, 1,2)'
                        ||'AND a.tip_audit = DECODE ('||EV_tipo||', NULL, a.tip_audit,'|| EV_tipo||')'
                        ||'AND TRUNC(a.fec_audit) >= TO_DATE('||EV_fecdesde||','|| EV_formato||') '
                        ||'AND TRUNC(a.fec_audit) <= TO_DATE('||EV_fechasta||','|| EV_formato||')'
                        ||'AND c.cod_tasa=nvl(ra_extrae_auditoria_pg.ra_campos_pk_fn(a.valor_ant,1),ra_extrae_auditoria_pg.ra_campos_pk_fn(a.valor_nue,1))'
                        ||'AND a.nom_usuario=b.nom_usuario'
                        ||'ORDER BY ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1),'
                        ||'         ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2),'
                        ||'              a.fec_audit,a.correlativo';


        ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
        IF LV_retorno = '' or LV_retorno IS NULL  THEN
        OPEN tInteres  FOR
                        SELECT TO_CHAR(a.fec_audit,LV_FormatoFecha) FECHA_AUDITORIA,
                               a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,
                               DECODE(a.proc_audit,0,'INTERESES',1,'IMPUESTOS') PROCESO_AUDITADO,
                               DECODE(a.tip_audit,0,'INGRESAR',1,'ELIMINAR',2,'MODIFICAR') ACCION,
                               c.des_tasa TASA_DE_INTERES,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1) C1,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2) C2,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3) C3,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4) C4,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,5) C5,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,6) C6,
                                   SUBSTR(ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,7),1,10) C7,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,8) C8,
                                   SUBSTR(ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,9),1,10) C9
                        FROM ra_auditoria_tributaria_to a, ge_seg_usuario b , co_tasas_td c
                        WHERE a.proc_audit=CN_cero
                        AND a.tip_audit in (CN_cero, CN_uno,CN_dos)
                        AND a.tip_audit = DECODE (EV_tipo, NULL, a.tip_audit, EV_tipo)
                        AND TRUNC(a.fec_audit) >= TO_DATE(EV_fecdesde, EV_formato)
                        AND TRUNC(a.fec_audit) <= TO_DATE(EV_fechasta, EV_formato)
                        AND c.cod_tasa(+)=nvl(ra_extrae_auditoria_pg.ra_campos_pk_fn(a.valor_ant,1),ra_extrae_auditoria_pg.ra_campos_pk_fn(a.valor_nue,1))
                        AND a.nom_usuario=b.nom_usuario
                        ORDER BY ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1),
                                 ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2),
                                         a.fec_audit,a.correlativo;

        ELSE
                RAISE ERROR_PROCESO;
        END IF;



   EXCEPTION
      WHEN ERROR_PROCESO THEN
                   SV_mens_retorno := LV_retorno;

            WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Información
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_error_no_clasIF;
          END IF;

                  LV_des_error:='error_ejec_omensaje:ra_Parametro_interes_pr('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
              || EV_proceso ||',' ||EV_proc_audit||',' || EV_correlativo ||',' || EV_proc ||',' || EV_tipo ||',' || EV_fecdesde ||',' || EV_fechasta || ',' ||EV_formato||
                  ') - '||sqlerrm;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_PARAMETRO_INTERES_PR',
                                                LV_sSql , SQLCODE, LV_des_error );

                  SV_mens_retorno := LN_cod_retorno;


END ra_Parametro_interes_pr ;


PROCEDURE ra_Parametro_categorias_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_tipo        IN VARCHAR2,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tCategoria      OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_Parametro_categorias_pr"
      Lenguaje="PL/SQL"
      Fecha creación="02-12-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_correlativo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_proc"  Tipo="CARACTER">oficina</param>
            <param nom="EV_tipo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formato "  Tipo="CARACTER">fecha Hasta</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);
        LV_FormatoFecha     VARCHAR2(45);



BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;
    LV_FormatoFecha:= ra_formato_fecha;


        LV_sSql :='SELECT TO_CHAR(a.fec_audit,DD-MM-YYYY HH24:MI:SS) FECHA_AUDITORIA,'
                        ||'      a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,'
                        ||'       DECODE(a.proc_audit,0,INTERESES,1,IMPUESTOS,11,CATEGORIAS) PROCESO_AUDITADO,'
                        ||'       DECODE(a.tip_audit,0,INGRESAR,1,ELIMINAR,2,MODIFICAR) ACCION,'
                        ||'        ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1) C1,'
                        ||'        ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2) C2,'
                        ||'        ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3) C3,'
                        ||'        ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4) C4'
                        ||'FROM ra_auditoria_tributaria_to a, ge_seg_usuario b'
                        ||'WHERE a.proc_audit = CN_11'
                        ||'AND a.tip_audit in (CN_cero, CN_uno,CN_dos)'
                        ||'AND a.tip_audit = DECODE ('||EV_tipo||', NULL, a.tip_audit,'|| EV_tipo||')'
                        ||'AND TRUNC(a.fec_audit) >= TO_DATE('||EV_fecdesde||','|| EV_formato||')'
                        ||'AND TRUNC(a.fec_audit) <= TO_DATE('||EV_fechasta||','|| EV_formato||')'
                        ||'AND a.nom_usuario=b.nom_usuario'
                        ||'ORDER BY ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1), a.fec_audit,a.correlativo';

        ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
        IF LV_retorno = '' or LV_retorno IS NULL  THEN
        OPEN tCategoria  FOR
                        SELECT TO_CHAR(a.fec_audit,LV_FormatoFecha) FECHA_AUDITORIA,
                               a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,
                               DECODE(a.proc_audit,0,'INTERESES',1,'IMPUESTOS',11,'CATEGORIAS') PROCESO_AUDITADO,
                               DECODE(a.tip_audit,0,'INGRESAR',1,'ELIMINAR',2,'MODIFICAR') ACCION,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1) C1,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,2) C2,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,3) C3,
                                   ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,4) C4
                        FROM ra_auditoria_tributaria_to a, ge_seg_usuario b
                        WHERE a.proc_audit = CN_11
                        AND a.tip_audit in (CN_cero, CN_uno,CN_dos)
                        AND a.tip_audit = DECODE (EV_tipo, NULL, a.tip_audit, EV_tipo)
                        AND TRUNC(a.fec_audit) >= TO_DATE(EV_fecdesde, EV_formato)
                        AND TRUNC(a.fec_audit) <= TO_DATE(EV_fechasta, EV_formato)
                        AND a.nom_usuario=b.nom_usuario
                        ORDER BY ra_extrae_auditoria_pg.ra_campos_fn(a.valor_ant,a.valor_nue,1),
                                 a.fec_audit,a.correlativo;
        ELSE
                RAISE ERROR_PROCESO;
        END IF;



   EXCEPTION
      WHEN ERROR_PROCESO THEN
                   SV_mens_retorno := LV_retorno;

            WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Información
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_error_no_clasIF;
          END IF;

                  LV_des_error:='error_ejec_omensaje:RA_PARAMETRO_CATEGORIAS_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
              || EV_proceso ||',' ||EV_proc_audit||',' || EV_correlativo ||',' || EV_proc ||',' || EV_tipo ||',' || EV_fecdesde ||',' || EV_fechasta || ',' ||EV_formato||
                  ') - '||sqlerrm;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_PARAMETRO_CATEGORIAS_PR',
                                                LV_sSql , SQLCODE, LV_des_error );

                  SV_mens_retorno := LN_cod_retorno;


END ra_Parametro_categorias_pr ;



PROCEDURE ra_con_reportes_pr (
        EV_tip_audit  IN VARCHAR2,
        EV_valor_ant  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_ant%TYPE,
        EV_valor_nue  IN RA_AUDITORIA_TRIBUTARIA_TO.valor_nue%TYPE,
        EV_proceso        IN RA_AUDITORIA_TRIBUTARIA_TO.proceso_audit%TYPE,
        EV_proc_audit  IN VARCHAR2,
        EV_correlativo IN VARCHAR2,
        EV_proc        IN VARCHAR2,
        EV_usuario    IN ge_seg_usuario.nom_usuario%TYPE,
        EV_fecdesde       IN VARCHAR2,
        EV_fechasta       IN VARCHAR2,
        EV_formato    IN VARCHAR2,
        tReportes      OUT NOCOPY refcursor,
    SV_mens_retorno OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_Parametros_tributarios_pr"
      Lenguaje="PL/SQL"
      Fecha creación="02-12-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera Reporte consolidado Mensual</Descripción>
      <Parámetros>
          <Entrada>
            <param nom="EV_tip_audit" Tipo="CARACTER">Tipo Auditoria</param>
            <param nom="EV_valor_ant" Tipo="CARACTER">Valor anterior</param>
            <param nom="EV_valor_nue" Tipo="CARACTER">valor nuevo</param>
            <param nom="EV_proceso "  Tipo="CARACTER">Proceso que se ejecuta</param>
            <param nom="EV_proc_audit "  Tipo="CARACTER">Usuario </param>
            <param nom="EV_correlativo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_proc"  Tipo="CARACTER">oficina</param>
            <param nom="EV_tipo"  Tipo="CARACTER">oficina</param>
            <param nom="EV_fecdesde "  Tipo="CARACTER">fecha desde</param>
            <param nom="EV_fechasta "  Tipo="CARACTER">fecha Hasta</param>
            <param nom="EV_formato "  Tipo="CARACTER">fecha Hasta</param>
         </Entrada>
         <Salida>
            <param nom="tCaja" Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO           EXCEPTION;
        NO_HAY_DATOS            EXCEPTION;
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
        LN_count                NUMBER;
        LV_retorno              VARCHAR2(200);
        CV_tipo_auditoria      CONSTANT VARCHAR2 (20) := 'TIPO_AUDITORIA';
        CV_proc_auditoria      CONSTANT VARCHAR2 (20) := 'PROCESO_AUDITORIA';



BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql :='SELECT a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,'
                        ||'      c.descripcion_valor OPCION, d.descripcion_valor REPORTE,'
                        ||'        a.fec_audit FECHA_AUDITORIA ,'
                        ||'        Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,1,:) F1,'
                        ||'        Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,2,:) F2,'
                        ||'        Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,3,:) F3,'
                        ||'        Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,4,:) F4,'
                        ||'        Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,5,:) F5'
                        ||'FROM ra_auditoria_tributaria_to a, ge_seg_usuario b, ra_tipo_auditoria_vw c ,ra_proceso_auditoria_vw d'
                        ||'WHERE a.proc_audit not in  (0,1,11,12,13,14)'
                        ||'AND a.proc_audit = DECODE ('||EV_proc||', NULL, a.proc_audit,'|| EV_proc||')'
                        ||'AND a.nom_usuario=b.nom_usuario'
                        ||'AND c.cod_dominio='||CV_tipo_auditoria
                        ||'AND c.valor=a.tip_audit'
                        ||'AND d.cod_dominio='||CV_proc_auditoria
                        ||'AND d.valor=a.proc_audit'
                        ||'AND TRUNC(a.fec_audit) >= TO_DATE('||EV_fecdesde||','|| EV_formato||')'
                        ||'AND TRUNC(a.fec_audit) <= TO_DATE('||EV_fechasta||','|| EV_formato||')'
                        ||'AND a.nom_usuario = DECODE (EV_usuario, NULL, a.nom_usuario, EV_usuario)'
                        ||'order by a.fec_audit';


        ra_Ingresa_Auditoria_pr(EV_tip_audit, EV_valor_ant,EV_valor_nue, EV_proceso, EV_proc_audit, EV_correlativo, LV_retorno );
        IF LV_retorno = '' or LV_retorno IS NULL  THEN
        OPEN tReportes  FOR

                        SELECT a.nom_usuario CODIGO_USUARIO,b.nom_operador USUARIO_AUDITORIA,
                               c.descripcion_valor OPCION, d.descripcion_valor REPORTE,
                                   a.fec_audit FECHA_AUDITORIA ,
                                   Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,1,':') F1,
                                   Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,2,':') F2,
                                   Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,3,':') F3,
                                   Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,4,':') F4,
                                   Ra_Extrae_Auditoria_Pg.RA_CAMPOS_FN( a.proceso_audit, a.valor_nue,5,':') F5
                        FROM ra_auditoria_tributaria_to a, ge_seg_usuario b, ra_tipo_auditoria_vw c ,ra_proceso_auditoria_vw d
                        WHERE a.proc_audit not in  (CN_cero,CN_uno,CN_11,CN_12,CN_13,CN_14)
                        AND a.proc_audit = DECODE (EV_proc      , NULL, a.proc_audit, EV_proc   )
                        AND a.nom_usuario=b.nom_usuario
                        AND c.cod_dominio=CV_tipo_auditoria
                        AND c.valor=a.tip_audit
                        AND d.cod_dominio=CV_proc_auditoria
                        AND d.valor=a.proc_audit
                        AND TRUNC(a.fec_audit) >= TO_DATE(EV_fecdesde, EV_formato)
                        AND TRUNC(a.fec_audit) <= TO_DATE(EV_fechasta, EV_formato)
                        AND a.nom_usuario = DECODE (EV_usuario, NULL, a.nom_usuario, EV_usuario)
                        order by a.fec_audit;


        ELSE
                RAISE ERROR_PROCESO;
        END IF;



   EXCEPTION
      WHEN ERROR_PROCESO THEN
                   SV_mens_retorno := LV_retorno;

            WHEN OTHERS THEN

                  LN_cod_retorno := 629;--Error al Obtener Información
          IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
                 LV_mens_retorno := CV_error_no_clasIF;
          END IF;
                  LV_des_error:='error_ejec_omensaje:RA_CON_REPORTES_PR('|| EV_tip_audit|| ',' || EV_valor_ant ||',' || EV_valor_nue ||','
              || EV_proceso ||',' ||EV_proc_audit||',' || EV_correlativo ||',' || EV_proc ||',' || EV_fecdesde ||',' || EV_fechasta || ',' ||EV_formato||
                  ') - '||sqlerrm;
          LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo,LV_mens_retorno,
                                                CV_version||'.'||CV_subversion,
                                                USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CON_REPORTES_PR',
                                                LV_sSql , SQLCODE, LV_des_error );

                  SV_mens_retorno := LN_cod_retorno;


END ra_con_reportes_pr  ;

PROCEDURE ra_con_ProcAuditoria_pr (
        tProcAuditoria            OUT NOCOPY refcursor,
    SV_mens_retorno   OUT NOCOPY VARCHAR2
)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "ra_con_ProcAuditoria_pr"
      Lenguaje="PL/SQL"
      Fecha creación="29-11-2005"
      Creado por="Maritza Tapia A"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripción>Recupera los valores del tipo de auditoria</Descripción>
      <Parámetros>
             <Entrada>
                 <Entrada>
         <Salida>
            <param nom="tTipAuditoria " Tipo="NUMERICO">Cursor de Salida</param>
            <param nom="SV_mens_retorno" Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/

AS

        ERROR_PROCESO    EXCEPTION;
        CV_procAuditoria CONSTANT VARCHAR (20) := 'PROCESO_AUDITORIA';
    CV_cero                 CONSTANT VARCHAR2 (1)   := '0';
    CV_uno                  CONSTANT VARCHAR2 (1)   := '1';
    CV_once                 CONSTANT VARCHAR2 (2)   := '11';
    CV_12                   CONSTANT VARCHAR2 (2)   := '12';
    CV_13                   CONSTANT VARCHAR2 (2)   := '13';
    CV_14                   CONSTANT VARCHAR2 (2)   := '14';
    LN_cod_retorno      ge_errores_td.cod_msgerror%TYPE;
    LV_mens_retorno     ge_errores_td.det_msgerror%TYPE;
    LN_num_evento       ge_errores_pg.Evento;
    LV_des_error        ge_errores_pg.DesEvent;
    LV_sSql             ge_errores_pg.vQuery;
BEGIN
        SV_mens_retorno:= '';
        LN_cod_retorno := 0;
        LV_des_error := '';
        LN_num_evento :=0;

        LV_sSql := 'SELECT a.valor, a.descripcion_valor'
                         ||'FROM RA_PROCESO_AUDITORIA_VW a'
                         ||'WHERE a.cod_dominio = PROCESO_AUDITORIA'
                 ||'AND a.valor not in  (0 , 1, 11,12, 13, 14)';


        OPEN tProcAuditoria FOR
        SELECT a.valor, a.descripcion_valor
          FROM RA_PROCESO_AUDITORIA_VW a
         WHERE a.cod_dominio = CV_procAuditoria
       AND a.valor not in  (CV_cero , CV_uno, CV_once, CV_12, CV_13, CV_14);


EXCEPTION
         WHEN OTHERS THEN


                LN_cod_retorno := 631;--Error al Obtener valores de Auditoria
        IF NOT Ge_Errores_Pg.MENSAJEERROR(LN_cod_retorno,LV_mens_retorno) THEN
               LV_mens_retorno :=  CV_error_no_clasif;
        END IF;
        LV_des_error:='error_ejec_omensaje:RA_CON_PROCAUDITORIA_Pr - '||sqlerrm;
        LN_num_evento:=Ge_Errores_Pg.Grabarpl( LN_num_evento,CV_cod_modulo ,LV_mens_retorno,
                                              CV_version||'.'||CV_subversion,
                                              USER, 'RA_REPORTES_TRIBUTARIOS_PG.RA_CON_PROCAUDITORIA_PR',
                                              LV_sSql , SQLCODE, LV_des_error );
                SV_mens_retorno := LV_mens_retorno;



END ra_con_ProcAuditoria_pr ;

END Ra_Reportes_Tributarios_Pg;
/
SHOW ERRORS