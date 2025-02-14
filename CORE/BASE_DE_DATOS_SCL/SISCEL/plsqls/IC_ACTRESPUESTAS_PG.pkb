CREATE OR REPLACE PACKAGE BODY SISCEL.IC_ACTRESPUESTAS_PG IS
/*
<NOMBRE>       : IC_ACTRESPUESTAS_PG
<FECHACREA>    : 22-11-2004
<MODULO >      : Módulo al que pertenece PL; Script; trigger; cursor; función. </MODULO >
<AUTOR >       : Pamela Barria>
<VERSION >     : 1.1>
<DESCRIPCION>  : Recupera la secuencia de acciones a ejecutar, en el orden establecido.
<FECHAMOD >    : 10/08/2006 </FECHAMOD >
<DESCMOD >     : se redefine largo de la variable v_valorparseo a 300 </DESCMOD >
<ParamEntr>    : Parámetros de entrada de la función  (solo si es función o procedimiento) </ParamEntr>
<ParamSal >    : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/

              TYPE  typ_rec_parametros IS RECORD (
                    t_v_nom_param    VARCHAR2(20),
                    t_v_tip_origen   CHAR,
                    t_v_num_parseo   NUMBER(2),
                    t_v_tip_dato     VARCHAR2(50),
                    t_v_nom_origen   VARCHAR2(50),
                    t_v_valinicial   VARCHAR2(50));

            TYPE  typ_tab_parametros IS TABLE OF typ_rec_parametros
                    INDEX BY BINARY_INTEGER;

            tab_parametros    typ_tab_parametros;
            emp_parametros    typ_tab_parametros;
            ind_parametros    BINARY_INTEGER := 0;
            v_n_num_movimiento NUMBER(9);

            CURSOR c_cursor_rutinas(p_c_producto VARCHAR2,p_c_acabo VARCHAR2,p_c_mod VARCHAR2,p_c_tecno VARCHAR2) IS
                        SELECT
                                b.cod_rutina,
                                a.nom_fisico,
                                b.num_orden,
                                a.tip_rutina,
                                a.tip_valor
                        FROM
                                ic_rutinas_td a,
                                ic_rutinasactabo_td b
                        WHERE
                                  b.cod_producto   = p_c_producto
                              AND b.cod_actabo     = p_c_acabo
                              AND b.cod_modulo     = p_c_mod
                              AND b.cod_tecnologia = p_c_tecno
                              AND b.cod_rutina     = a.cod_rutina
                        ORDER BY b.num_orden;

            CURSOR c_cursor_parametros(p_c_rutina VARCHAR2) IS
                     SELECT
                                 a.nom_parametro,
                                 a.num_orden,
                                 a.mod_parametro,
                                 b.des_parametro,
                                 b.tip_origen,
                                 b.nom_origen,
                                 b.tip_valor,
                                 b.tip_dato,
                                 nvl(a.val_inicial,'*') val_inicial
                        FROM
                               ic_paramrutinas_td a,
                               ic_parametros_td b
                        WHERE
                               a.cod_rutina     = p_c_rutina
                           and b.nom_parametro  = a.nom_parametro
                        ORDER BY a.num_orden;

            fmt_date CONSTANT VARCHAR2(18) := 'YYYYMMDDHH24MISS';


FUNCTION pv_retorna_version_fn RETURN VARCHAR2
/*
<NOMBRE>      : IC_NUEVOMODULO_FN
<FECHACREA>      : 25-11-2004
<MODULO >      : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >           : Fabian Aedo>
<VERSION >          : 1>
<DESCRIPCION> : Retorna versión del Package.</DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripción de Modificación </DESCMOD >
<ParamEntr>            : p_v_parametro: nombre del parámetro a validar</ParamEntr>
<ParamSal >             : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
IS
  c_v_version    CONSTANT VARCHAR2(3) := '001';
  c_v_subversion CONSTANT VARCHAR2(3) := '001';
BEGIN
   RETURN('Version : '||c_v_version||' <--> SubVersion : '||c_v_subversion);
END pv_retorna_version_fn;


FUNCTION ic_nuevomodulo_fn (p_v_producto IN NUMBER,p_v_actabo IN VARCHAR2,p_v_modulo IN VARCHAR2,p_v_tecnologia IN VARCHAR2) RETURN BOOLEAN
IS
/*
<NOMBRE>      : IC_NUEVOMODULO_FN
<FECHACREA>   : 25-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Pamela Barria>
<VERSION >    : 1>
<DESCRIPCION> : Retorna la desición de continuar por el nuevo módulo al verificar data en la tabla GA_ACTABO.</DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD >
<DESCMOD >    : Breve descripción de Modificación </DESCMOD >
<ParamEntr>   : p_v_parametro: nombre del parámetro a validar</ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
v_n_retorno NUMBER;

BEGIN

         SELECT
                 COUNT(cod_producto)
         INTO
                 v_n_retorno
         FROM
                 ic_rutinasactabo_td
         WHERE
              cod_producto  = p_v_producto
          AND cod_actabo    = p_v_actabo
          AND cod_modulo    = p_v_modulo
          AND cod_tecnologia= p_v_tecnologia;

       IF v_n_retorno > 0 THEN
          RETURN TRUE;
       ELSE
          RETURN FALSE;
       END IF;
EXCEPTION
  WHEN OTHERS THEN
       RETURN FALSE;
END ic_nuevomodulo_fn ;
PROCEDURE ic_initabparametros_pr
IS
/*
<NOMBRE>      : IC_INITABPARAMETROS_PR
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Fabian Aedo>
<VERSION >    : 1>
<DESCRIPCION> : Inicializa la tabla de parámetros (memoria).</DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD >
<DESCMOD >    : Breve descripción de Modificación </DESCMOD >
<ParamEntr>   : no hay.</ParamEntr>
<ParamSal >   : no hay   (solo si es función o procedimiento) </ParamEntr>
*/
BEGIN
      tab_parametros    := emp_parametros;
      ind_parametros    := 0;
      v_n_num_evento    := -1;
