CREATE OR REPLACE PACKAGE BODY PV_EJECUTA_TRANS_OS_PG is

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
            Lv_n_num_movimiento NUMBER(9);

            CURSOR c_cursor_rutinas(EV_p_c_producto VARCHAR2,
			                        EV_p_c_acabo VARCHAR2,
									EV_p_c_mod VARCHAR2,
									EV_p_c_tecno VARCHAR2,
									EV_p_c_estado varchar2) IS
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
                                  b.cod_producto   = EV_p_c_producto
                              AND b.cod_actabo     = EV_p_c_acabo
                              AND b.cod_modulo     = EV_p_c_mod
                              AND b.cod_tecnologia = EV_p_c_tecno
							  AND B.flg_estado     = EV_p_c_estado
                              AND b.cod_rutina     = a.cod_rutina
                        ORDER BY b.num_orden;

            CURSOR c_cursor_parametros(EV_p_c_rutina VARCHAR2) IS
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
                               a.cod_rutina     = EV_p_c_rutina
                           and b.nom_parametro  = a.nom_parametro
                        ORDER BY a.num_orden;

            fmt_date CONSTANT VARCHAR2(18) := 'YYYYMMDDHH24MISS';



FUNCTION pv_retorna_version_fn RETURN VARCHAR2

IS
    CV_c_v_version    CONSTANT VARCHAR2(3) := '001';
    CV_c_v_subversion CONSTANT VARCHAR2(3) := '001';
BEGIN
   RETURN('Version : '||CV_c_v_version||' <--> SubVersion : '||CV_c_v_subversion);
END pv_retorna_version_fn;


FUNCTION PV_nuevomodulo_fn (EN_p_v_producto IN NUMBER,
                            EV_p_v_actabo IN VARCHAR2,
							EV_p_v_modulo IN VARCHAR2,
							EV_p_v_tecnologia IN VARCHAR2) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_nuevomodulo_fn  "
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EN_p_v_producto"       Tipo="numerico">producto</param>
			<param nom="EV_p_v_actabo  "       Tipo="varchar2">codigo actuacion</param>
			<param nom="EV_p_v_modulo "        Tipo="varchar2">modulo</param>
			<param nom="EV_p_v_tecnologia "    Tipo="varchar2">tecnologia</param>

		   </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/


IS



Lv_n_retorno NUMBER;

BEGIN

         SELECT
                 COUNT(cod_producto)
         INTO
                 Lv_n_retorno
         FROM
                 ic_rutinasactabo_td
         WHERE
              cod_producto  = EN_p_v_producto
          AND cod_actabo    = EV_p_v_actabo
          AND cod_modulo    = EV_p_v_modulo
          AND cod_tecnologia= EV_p_v_tecnologia;

       IF Lv_n_retorno > 0 THEN
          RETURN TRUE;
       ELSE
          RETURN FALSE;
       END IF;
EXCEPTION
  WHEN OTHERS THEN
       RETURN FALSE;
END PV_nuevomodulo_fn ;

PROCEDURE PV_initabparametros_pr
IS
BEGIN
      tab_parametros    := emp_parametros;
      ind_parametros    := 0;
      Lv_n_num_evento    := -1;
END PV_initabparametros_pr;

PROCEDURE PV_graba_tmpmov_pr (EN_p_n_producto IN NUMBER,
                              EV_p_rec_movcelular IN PV_TMPPARAMETROS_ENTRADA_TT%ROWTYPE)
IS

/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_graba_tmpmov_pr "
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EN_p_n_producto "       Tipo="varchar2">producto</param>
			<param nom="EV_p_rec_movcelular  "   Tipo="rowtype">registro de datos</param>
		   </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
SQLL VARCHAR(255);
BEGIN
       INSERT INTO PV_TMPPARAMETROS_ENTRADA_TT
               (
                   NUM_MOVIMIENTO
  				  ,COD_ACTABO
				  ,COD_PRODUCTO
				  ,COD_TECNOLOGIA
				  ,TIP_PANTALLA
				  ,COD_CONCEPTO
				  ,COD_MODULO
				  ,COD_PLANTARIF_NUE
				  ,COD_PLANTARIF_ANT
				  ,TIP_ABONADO
				  ,COD_OS
				  ,COD_CLIENTE
				  ,NUM_ABONADO
				  ,IND_FACTUR
				  ,COD_PLANSERV
				  ,COD_OPERACION
				  ,COD_TIPCONTRATO
				  ,TIP_CELULAR
				  ,NUM_MESES
				  ,COD_ANTIGUEDAD
				  ,COD_CICLO
				  ,NUM_CELULAR
				  ,TIP_SERVICIO
				  ,COD_PLANCOM
				  ,PARAM1_MENS
				  ,PARAM2_MENS
				  ,PARAM3_MENS
				  ,COD_ARTICULO
				  ,COD_CAUSA
				  ,COD_CAUSA_NUE
				  ,COD_VEND
				  ,COD_CATEGORIA
				  ,COD_MODVENTA
				  ,COD_CAUSINIE
                   )
       VALUES
               (
                  EV_p_rec_movcelular.NUM_MOVIMIENTO
				  ,EV_p_rec_movcelular.COD_ACTABO
				  ,EV_p_rec_movcelular.COD_PRODUCTO
				  ,EV_p_rec_movcelular.COD_TECNOLOGIA
				  ,EV_p_rec_movcelular.TIP_PANTALLA
				  ,EV_p_rec_movcelular.COD_CONCEPTO
				  ,EV_p_rec_movcelular.COD_MODULO
				  ,EV_p_rec_movcelular.COD_PLANTARIF_NUE
				  ,EV_p_rec_movcelular.COD_PLANTARIF_ANT
				  ,EV_p_rec_movcelular.TIP_ABONADO
				  ,EV_p_rec_movcelular.COD_OS
				  ,EV_p_rec_movcelular.COD_CLIENTE
				  ,EV_p_rec_movcelular.NUM_ABONADO
				  ,EV_p_rec_movcelular.IND_FACTUR
				  ,EV_p_rec_movcelular.COD_PLANSERV
				  ,EV_p_rec_movcelular.COD_OPERACION
				  ,EV_p_rec_movcelular.COD_TIPCONTRATO
				  ,EV_p_rec_movcelular.TIP_CELULAR
				  ,EV_p_rec_movcelular.NUM_MESES
				  ,EV_p_rec_movcelular.COD_ANTIGUEDAD
				  ,EV_p_rec_movcelular.COD_CICLO
				  ,EV_p_rec_movcelular.NUM_CELULAR
				  ,EV_p_rec_movcelular.TIP_SERVICIO
				  ,EV_p_rec_movcelular.COD_PLANCOM
				  ,EV_p_rec_movcelular.PARAM1_MENS
				  ,EV_p_rec_movcelular.PARAM2_MENS
				  ,EV_p_rec_movcelular.PARAM3_MENS
				  ,EV_p_rec_movcelular.COD_ARTICULO
				  ,EV_p_rec_movcelular.COD_CAUSA
				  ,EV_p_rec_movcelular.COD_CAUSA_NUE
				  ,EV_p_rec_movcelular.COD_VEND
				  ,EV_p_rec_movcelular.COD_CATEGORIA
				  ,EV_p_rec_movcelular.COD_MODVENTA
				  ,EV_p_rec_movcelular.COD_CAUSINIE

                   );
EXCEPTION
       WHEN OTHERS THEN
	  SQLL:= SQLERRM;
               RAISE;
END PV_graba_tmpmov_pr;

PROCEDURE PV_graba_param_pr (EV_p_v_parametro IN VARCHAR2,
                             EV_p_c_origen IN CHAR,
							 EN_p_n_parseo IN OUT NUMBER,
							 EV_p_v_tipdato IN VARCHAR2,
							 EV_p_v_origen IN VARCHAR2,
							 EV_p_v_inicial IN VARCHAR2)
/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_graba_param_pr"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_p_v_parametro "   Tipo="varchar2">PARAMETRO</param>
			<param nom="EV_p_c_origen  "    Tipo="varchar2">origen parametro</param>
			<param nom="EN_p_n_parseo   "   Tipo="varchar2">numero de parseo</param>
			<param nom="EV_p_v_tipdato  "   Tipo="varchar2">tipo de datos</param>
			<param nom="EV_p_v_origen"    Tipo="varchar2">valor origen</param>
			<param nom="EV_p_v_inicial  "   Tipo="varchar2">VALOR INICIAL</param>


		   </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

BEGIN
            tab_parametros(ind_parametros).t_v_nom_param     := EV_p_v_parametro;
            tab_parametros(ind_parametros).t_v_tip_origen    := EV_p_c_origen;
            tab_parametros(ind_parametros).t_v_tip_dato      := EV_p_v_tipdato;
            tab_parametros(ind_parametros).t_v_nom_origen    := EV_p_v_origen;
            tab_parametros(ind_parametros).t_v_valinicial    := EV_p_v_inicial;

            IF EV_p_c_origen = 'I' THEN
               IF UPPER(TRIM(EV_p_v_inicial)) <> 'NULL' THEN
                  EN_p_n_parseo := EN_p_n_parseo + 1;
                  tab_parametros(ind_parametros).t_v_num_parseo := EN_p_n_parseo;
               END IF;
            ELSE
               IF EV_p_v_inicial <> '*' AND UPPER(TRIM(EV_p_v_inicial)) <> 'NULL' THEN
                     EN_p_n_parseo := EN_p_n_parseo + 1;
                     tab_parametros(ind_parametros).t_v_num_parseo := EN_p_n_parseo;
               ELSE
                       IF EV_p_v_tipdato = 'DATE' AND UPPER(TRIM(EV_p_v_inicial)) <> 'NULL' THEN
                          EN_p_n_parseo := EN_p_n_parseo + 1;
                          tab_parametros(ind_parametros).t_v_num_parseo := EN_p_n_parseo;
                       ELSE
					      IF UPPER(TRIM(EV_p_v_inicial)) <> 'NULL' THEN
                             tab_parametros(ind_parametros).t_v_num_parseo := -1;
						  END IF;
                       END IF;
               END IF;
            END IF;

    ind_parametros := ind_parametros + 1;
END PV_graba_param_pr;

FUNCTION PV_genera_declare_fn (EV_p_v_parametro IN VARCHAR2,
                               EV_p_v_tipvalor  IN VARCHAR2,
							   EV_p_v_inicial   IN VARCHAR2)
							   RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_genera_declare_fn"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_p_v_parametro "   Tipo="varchar2">PARAMETRO</param>
			<param nom="EV_p_v_tipvalor "    Tipo="varchar2">TIPO valor</param>
			<param nom="EV_p_v_inicial   "   Tipo="varchar2">VALOR INICIAL</param>

		   </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

            Lv_sqldeclare VARCHAR2(150) := '';
BEGIN
            IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
               Lv_sqldeclare := ' '||EV_p_v_parametro||' '||EV_p_v_tipvalor||';';
            ELSE
               Lv_sqldeclare := ' '||EV_p_v_parametro||' '||EV_p_v_tipvalor||'%TYPE;';
            END IF;
            RETURN Lv_sqldeclare;

END PV_genera_declare_fn;

FUNCTION PV_genera_inicializacion_fn (EV_p_v_parametro IN VARCHAR2,
                                      EV_p_v_tipdato IN VARCHAR2,
									  EV_p_c_tiporigen IN CHAR,
									  EV_p_v_inicial IN VARCHAR2) RETURN VARCHAR2
/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_genera_inicializacion_fn"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_p_v_parametro "   Tipo="varchar2">PARAMETRO</param>
			<param nom="EV_p_v_tipdato  "   Tipo="varchar2">TIPO DE DATO</param>
			<param nom="EV_p_c_tiporigen "   Tipo="CHAR">TIPO ORIGEN</param>
			<param nom="EV_p_v_inicial   "   Tipo="varchar2">VALOR INICIAL</param>

		   </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

          Lv_sqlinicialice VARCHAR2(2000) := '';