END ic_initabparametros_pr;

PROCEDURE ic_graba_tmpmov_pr (p_n_producto IN NUMBER, p_rec_movcelular IN icc_movimiento%ROWTYPE)
IS
/*
<NOMBRE>      : IC_GRABA_PARAM_PR
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Fabian Aedo>
<VERSION >    : 1>
<DESCRIPCION> : Graba losparámetros recibidos en la tabla global temporary.</DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD >
<DESCMOD >    : Breve descripción de Modificación </DESCMOD >
<ParamEntr>   : p_rec_movcelular: registro de la tabla icc_movimiento a guardar.</ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
BEGIN
       INSERT INTO ic_tmpmovimiento_td
               (
                   num_movimiento,
                   num_abonado,
                   cod_estado,
                   cod_actabo,
                   cod_modulo,
                   num_intentos,
                   cod_central_nue,
                   des_respuesta,
                   cod_actuacion,
                   nom_usuarora,
                   fec_ingreso,
                   tip_terminal,
                   cod_central,
                   fec_lectura,
                   ind_bloqueo,
                   fec_ejecucion,
                   tip_terminal_nue,
                   num_movant,
                   num_celular,
                   num_movpos,
                   num_serie,
                   num_personal,
                   num_celular_nue,
                   num_serie_nue,
                   num_personal_nue,
                   num_msnb,
                   num_msnb_nue,
                   cod_suspreha,
                   cod_servicios,
                   num_min,
                   num_min_nue,
                   sta,
                   cod_mensaje,
                   param1_mens,
                   param2_mens,
                   param3_mens,
                   plan,
                   carga,
                   valor_plan,
                   pin,
                   fec_expira,
                   des_mensaje,
                   cod_pin,
                   cod_idioma,
                   cod_enrutamiento,
                   tip_enrutamiento,
                   des_origen_pin,
                   num_lote_pin,
                   num_serie_pin,
                   tip_tecnologia,
                   imsi,
                   imsi_nue,
                   imei,
                   imei_nue,
                   icc,
                   icc_nue,
                   cod_producto,
   				         cod_espec_prov,
   				         cod_prod_contratado,
   				         fec_activacion,
   	      			   ind_bajatrans
                   )
       VALUES
               (
                   p_rec_movcelular.num_movimiento,
                   p_rec_movcelular.num_abonado,
                   p_rec_movcelular.cod_estado,
                   p_rec_movcelular.cod_actabo,
                   p_rec_movcelular.cod_modulo,
                   p_rec_movcelular.num_intentos,
                   p_rec_movcelular.cod_central_nue,
                   p_rec_movcelular.des_respuesta,
                   p_rec_movcelular.cod_actuacion,
                   p_rec_movcelular.nom_usuarora,
                   p_rec_movcelular.fec_ingreso,
                   p_rec_movcelular.tip_terminal,
                   p_rec_movcelular.cod_central,
                   p_rec_movcelular.fec_lectura,
                   nvl(p_rec_movcelular.ind_bloqueo, 0),
                   p_rec_movcelular.fec_ejecucion,
                   p_rec_movcelular.tip_terminal_nue,
                   p_rec_movcelular.num_movant,
                   p_rec_movcelular.num_celular,
                   p_rec_movcelular.num_movpos,
                   p_rec_movcelular.num_serie,
                   p_rec_movcelular.num_personal,
                   p_rec_movcelular.num_celular_nue,
                   p_rec_movcelular.num_serie_nue,
                   p_rec_movcelular.num_personal_nue,
                   p_rec_movcelular.num_msnb,
                   p_rec_movcelular.num_msnb_nue,
                   p_rec_movcelular.cod_suspreha,
                   p_rec_movcelular.cod_servicios,
                   p_rec_movcelular.num_min,
                   p_rec_movcelular.num_min_nue,
                   p_rec_movcelular.sta,
                   p_rec_movcelular.cod_mensaje,
                   p_rec_movcelular.param1_mens,
                   p_rec_movcelular.param2_mens,
                   p_rec_movcelular.param3_mens,
                   p_rec_movcelular.plan,
                   p_rec_movcelular.carga,
                   p_rec_movcelular.valor_plan,
                   p_rec_movcelular.pin,
                   p_rec_movcelular.fec_expira,
                   p_rec_movcelular.des_mensaje,
                   p_rec_movcelular.cod_pin,
                   p_rec_movcelular.cod_idioma,
                   p_rec_movcelular.cod_enrutamiento,
                   p_rec_movcelular.tip_enrutamiento,
                   p_rec_movcelular.des_origen_pin,
                   p_rec_movcelular.num_lote_pin,
                   p_rec_movcelular.num_serie_pin,
                   p_rec_movcelular.tip_tecnologia,
                   p_rec_movcelular.imsi,
                   p_rec_movcelular.imsi_nue,
                   p_rec_movcelular.imei,
                   p_rec_movcelular.imei_nue,
                   p_rec_movcelular.icc,
                   p_rec_movcelular.icc_nue,
                   p_n_producto,
                   p_rec_movcelular.cod_espec_prov,
                   p_rec_movcelular.cod_prod_contratado,
                   p_rec_movcelular.fec_Activacion,
                   p_rec_movcelular.ind_bajatrans
                   );
EXCEPTION
       WHEN OTHERS THEN
               RAISE;
END ic_graba_tmpmov_pr;

PROCEDURE ic_graba_param_pr (p_v_parametro IN VARCHAR2, p_c_origen IN CHAR, p_n_parseo IN OUT NUMBER, p_v_tipdato IN VARCHAR2, p_v_origen IN VARCHAR2, p_v_inicial IN VARCHAR2)
IS
/*
<NOMBRE>      : IC_GRABA_PARAM_PR
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Fabian Aedo>
<VERSION >    : 1.1>
<DESCRIPCION> : Carga los registros del cursor de parámetros en la estructura de parámetros.</DESCRIPCION>
<FECHAMOD >   : 05/11/2005 </FECHAMOD >
<DESCMOD >    : Aceptar Valores nulos </DESCMOD >
<ParamEntr>   : p_v_parametro: parámetro a ingresar en estructura en memoria.</ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/

BEGIN
            tab_parametros(ind_parametros).t_v_nom_param     := p_v_parametro;
            tab_parametros(ind_parametros).t_v_tip_origen    := p_c_origen;
            tab_parametros(ind_parametros).t_v_tip_dato      := p_v_tipdato;
            tab_parametros(ind_parametros).t_v_nom_origen    := p_v_origen;
            tab_parametros(ind_parametros).t_v_valinicial    := p_v_inicial;

            IF p_c_origen = 'I' THEN
               IF UPPER(TRIM(p_v_inicial)) <> 'NULL' THEN
                  p_n_parseo := p_n_parseo + 1;
                  tab_parametros(ind_parametros).t_v_num_parseo := p_n_parseo;
               END IF;
            ELSE
               IF p_v_inicial <> '*' AND UPPER(TRIM(p_v_inicial)) <> 'NULL' THEN
                     p_n_parseo := p_n_parseo + 1;
                     tab_parametros(ind_parametros).t_v_num_parseo := p_n_parseo;
               ELSE
                       IF p_v_tipdato = 'DATE' AND UPPER(TRIM(p_v_inicial)) <> 'NULL' THEN
                          p_n_parseo := p_n_parseo + 1;
                          tab_parametros(ind_parametros).t_v_num_parseo := p_n_parseo;
                       ELSE
					      IF UPPER(TRIM(p_v_inicial)) <> 'NULL' THEN
                             tab_parametros(ind_parametros).t_v_num_parseo := -1;
						  END IF;
                       END IF;
               END IF;
            END IF;

    ind_parametros := ind_parametros + 1;
END ic_graba_param_pr;

FUNCTION ic_genera_declare_fn (p_v_parametro IN VARCHAR2, p_v_tipvalor IN VARCHAR2,p_v_inicial IN VARCHAR2) RETURN VARCHAR2
IS
/*
<NOMBRE>      : IC_EXISTE_PARAM_FN
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Fabian Aedo>
<VERSION >    : 1.1>
<DESCRIPCION> : genera trozo sql de declaración de variables...</DESCRIPCION>
<FECHAMOD >   : 05/11/2005 </FECHAMOD >
<DESCMOD >    : Aceptar Valores nulos </DESCMOD >
<ParamEntr>   : p_v_parametro: nombre del parámetro a validar</ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
v_sqldeclare VARCHAR2(150) := '';
BEGIN
            IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
               v_sqldeclare := ' '||p_v_parametro||' '||p_v_tipvalor||';';
            ELSE
               v_sqldeclare := ' '||p_v_parametro||' '||p_v_tipvalor||'%TYPE;';
            END IF;
            RETURN v_sqldeclare;

END ic_genera_declare_fn;

FUNCTION ic_genera_inicializacion_fn (p_v_parametro IN VARCHAR2, p_v_tipdato IN VARCHAR2, p_c_tiporigen IN CHAR, p_v_inicial IN VARCHAR2) RETURN VARCHAR2
IS
/*
<NOMBRE>      : IC_GENERA_INICIALIZACION_FN
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Fabian Aedo>
<VERSION >    : 1>
<DESCRIPCION> : genera trozo sql de inicialización de variables...</DESCRIPCION>
<FECHAMOD >   : 05/11/2005 </FECHAMOD >
<DESCMOD >    : Ingreso de valores nulos </DESCMOD >
<ParamEntr>   : p_v_parametro: nombre del parámetro a validar
              p_v_tipdato -> tipo de dato original del parametro...</ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
v_sqlinicialice VARCHAR2(2000) := '';
BEGIN

          IF p_c_tiporigen = 'I' THEN
                  IF p_v_tipdato = 'VARCHAR2' THEN
                     IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
                        v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                     ELSE
                        v_sqlinicialice := ' '||p_v_parametro||' := :'||tab_parametros(ind_parametros-1).t_v_num_parseo||'; ';
                     END IF;
                  ELSIF p_v_tipdato = 'NUMBER' THEN
                      IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
                         v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                      ELSE
                        v_sqlinicialice := ' '||p_v_parametro||' := TO_NUMBER(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||'); ';
                      END IF;
                ELSIF p_v_tipdato = 'DATE' THEN
                      IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
                         v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                      ELSE
                         v_sqlinicialice := ' '||p_v_parametro||' := TO_DATE(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||','''||fmt_date||'''); ';
                      END IF;
                END IF;
          ELSE
                  IF p_v_inicial = '*' THEN
                     IF p_v_tipdato = 'DATE' THEN
                       IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
                          v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                       ELSE
                          v_sqlinicialice := ' '||p_v_parametro||' := TO_DATE(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||','''||fmt_date||'''); ';
                       END IF;
                     ELSE
                        v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                     END IF;
                  ELSE
                     IF p_v_tipdato = 'VARCHAR2' THEN
                        v_sqlinicialice := ' '||p_v_parametro||' := :'||tab_parametros(ind_parametros-1).t_v_num_parseo||'; ';
                     ELSIF p_v_tipdato = 'NUMBER' THEN
                        IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
                           v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                        ELSE
                          v_sqlinicialice := ' '||p_v_parametro||' := TO_NUMBER(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||'); ';
                       END IF;
                    ELSIF p_v_tipdato = 'DATE' THEN
                       IF UPPER(TRIM(p_v_inicial)) = 'NULL' THEN
                          v_sqlinicialice := ' '||p_v_parametro||' := NULL;';
                       ELSE
                          v_sqlinicialice := ' '||p_v_parametro||' := TO_DATE(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||','''||fmt_date||'''); ';
                       END IF;
                    END IF;
                 END IF;
        END IF;

        RETURN v_sqlinicialice;
END ic_genera_inicializacion_fn;

FUNCTION ic_existe_param_fn (p_v_parametro IN VARCHAR2) RETURN BOOLEAN
IS
/*
<NOMBRE>      : IC_EXISTE_PARAM_FN
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES </MODULO >
<AUTOR >      : Fabian Aedo>
<VERSION >    : 1>
<DESCRIPCION> : Valida la existencia del parámetro en lista de parámetros para bloque SQL.</DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD >
<DESCMOD >    : Breve descripción de Modificación </DESCMOD >
<ParamEntr>   : p_v_parametro: nombre del parámetro a validar</ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
    n_rownum    BINARY_INTEGER := 0;
    b_existe    BOOLEAN := FALSE;
BEGIN
   WHILE (n_rownum <= ind_parametros -1) AND NOT b_existe
   LOOP
           IF tab_parametros(n_rownum).t_v_nom_param = p_v_parametro THEN
               b_existe := TRUE;
           ELSE
              n_rownum := n_rownum +1;
           END IF;

   END LOOP;
   IF b_existe THEN
        RETURN TRUE;
   ELSE
        RETURN FALSE;
   END IF;
END ic_existe_param_fn;

FUNCTION ic_recupera_param_fn(p_v_parametro IN VARCHAR2, p_v_tipdato IN VARCHAR2, p_v_origen IN VARCHAR2) RETURN VARCHAR2
IS
/*
<NOMBRE>      : IC_PRINCIPAL_PR
<FECHACREA>   : 22-11-2004
<MODULO >     : INTERFAZ CON CENTRALES. </MODULO >
<AUTOR >      : Pamela Barria>
<VERSION >    : 1>
<DESCRIPCION> : Recupera, desde global temporary table, el valor del parámetro... </DESCRIPCION>
<FECHAMOD >   : DD/MM/YYYY </FECHAMOD >
<DESCMOD >    : Breve descripción de Modificación </DESCMOD >
<ParamEntr>   : Parámetros de entrada de la función  (solo si es función o procedimiento) </ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
    v_stmsql          VARCHAR2(300);
    v_valorparam      VARCHAR2(300);
BEGIN
    v_stmsql := 'SELECT ';

      IF p_v_tipdato = 'VARCHAR2' THEN
         v_stmsql := v_stmsql ||p_v_origen||' ';
      ELSIF p_v_tipdato = 'NUMBER' THEN
         v_stmsql := v_stmsql ||'TO_CHAR('||p_v_origen||') ';
      ELSIF p_v_tipdato = 'DATE' THEN
         v_stmsql := v_stmsql ||'TO_CHAR('||p_v_origen||','''||fmt_date||''') ';
      END IF;

      v_stmsql := v_stmsql ||'FROM ic_tmpmovimiento_td ';
      v_stmsql := v_stmsql ||'WHERE num_movimiento = '||v_n_num_movimiento;
      EXECUTE IMMEDIATE v_stmsql INTO v_valorparam;
      RETURN v_valorparam;
EXCEPTION
    WHEN OTHERS THEN
             RAISE;
END ic_recupera_param_fn;

PROCEDURE ic_principal_pr(p_n_producto IN NUMBER, p_r_cmov icc_movimiento%ROWTYPE)
IS
/*
<NOMBRE>      : IC_PRINCIPAL_PR
<FECHACREA>   : 22-11-2004
<MODULO >     : Módulo al que pertenece PL; Script; trigger; cursor; función. </MODULO >
<AUTOR >      : Pamela Barria>
<VERSION >    : 1.1>
<DESCRIPCION> : Breve descripción explicativa </DESCRIPCION>
<FECHAMOD >   : 05/11/2005 </FECHAMOD >
<DESCMOD >    : Aceptar Valores nulos </DESCMOD >
<ParamEntr>   : Parámetros de entrada de la función  (solo si es función o procedimiento) </ParamEntr>
<ParamSal >   : Parámetros de salida de la función    (solo si es función o procedimiento) </ParamEntr>
*/
      v_sqlVarFijas      VARCHAR2(3000);
      v_sqlVariables     VARCHAR2(3000):='';
      v_sqlIniVariables  VARCHAR2(3000):='';
      v_sqlLlamadas      VARCHAR2(3000):= '';
      v_sqlLlamadas_fin  VARCHAR2(5000):= '';
      v_SqlFinal         VARCHAR2(5000);
      v_c_comando        VARCHAR2(3000);
      v_c_LlamadaAux     VARCHAR2(3000);
      v_c_IniVarAux      VARCHAR2(3000);
	  v_c_IniContError   VARCHAR2(2000);
      v_c_actabo         VARCHAR2(2);
      v_c_modulo         VARCHAR2(2);
      v_c_tecnologia     VARCHAR2(7);
      v_glosa            VARCHAR2(500);
      n_numparam         NUMBER(2);
      n_numparseo        NUMBER(2);

      i_curdinamico      INTEGER;
      v_varparseo        VARCHAR2(4);
      v_valorparseo      VARCHAR2(300);
      n_rows             NUMBER(5);

      v_n_evento         NUMBER(9);

      pl_block_error     EXCEPTION;
      v_v_bandera        VARCHAR2(3000);

      PRAGMA EXCEPTION_INIT(pl_block_error, -20100);