BEGIN

          IF EV_p_c_tiporigen = 'I' THEN
                  IF EV_p_v_tipdato = 'VARCHAR2' THEN
                     IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
                        Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                     ELSE
                        Lv_sqlinicialice := ' '||EV_p_v_parametro||' := :'||tab_parametros(ind_parametros-1).t_v_num_parseo||'; ';
                     END IF;
                  ELSIF EV_p_v_tipdato = 'NUMBER' THEN
                      IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
                         Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                      ELSE
                        Lv_sqlinicialice := ' '||EV_p_v_parametro||' := TO_NUMBER(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||'); ';
                      END IF;
                ELSIF EV_p_v_tipdato = 'DATE' THEN
                      IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
                         Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                      ELSE
                         Lv_sqlinicialice := ' '||EV_p_v_parametro||' := TO_DATE(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||','''||fmt_date||'''); ';
                      END IF;
                END IF;
          ELSE
                  IF EV_p_v_inicial = '*' THEN
                     IF EV_p_v_tipdato = 'DATE' THEN
                       IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
                          Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                       ELSE
                          Lv_sqlinicialice := ' '||EV_p_v_parametro||' := TO_DATE(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||','''||fmt_date||'''); ';
                       END IF;
                     ELSE
                        Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                     END IF;
                  ELSE
                     IF EV_p_v_tipdato = 'VARCHAR2' THEN
                        Lv_sqlinicialice := ' '||EV_p_v_parametro||' := :'||tab_parametros(ind_parametros-1).t_v_num_parseo||'; ';
                     ELSIF EV_p_v_tipdato = 'NUMBER' THEN
                        IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
                           Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                        ELSE
                          Lv_sqlinicialice := ' '||EV_p_v_parametro||' := TO_NUMBER(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||'); ';
                       END IF;
                    ELSIF EV_p_v_tipdato = 'DATE' THEN
                       IF UPPER(TRIM(EV_p_v_inicial)) = 'NULL' THEN
                          Lv_sqlinicialice := ' '||EV_p_v_parametro||' := NULL;';
                       ELSE
                          Lv_sqlinicialice := ' '||EV_p_v_parametro||' := TO_DATE(:'||tab_parametros(ind_parametros-1).t_v_num_parseo||','''||fmt_date||'''); ';
                       END IF;
                    END IF;
                 END IF;
        END IF;

        RETURN Lv_sqlinicialice;
END PV_genera_inicializacion_fn;

FUNCTION PV_existe_param_fn (EV_p_v_parametro IN VARCHAR2) RETURN BOOLEAN
/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_existe_param_fn"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_p_v_parametro  "   Tipo="varchar2">PARAMETRO</param>
		   </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

    Ln_rownum    BINARY_INTEGER := 0;
    LN_b_existe    BOOLEAN := FALSE;
BEGIN
   WHILE (Ln_rownum <= ind_parametros -1) AND NOT LN_b_existe
   LOOP
           IF tab_parametros(Ln_rownum).t_v_nom_param = EV_p_v_parametro THEN
               LN_b_existe := TRUE;
           ELSE
              Ln_rownum := Ln_rownum +1;
           END IF;

   END LOOP;
   IF LN_b_existe THEN
        RETURN TRUE;
   ELSE
        RETURN FALSE;
   END IF;
END PV_existe_param_fn;

FUNCTION PV_recupera_param_fn(EV_p_v_parametro IN VARCHAR2,
                              EV_p_v_tipdato   IN VARCHAR2,
							  EV_p_v_origen IN VARCHAR2) RETURN VARCHAR2

/*
<Documentación
  TipoDoc = "FUNCIÓN">
   <Elemento
      Nombre = "PV_recupera_param_fn"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_p_v_parametro  "   Tipo="varchar2">PARAMETRO</param>
			<param nom="EV_p_v_tipdato "      Tipo="VARCHAR2">TIPO DE DATO</param>
			<param nom="EV_p_v_origen "	      Tipo="VARCHAR2">ORIGEN DEL PARAMETRO</param>
	     </Entrada>
         <Salida>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    Lv_stmsql          VARCHAR2(300);
    Lv_valorparam      VARCHAR2(300);
BEGIN
    Lv_stmsql := 'SELECT ';

      IF EV_p_v_tipdato = 'VARCHAR2' THEN
         Lv_stmsql := Lv_stmsql ||EV_p_v_origen||' ';
      ELSIF EV_p_v_tipdato = 'NUMBER' THEN
         Lv_stmsql := Lv_stmsql ||'TO_CHAR('||EV_p_v_origen||') ';
      ELSIF EV_p_v_tipdato = 'DATE' THEN
         Lv_stmsql := Lv_stmsql ||'TO_CHAR('||EV_p_v_origen||','''||fmt_date||''') ';
      END IF;

      Lv_stmsql := Lv_stmsql ||' FROM PV_TMPPARAMETROS_ENTRADA_TT ';
      Lv_stmsql := Lv_stmsql ||' WHERE num_movimiento = '||Lv_n_num_movimiento;
      EXECUTE IMMEDIATE Lv_stmsql INTO Lv_valorparam;
      RETURN Lv_valorparam;
EXCEPTION
    WHEN OTHERS THEN
             RAISE;
END PV_recupera_param_fn;


PROCEDURE PV_FACHADA_PARAMETRO(
                           EN_NUM_MOVIMIENTO     IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MOVIMIENTO%TYPE,
						   EV_COD_ACTABO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
						   EN_COD_PRODUCTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
				 		   EV_COD_TECNOLOGIA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TECNOLOGIA%TYPE,
						   EN_TIP_PANTALLA       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_PANTALLA%TYPE,
						   EN_COD_CONCEPTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CONCEPTO%TYPE,
						   EV_COD_MODULO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODULO%TYPE,
						   EV_COD_PLANTARIF_NUE  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_NUE%TYPE,
						   EV_COD_PLANTARIF_ANT  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_ANT%TYPE,
						   EN_TIP_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
						   EV_COD_OS             IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
						   EN_COD_CLIENTE        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
						   EN_NUM_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
						   EN_IND_FACTUR         IN PV_TMPPARAMETROS_ENTRADA_TT.IND_FACTUR%TYPE,
						   EV_COD_PLANSERV       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
						   EV_COD_OPERACION      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
						   EV_COD_TIPCONTRATO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
						   EN_TIP_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_CELULAR%TYPE,
						   EN_NUM_MESES          IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
						   EV_COD_ANTIGUEDAD     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
						   EN_COD_CICLO          IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CICLO%TYPE,
						   EN_NUM_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
						   EN_TIP_SERVICIO       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
						   EN_COD_PLANCOM        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
						   EV_PARAM1_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
						   EV_PARAM2_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
						   EV_PARAM3_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
						   EN_COD_ARTI           IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
						   EV_COD_CAUSA   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
						   EV_COD_CAUSA_NUE 	 IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
						   EN_COD_VENDE   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
						   EV_COD_CATEG   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
						   EN_COD_MODVTA   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
						   EV_COD_CAUSINIE   	 IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSINIE%TYPE,
						   SV_record     out nocopy refcursor)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_PROG_PRINCIPAL"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EN_NUM_MOVIMIENTO  "   Tipo="NUMERICO">numero movimiento</param>
			<param nom="EV_COD_ACTABO      "   Tipo="varchar2">codigo actuacion comercial</param>
			<param nom="EN_COD_PRODUCTO    "   Tipo="NUMERICO">codigo producto</param>
			<param nom="EV_COD_TECNOLOGIA  "   Tipo="varchar2">codigo tecnologia</param>
			<param nom="EN_TIP_PANTALLA    "   Tipo="NUMERICO">tipo pantalla</param>
			<param nom="EN_COD_CONCEPTO    "   Tipo="NUMERICO">codigo concepto</param>
			<param nom="EV_COD_MODULO      "   Tipo="varchar2">codigo modulo</param>
			<param nom="EV_COD_PLANTARIF_NUE"  Tipo="varchar2">plan nuevo</param>
			<param nom="EV_COD_PLANTARIF_ANT"  Tipo="varchar2">plan antiguo</param>
			<param nom="EN_TIP_ABONADO     "   Tipo="NUMERICO">tipo abonado</param>
			<param nom="EV_COD_OS          "   Tipo="varchar2">codigo ooss</param>
			<param nom="EN_COD_CLIENTE     "   Tipo="NUMERICO">codigo cliente</param>
			<param nom="EN_NUM_ABONADO     "   Tipo="NUMERICO">numero abonado</param>
			<param nom="EN_IND_FACTUR      "   Tipo="NUMERICO">indicador de facturación</param>
			<param nom="EV_COD_PLANSERV    "   Tipo="varchar2">codigo plan de servicio</param>
			<param nom="EV_COD_OPERACION   "   Tipo="varchar2">codigo de operacion</param>
			<param nom="EV_COD_TIPCONTRATO "   Tipo="varchar2">codigo tipo contrato</param>
			<param nom="EN_TIP_CELULAR     "   Tipo="NUMERICO">TIPO CELULAR</param>
			<param nom="EN_NUM_MESES       "   Tipo="NUMERICO">NUMERO DE MESES</param>
			<param nom="EV_COD_ANTIGUEDAD  "   Tipo="varchar2">CODIGO ANTIGUEDAD</param>
			<param nom="EN_COD_CICLO       "   Tipo="NUMERICO">CODIGO CICLO</param>
			<param nom="EN_NUM_CELULAR     "   Tipo="NUMERICO">NUMERO CELULAR</param>
			<param nom="EN_TIP_SERVICIO    "   Tipo="NUMERICO">TIPO SERVICIO</param>
			<param nom="EN_COD_PLANCOM     "   Tipo="NUMERICO">CODIGO PLAN COMERCIAL</param>
			<param nom="EV_PARAM1_MENS     "   Tipo="varchar2">PARAMETRO DE MENSAJE 1</param>
			<param nom="EV_PARAM2_MENS     "   Tipo="varchar2">PARAMETRO DE MENSAJE 2</param>
			<param nom="EV_PARAM3_MENS     "   Tipo="varchar2">PARAMETRO DE MENSAJE 3</param>

	     </Entrada>
         <Salida>
    		<param nom="SV_RECORD"          Tipo="REFCURSOR">REGISTRO DE DATOS</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

LV_REGISTRO   PV_TMPPARAMETROS_ENTRADA_TT%ROWTYPE;
Lv_SqlFinal         VARCHAR2(5000);

BEGIN


      LV_REGISTRO.NUM_MOVIMIENTO   :=                EN_NUM_MOVIMIENTO;
      LV_REGISTRO.COD_ACTABO       :=                EV_COD_ACTABO    ;
	  LV_REGISTRO.COD_PRODUCTO     :=                EN_COD_PRODUCTO  ;
	  LV_REGISTRO.COD_TECNOLOGIA   :=                EV_COD_TECNOLOGIA;
	  LV_REGISTRO.TIP_PANTALLA     :=                EN_TIP_PANTALLA  ;
	  LV_REGISTRO.COD_CONCEPTO     :=                EN_COD_CONCEPTO  ;
	  LV_REGISTRO.COD_MODULO       :=                EV_COD_MODULO    ;
	  LV_REGISTRO.COD_PLANTARIF_NUE:=                EV_COD_PLANTARIF_NUE;
	  LV_REGISTRO.COD_PLANTARIF_ANT:=                EV_COD_PLANTARIF_ANT;
	  LV_REGISTRO.TIP_ABONADO      :=                EN_TIP_ABONADO      ;
	  LV_REGISTRO.COD_OS           :=                EV_COD_OS           ;
	  LV_REGISTRO.COD_CLIENTE      :=                EN_COD_CLIENTE      ;
	  LV_REGISTRO.NUM_ABONADO      :=                EN_NUM_ABONADO      ;
	  LV_REGISTRO.IND_FACTUR       :=                EN_IND_FACTUR       ;
	  LV_REGISTRO.COD_PLANSERV     :=                EV_COD_PLANSERV     ;
	  LV_REGISTRO.COD_OPERACION    :=                EV_COD_OPERACION    ;
	  LV_REGISTRO.COD_TIPCONTRATO  :=                EV_COD_TIPCONTRATO  ;
	  LV_REGISTRO.TIP_CELULAR      :=                EN_TIP_CELULAR      ;
	  LV_REGISTRO.NUM_MESES        :=                EN_NUM_MESES        ;
	  LV_REGISTRO.COD_ANTIGUEDAD   :=                EV_COD_ANTIGUEDAD   ;
	  LV_REGISTRO.COD_CICLO        :=                EN_COD_CICLO        ;
	  LV_REGISTRO.NUM_CELULAR      :=                EN_NUM_CELULAR      ;
	  LV_REGISTRO.TIP_SERVICIO     :=                EN_TIP_SERVICIO     ;
	  LV_REGISTRO.COD_PLANCOM      :=                EN_COD_PLANCOM      ;
	  LV_REGISTRO.PARAM1_MENS      :=                EV_PARAM1_MENS      ;
	  LV_REGISTRO.PARAM2_MENS      :=                EV_PARAM2_MENS      ;
	  LV_REGISTRO.PARAM3_MENS      :=                EV_PARAM3_MENS   	 ;
	  LV_REGISTRO.COD_ARTICULO     :=                EN_COD_ARTI   	 	 ;
	  LV_REGISTRO.COD_CAUSA        :=                EV_COD_CAUSA  	 	 ;
	  LV_REGISTRO.COD_CAUSA_NUE    :=                EV_COD_CAUSA_NUE 	 ;
	  LV_REGISTRO.COD_VEND         :=                EN_COD_VENDE 		 ;
	  LV_REGISTRO.COD_CATEGORIA    :=                EV_COD_CATEG  	 	 ;
	  LV_REGISTRO.COD_MODVENTA     :=                EN_COD_MODVTA   	 ;
	  LV_REGISTRO.COD_CAUSINIE    :=                 EV_COD_CAUSINIE     ;




	  Lv_SqlFinal := 'PV_EJECUTA_TRANS_OS_PG.PV_PROG_PRINCIPAL('||EV_COD_ACTABO ||','||EV_COD_MODULO||','||EN_COD_PRODUCTO||','||EV_COD_TECNOLOGIA||')';
      dbms_output.put_line(' PV_EJECUTA_TRANS_OS_PG.PV_PROG_PRINCIPAL: '||Lv_SqlFinal );
	  PV_EJECUTA_TRANS_OS_PG.PV_PROG_PRINCIPAL(EV_COD_ACTABO,EV_COD_MODULO,EN_COD_PRODUCTO,EV_COD_TECNOLOGIA,LV_REGISTRO,SV_record);
      dbms_output.put_line('se ejecuto ');
	  Lv_SqlFinal :='';
	  EXCEPTION
             WHEN OTHERS THEN
                   BEGIN
                          IF Lv_n_num_evento = -1 THEN
                                 Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en Llamada a PV_EJECUTA_TRANS_OS_PG.PV_PROG_PRINCIPAL','1',USER,'PV_EJECUTA_TRANS_OS_PG',Lv_SqlFinal,SQLCODE,SQLERRM);
                          ELSE
                                 Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en Llamada a PV_EJECUTA_TRANS_OS_PG.PV_PROG_PRINCIPAL','1',USER,'PV_EJECUTA_TRANS_OS_PG',Lv_SqlFinal,SQLCODE, SQLERRM);
                          END IF;
                          dbms_output.put_line('ERROR PV_EJECUTA_TRANS_OS_PG.PV_PROG_PRINCIPAL ');

                               RAISE_APPLICATION_ERROR(-20002, 'N° de Evento:'||to_char(Lv_n_num_evento)||' - Ocurrió un error al ejecutar las acciones asiociadas a la actuación.');
                    END;
END PV_FACHADA_PARAMETRO;

PROCEDURE PV_FACHADA_PARAMETRO_ODBC(
                           EN_NUM_MOVIMIENTO     IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MOVIMIENTO%TYPE,
						   EV_COD_ACTABO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ACTABO%TYPE,
						   EN_COD_PRODUCTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
				 		   EV_COD_TECNOLOGIA     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TECNOLOGIA%TYPE,
						   EN_TIP_PANTALLA       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_PANTALLA%TYPE,
						   EN_COD_CONCEPTO       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CONCEPTO%TYPE,
						   EV_COD_MODULO         IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODULO%TYPE,
						   EV_COD_PLANTARIF_NUE  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_NUE%TYPE,
						   EV_COD_PLANTARIF_ANT  IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANTARIF_ANT%TYPE,
						   EN_TIP_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_ABONADO%TYPE,
						   EV_COD_OS             IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OS%TYPE,
						   EN_COD_CLIENTE        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CLIENTE%TYPE,
						   EN_NUM_ABONADO        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_ABONADO%TYPE,
						   EN_IND_FACTUR         IN PV_TMPPARAMETROS_ENTRADA_TT.IND_FACTUR%TYPE,
						   EV_COD_PLANSERV       IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANSERV%TYPE,
						   EV_COD_OPERACION      IN PV_TMPPARAMETROS_ENTRADA_TT.COD_OPERACION%TYPE,
						   EV_COD_TIPCONTRATO    IN PV_TMPPARAMETROS_ENTRADA_TT.COD_TIPCONTRATO%TYPE,
						   EN_TIP_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_CELULAR%TYPE,
						   EN_NUM_MESES          IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_MESES%TYPE,
						   EV_COD_ANTIGUEDAD     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ANTIGUEDAD%TYPE,
						   EN_COD_CICLO          IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CICLO%TYPE,
						   EN_NUM_CELULAR        IN PV_TMPPARAMETROS_ENTRADA_TT.NUM_CELULAR%TYPE,
						   EN_TIP_SERVICIO       IN PV_TMPPARAMETROS_ENTRADA_TT.TIP_SERVICIO%TYPE,
						   EN_COD_PLANCOM        IN PV_TMPPARAMETROS_ENTRADA_TT.COD_PLANCOM%TYPE,
						   EV_PARAM1_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM1_MENS%TYPE,
						   EV_PARAM2_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM2_MENS%TYPE,
						   EV_PARAM3_MENS        IN PV_TMPPARAMETROS_ENTRADA_TT.PARAM3_MENS%TYPE,
						   EN_COD_ARTI           IN PV_TMPPARAMETROS_ENTRADA_TT.COD_ARTICULO%TYPE,
						   EV_COD_CAUSA   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA%TYPE,
						   EV_COD_CAUSA_NUE 	 IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSA_NUE%TYPE,
						   EN_COD_VENDE   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_VEND%TYPE,
						   EV_COD_CATEG   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CATEGORIA%TYPE,
						   EN_COD_MODVTA   	     IN PV_TMPPARAMETROS_ENTRADA_TT.COD_MODVENTA%TYPE,
						   EV_COD_CAUSINIE   	 IN PV_TMPPARAMETROS_ENTRADA_TT.COD_CAUSINIE%TYPE)
--						   SV_record       		 out nocopy refcursor)

/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_PROG_PRINCIPAL"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EN_NUM_MOVIMIENTO  "   Tipo="NUMERICO">numero movimiento</param>
			<param nom="EV_COD_ACTABO      "   Tipo="varchar2">codigo actuacion comercial</param>
			<param nom="EN_COD_PRODUCTO    "   Tipo="NUMERICO">codigo producto</param>
			<param nom="EV_COD_TECNOLOGIA  "   Tipo="varchar2">codigo tecnologia</param>
			<param nom="EN_TIP_PANTALLA    "   Tipo="NUMERICO">tipo pantalla</param>
			<param nom="EN_COD_CONCEPTO    "   Tipo="NUMERICO">codigo concepto</param>
			<param nom="EV_COD_MODULO      "   Tipo="varchar2">codigo modulo</param>
			<param nom="EV_COD_PLANTARIF_NUE"  Tipo="varchar2">plan nuevo</param>
			<param nom="EV_COD_PLANTARIF_ANT"  Tipo="varchar2">plan antiguo</param>
			<param nom="EN_TIP_ABONADO     "   Tipo="NUMERICO">tipo abonado</param>
			<param nom="EV_COD_OS          "   Tipo="varchar2">codigo ooss</param>
			<param nom="EN_COD_CLIENTE     "   Tipo="NUMERICO">codigo cliente</param>
			<param nom="EN_NUM_ABONADO     "   Tipo="NUMERICO">numero abonado</param>
			<param nom="EN_IND_FACTUR      "   Tipo="NUMERICO">indicador de facturación</param>
			<param nom="EV_COD_PLANSERV    "   Tipo="varchar2">codigo plan de servicio</param>
			<param nom="EV_COD_OPERACION   "   Tipo="varchar2">codigo de operacion</param>
			<param nom="EV_COD_TIPCONTRATO "   Tipo="varchar2">codigo tipo contrato</param>
			<param nom="EN_TIP_CELULAR     "   Tipo="NUMERICO">TIPO CELULAR</param>
			<param nom="EN_NUM_MESES       "   Tipo="NUMERICO">NUMERO DE MESES</param>
			<param nom="EV_COD_ANTIGUEDAD  "   Tipo="varchar2">CODIGO ANTIGUEDAD</param>
			<param nom="EN_COD_CICLO       "   Tipo="NUMERICO">CODIGO CICLO</param>
			<param nom="EN_NUM_CELULAR     "   Tipo="NUMERICO">NUMERO CELULAR</param>
			<param nom="EN_TIP_SERVICIO    "   Tipo="NUMERICO">TIPO SERVICIO</param>
			<param nom="EN_COD_PLANCOM     "   Tipo="NUMERICO">CODIGO PLAN COMERCIAL</param>
			<param nom="EV_PARAM1_MENS     "   Tipo="varchar2">PARAMETRO DE MENSAJE 1</param>
			<param nom="EV_PARAM2_MENS     "   Tipo="varchar2">PARAMETRO DE MENSAJE 2</param>
			<param nom="EV_PARAM3_MENS     "   Tipo="varchar2">PARAMETRO DE MENSAJE 3</param>

	     </Entrada>
         <Salida>
    		<param nom="SV_RECORD"          Tipo="REFCURSOR">REGISTRO DE DATOS</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS

  TYPE refcursor IS REF CURSOR;
  lv_record  refcursor;
BEGIN


	 PV_EJECUTA_TRANS_OS_PG.PV_FACHADA_PARAMETRO(EN_NUM_MOVIMIENTO, EV_COD_ACTABO, EN_COD_PRODUCTO,
	 										     EV_COD_TECNOLOGIA, EN_TIP_PANTALLA, EN_COD_CONCEPTO,
												 EV_COD_MODULO, EV_COD_PLANTARIF_NUE, EV_COD_PLANTARIF_ANT,
												 EN_TIP_ABONADO, EV_COD_OS, EN_COD_CLIENTE, EN_NUM_ABONADO,
												 EN_IND_FACTUR, EV_COD_PLANSERV, EV_COD_OPERACION,
												 EV_COD_TIPCONTRATO, EN_TIP_CELULAR, EN_NUM_MESES,
												 EV_COD_ANTIGUEDAD, EN_COD_CICLO, EN_NUM_CELULAR, EN_TIP_SERVICIO,
												 EN_COD_PLANCOM, EV_PARAM1_MENS, EV_PARAM2_MENS, EV_PARAM3_MENS,
												 EN_COD_ARTI, EV_COD_CAUSA, EV_COD_CAUSA_NUE, EN_COD_VENDE,
												 EV_COD_CATEG, EN_COD_MODVTA, EV_COD_CAUSINIE, lv_record);



END PV_FACHADA_PARAMETRO_ODBC;


PROCEDURE PV_PROG_PRINCIPAL(
                           EV_COD_ACTABO     IN  icc_movimiento.COD_ACTABO%TYPE,
 		  				   EV_COD_MODULO     IN  icc_movimiento.COD_MODULO%TYPE,
						   EN_COD_PRODUCTO   IN  PV_TMPPARAMETROS_ENTRADA_TT.COD_PRODUCTO%TYPE,
						   EV_COD_TECNOLOGIA IN  PV_TMPPARAMETROS_ENTRADA_TT.COD_TECNOLOGIA%TYPE,
						   EN_MOVIMIENTO     IN  PV_TMPPARAMETROS_ENTRADA_TT%ROWTYPE,
                           SV_record       out nocopy refcursor)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_PROG_PRINCIPAL"
      Lenguaje="PL/SQL"
      Fecha="13-11-2006"
      Versión="1.0"
      Diseñador="Orlando Cabezas / Ricardo Roco"
      Programador="Orlando Cabezas B"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_COD_ACTABO   "   Tipo="varchar2">codigo actuacion comercial</param>
			<param nom="EV_MODULO"          Tipo="VARCHAR2">codigo modulo</param>
			<param nom="EN_cod_producto "	Tipo="NUMERICO">PRODUCTO</param>
			<param nom="EN_cod_tecnologia"	Tipo="VARCHAR2">TECNOLOGIA</param>
			<param nom="EV_movimiento"      Tipo="ROW|TYPE">ESTRUCTURA DE DATOS</param>
	     </Entrada>
         <Salida>
    		<param nom="SV_RECORD"          Tipo="REFCURSOR">REGISTRO DE DATOS</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/

IS
      Lv_sqlVarFijas      VARCHAR2(3000);
      Lv_sqlVariables     VARCHAR2(3000):='';
      Lv_sqlIniVariables  VARCHAR2(3000):='';
      Lv_sqlLlamadas      VARCHAR2(3000):= '';
      Lv_sqlLlamadas_fin  VARCHAR2(5000):= '';
      Lv_SqlFinal         VARCHAR2(32000):= '';
      Lv_c_comando        VARCHAR2(3000);
      Lv_c_LlamadaAux     VARCHAR2(3000);
      Lv_c_IniVarAux      VARCHAR2(3000);
      Lv_c_actabo         VARCHAR2(2);
      Lv_c_modulo         VARCHAR2(2);
      Lv_c_tecnologia     VARCHAR2(7);
      Lv_glosa            VARCHAR2(500);
      Ln_numparam         NUMBER(2);
      Ln_numparseo        NUMBER(2);

      Li_curdinamico      INTEGER;
      Lv_varparseo        VARCHAR2(4);
      Lv_valorparseo      VARCHAR2(300);

      Ln_rows             NUMBER(5);
	  LN_FLG_REG		  NUMBER(1);

      Lv_n_evento         NUMBER(9);

      pl_block_error     EXCEPTION;
      Lv_v_bandera        VARCHAR2(3000);

      PRAGMA EXCEPTION_INIT(pl_block_error, -20100);

BEGIN
					dbms_output.put_line('1');

            PV_initabparametros_pr();

            Lv_c_actabo := EV_COD_ACTABO;
            Lv_c_modulo := EV_COD_MODULO  ;
            Lv_c_tecnologia := EV_COD_TECNOLOGIA;
            Lv_v_bandera := 'PV_graba_tmpmov_pr (EN_COD_PRODUCTO,EN_MOVIMIENTO);';
            PV_graba_tmpmov_pr (EN_COD_PRODUCTO,EN_MOVIMIENTO);
            LV_n_num_movimiento := EN_MOVIMIENTO.NUM_MOVIMIENTO;

            Lv_sqlVarFijas := ' Lv_procedimiento         VARCHAR2(800); ' ;
            Lv_sqlVarFijas := Lv_sqlVarFijas || ' Lv_error         VARCHAR2(800); ';
            Lv_c_comando := '';
            Lv_sqlLlamadas := '';
            Lv_sqlVariables := '';
            Ln_numparseo:= 0;
			LN_FLG_REG	:=0;
			
								dbms_output.put_line('2');
								
                                
            FOR rReg IN c_cursor_rutinas(EN_COD_PRODUCTO,Lv_c_actabo,Lv_c_modulo,Lv_c_tecnologia,CV_ESTADO) LOOP
			      LN_FLG_REG	:=1;
                  Lv_v_bandera := 'c_cursor_rutinas('||EN_COD_PRODUCTO||','||Lv_c_actabo||','||Lv_c_modulo||','||Lv_c_tecnologia||','||CV_ESTADO||');';
                  Lv_sqlLlamadas := UPPER(rReg.nom_fisico);
                  Lv_c_comando := ' Lv_procedimiento :=''['||UPPER(rReg.nom_fisico);
                  Ln_numparam := 0;
				  			  
				dbms_output.put_line(Lv_c_comando);
							  
                  FOR rRegParam IN c_cursor_parametros(rReg.cod_rutina) LOOP
                        IF Ln_numparam = 0 THEN
                           Lv_c_comando := Lv_c_comando ||'(''||';
                        END IF;
                        Lv_v_bandera := 'c_cursor_parametros('||rReg.cod_rutina||');';
                        Ln_numparam := Ln_numparam + 1;

                        Lv_v_bandera := 'IF NOT PV_existe_param_fn('||rRegParam.nom_parametro||');';

                        IF NOT PV_existe_param_fn(rRegParam.nom_parametro) THEN
                           Lv_v_bandera := 'PV_graba_param_pr('||rRegParam.nom_parametro||','||rRegParam.tip_origen||','||Ln_numparseo||','||rRegParam.tip_dato||','||rRegParam.nom_origen||','||rRegParam.val_inicial||');';
                           PV_graba_param_pr(rRegParam.nom_parametro, rRegParam.tip_origen, Ln_numparseo, rRegParam.tip_dato, rRegParam.nom_origen, rRegParam.val_inicial);

                           Lv_v_bandera := 'PV_genera_declare_fn('||rRegParam.nom_parametro||','||rRegParam.tip_valor||','||rRegParam.val_inicial ||')';
                           Lv_sqlVariables := Lv_sqlVariables || pv_genera_declare_fn(rRegParam.nom_parametro, rRegParam.tip_valor,rRegParam.val_inicial);

                           Lv_v_bandera := 'PV_genera_inicializacion_fn('||rRegParam.nom_parametro||','||rRegParam.tip_dato||','||rRegParam.tip_origen||','||rRegParam.val_inicial||');';
                           Lv_sqlIniVariables := Lv_sqlIniVariables || pv_genera_inicializacion_fn(rRegParam.nom_parametro, rRegParam.tip_dato, rRegParam.tip_origen, rRegParam.val_inicial);
                        END IF;

                        IF Ln_numparam = 1 THEN
                           Lv_sqlLlamadas := Lv_sqlLlamadas||'('||rRegParam.nom_parametro;
                        ELSE
                           Lv_sqlLlamadas := Lv_sqlLlamadas||', '||rRegParam.nom_parametro;
                           Lv_c_comando := Lv_c_comando ||'||'',''|| ';
                        END IF;

                        IF rRegParam.tip_dato = 'VARCHAR2' THEN
                                   Lv_c_comando := Lv_c_comando ||rRegParam.nom_parametro;
                        ELSIF rRegParam.tip_dato = 'NUMBER' THEN
                                  IF UPPER(TRIM(rRegParam.val_inicial)) = 'NULL' THEN
                                     Lv_c_comando := Lv_c_comando ||rRegParam.nom_parametro;
                                  ELSE
                                     Lv_c_comando := Lv_c_comando ||'TO_CHAR('||rRegParam.nom_parametro||')';
                                  END IF;
                        ELSIF rRegParam.tip_dato = 'DATE' THEN
                                  IF UPPER(TRIM(rRegParam.val_inicial)) = 'NULL' THEN
                                     Lv_c_comando := Lv_c_comando ||rRegParam.nom_parametro;
                                  ELSE
                                     Lv_c_comando := Lv_c_comando ||'TO_CHAR('||rRegParam.nom_parametro||','''||fmt_date||''')';
                                  END IF;
                        END IF ;
                  END LOOP;
                  IF Ln_numparam > 0 THEN
                        Lv_sqlLlamadas := Lv_sqlLlamadas||');';
                        Lv_c_comando := Lv_c_comando ||'||'')]'';';
                  ELSE
                        Lv_sqlLlamadas := Lv_sqlLlamadas||';';
                        Lv_c_comando := Lv_c_comando ||']'';';
                  END IF;
                  Lv_sqlLlamadas_fin := Lv_sqlLlamadas_fin ||' '||Lv_sqlLlamadas   ;
            END LOOP;



			IF   LN_FLG_REG	= 1 THEN
		            Lv_c_IniVarAux := '';
                    for Ln_indice in 0..ind_parametros - 1 LOOP
                       Lv_v_bandera := 'IF '||tab_parametros(Ln_indice).t_v_tip_origen||' = ''F'' then';
                       IF tab_parametros(Ln_indice).t_v_tip_origen = 'F' then

                                Lv_c_LlamadaAux := tab_parametros(Ln_indice).t_v_nom_param || ':=' || tab_parametros(Ln_indice).t_v_nom_origen;
                                Ln_numparam := 0;
                                FOR rRegParam IN c_cursor_parametros(tab_parametros(Ln_indice).t_v_nom_origen) LOOP
                                      Lv_v_bandera := '[origen: FUNCION] c_cursor_parametros('||tab_parametros(Ln_indice).t_v_nom_origen||');';
                                      Ln_numparam := Ln_numparam + 1;
                                      IF NOT pv_existe_param_fn(rRegParam.nom_parametro) THEN
                                         Lv_v_bandera := 'PV_graba_param_pr('||rRegParam.nom_parametro||','||rRegParam.tip_origen||','||Ln_numparseo||','||rRegParam.tip_dato||','||rRegParam.nom_origen||','||rRegParam.val_inicial||');';
                                         pv_graba_param_pr(rRegParam.nom_parametro, rRegParam.tip_origen, Ln_numparseo, rRegParam.tip_dato, rRegParam.nom_origen, rRegParam.val_inicial);

                                         Lv_v_bandera := 'PV_genera_declare_fn('||rRegParam.nom_parametro||','||rRegParam.tip_valor||','||rRegParam.val_inicial||');';
                                         Lv_sqlVariables := Lv_sqlVariables || pv_genera_declare_fn(rRegParam.nom_parametro, rRegParam.tip_valor,rRegParam.val_inicial);

                                         Lv_v_bandera := 'PV_genera_inicializacion_fn('||rRegParam.nom_parametro||','||rRegParam.tip_dato||','||rRegParam.tip_origen||','||rRegParam.val_inicial||');';
                                         Lv_sqlIniVariables := Lv_sqlIniVariables || pv_genera_inicializacion_fn(rRegParam.nom_parametro, rRegParam.tip_dato, rRegParam.tip_origen, rRegParam.val_inicial);
                                      END IF;

                                      IF Ln_numparam = 1 THEN
                                         Lv_c_LlamadaAux := Lv_c_LlamadaAux||'('||rRegParam.nom_parametro;
                                      ELSE
                                         Lv_c_LlamadaAux := Lv_c_LlamadaAux||', '||rRegParam.nom_parametro;
                                      END IF;

                                END LOOP;
                                  Lv_c_LlamadaAux := Lv_c_LlamadaAux||'); ';
                                  Lv_c_IniVarAux := Lv_c_IniVarAux ||' '|| Lv_c_LlamadaAux;
                       end if;

                    end loop;
                    Lv_v_bandera := 'Comienza a Cosntruir el Bloque SQL - FINAL.';
                    Lv_SqlFinal:= 'DECLARE ' ;
                    --DECLARACION DE VARIABLES
                    Lv_SqlFinal:=Lv_SqlFinal || Lv_sqlVariables ;

                    --VARIABLES FIJAS
                    Lv_SqlFinal:=Lv_SqlFinal || Lv_sqlVarFijas || 'BEGIN '|| Lv_sqlIniVariables || Lv_c_IniVarAux || Lv_sqlLlamadas_fin || ' END;';



                    -- AHORA SE TRABAJA EN LA EJECUCION DEL PL/SQL ANONIMO RECIEN CONSTRUIDO.
                    dbms_output.put_line(substr(Lv_sqlIniVariables,1,255));
                    dbms_output.put_line(substr(Lv_c_IniVarAux,1,255));
                    dbms_output.put_line(substr(Lv_sqlLlamadas_fin,1,255));
                    --dbms_output.put_line(substr(Lv_SqlFinal,1,255));
                    --dbms_output.put_line(substr(Lv_SqlFinal,256,255));
                    --dbms_output.put_line(substr(Lv_SqlFinal,511,255));
                    --dbms_output.put_line(substr(Lv_SqlFinal,766,255));
                    --dbms_output.put_line(substr(Lv_SqlFinal,1021,255));

                    Lv_v_bandera := 'Comienza Tratamiento dinámico del Bloque SQL - FINAL.';
                    Li_curdinamico := DBMS_SQL.OPEN_CURSOR;
                    DBMS_SQL.PARSE(Li_curdinamico, Lv_SqlFinal, DBMS_SQL.NATIVE);
                    Lv_v_bandera := 'Abierto y Parseado el Cursor, comienza la asociación de parámetros.';

                    FOR n_parse IN 0..ind_parametros -1 LOOP
                        IF  UPPER(TRIM(tab_parametros(n_parse).t_v_valinicial)) <> 'NULL' THEN
                          IF tab_parametros(n_parse).t_v_num_parseo > 0 THEN
                             Lv_varparseo := ':'||tab_parametros(n_parse).t_v_num_parseo;

                             IF tab_parametros(n_parse).t_v_tip_origen = 'I'  THEN
                                 Lv_valorparseo := PV_recupera_param_fn(tab_parametros(n_parse).t_v_nom_param, tab_parametros(n_parse).t_v_tip_dato, tab_parametros(n_parse).t_v_nom_origen );
                             ELSE
                                 IF tab_parametros(n_parse).t_v_valinicial = '*' THEN
                                       IF tab_parametros(n_parse).t_v_tip_dato = 'DATE'  THEN
                                             Lv_valorparseo := TO_CHAR(SYSDATE,fmt_DATE);
                                         ELSE
                                             Lv_valorparseo := NULL;
                                         END IF;
                                   ELSE
                                            Lv_valorparseo := tab_parametros(n_parse).t_v_valinicial;
                                   END IF;
                             END IF;

                             Lv_v_bandera := 'DBMS_SQL.BIND_VARIABLE:['||Lv_varparseo||'] con valor ['||Lv_valorparseo||'];';

dbms_output.put_line('TRAZA: '||n_parse||'-'||Li_curdinamico ||'-'||Lv_varparseo||'-'||Lv_valorparseo);

                             DBMS_SQL.BIND_VARIABLE(Li_curdinamico, Lv_varparseo, Lv_valorparseo);
                          END IF;
                        END IF;
                    END LOOP;

                    Lv_v_bandera := 'Ejecuta el cursor dinamico .';
                    dbms_output.put_line('ANTES DE EJECUTAR Li_curdinamico ---> '||Li_curdinamico ||'-'||SQLERRM );
                    Ln_rows := dbms_sql.execute(Li_curdinamico);
                    dbms_output.put_line('DESPUES DE EJECUTAR Li_curdinamico ---> '||Li_curdinamico ||'-'||SQLERRM );
                    DBMS_SQL.close_cursor(Li_curdinamico);
            END IF;

dbms_output.put_line('ANTES DEL SELECT ---> PV_PROG_PRINCIPAL: '||SQLERRM );
            OPEN  SV_record  FOR
            SELECT   NUM_MOVIMIENTO              ,COD_ACTABO          ,IND_FACTUR        ,DES_SERV    ,NVL(NUM_UNIDADES,0),COD_CONCEPTO  ,nvl(IMP_CARGO,0)
                     ,NVL(COD_ARTICULO,0)        ,NVL(COD_BODEGA,0)   ,NUM_SERIE                  ,IND_EQUIPO  ,NVL(COD_CLIENTE,0)   ,NVL(NUM_ABONADO,0)
                     ,TIP_DTO                    ,nvl(VAL_DTO,0)      ,NVL(COD_CONCEPTO_DTO,0)   ,NVL(NUM_CELULAR,0)  ,NVL(COD_PLANCOM,0)   ,CLASE_SERVICIO_ACT
                     ,CLASE_SERVICIO_DES ,PARAM1_MENS ,PARAM2_MENS     ,PARMA3_MENS ,CLASE_SERVICIO,DES_MONEDA,NVL(COD_MONEDA,0)
                     ,NVL(COD_CICLO,0)           ,NVL(FACT_CONT,1)   ,NVL(P_DESC,0)            ,NVL(VAL_MIN,0)     ,NVL(VAL_MAX,0),COD_ERROR,DES_ERROR
                      FROM PV_TMPPARAMETROS_SALIDA_TT
                      order by num_abonado ,cod_concepto;

dbms_output.put_line('se ejecuto ---> PV_PROG_PRINCIPAL: '||SQLERRM ); 
      EXCEPTION
             WHEN OTHERS THEN
                   BEGIN
                          IF Lv_n_num_evento = -1 THEN
                                 Lv_n_num_evento := ge_errores_pg.grabarpl(0,'PV','Error en Actualización PV_TMPPARAMETRO_TD','1',USER,'PV_EJECUTA_TRANS_OS_PG',Lv_SqlFinal,SQLCODE,SQLERRM);
                          ELSE
                                 Lv_n_num_evento := ge_errores_pg.grabarpl(Lv_n_num_evento,'PV','Error en Actualización PV_TMPPARAMETRO_TD','1',USER,'PV_EJECUTA_TRANS_OS_PG',Lv_SqlFinal,SQLCODE, SQLERRM);
                          END IF;

                          RAISE_APPLICATION_ERROR(-20002, 'N° de Evento:'||to_char(Lv_n_num_evento)||' - Ocurrió un error al ejecutar las acciones asiociadas a la actuación.');
                 dbms_output.put_line(' PV_PROG_PRINCIPAL: '||SQLERRM );                          
                     EXCEPTION
                          WHEN OTHERS THEN
                            RAISE_APPLICATION_ERROR(-20002, SQLERRM, FALSE);
                     END;
      END PV_PROG_PRINCIPAL;


END PV_EJECUTA_TRANS_OS_PG; 
/
SHOW ERRORS