BEGIN
            ic_initabparametros_pr();

            v_c_actabo := p_r_cmov.cod_actabo;
            v_c_modulo := p_r_cmov.cod_modulo;
            v_c_tecnologia := p_r_cmov.tip_tecnologia;
            v_v_bandera := 'ic_graba_tmpmov_pr (p_n_producto,p_r_cmov);';
            ic_graba_tmpmov_pr (p_n_producto,p_r_cmov);
            v_n_num_movimiento := p_r_cmov.NUM_MOVIMIENTO;

            v_sqlVarFijas := ' v_procedimiento         VARCHAR2(800); ' ;
            v_sqlVarFijas := v_sqlVarFijas || ' v_error         VARCHAR2(800); ';
            v_sqlVarFijas := v_sqlVarFijas || ' V_PROCESO               VARCHAR2(100):= NULL; ';
            v_c_comando := '';
            v_sqlLlamadas := '';
            v_sqlVariables := '';
			v_c_IniContError := '';
            n_numparseo:= 0;
            FOR rReg IN c_cursor_rutinas(p_n_producto,v_c_actabo,v_c_modulo,v_c_tecnologia) LOOP
                v_v_bandera := 'c_cursor_rutinas('||p_n_producto||','||v_c_actabo||','||v_c_modulo||','||v_c_tecnologia||');';
                  v_sqlLlamadas := UPPER(rReg.nom_fisico);
                  v_c_comando := ' v_procedimiento :=''['||UPPER(rReg.nom_fisico);
                  n_numparam := 0;
                  v_c_IniContError :=  ' V_PROCESO := ''' || v_sqlLlamadas || ''';  ';

                  FOR rRegParam IN c_cursor_parametros(rReg.cod_rutina) LOOP
                        IF n_numparam = 0 THEN
                           v_c_comando := v_c_comando ||'(''||';
                        END IF;
                        v_v_bandera := 'c_cursor_parametros('||rReg.cod_rutina||');';
                        n_numparam := n_numparam + 1;

                        v_v_bandera := 'IF NOT ic_existe_param_fn('||rRegParam.nom_parametro||');';

                        IF NOT ic_existe_param_fn(rRegParam.nom_parametro) THEN
                           v_v_bandera := 'ic_graba_param_pr('||rRegParam.nom_parametro||','||rRegParam.tip_origen||','||n_numparseo||','||rRegParam.tip_dato||','||rRegParam.nom_origen||','||rRegParam.val_inicial||');';
                           ic_graba_param_pr(rRegParam.nom_parametro, rRegParam.tip_origen, n_numparseo, rRegParam.tip_dato, rRegParam.nom_origen, rRegParam.val_inicial);

                           v_v_bandera := 'ic_genera_declare_fn('||rRegParam.nom_parametro||','||rRegParam.tip_valor||','||rRegParam.val_inicial ||')';
                           v_sqlVariables := v_sqlVariables || ic_genera_declare_fn(rRegParam.nom_parametro, rRegParam.tip_valor,rRegParam.val_inicial);

                           v_v_bandera := 'ic_genera_inicializacion_fn('||rRegParam.nom_parametro||','||rRegParam.tip_dato||','||rRegParam.tip_origen||','||rRegParam.val_inicial||');';
                           v_sqlIniVariables := v_sqlIniVariables || ic_genera_inicializacion_fn(rRegParam.nom_parametro, rRegParam.tip_dato, rRegParam.tip_origen, rRegParam.val_inicial);
                        END IF;

                        IF n_numparam = 1 THEN
                           v_sqlLlamadas := v_sqlLlamadas||'('||rRegParam.nom_parametro;
                        ELSE
                           v_sqlLlamadas := v_sqlLlamadas||', '||rRegParam.nom_parametro;
                           v_c_comando := v_c_comando ||'||'',''|| ';
                        END IF;

                        IF rRegParam.tip_dato = 'VARCHAR2' THEN
                                   v_c_comando := v_c_comando ||rRegParam.nom_parametro;
                        ELSIF rRegParam.tip_dato = 'NUMBER' THEN
                                  IF UPPER(TRIM(rRegParam.val_inicial)) = 'NULL' THEN
                                     v_c_comando := v_c_comando ||rRegParam.nom_parametro;
                                  ELSE
                                     v_c_comando := v_c_comando ||'TO_CHAR('||rRegParam.nom_parametro||')';
                                  END IF;
                        ELSIF rRegParam.tip_dato = 'DATE' THEN
                                  IF UPPER(TRIM(rRegParam.val_inicial)) = 'NULL' THEN
                                     v_c_comando := v_c_comando ||rRegParam.nom_parametro;
                                  ELSE
                                     v_c_comando := v_c_comando ||'TO_CHAR('||rRegParam.nom_parametro||','''||fmt_date||''')';
                                  END IF;
                        END IF ;
                  END LOOP;
                  IF n_numparam > 0 THEN
                        v_sqlLlamadas := v_sqlLlamadas||');';
                        v_c_comando := v_c_comando ||'||'')]'';';
                  ELSE
                        v_sqlLlamadas := v_sqlLlamadas||';';
                        v_c_comando := v_c_comando ||']'';';
                  END IF;
                  --v_sqlLlamadas_fin := v_sqlLlamadas_fin ||' '||v_c_comando||' '||v_sqlLlamadas   ;
                  v_sqlLlamadas_fin := v_sqlLlamadas_fin ||' '||v_c_IniContError||' '||v_sqlLlamadas;
            END LOOP;

			v_c_IniContError := '';

            v_c_IniVarAux := '';
            for n_indice in 0..ind_parametros - 1 LOOP
               v_v_bandera := 'IF '||tab_parametros(n_indice).t_v_tip_origen||' = ''F'' then';
               IF tab_parametros(n_indice).t_v_tip_origen = 'F' then

                        v_c_LlamadaAux := tab_parametros(n_indice).t_v_nom_param || ':=' || tab_parametros(n_indice).t_v_nom_origen;
                        n_numparam := 0;
                        FOR rRegParam IN c_cursor_parametros(tab_parametros(n_indice).t_v_nom_origen) LOOP
                              v_v_bandera := '[origen: FUNCION] c_cursor_parametros('||tab_parametros(n_indice).t_v_nom_origen||');';
                              n_numparam := n_numparam + 1;
                              IF NOT ic_existe_param_fn(rRegParam.nom_parametro) THEN
                                 v_v_bandera := 'ic_graba_param_pr('||rRegParam.nom_parametro||','||rRegParam.tip_origen||','||n_numparseo||','||rRegParam.tip_dato||','||rRegParam.nom_origen||','||rRegParam.val_inicial||');';
                                 ic_graba_param_pr(rRegParam.nom_parametro, rRegParam.tip_origen, n_numparseo, rRegParam.tip_dato, rRegParam.nom_origen, rRegParam.val_inicial);

                                 v_v_bandera := 'ic_genera_declare_fn('||rRegParam.nom_parametro||','||rRegParam.tip_valor||','||rRegParam.val_inicial||');';
                                 v_sqlVariables := v_sqlVariables || ic_genera_declare_fn(rRegParam.nom_parametro, rRegParam.tip_valor,rRegParam.val_inicial);

                                 v_v_bandera := 'ic_genera_inicializacion_fn('||rRegParam.nom_parametro||','||rRegParam.tip_dato||','||rRegParam.tip_origen||','||rRegParam.val_inicial||');';
                                 v_sqlIniVariables := v_sqlIniVariables || ic_genera_inicializacion_fn(rRegParam.nom_parametro, rRegParam.tip_dato, rRegParam.tip_origen, rRegParam.val_inicial);
                              END IF;

                              IF n_numparam = 1 THEN
                                 v_c_LlamadaAux := v_c_LlamadaAux||'('||rRegParam.nom_parametro;
                              ELSE
                                 v_c_LlamadaAux := v_c_LlamadaAux||', '||rRegParam.nom_parametro;
                              END IF;

                        END LOOP;
                          v_c_LlamadaAux := v_c_LlamadaAux||'); ';
                          v_c_IniVarAux := v_c_IniVarAux ||' '|| v_c_LlamadaAux;
               end if;

            end loop;
            v_v_bandera := 'Comienza a Cosntruir el Bloque SQL - FINAL.';
            v_SqlFinal:= 'DECLARE ' ;
            --DECLARACION DE VARIABLES
            v_SqlFinal:=v_SqlFinal || v_sqlVariables ;
            --VARIABLES FIJAS
            v_SqlFinal:=v_SqlFinal || v_sqlVarFijas ;

            v_SqlFinal:=v_SqlFinal || 'BEGIN ';
            --ASIGNACION DE VARIABLES
            v_SqlFinal:=v_SqlFinal || v_sqlIniVariables;

            --INICIALIZACION DE VARIABLES :=F(X)
            v_SqlFinal:=v_SqlFinal || v_c_IniVarAux;

            --EJECUCIÓN DE PLs
            v_SqlFinal:=v_SqlFinal || v_sqlLlamadas_fin;

            --EJECUCIÓN DE PLs
            v_SqlFinal:=v_SqlFinal || ' EXCEPTION ';
            v_SqlFinal:=v_SqlFinal || ' WHEN OTHERS THEN' ;
           -- v_SqlFinal := v_SqlFinal || ' v_error:= ''Error en  procedimiento:''||v_procedimiento; ' ;
            v_SqlFinal := v_SqlFinal || ' RAISE_APPLICATION_ERROR(-20199, ''IC_ACTRESPUESTAS_PG:  '' || V_PROCESO || ''-'' || SQLERRM, true);'  ;
            v_SqlFinal := v_SqlFinal || ' END;';


            -- AHORA SE TRABAJA EN LA EJECUCION DEL PL/SQL ANONIMO RECIEN CONSTRUIDO.

            v_v_bandera := 'Comienza Tratamiento dinámico del Bloque SQL - FINAL.';
            i_curdinamico := DBMS_SQL.OPEN_CURSOR;
            DBMS_SQL.PARSE(i_curdinamico, v_SqlFinal, DBMS_SQL.NATIVE);
            v_v_bandera := 'Abierto y Parseado el Cursor, comienza la asociación de parámetros.';

            FOR n_parse IN 0..ind_parametros -1 LOOP
                IF  UPPER(TRIM(tab_parametros(n_parse).t_v_valinicial)) <> 'NULL' THEN
                  IF tab_parametros(n_parse).t_v_num_parseo > 0 THEN
                     v_varparseo := ':'||tab_parametros(n_parse).t_v_num_parseo;

                     IF tab_parametros(n_parse).t_v_tip_origen = 'I'  THEN
                         v_valorparseo := ic_recupera_param_fn(tab_parametros(n_parse).t_v_nom_param, tab_parametros(n_parse).t_v_tip_dato, tab_parametros(n_parse).t_v_nom_origen );
                     ELSE
                         IF tab_parametros(n_parse).t_v_valinicial = '*' THEN
                               IF tab_parametros(n_parse).t_v_tip_dato = 'DATE'  THEN
                                     v_valorparseo := TO_CHAR(SYSDATE,fmt_DATE);
                                 ELSE
                                     v_valorparseo := NULL;
                                 END IF;
                           ELSE
                                    v_valorparseo := tab_parametros(n_parse).t_v_valinicial;
                           END IF;
                     END IF;

                     v_v_bandera := 'DBMS_SQL.BIND_VARIABLE:['||v_varparseo||'] con valor ['||v_valorparseo||'];';

                     DBMS_SQL.BIND_VARIABLE(i_curdinamico, v_varparseo, v_valorparseo);
                  END IF;
                END IF;
            END LOOP;

            v_v_bandera := 'Ejecuta el cursor dinamico .';
            n_rows := dbms_sql.execute(i_curdinamico);
            DBMS_SQL.close_cursor(i_curdinamico);

      EXCEPTION
             WHEN OTHERS THEN
                   BEGIN
						IF dbms_sql.is_open(i_curdinamico) THEN
							dbms_sql.close_cursor(i_curdinamico);
						END IF;
                        v_SqlFinal:=substr(v_SqlFinal,1,3000);
                          IF v_n_num_evento = -1 THEN
                                 v_n_num_evento := ge_errores_pg.grabarpl(0,'IC','Error en Actualización ICC_MOVIMIENTO','1',USER,'IC_ACTRESPUESTAS_PG',v_SqlFinal,SQLCODE,SQLERRM);
                          ELSE
                                 v_n_num_evento := ge_errores_pg.grabarpl(v_n_num_evento,'IC','Error en Actualización ICC_MOVIMIENTO','1',USER,'IC_ACTRESPUESTAS_PG',v_SqlFinal,SQLCODE, SQLERRM);
                          END IF;

                          RAISE_APPLICATION_ERROR(-20002, 'N° de Evento:'||to_char(v_n_num_evento)||' - Ocurrió un error al ejecutar las acciones asiociadas a la actuación.');
                     EXCEPTION
                          WHEN OTHERS THEN
                            RAISE_APPLICATION_ERROR(-20002, SQLERRM, FALSE);
                     END;
      END ic_principal_pr;
END ic_actrespuestas_pg;
/
