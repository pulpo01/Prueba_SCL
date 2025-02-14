CREATE OR REPLACE PACKAGE BODY ADN_NUMERACION_PG IS
-- PL/SQL Specification
--
-- *************************************************************
-- * Paquete            : ADN_NUMERACION_PG
-- * Descripcion        : Rutinas de validacion y apertura de rangos de numeracion
-- * Fecha de creacion  : 13-08-2003
-- * Responsable        : Logistica
-- *************************************************************

FUNCTION ADN_MAX_CONTAMINADO_FN (
         p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
         p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
         RETURN adn_contaminados_td.num_celular%TYPE
IS
-- ************************************************************************************
-- * DESCRIPCION : Esta Funcion entrega el mayor de los numeros contaminados          *
-- *               que existen en un rango numerico.                                  *
-- *               Si no existen numeros contaminados para el Rango devuelve un 0     *
-- ************************************************************************************
  v_max_contaminado  adn_contaminados_td.num_celular%TYPE;
BEGIN
   v_max_contaminado:=0;
   SELECT nvl(max(num_celular),0)
   INTO v_max_contaminado
   FROM adn_contaminados_td
   WHERE num_celular BETWEEN p_num_desde AND p_num_hasta
   ;

   RETURN v_max_contaminado;

   EXCEPTION
        WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_MAX_CONTAMINADO_FN ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_MAX_CONTAMINADO_FN;

FUNCTION ADN_ES_NRO_CONTAMINADO_FN(
         p_num_celular IN adn_contaminados_td.num_celular%TYPE)
         RETURN PLS_INTEGER
IS
-- ************************************************************************************
-- * DESCRIPCION : Esta Funcion indica si el numero de celular ingresado              *
-- *               corresponde a un numero contaminado.                               *
-- *               RETORNO  0     No es Numero Contaminado                            *
-- *                        1     Es Numero Contaminado                               *
-- ************************************************************************************
  v_contaminado PLS_INTEGER;
BEGIN
    SELECT decode(count(1),0,0,1)
    INTO v_contaminado
    FROM adn_contaminados_td
    WHERE num_celular=p_num_celular
    ;

    RETURN v_contaminado;
    EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ES_NRO_CONTAMINADO_FN ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ES_NRO_CONTAMINADO_FN;

FUNCTION ADN_ES_RANGO_CONTAMINADO_FN(
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN PLS_INTEGER
IS
-- ************************************************************************************
-- * DESCRIPCION : Esta Funcion indica si el Rango ingresado esta contaminado         *
-- *               RETORNO  0     No es Rango Contaminado                             *
-- *                        1     Es Rango Contaminado                                *
-- ************************************************************************************
  v_contaminado PLS_INTEGER;
BEGIN
    SELECT decode(count(1),0,0,1)
    INTO v_contaminado
    FROM adn_contaminados_td
    WHERE num_celular between p_num_desde and p_num_hasta
    ;

    RETURN v_contaminado;
    EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ES_RANGO_CONTAMINADO_FN ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ES_RANGO_CONTAMINADO_FN;

FUNCTION ADN_DISPONIBLES_USO_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_numdesde          ga_celnum_uso.num_desde%TYPE;
   v_numhasta          ga_celnum_uso.num_hasta%TYPE;
   v_num_disponibles  ga_celnum_uso.num_libres%TYPE;
   v_num_desde_sig     ga_celnum_uso.num_siguiente%TYPE;


  CURSOR c_disp_uso (
      p_num_desde   ga_celnum_uso.num_desde%type,
      p_num_hasta   ga_celnum_uso.num_hasta%type
   )
   IS
       SELECT   num_desde, num_hasta, num_libres, num_siguiente
       FROM (SELECT num_desde, num_hasta, num_libres, num_siguiente
             FROM ga_celnum_uso
             WHERE p_num_desde BETWEEN num_desde AND num_hasta
             UNION
             SELECT num_desde, num_hasta, num_libres, num_siguiente
             FROM ga_celnum_uso
             WHERE p_num_hasta BETWEEN num_desde AND num_hasta
             UNION
             SELECT num_desde, num_hasta, num_libres, num_siguiente
             FROM ga_celnum_uso
             WHERE num_desde >= p_num_desde AND num_desde <= p_num_hasta
             UNION
             SELECT num_desde, num_hasta, num_libres, num_siguiente
             FROM ga_celnum_uso
             WHERE num_hasta >= p_num_desde AND num_hasta <= p_num_hasta
            )
       ORDER BY num_desde ;

       v_disp_uso c_disp_uso%ROWTYPE;

BEGIN
   v_num_disponibles := 0;
   OPEN c_disp_uso(p_num_desde, p_num_hasta);
   LOOP
      FETCH c_disp_uso INTO v_disp_uso;
      EXIT WHEN c_disp_uso%NOTFOUND;
      IF v_disp_uso.num_libres > 0 THEN
         IF v_disp_uso.num_siguiente >= p_num_desde THEN
            v_numdesde:=v_disp_uso.num_siguiente;
            IF p_num_hasta >= v_disp_uso.num_hasta THEN
               v_numhasta:=v_disp_uso.num_hasta;
            ELSE
               v_numhasta:=p_num_hasta;
            END IF;
            v_num_disponibles :=   v_num_disponibles + (v_numhasta - v_numdesde + 1);
         ELSE
            v_numdesde:=p_num_desde;
            IF p_num_hasta >= v_disp_uso.num_hasta THEN
               v_numhasta:=v_disp_uso.num_hasta;
            ELSE
                  v_numhasta:= p_num_hasta;
            END IF;
            v_num_disponibles :=v_num_disponibles + ( v_numhasta - v_numdesde + 1);
         END IF;
      END IF;
      v_num_desde_sig:= adn_nrosig_fn(v_disp_uso.num_desde,'ga_celnum_uso');
      IF ( v_num_desde_sig IS NOT NULL) THEN
        IF (v_num_desde_sig < p_num_hasta ) THEN
         v_numdesde := v_disp_uso.num_hasta  + 1;
         v_numhasta := v_num_desde_sig;
        ELSE
          v_numdesde:=v_disp_uso.num_hasta  + 1;
          v_numhasta := p_num_hasta + 1 ;
        END IF;
       IF (v_numdesde <> v_numhasta) and (v_numdesde <= v_numhasta) THEN
          v_num_disponibles := v_num_disponibles + adn_total_rango_fn(v_numdesde ,v_numhasta - 1);
       END IF;
      END IF;
      v_numdesde:=0;
        v_numhasta:=0;
   END LOOP;
   IF c_disp_uso%rowcount=0 THEN
    v_num_disponibles:=adn_total_rango_fn(p_num_desde ,p_num_hasta);
   END IF;
   CLOSE c_disp_uso;
RETURN v_num_disponibles;
END ADN_DISPONIBLES_USO_FN;

FUNCTION ADN_INTERMEDIOS_KIT_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_num_disponibles   ga_celnum_uso.num_libres%TYPE;
   v_tip_articulokit   al_tipos_articulos.tip_articulo%TYPE;
BEGIN
    SELECT TO_NUMBER (val_parametro)
    INTO v_tip_articulokit
    FROM ged_parametros
    WHERE nom_parametro = 'TIP_ARTICULO_KIT'
    AND cod_modulo = 'AL'
    AND cod_producto = 1
    ;


    SELECT COUNT (DISTINCT d.num_telefono)
    INTO v_num_disponibles
    FROM al_tipos_articulos c,al_articulos b,al_componente_kit d,al_series a
    WHERE b.tip_articulo = v_tip_articulokit
    AND d.num_telefono BETWEEN p_num_desde AND p_num_hasta
    AND d.num_kit=a.num_serie
    AND a.cod_articulo = b.cod_articulo
    AND b.tip_articulo = c.tip_articulo
    ;

    RETURN v_num_disponibles;
EXCEPTION
         WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20130, 'Error(ADN_INTERMEDIOS_KIT_FN) No hay Informacion Parametro Tipo Kit' );
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_INTERMEDIOS_KIT_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_INTERMEDIOS_KIT_FN;



FUNCTION ADN_RESERVADOS_RESER_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_num_disponibles   ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT COUNT (1)
    INTO v_num_disponibles
    FROM ga_reserva
    WHERE num_celular BETWEEN p_num_desde AND p_num_hasta
    AND  (SYSDATE-fec_reserva) <=45
    ;
    RETURN v_num_disponibles;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_RESERVADOS_RESER_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_RESERVADOS_RESER_FN;


FUNCTION ADN_HIBERNADOS_REUTIL_GA_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_num_disponibles   ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT COUNT (1)
    INTO v_num_disponibles
    FROM al_usos b, ga_celnum_reutil a
    WHERE a.num_celular BETWEEN p_num_desde AND p_num_hasta
    AND   a.cod_uso = b.cod_uso
    AND (a.fec_baja + (ge_fn_dias_hibernacion (a.cod_uso))) > SYSDATE
    ;
    RETURN v_num_disponibles;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_HIBERNADOS_REUTIL_GA_FN ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_HIBERNADOS_REUTIL_GA_FN ;

FUNCTION ADN_ACTIVOS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_num_activos       ga_celnum_uso.num_libres%TYPE;
BEGIN

    SELECT count(num_celular)
    INTO v_num_activos
    FROM (
           SELECT num_celular
           FROM  ga_aboamist
           WHERE num_abonado > 0
           AND cod_situacion not in ('BAA','BAP')
           AND num_celular BETWEEN p_num_desde AND p_num_hasta
           UNION
           SELECT num_celular
           FROM ga_abocel
           WHERE num_abonado > 0
           AND cod_situacion not in ('BAA','BAP')
           AND num_celular BETWEEN p_num_desde AND p_num_hasta )
           ;

     RETURN v_num_activos;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ACTIVOS_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ACTIVOS_FN;


FUNCTION ADN_DISPONIBLES_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_disponibles       ga_celnum_uso.num_libres%TYPE;
BEGIN
    v_disponibles:=adn_disponibles_uso_fn(p_num_desde,p_num_hasta);
    v_disponibles:=v_disponibles + adn_disponibles_otros_fn(p_num_desde,p_num_hasta);
RETURN v_disponibles;
   EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_DISPONIBLES_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_DISPONIBLES_FN;

FUNCTION ADN_PRE_ACTIVOS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_num_temporales      ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT COUNT(1)
    INTO v_num_temporales
    FROM (
           SELECT a.num_telefono
           FROM al_cab_numeracion b, al_lin_numeracion c,al_ser_numeracion a
           WHERE b.num_numeracion = c.num_numeracion
           AND a.num_numeracion=c.num_numeracion
           AND a.lin_numeracion=c.lin_numeracion
           AND b.cod_estado <> 'CE'
           AND a.num_telefono BETWEEN p_num_desde AND p_num_hasta
           UNION
           SELECT num_telefono
           FROM al_fic_series
           WHERE num_orden >0
           AND tip_orden>0
           AND num_linea>0
           AND num_telefono BETWEEN p_num_desde AND p_num_hasta
           UNION
           SELECT a.num_telefono
           FROM al_cab_es_extras b, al_lin_es_extras c, al_ser_es_extras a
           WHERE b.num_extra=c.num_extra
           AND c.num_extra=a.num_extra
           AND c.num_linea=a.num_linea
           AND b.cod_estado <> 'CE'
           AND a.num_telefono BETWEEN p_num_desde AND p_num_hasta
           UNION
           SELECT a.num_telefono
           FROM al_cabecera_ordenes2 b, al_lineas_ordenes2 c, al_series_ordenes2 a
           WHERE b.num_orden = c.num_orden
           AND a.num_orden=c.num_orden
           AND a.num_linea=c.num_linea
           AND a.tip_orden=2
           AND b.cod_estado <> 'CE'
           AND a.num_telefono > 0
           AND b.tip_orden=2
           AND c.tip_orden=2
           AND num_telefono BETWEEN p_num_desde AND p_num_hasta)
    ;
    RETURN v_num_temporales;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_PRE_ACTIVOS_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_PRE_ACTIVOS_FN;


FUNCTION ADN_ASIGNADOS_AMIS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_numdesde          ga_celnum_uso.num_desde%TYPE;
   v_numhasta          ga_celnum_uso.num_hasta%TYPE;
   v_num_activos       ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT count(a.num_celular)
    INTO v_num_activos
    FROM ga_aboamist a
    WHERE a.num_abonado > 0
    AND a.cod_situacion not in ('BAA','BAP')
    AND a.num_celular BETWEEN p_num_desde AND p_num_hasta
    AND not exists (SELECT 1 FROM adn_categoria_td b WHERE b.cod_plantarif= a.cod_plantarif)
    ;
    RETURN v_num_activos;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ASIGNADOS_AMIS_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ASIGNADOS_AMIS_FN;



FUNCTION ADN_ADMINISTRATIVOS_AMIS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_numdesde          ga_celnum_uso.num_desde%TYPE;
   v_numhasta          ga_celnum_uso.num_hasta%TYPE;
   v_num_activos       ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT count(a.num_celular)
    INTO v_num_activos
    FROM  ga_aboamist a
    WHERE a.num_abonado > 0
    AND a.cod_situacion not in ('BAA','BAP')
    AND a.num_celular BETWEEN p_num_desde AND p_num_hasta
    AND exists (SELECT 1 FROM adn_categoria_td b WHERE b.cod_plantarif= a.cod_plantarif)
    ;
    RETURN v_num_activos;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ADMINISTRATIVOS_AMIS_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ADMINISTRATIVOS_AMIS_FN;

FUNCTION ADN_ADMINISTRATIVOS_CEL_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_numdesde          ga_celnum_uso.num_desde%TYPE;
   v_numhasta          ga_celnum_uso.num_hasta%TYPE;
   v_num_activos       ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT count(a.num_celular)
    INTO v_num_activos
    FROM  ga_abocel a
    WHERE a.num_abonado > 0
    AND a.cod_situacion not in ('BAA','BAP')
    AND a.num_celular BETWEEN p_num_desde AND p_num_hasta
    AND exists (SELECT 1 FROM adn_categoria_td b WHERE b.cod_plantarif= a.cod_plantarif)
    ;
    RETURN v_num_activos;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ADMINISTRATIVOS_CEL_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ADMINISTRATIVOS_CEL_FN;

FUNCTION ADN_ASIGNADOS_CEL_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_numdesde          ga_celnum_uso.num_desde%TYPE;
   v_numhasta          ga_celnum_uso.num_hasta%TYPE;
   v_num_activos       ga_celnum_uso.num_libres%TYPE;
BEGIN
    SELECT count(a.num_celular)
    INTO v_num_activos
    FROM  ga_abocel a
    WHERE a.num_abonado > 0
    AND a.cod_situacion not in ('BAA','BAP')
    AND a.num_celular BETWEEN p_num_desde AND p_num_hasta
    AND not exists (SELECT 1 FROM adn_categoria_td b WHERE b.cod_plantarif=a.cod_plantarif)
    ;
    RETURN v_num_activos;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ASIGNADOS_CEL_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ASIGNADOS_CEL_FN;

FUNCTION ADN_TOTAL_RANGO_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
      v_total_rango ga_celnum_uso.num_libres%type;
      v_numdesde   ga_celnum_uso.num_desde%type;
      v_numhasta   ga_celnum_uso.num_hasta%type;
BEGIN
      v_total_rango:=0;
      BEGIN
         SELECT nvl(sum(tot_bloque),0)
         INTO v_total_rango
         FROM (
         SELECT num_desde, num_hasta,(decode(sign((num_hasta - p_num_hasta)),-1,num_hasta,p_num_hasta) - decode(sign((p_num_desde - num_desde)),-1,num_desde,p_num_desde) + 1) Tot_Bloque
         FROM ga_celnum_subalm
         WHERE num_desde >0
         AND p_num_desde BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,(decode(sign((num_hasta - p_num_hasta)),-1,num_hasta,p_num_hasta) - decode(sign((p_num_desde - num_desde)),-1,num_desde,p_num_desde) + 1) Tot_Bloque
         FROM ga_celnum_subalm
         WHERE num_desde >0
         AND p_num_hasta BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,(decode(sign((num_hasta - p_num_hasta)),-1,num_hasta,p_num_hasta) - decode(sign((p_num_desde - num_desde)),-1,num_desde,p_num_desde) + 1) Tot_Bloque
         FROM ga_celnum_subalm
         WHERE num_desde >0
         AND num_desde >= p_num_desde AND num_desde <= p_num_hasta
         UNION
         SELECT num_desde, num_hasta,(decode(sign((num_hasta - p_num_hasta)),-1,num_hasta,p_num_hasta) - decode(sign((p_num_desde - num_desde)),-1,num_desde,p_num_desde) + 1) Tot_Bloque
         FROM ga_celnum_subalm
         WHERE num_desde >0
         AND num_hasta >= p_num_desde AND num_hasta <= p_num_hasta)
         ;
         EXCEPTION
            WHEN OTHERS THEN
              v_total_rango:=0;
      END;

      RETURN v_total_rango;
EXCEPTION
      WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_TOTAL_RANGOII_FN' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_TOTAL_RANGO_FN;


FUNCTION ADN_ES_DEVUELTO_FN (p_num_desde IN  ga_celnum_uso.num_desde%type)
   RETURN PLS_INTEGER
IS
-- ************************************************************************************
-- * DESCRIPCION : Esta Funcion indica si el numero de celular                        *
-- *               corresponde a un numero devuelto.                                  *
-- *               RETORNO  0     No es Numero Devuelto                               *
-- *                        1     Es Numero Devuelto                                  *
-- ************************************************************************************
v_numeros       PLS_INTEGER;
v_bloque     ga_celnum_uso.num_desde%type;
BEGIN
      v_bloque:=substr(p_num_desde,1,7);
      SELECT DECODE(count(distinct num_desde),0,0,1)
        INTO v_numeros
      FROM adn_celnum_devueltos_to
      WHERE num_celular >0
      AND substr(num_desde,1,7)=v_bloque
      ;
    RETURN v_numeros;
END ADN_ES_DEVUELTO_FN;

FUNCTION ADN_DISPONIBLES_OTROS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
IS
   v_num_disponibles   ga_celnum_uso.num_libres%TYPE;
   v_tip_articulokit   al_tipos_articulos.tip_articulo%TYPE;
BEGIN
    SELECT TO_NUMBER (val_parametro)
    INTO v_tip_articulokit
    FROM ged_parametros
    WHERE nom_parametro = 'TIP_ARTICULO_KIT'
    AND cod_modulo = 'AL'
    AND cod_producto = 1
    ;
    SELECT COUNT(1)
    INTO v_num_disponibles
    FROM (
    SELECT  a.num_telefono
    FROM al_tipos_articulos c, al_articulos b, al_series a
    WHERE a.num_telefono BETWEEN p_num_desde AND p_num_hasta
    AND a.cod_articulo = b.cod_articulo
    AND b.tip_articulo = c.tip_articulo
    AND b.tip_articulo <> v_tip_articulokit
    UNION
    SELECT a.num_telefono
    FROM al_cab_numeracion b, al_ser_numeracion a
    WHERE b.cod_estado <> 'CE'
    AND a.num_numeracion = b.num_numeracion
    AND a.num_telefono BETWEEN p_num_desde AND p_num_hasta
    UNION
    SELECT num_telefono
    FROM al_fic_series
    WHERE num_orden >0
    AND tip_orden>0
    AND num_linea>0
    AND num_telefono BETWEEN p_num_desde AND p_num_hasta
    UNION
    SELECT a.num_telefono
    FROM al_cab_es_extras b, al_ser_es_extras a
    WHERE b.cod_estado <> 'CE'
    AND a.num_extra = b.num_extra
    AND a.num_telefono BETWEEN p_num_desde AND p_num_hasta
    UNION
    SELECT num_celular
    FROM ga_reserva
    WHERE (SYSDATE-fec_reserva) >45
    AND num_celular BETWEEN p_num_desde AND p_num_hasta
    UNION
    SELECT num_celular
    FROM al_celnum_reutil
    WHERE num_celular > 0
    AND num_celular BETWEEN p_num_desde AND p_num_hasta
    UNION
    SELECT a.num_celular
    FROM al_usos b, ga_celnum_reutil a
    WHERE a.cod_uso = b.cod_uso
    AND a.num_celular BETWEEN p_num_desde AND p_num_hasta
    AND (a.fec_baja + (ge_fn_dias_hibernacion (a.cod_uso))) <= SYSDATE
    UNION
    SELECT a.num_telefono
    FROM al_cabecera_ordenes2 b, al_series_ordenes2 a
    WHERE b.cod_estado <> 'CE'
    AND a.num_telefono > 0
    AND num_telefono BETWEEN p_num_desde AND p_num_hasta
    AND a.num_orden = b.num_orden )
    ;
    RETURN v_num_disponibles;
EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_DISPONIBLES_OTROS_FN '|| to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_DISPONIBLES_OTROS_FN;

FUNCTION ADN_NROSIG_FN (p_num_desde  ga_celnum_uso.num_desde%TYPE,
                        p_tabla VARCHAR2)
   RETURN  ga_celnum_uso.num_desde%TYPE
IS
  TYPE SigCurTipo IS REF CURSOR;
  c_rango SigCurTipo;
  v_desde_sig ga_celnum_uso.num_desde%TYPE;
  v_query    VARCHAR2(150);
BEGIN
    v_query:='SELECT ';
    v_query:=v_query||'LEAD (num_desde,1) OVER (ORDER BY num_desde) ';
    v_query:=v_query||'FROM '|| p_tabla ||'  ';
    v_query:=v_query||'WHERE num_desde >= :p_desde ';
    v_query:=v_query||'ORDER BY num_desde';

    OPEN c_rango FOR v_query USING p_num_desde;
    LOOP
       FETCH c_rango INTO v_desde_sig;
       EXIT WHEN c_rango%NOTFOUND;
        v_desde_sig:=v_desde_sig;
        EXIT;
       END LOOP;
    CLOSE c_rango;

    RETURN v_desde_sig;

EXCEPTION
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_DISPONIBLES_OTROS_FN '|| to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_NROSIG_FN ;

FUNCTION ADN_ES_PORTADO_IN_FN (p_num_celular IN  ga_celnum_uso.num_desde%type)
   RETURN PLS_INTEGER
IS
-- ************************************************************************************
-- * DESCRIPCION : Esta Funcion indica si el numero de celular ingresado              *
-- *               corresponde a un numero portado.                                   *
-- *               RETORNO  0     No es Numero Portado                                *
-- *                        1     Es Numero Portado                                   *
-- ************************************************************************************
v_numeros    PLS_INTEGER;
BEGIN
   SELECT DECODE(count(distinct num_desde),0,0,1)
   INTO v_numeros
   FROM ga_celnum_subalm
   WHERE   ind_porta_in=1
   AND num_desde>0
   AND num_desde = p_num_celular;
   RETURN v_numeros;
END ADN_ES_PORTADO_IN_FN;

PROCEDURE ADN_GENERA_RANGOS_PR
IS
      v_numdesde    ga_celnum_uso.num_desde%type;
      v_numhasta    ga_celnum_uso.num_hasta%type;
      v_numbloques  ga_celnum_uso.num_libres%type;
      v_bloques     ga_celnum_uso.num_libres%type;
      v_total       ga_celnum_uso.num_libres%type;
      v_disponibles ga_celnum_uso.num_libres%type;
      v_temporales  ga_celnum_uso.num_libres%type;
      v_activos     ga_celnum_uso.num_libres%type;
      v_fecha       date;
      v_gen_bloques     pls_integer;
        v_devuelto        pls_integer;
      v_portado         pls_integer;
      p_nro_inf     adn_cab_plan_status_to.num_informe%type;
      v_bloque_desde ga_celnum_subalm.num_desde%type;
      v_bloque_hasta ga_celnum_subalm.num_hasta%type;
      v_bloque_desdeV ga_celnum_subalm.num_desde%type;
      v_bloque_hastaV ga_celnum_subalm.num_hasta%type;
      v_bloque_anterior ga_celnum_subalm.num_desde%type;
      v_desde ga_celnum_subalm.num_desde%type;
      v_hasta ga_celnum_subalm.num_hasta%type;

      CURSOR c_bloques
      IS
        SELECT distinct substr(num_desde,1,7) bloque_desde, substr(num_hasta,1,7) bloque_hasta
        FROM ga_celnum_subalm
        WHERE num_Desde > 0
        ;

BEGIN
     v_bloques:=0;
     BEGIN
       SELECT max(a.num_informe)
       INTO p_nro_inf
       FROM adn_cab_plan_status_to a, adn_det_plan_status_to b
       WHERE b.num_informe > 0
       AND b.num_desde > 0
       AND b.ind_registro=1
       AND a.num_informe=b.num_informe
       AND a.fec_informe=b.fec_informe;
       EXCEPTION
         WHEN others THEN
             p_nro_inf:=0;
     END;
     IF p_nro_inf <> 0 THEN
          BEGIN
              SELECT decode(a.total,b.total,0,1)
              INTO v_gen_bloques
              FROM
                  (SELECT sum(num_hasta - num_desde + 1) total
                   FROM ga_celnum_subalm) a,
                  (SELECT sum(tot_bloque) total
                   FROM adn_det_plan_status_to
                   WHERE num_informe=p_nro_inf) b;
              IF v_gen_bloques=0 THEN
                 BEGIN
                   SELECT count(1)
                   INTO v_gen_bloques
                   FROM adn_det_plan_status_to
                   WHERE num_informe=p_nro_inf
                   GROUP BY asignados,num_desde, num_hasta
                   HAVING decode(asignados,adn_activos_fn(num_desde, num_hasta),0,1)=1;
                 EXCEPTION
                   WHEN NO_DATA_FOUND THEN
                      v_gen_bloques:=0;
                 END ;
               END IF;
            EXCEPTION
              WHEN OTHERS THEN
                  v_gen_bloques:=1;
            END;
      ELSE
           v_gen_bloques:=1;
      END IF;
      IF v_gen_bloques=1 THEN
           v_fecha:= sysdate;
           SELECT adn_nro_informe_seq.nextval
           INTO p_nro_inf
           FROM dual;

             INSERT INTO adn_cab_plan_status_to ( num_informe, fec_informe, cod_cliente, nom_usuario,cod_estado)
           VALUES (p_nro_inf,v_fecha,1,user,2);

           v_bloque_desde:=0;
           FOR v_bloques IN c_bloques LOOP
              v_bloque_desde:=v_bloques.bloque_desde;
              v_bloque_hasta:=v_bloques.bloque_hasta;
              IF (v_bloque_desde=v_bloque_hasta and v_bloque_anterior<>v_bloque_desde) THEN
                 v_desde:=v_bloque_desde ||'000';
                 v_hasta:=v_bloque_desde ||'999';
                 v_total:=adn_total_rango_fn(v_desde,v_hasta);
                 v_devuelto:=adn_es_devuelto_fn(v_desde);
                 v_portado:=adn_es_portado_in_fn(v_desde);
                 IF (v_total > 0 and v_devuelto <> 1 and v_portado <> 1) THEN
                    v_disponibles:=adn_disponibles_fn(v_desde,v_hasta);
                    v_activos:=adn_activos_fn(v_desde,v_hasta);
                    v_temporales:=adn_pre_activos_fn(v_desde,v_hasta);
                    --Asignados = v_activos , Disponibles = v_disponibles, Tot_Bloque= v_total, Reservados=v_temporales
                    --dbms_output.put_line(to_char(v_bloque_desde)||'  Desde: '||to_char(v_desde)||'   Hasta: '||to_char(v_hasta));
                    INSERT INTO adn_det_plan_status_to (num_informe, num_desde, num_hasta,fec_informe, asignados,nom_usuario, ind_registro, disponibles,tot_bloque,reservados)
                    VALUES (p_nro_inf,v_desde,v_hasta,v_fecha,v_activos,user,1,v_disponibles,v_total,v_temporales);
                 END IF;
                 v_bloque_anterior:=v_bloque_desde ;
              ELSE
                 WHILE (v_bloque_desde <= v_bloque_hasta) LOOP
                     v_bloque_desdeV:=v_bloque_desde;
                     v_bloque_hastaV:=v_bloque_desdeV;
                     v_desde:=v_bloque_desdeV ||'000';
                     v_hasta:=v_bloque_desdeV ||'999';
                     IF v_bloque_anterior<>v_bloque_desde THEN
                        --dbms_output.put_line(to_char(v_bloque_desdeV)||'  Desde: '||to_char(v_desde)||'   Hasta: '||to_char(v_hasta));
                        v_total:=adn_total_rango_fn(v_desde,v_hasta);
                        v_devuelto:=adn_es_devuelto_fn(v_desde);
                        v_portado:=adn_es_portado_in_fn(v_desde);
                        IF (v_total > 0 and v_devuelto <> 1 and v_portado <> 1) THEN
                           v_disponibles:=adn_disponibles_fn(v_desde,v_hasta);
                           v_activos:=adn_activos_fn(v_desde,v_hasta);
                           v_temporales:=adn_pre_activos_fn(v_desde,v_hasta);
                           --Asignados = v_activos , Disponibles = v_disponibles, Tot_Bloque= v_total, Reservados=v_temporales
                           INSERT INTO adn_det_plan_status_to (num_informe, num_desde, num_hasta,fec_informe, asignados,nom_usuario, ind_registro, disponibles,tot_bloque,reservados)
                           VALUES (p_nro_inf,v_desde,v_hasta,v_fecha,v_activos,user,1,v_disponibles,v_total,v_temporales);
                        END IF;
                     END IF;
                     v_bloque_desde:=v_bloque_hastaV + 1;
                 END LOOP;
                 v_bloque_anterior:=v_bloque_desde - 1;
              END IF;
           END LOOP;
       END IF;
   EXCEPTION
         WHEN TOO_MANY_ROWS THEN
              RAISE_APPLICATION_ERROR(-20120, 'Error(AADN_GENERA_RANGOS_PR) Retorna mas Registros que lo Esperado ' );
         WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20130, 'Error(ADN_GENERA_RANGOS_PR) No hay Informacion ' );
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_GENERA_RANGOS_PR ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_GENERA_RANGOS_PR;

PROCEDURE ADN_DEVUELVE_RANGO_PR (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE,
      p_num_inf    IN adn_celnum_devueltos_to.num_informe%TYPE)
IS
      CURSOR c_celular (p_num_desde  ga_celnum_uso.num_desde%type,
                        p_num_hasta  ga_celnum_uso.num_hasta%type)
      IS
         SELECT num_celular ,1 tipo
         FROM al_celnum_reutil
         WHERE num_celular > 0
         AND num_celular BETWEEN p_num_desde AND p_num_hasta
         UNION
         SELECT num_celular ,2 tipo
         FROM al_usos b, ga_celnum_reutil a
         WHERE a.cod_uso = b.cod_uso
         AND a.num_celular BETWEEN p_num_desde AND p_num_hasta
         AND (a.fec_baja + (ge_fn_dias_hibernacion (a.cod_uso))) <= SYSDATE
         UNION
         SELECT num_celular, 3 tipo
         FROM ga_reserva
         WHERE (SYSDATE-fec_reserva) >45
         AND num_celular BETWEEN p_num_desde AND p_num_hasta
         ;

         CURSOR c_uso (p_num_desde   ga_celnum_uso.num_desde%type,
                            p_num_hasta   ga_celnum_uso.num_desde%type)
          IS
             SELECT num_desde, num_hasta, num_libres, num_siguiente,
                    cod_subalm,cod_central,cod_cat,cod_uso,cod_producto
             FROM ga_celnum_uso
             WHERE p_num_desde BETWEEN num_desde AND num_hasta
             UNION
             SELECT num_desde, num_hasta, num_libres, num_siguiente,
                    cod_subalm,cod_central,cod_cat,cod_uso,cod_producto
             FROM ga_celnum_uso
             WHERE p_num_hasta BETWEEN num_desde AND num_hasta
             UNION
             SELECT num_desde, num_hasta, num_libres, num_siguiente,
                    cod_subalm,cod_central,cod_cat,cod_uso,cod_producto
             FROM ga_celnum_uso
             WHERE num_desde >= p_num_desde AND num_desde <= p_num_hasta
             UNION
             SELECT num_desde, num_hasta, num_libres, num_siguiente,
                    cod_subalm,cod_central,cod_cat,cod_uso,cod_producto
             FROM ga_celnum_uso
             WHERE num_hasta >= p_num_desde AND num_hasta <= p_num_hasta
             ;
      v_telefono       ga_celnum_reutil.num_celular%type;
      v_categoria      ga_catnumer.cod_cat%type;
      v_subalm         ge_subalms.cod_subalm%type;
      v_central        icg_central.cod_central%type;
      v_producto       ga_celnum_reutil.cod_producto%type;
      v_uso            al_usos.cod_uso%type;
      v_operadora      adn_celnum_devueltos_to.cod_operadora%type;
      v_numdesde       ga_celnum_uso.num_desde%type;
      v_numhasta       ga_celnum_uso.num_hasta%type;
      v_inicio         ga_celnum_uso.num_desde%type;
      v_fin            ga_celnum_uso.num_hasta%type;
      v_total          ga_celnum_uso.num_libres%type;
      v_num_desde_sig  ga_celnum_uso.num_desde%type;
      v_fecha          adn_contaminados_th.fec_baja%type;
      v_observacion    adn_contaminados_th.observacion%type;
      v_cur_uso c_uso%ROWTYPE;

      v_insert_dev      varchar2(250);
      v_delete_con      varchar2(250);
      v_delete_al       varchar2(250);
      v_delete_ga       varchar2(250);
      v_delete_reserva  varchar2(250);
      v_update_uso      varchar2(250);
      v_update_conh     varchar2(250);
      LN_cod_retorno      ge_errores_pg.CodError;
      LV_mens_retorno     ge_errores_pg.MsgError;
      LN_num_evento       ge_errores_pg.Evento;

BEGIN

    LN_cod_retorno:=0;
    LV_mens_retorno:=null;
    LN_num_evento :=null;
    v_operadora:=trim(GE_Obtiene_Operadora_Local_FN(LN_cod_retorno,LV_mens_retorno,LN_num_evento ));

     v_insert_dev:='INSERT INTO adn_celnum_devueltos_to(num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,cod_operadora,ind_origen,num_informe,num_desde) ';
     v_insert_dev:=v_insert_dev||'VALUES(:celular,:subalm,:producto,:central,:categoria,:uso,:operadora,1,:inf,:desde)';

     v_delete_con:='DELETE FROM adn_contaminados_td WHERE num_celular=:celular';
     v_delete_al:='DELETE FROM al_celnum_reutil WHERE num_celular=:celular';
     v_delete_ga:='DELETE FROM ga_celnum_reutil WHERE num_celular=:celular';
     v_delete_reserva:='DELETE FROM ga_reserva  WHERE num_celular=:celular';

     v_update_uso:='UPDATE ga_celnum_uso                       ';
     v_update_uso:= v_update_uso||'SET num_siguiente=num_hasta,';
     v_update_uso:= v_update_uso||'num_libres=0                ';
     v_update_uso:= v_update_uso||'WHERE num_desde=:desde      ';
     v_update_conh:='UPDATE adn_contaminados_th SET observacion=:obs WHERE num_celular=:celular and trunc(fec_baja)=:fecha';

    --Devolver de GA_CELNUM_REUTIL, AL_CELNUM_REUTIL, GA_RESERVA
    FOR v_celular IN c_celular (p_num_desde, p_num_hasta)
    LOOP
       BEGIN
         IF v_celular.tipo=1 THEN
             SELECT num_celular,cod_producto,cod_subalm,cod_central,cod_cat,cod_uso
             INTO v_telefono,v_producto,v_subalm,v_central,v_categoria,v_uso
             FROM al_celnum_reutil
             WHERE num_celular = v_celular.num_celular
             FOR UPDATE NOWAIT;
         ELSE
            IF v_celular.tipo=2 THEN
                 SELECT num_celular,cod_producto,cod_subalm,cod_central,cod_cat,cod_uso
               INTO v_telefono,v_producto,v_subalm,v_central,v_categoria,v_uso
               FROM ga_celnum_reutil
               WHERE num_celular = v_celular.num_celular
               FOR UPDATE NOWAIT;
            ELSE
                 SELECT num_celular,cod_producto,cod_subalm,cod_central,cod_cat,cod_uso
               INTO v_telefono,v_producto,v_subalm,v_central,v_categoria,v_uso
               FROM ga_reserva
               WHERE num_celular = v_celular.num_celular
               FOR UPDATE NOWAIT;
            END IF;
         END IF;

         EXECUTE IMMEDIATE v_insert_dev
         USING v_telefono,v_subalm,v_producto,v_central,v_categoria,v_uso,v_operadora,p_num_inf,p_num_desde;

         IF v_celular.tipo=1 THEN
            EXECUTE IMMEDIATE v_delete_al
            USING v_telefono;
         ELSE
           IF v_celular.tipo=2 THEN
            EXECUTE IMMEDIATE v_delete_ga
            USING v_telefono;
           ELSE
             EXECUTE IMMEDIATE v_delete_reserva
             USING v_telefono;
           END IF;
         END IF;
         EXCEPTION
             WHEN NO_DATA_FOUND THEN
                NULL;
             WHEN OTHERS THEN
               IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                      NULL;
               ELSE
                  RAISE_APPLICATION_ERROR (-20002,'Error Devolucion de Numeros Disponibles :' || TO_CHAR(SQLCODE) || ' ' || SQLERRM || '. ERROR PROCESO DE ENTREGA DE RANGO.');
               END IF;
       END;
    END LOOP;

    --Devolver de GA_CELNUM_USO

    adn_rangos_faltantes_pr(p_num_desde, p_num_hasta);
    v_fecha:=sysdate;
    v_observacion:='Numero Pertenece a Rango Devuelto ('|| to_char(p_num_desde)||')';

    OPEN c_uso(p_num_desde, p_num_hasta);
    LOOP
       FETCH c_uso INTO v_cur_uso;
       EXIT WHEN c_uso%NOTFOUND;
       IF v_cur_uso.num_libres >0 THEN
         IF v_cur_uso.num_siguiente >= p_num_desde THEN
            v_numdesde:=v_cur_uso.num_siguiente;
            IF p_num_hasta >= v_cur_uso.num_hasta THEN
               v_numhasta:=v_cur_uso.num_hasta;
            ELSE
               v_numhasta:=p_num_hasta;
            END IF;
            EXECUTE IMMEDIATE v_update_uso
            USING v_numdesde;

            v_inicio:=v_numdesde;
            v_fin:=v_numhasta;
            WHILE (v_inicio <= v_fin) LOOP
              EXECUTE IMMEDIATE v_insert_dev
              USING v_inicio,v_cur_uso.cod_subalm,v_cur_uso.cod_producto,v_cur_uso.cod_central,v_cur_uso.cod_cat,v_cur_uso.cod_uso,v_operadora,p_num_inf,p_num_desde;

              IF adn_es_nro_contaminado_fn(v_inicio)=1 THEN
                 EXECUTE IMMEDIATE v_delete_con
                   USING v_inicio;
                EXECUTE IMMEDIATE v_update_conh
                USING v_observacion,v_inicio,trunc(v_fecha);
              END IF;
              v_inicio:=v_inicio + 1 ;
            END LOOP;
         ELSE
            v_numdesde:=p_num_desde;
            IF p_num_hasta >= v_cur_uso.num_hasta THEN
               v_numhasta:=v_cur_uso.num_hasta;
            ELSE
                  v_numhasta:= p_num_hasta;
            END IF;
            EXECUTE IMMEDIATE v_update_uso
            USING v_numdesde;

            v_inicio:=v_numdesde;
            v_fin:=v_numhasta;
            WHILE (v_inicio <= v_fin) LOOP

              EXECUTE IMMEDIATE v_insert_dev
              USING v_inicio,v_cur_uso.cod_subalm,v_cur_uso.cod_producto,v_cur_uso.cod_central,v_cur_uso.cod_cat,v_cur_uso.cod_uso,v_operadora,p_num_inf,p_num_desde;

              IF adn_es_nro_contaminado_fn(v_inicio)=1 THEN
                EXECUTE IMMEDIATE v_delete_con
                USING v_inicio;
                EXECUTE IMMEDIATE v_update_conh
                USING v_observacion,v_inicio,trunc(v_fecha);
              END IF;
              v_inicio:=v_inicio + 1 ;
            END LOOP;
         END IF;
       END IF;
    END LOOP;
    CLOSE c_uso;


    UPDATE ga_celnum_subalm
    SET ind_contaminado=0
    WHERE  num_desde IN (SELECT num_desde
                     FROM ga_celnum_subalm
                     WHERE ind_contaminado=1
                     GROUP BY num_desde,num_hasta
                     HAVING adn_es_rango_contaminado_fn(num_desde,num_hasta)=0);

    UPDATE ga_celnum_uso
    SET ind_contaminado=0
    WHERE  num_desde IN (SELECT num_desde
                     FROM ga_celnum_uso
                     WHERE ind_contaminado=1
                     GROUP BY num_desde,num_hasta
                     HAVING adn_es_rango_contaminado_fn(num_desde,num_hasta)=0);

EXCEPTION
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20002,'Error Devolucion de Numeros Disponibles :('||to_char(v_inicio)||') ' || TO_CHAR(SQLCODE) || ' ' || SQLERRM || '. ERROR PROCESO DE ENTREGA DE RANGO.');
END ADN_DEVUELVE_RANGO_PR;

PROCEDURE ADN_HOME_DEFAULT_PR (
   p_num_desde IN ga_celnum_uso.num_desde%TYPE,
   p_central OUT ga_celnum_uso.num_desde%TYPE,
   p_cat OUT ga_celnum_uso.num_desde%TYPE,
   p_uso OUT ga_celnum_uso.num_desde%TYPE)
IS
BEGIN
    SELECT
    decode(b.cod_central,null,14,b.cod_central) cod_central,
    decode(c.cod_cat,null,1,c.cod_cat) cod_cat,
    decode(d.cod_uso,null,1,d.cod_uso) cod_uso
    INTO p_central,p_cat,p_uso
    FROM ga_celnum_subalm a, ga_celnum_central b, ga_celnum_cat c, ga_celnum_uso d
    WHERE a.num_desde=b.num_desde(+)
    AND   b.num_desde=c.num_desde(+)
    AND   c.num_desde=d.num_desde(+)
    AND  p_num_desde BETWEEN a.num_desde AND a.num_hasta
    AND  p_num_desde BETWEEN b.num_desde(+) AND b.num_hasta(+)
    AND  p_num_desde BETWEEN c.num_desde(+) AND c.num_hasta(+)
    AND  p_num_desde BETWEEN d.num_desde(+) AND d.num_hasta(+);
  EXCEPTION
    WHEN OTHERS THEN
        --Por defecto cod_central=14, cod_cat=1, cod_uso=1
           p_central:=14;
        p_cat:=1;
        p_uso:=1;
END ADN_HOME_DEFAULT_PR ;

PROCEDURE ADN_RANGOS_FALTANTES_PR(
   p_num_desde  ga_celnum_uso.num_desde%type,
   p_num_hasta  ga_celnum_uso.num_hasta%type)
IS
      CURSOR c_subalm (
      p_desde_sub   ga_celnum_uso.num_desde%type,
      p_hasta_sub   ga_celnum_uso.num_hasta%type)
      IS
         SELECT num_desde, num_hasta, cod_subalm
         FROM ga_celnum_subalm
         WHERE p_desde_sub BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,cod_subalm
         FROM ga_celnum_subalm
         WHERE p_hasta_sub BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,cod_subalm
         FROM ga_celnum_subalm
         WHERE num_desde >= p_desde_sub AND num_desde <= p_hasta_sub
         UNION
         SELECT num_desde, num_hasta,cod_subalm
         FROM ga_celnum_subalm
         WHERE num_hasta >= p_desde_sub AND num_hasta <= p_hasta_sub
        ;

      CURSOR c_central (
      p_desde_cen   ga_celnum_uso.num_desde%type,
      p_hasta_cen   ga_celnum_uso.num_hasta%type)
      IS
         SELECT num_desde, num_hasta, cod_subalm,cod_central, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_central') num_sig
         FROM ga_celnum_central
         WHERE p_desde_cen BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,cod_subalm,cod_central, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_central') num_sig
         FROM ga_celnum_central
         WHERE p_hasta_cen BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,cod_subalm,cod_central, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_central') num_sig
         FROM ga_celnum_central
         WHERE num_desde >= p_desde_cen AND num_desde <= p_hasta_cen
         UNION
         SELECT num_desde, num_hasta,cod_subalm,cod_central, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_central') num_sig
         FROM ga_celnum_central
         WHERE num_hasta >= p_desde_cen AND num_hasta <= p_hasta_cen
        ;

      CURSOR c_categoria (
      p_desde_cat   ga_celnum_uso.num_desde%type,
      p_hasta_cat   ga_celnum_uso.num_hasta%type)
      IS
         SELECT num_desde, num_hasta, cod_subalm,cod_central,cod_cat, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_cat') num_sig
         FROM ga_celnum_cat
         WHERE p_desde_cat BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,cod_subalm,cod_central,cod_cat, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_cat') num_sig
         FROM ga_celnum_cat
         WHERE p_hasta_cat BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,cod_subalm,cod_central,cod_cat, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_cat') num_sig
         FROM ga_celnum_cat
         WHERE num_desde >= p_desde_cat AND num_desde <= p_hasta_cat
         UNION
         SELECT num_desde, num_hasta,cod_subalm,cod_central,cod_cat, cod_producto,adn_nrosig_fn(num_desde,'ga_celnum_cat') num_sig
         FROM ga_celnum_cat
         WHERE num_hasta >= p_desde_cat AND num_hasta <= p_hasta_cat
        ;
        CURSOR c_uso (
          p_desde_uso   ga_celnum_uso.num_desde%type,
          p_hasta_uso   ga_celnum_uso.num_hasta%type)
        IS
         SELECT num_desde, num_hasta, num_libres,num_siguiente,cod_subalm,cod_central,cod_cat, cod_producto,cod_uso,adn_nrosig_fn(num_desde,'ga_celnum_uso') num_sig
         FROM ga_celnum_uso
         WHERE p_desde_uso BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,num_libres,num_siguiente,cod_subalm,cod_central,cod_cat, cod_producto,cod_uso,adn_nrosig_fn(num_desde,'ga_celnum_uso') num_sig
         FROM ga_celnum_uso
         WHERE p_hasta_uso BETWEEN num_desde AND num_hasta
         UNION
         SELECT num_desde, num_hasta,num_libres,num_siguiente,cod_subalm,cod_central,cod_cat, cod_producto,cod_uso,adn_nrosig_fn(num_desde,'ga_celnum_uso') num_sig
         FROM ga_celnum_uso
         WHERE num_desde >= p_desde_uso AND num_desde <= p_hasta_uso
         UNION
         SELECT num_desde, num_hasta,num_libres,num_siguiente,cod_subalm,cod_central,cod_cat, cod_producto,cod_uso,adn_nrosig_fn(num_desde,'ga_celnum_uso') num_sig
         FROM ga_celnum_uso
         WHERE num_hasta >= p_desde_uso AND num_hasta <= p_hasta_uso
        ;
        v_subalm    c_subalm%ROWTYPE;
        v_central   c_central%ROWTYPE;
        v_categoria c_categoria%ROWTYPE;
        v_uso       c_uso%ROWTYPE;

        v_desde_sub ga_celnum_uso.num_desde%TYPE;
        v_hasta_sub ga_celnum_uso.num_hasta%TYPE;
        v_desde_cen ga_celnum_uso.num_desde%TYPE;
        v_hasta_cen ga_celnum_uso.num_hasta%TYPE;
        v_desde_cat ga_celnum_uso.num_desde%TYPE;
        v_hasta_cat ga_celnum_uso.num_hasta%TYPE;
        v_desde_uso ga_celnum_uso.num_desde%TYPE;
        v_hasta_uso ga_celnum_uso.num_hasta%TYPE;

        v_desde     ga_celnum_uso.num_desde%TYPE;
        v_hasta     ga_celnum_uso.num_hasta%TYPE;
        v_inicio    ga_celnum_uso.num_desde%TYPE;
        v_fin       ga_celnum_uso.num_hasta%TYPE;
        v_libres    ga_celnum_uso.num_libres%TYPE;
        v_siguiente ga_celnum_uso.num_siguiente%TYPE;
        v_desdewait ga_celnum_uso.num_desde%TYPE;

        v_cod_central ga_celnum_uso.cod_central%TYPE;
        v_cod_cat     ga_celnum_uso.cod_cat%TYPE;
        v_cod_uso     ga_celnum_uso.cod_uso%TYPE;
        v_cod_prod    ga_celnum_uso.cod_producto%TYPE;

        v_insert_uso  varchar2(250);
        v_insert_cat  varchar2(250);
        v_insert_cen  varchar2(250);

        v_update_uso  varchar2(250);
BEGIN
  --El Rango que vienen como parametro no existe en ga_celnum_uso
  --Pero existe en ga_celnum_subalm
     v_insert_uso:='INSERT INTO ga_celnum_uso (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente,ind_contaminado) ';
     v_insert_uso:= v_insert_uso||'VALUES(:desde,:hasta,:subalm,:producto,:central,:categoria,:uso,:libres,:sig,0)';


     v_insert_cat:='INSERT INTO ga_celnum_cat (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat) ';
     v_insert_cat:=v_insert_cat||'VALUES(:desde,:hasta,:subalm,:producto,:central,:cat)';


     v_insert_cen:='INSERT INTO ga_celnum_central (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,ind_equipado) ';
     v_insert_cen:=v_insert_cen||'VALUES(:desde,:hasta,:subalm,:producto,:central,1)';


     v_update_uso:='UPDATE ga_celnum_uso                  ';
     v_update_uso:= v_update_uso||'SET num_hasta=:hasta,  ';
     v_update_uso:= v_update_uso||'num_siguiente=:sig,    ';
     v_update_uso:= v_update_uso||'num_libres=:libres     ';
     v_update_uso:= v_update_uso||'WHERE num_desde=:desde ';


     adn_home_default_pr(p_num_desde,v_cod_central,v_cod_cat,v_cod_uso);
     v_cod_prod:=1;

     OPEN c_subalm(p_num_desde,p_num_hasta);
     LOOP
         FETCH c_subalm INTO v_subalm;
         EXIT WHEN c_subalm%NOTFOUND;
         v_desde_sub:=v_subalm.num_desde;
         v_hasta_sub:=v_subalm.num_hasta;
         OPEN c_central(v_desde_sub,v_hasta_sub);
         LOOP
             FETCH c_central INTO v_central;
             EXIT WHEN c_central%NOTFOUND;
             v_desde_cen:=v_central.num_desde;
             v_hasta_cen:=v_central.num_hasta;
             OPEN c_categoria(v_desde_cen,v_hasta_cen);
             LOOP
                 FETCH c_categoria INTO v_categoria;
                 EXIT WHEN c_categoria%NOTFOUND;
                 v_desde_cat:=v_categoria.num_desde;
                 v_hasta_cat:=v_categoria.num_hasta;
                 OPEN c_uso(v_desde_cat,v_hasta_cat);
                 LOOP
                     FETCH c_uso INTO v_uso;
                      EXIT WHEN c_uso%NOTFOUND;

                     IF v_uso.num_libres>0 THEN

                        IF v_uso.num_siguiente > p_num_desde THEN

                           IF v_uso.num_siguiente = p_num_hasta THEN

                              v_inicio:=v_uso.num_desde;
                              v_fin:=p_num_hasta -1;
                              v_libres:= 0;
                              v_siguiente:=v_fin;
                              --Update sobre v_fin,num_libres,v_siguiente
                              IF v_inicio <= v_fin THEN

                                SELECT num_desde
                                INTO v_desdewait
                                FROM ga_celnum_uso
                                WHERE num_desde= v_inicio
                                FOR UPDATE NOWAIT;

                                EXECUTE IMMEDIATE v_update_uso
                                USING v_fin,v_siguiente,v_libres,v_inicio;

                                v_inicio:=p_num_hasta;
                                v_fin:=p_num_hasta;
                                v_libres:=1;
                                v_siguiente:=v_inicio;
                                --Insert
                                EXECUTE IMMEDIATE v_insert_uso
                                USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;

                                v_inicio:=p_num_hasta + 1;
                                v_fin:=v_uso.num_hasta;
                                v_libres:=v_fin -v_inicio +1 ;
                                v_siguiente:=v_inicio;
                                --insert
                                EXECUTE IMMEDIATE v_insert_uso
                                USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                              END IF;
                           ELSE
                             IF v_uso.num_siguiente < p_num_hasta THEN

                                IF v_uso.num_hasta > p_num_hasta THEN
                                   v_inicio:=v_uso.num_desde;
                                   v_fin:=v_uso.num_siguiente -1;
                                   v_libres:=0;
                                   v_siguiente:=v_fin;
                                   -- Update
                                   IF v_inicio <= v_fin THEN
                                     SELECT num_desde
                                     INTO v_desdewait
                                     FROM ga_celnum_uso
                                     WHERE num_desde= v_inicio
                                     FOR UPDATE NOWAIT;

                                     EXECUTE IMMEDIATE v_update_uso
                                     USING v_fin,v_siguiente,v_libres,v_inicio;

                                     v_inicio:=v_uso.num_siguiente;
                                     v_fin:=p_num_hasta;
                                     v_libres:=v_fin - v_inicio + 1;
                                     v_siguiente:=v_inicio;
                                     --insert
                                     EXECUTE IMMEDIATE v_insert_uso
                                     USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;

                                     v_inicio:=p_num_hasta +1;
                                     v_fin:=v_uso.num_hasta;
                                     v_libres:=v_fin - v_inicio +1;
                                     v_siguiente:=v_inicio;
                                     --insert
                                     EXECUTE IMMEDIATE v_insert_uso
                                     USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                   END IF;
                                ELSE
                                  IF v_uso.num_hasta = p_num_hasta THEN
                                    v_inicio:=v_uso.num_desde;
                                    v_fin:=v_uso.num_siguiente -1;
                                    v_libres:=0;
                                    v_siguiente:=v_fin;
                                    -- Update
                                    IF v_inicio <= v_fin THEN
                                        SELECT num_desde
                                        INTO v_desdewait
                                        FROM ga_celnum_uso
                                        WHERE num_desde= v_inicio
                                        FOR UPDATE NOWAIT;

                                      EXECUTE IMMEDIATE v_update_uso
                                      USING v_fin,v_siguiente,v_libres,v_inicio;

                                      v_inicio:=v_uso.num_siguiente;
                                      v_fin:=p_num_hasta;
                                      v_libres:=v_fin - v_inicio + 1;
                                      v_siguiente:=v_inicio;
                                      --insert
                                      EXECUTE IMMEDIATE v_insert_uso
                                      USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                    END IF;
                                  ELSE
                                    v_inicio:=v_uso.num_desde;
                                    v_fin:=v_uso.num_siguiente -1;
                                    v_libres:=0;
                                    v_siguiente:=v_fin;
                                    -- Update
                                    IF v_inicio <= v_fin THEN
                                        SELECT num_desde
                                        INTO v_desdewait
                                        FROM ga_celnum_uso
                                        WHERE num_desde= v_inicio
                                        FOR UPDATE NOWAIT;

                                      EXECUTE IMMEDIATE v_update_uso
                                      USING v_fin,v_siguiente,v_libres,v_inicio;

                                      v_inicio:=v_uso.num_siguiente;
                                      v_fin:=v_uso.num_hasta;
                                      v_libres:=v_fin - v_inicio + 1;
                                      v_siguiente:=v_inicio;
                                      --insert
                                      EXECUTE IMMEDIATE v_insert_uso
                                      USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                    END IF;
                                  END IF;
                                END IF;
                             END IF;
                           END IF;
                        ELSE
                            IF v_uso.num_siguiente = p_num_desde THEN

                               IF v_uso.num_siguiente = p_num_hasta THEN

                                 v_inicio:=v_uso.num_desde;
                                 v_fin:=v_uso.num_siguiente -1;
                                 v_libres:=0;
                                 v_siguiente:=v_fin;
                                 -- Update
                                 IF v_inicio <= v_fin THEN
                                    SELECT num_desde
                                    INTO v_desdewait
                                    FROM ga_celnum_uso
                                    WHERE num_desde= v_inicio
                                    FOR UPDATE NOWAIT;

                                   EXECUTE IMMEDIATE v_update_uso
                                   USING v_fin,v_siguiente,v_libres,v_inicio;

                                   v_inicio:=v_uso.num_siguiente;
                                   v_fin:=v_inicio;
                                   v_libres:=v_fin - v_inicio + 1;
                                   v_siguiente:=v_inicio;
                                   --insert
                                   EXECUTE IMMEDIATE v_insert_uso
                                   USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;

                                   v_inicio:=v_uso.num_siguiente + 1;
                                   v_fin:=v_uso.num_hasta;
                                   v_libres:=v_fin - v_inicio + 1;
                                   v_siguiente:=v_inicio;
                                   --insert
                                   EXECUTE IMMEDIATE v_insert_uso
                                   USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                 END IF;
                               ELSE
                                  IF v_uso.num_siguiente < p_num_hasta THEN

                                    IF v_uso.num_hasta > p_num_hasta THEN
                                       v_inicio:=v_uso.num_desde;
                                       v_fin:=v_uso.num_siguiente -1;
                                       v_libres:=0;
                                       v_siguiente:=v_fin;
                                       -- Update
                                       IF v_inicio <= v_fin THEN
                                            SELECT num_desde
                                            INTO v_desdewait
                                            FROM ga_celnum_uso
                                            WHERE num_desde= v_inicio
                                            FOR UPDATE NOWAIT;

                                         EXECUTE IMMEDIATE v_update_uso
                                         USING v_fin,v_siguiente,v_libres,v_inicio;

                                         v_inicio:=v_uso.num_siguiente + 1;
                                         v_fin:=p_num_hasta;
                                         v_libres:=v_fin - v_inicio + 1;
                                         v_siguiente:=v_inicio;
                                         --insert
                                         EXECUTE IMMEDIATE v_insert_uso
                                         USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;

                                         v_inicio:=p_num_hasta + 1;
                                         v_fin:=v_uso.num_hasta;
                                         v_libres:=v_fin - v_inicio + 1;
                                         v_siguiente:=v_inicio;
                                         --insert
                                         EXECUTE IMMEDIATE v_insert_uso
                                         USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                       END IF;
                                    ELSE
                                      IF v_uso.num_hasta = p_num_hasta THEN
                                        v_inicio:=v_uso.num_desde;
                                        v_fin:=v_uso.num_siguiente -1;
                                        v_libres:=0;
                                        v_siguiente:=v_fin;
                                        -- Update
                                        IF v_inicio <= v_fin THEN
                                            SELECT num_desde
                                            INTO v_desdewait
                                            FROM ga_celnum_uso
                                            WHERE num_desde= v_inicio
                                            FOR UPDATE NOWAIT;

                                          EXECUTE IMMEDIATE v_update_uso
                                          USING v_fin,v_siguiente,v_libres,v_inicio;

                                          v_inicio:=v_uso.num_siguiente + 1;
                                          v_fin:=p_num_hasta;
                                          v_libres:=v_fin - v_inicio + 1;
                                          v_siguiente:=v_inicio;
                                          --insert
                                          EXECUTE IMMEDIATE v_insert_uso
                                          USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                        END IF;
                                      ELSE --v_uso.num_hasta < p_num_hasta
                                        v_inicio:=v_uso.num_desde;
                                        v_fin:=v_uso.num_siguiente -1;
                                        v_libres:=0;
                                        v_siguiente:=v_fin;
                                        -- Update
                                        IF v_inicio <= v_fin THEN
                                            SELECT num_desde
                                            INTO v_desdewait
                                            FROM ga_celnum_uso
                                            WHERE num_desde= v_inicio
                                            FOR UPDATE NOWAIT;

                                          EXECUTE IMMEDIATE v_update_uso
                                          USING v_fin,v_siguiente,v_libres,v_inicio;

                                          v_inicio:=v_uso.num_siguiente + 1;
                                          v_fin:=v_uso.num_hasta;
                                          v_libres:=v_fin - v_inicio + 1;
                                          v_siguiente:=v_inicio;
                                          --insert
                                          EXECUTE IMMEDIATE v_insert_uso
                                          USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                        END IF;
                                      END IF;
                                    END IF;
                                  END IF;
                             END IF;
                           ELSE --v_uso.num_siguiente < p_num_desde
                                v_inicio:=v_uso.num_desde;
                                v_fin:= p_num_desde -1;
                                v_libres:= v_fin - v_uso.num_siguiente + 1;
                                v_siguiente:=v_uso.num_siguiente;
                                --update
                                IF v_inicio <= v_fin THEN
                                    SELECT num_desde
                                    INTO v_desdewait
                                    FROM ga_celnum_uso
                                    WHERE num_desde= v_inicio
                                    FOR UPDATE NOWAIT;

                                  EXECUTE IMMEDIATE v_update_uso
                                  USING v_fin,v_siguiente,v_libres,v_inicio;

                                  IF v_uso.num_hasta > p_num_hasta THEN
                                    v_inicio:=p_num_desde;
                                    v_fin:= p_num_hasta;
                                    v_libres:=v_fin - v_inicio + 1;
                                    v_siguiente:=v_inicio;
                                    --insert
                                    EXECUTE IMMEDIATE v_insert_uso
                                    USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;

                                    v_inicio:=p_num_hasta + 1;
                                    v_fin:= v_uso.num_hasta;
                                    v_libres:=v_fin - v_inicio +1;
                                    v_siguiente:=v_inicio;
                                    --insert
                                    EXECUTE IMMEDIATE v_insert_uso
                                    USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                  END IF;
                                ELSE

                                  v_inicio:=p_num_desde;
                                  IF v_uso.num_hasta = p_num_hasta THEN
                                    v_fin:= p_num_hasta;
                                  ELSE --v_uso.num_hasta < p_num_hasta
                                    v_fin:= v_uso.num_hasta;
                                  END IF;
                                  v_libres:=v_fin - v_inicio + 1;
                                  v_siguiente:=v_inicio;
                                  --insert
                                  IF v_inicio <= v_fin THEN
                                    EXECUTE IMMEDIATE v_insert_uso
                                    USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_siguiente;
                                  END IF;
                                END IF;
                            END IF;
                        END IF;
                     END IF;

                     v_desde_uso:=v_uso.num_desde;
                     v_hasta_uso:=v_uso.num_hasta;
                       v_inicio:=v_hasta_uso + 1;

                     IF (v_uso.num_sig is not null) THEN
                        IF v_uso.num_sig <> v_inicio THEN
                           IF v_uso.num_sig < v_hasta_cat THEN
                             v_fin:=v_uso.num_sig - 1;
                          ELSE
                             v_fin:=v_hasta_cat;
                          END IF;
                          IF v_fin > p_num_hasta THEN
                             v_fin:=p_num_hasta;
                          END IF;

                          IF v_inicio <= v_fin THEN
                          -- Creo Rango Uso'
                              v_libres:=v_fin - v_inicio +1;

                              EXECUTE IMMEDIATE v_insert_uso
                              USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_uso.cod_uso,v_libres,v_inicio;
                          END IF;
                        END IF;
                     END IF;
                     --IF
                 END LOOP; --Cursor GA_CELNUM_USO
                 IF c_uso%ROWCOUNT=0 THEN
                   -- Creo Rango Uso'
                   v_inicio:=v_desde_cat;
                   v_fin:=v_hasta_cat;
                   v_libres:=v_fin - v_inicio +1;
                   IF v_fin > p_num_hasta THEN
                     v_fin:=p_num_hasta;
                   END IF;
                   IF v_inicio <= v_fin THEN
                     EXECUTE IMMEDIATE v_insert_uso
                     USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_cod_uso,v_libres,v_inicio;
                   END IF;
                 END IF;
                 CLOSE c_uso;
                 IF (v_categoria.num_sig is not null) THEN
                    v_inicio:=v_categoria.num_hasta + 1;
                    IF (v_categoria.num_sig <> v_inicio) THEN
                       IF v_categoria.num_sig < v_hasta_cen THEN
                          v_fin:=v_categoria.num_sig - 1;
                       ELSE
                          v_fin:=v_hasta_cen;
                       END IF;
                       IF v_fin > p_num_hasta THEN
                          v_fin:=p_num_hasta;
                       END IF;
                       IF v_inicio <= v_fin THEN
                           v_libres:=v_fin - v_inicio +1;

                           EXECUTE IMMEDIATE v_insert_cat
                           USING v_inicio,v_fin,v_subalm.cod_subalm,v_central.cod_producto,v_central.cod_central,v_categoria.cod_cat;
                           EXECUTE IMMEDIATE v_insert_uso

                           USING v_inicio,v_fin,v_subalm.cod_subalm,v_categoria.cod_producto,v_central.cod_central,v_categoria.cod_cat,v_cod_uso,v_libres,v_inicio;
                       END IF;
                    END IF;
                 END IF;
             END LOOP;    --Cursor GA_CELNUM_CAT
             IF c_categoria%ROWCOUNT=0 THEN
                -- Sin Datos Categoria: Creo Rango Categoria-Uso'
                v_desde:=v_central.num_desde;
                v_hasta:=v_central.num_hasta;
                v_libres:=v_hasta - v_desde +1;
                IF v_hasta > p_num_hasta THEN
                   v_hasta:=p_num_hasta;
                END IF;
                IF v_desde <= v_hasta THEN
                  EXECUTE IMMEDIATE v_insert_cat
                  USING v_desde,v_hasta,v_subalm.cod_subalm,v_central.cod_producto,v_central.cod_central,v_cod_cat;

                  EXECUTE IMMEDIATE v_insert_uso
                  USING v_desde,v_hasta,v_subalm.cod_subalm,v_central.cod_producto,v_central.cod_central,v_cod_cat,v_cod_uso,v_libres,v_desde;
                END IF;
             END IF;
             CLOSE c_categoria;
             IF (v_central.num_sig is not null) THEN
                v_inicio:=v_central.num_hasta + 1;
                IF (v_central.num_sig <> v_inicio) THEN
                      IF v_central.num_sig < v_hasta_sub THEN
                      v_fin:=v_central.num_sig - 1;
                   ELSE
                         v_fin:=v_hasta_sub;
                   END IF;
                   IF v_fin > p_num_hasta THEN
                      v_fin:=p_num_hasta;
                   END IF;
                   IF v_inicio <= v_fin THEN
                          v_libres:=v_fin - v_inicio +1;

                       EXECUTE IMMEDIATE v_insert_cen
                       USING v_inicio,v_fin,v_subalm.cod_subalm,v_central.cod_producto,v_central.cod_central;
                       EXECUTE IMMEDIATE v_insert_cat
                       USING v_inicio,v_fin,v_subalm.cod_subalm,v_central.cod_producto,v_central.cod_central,v_cod_cat;

                       EXECUTE IMMEDIATE v_insert_uso
                       USING v_inicio,v_fin,v_subalm.cod_subalm,v_central.cod_producto,v_central.cod_central,v_cod_cat,v_cod_uso,v_libres,v_inicio;
                   END IF;
                   END IF;
             END IF;
         END LOOP; --Cursor GA_CELNUM_CENTRAL
         IF c_central%ROWCOUNT=0 THEN
            --Sin Datos Central: Creo Rango Central-Categoria-Uso

            v_desde:=v_subalm.num_desde;
            v_hasta:=v_subalm.num_hasta;
            v_libres:=v_hasta - v_desde +1;
            IF v_hasta > p_num_hasta THEN
               v_hasta:=p_num_hasta;
            END IF;
            IF v_desde <= v_hasta THEN
               EXECUTE IMMEDIATE v_insert_cen
               USING v_desde,v_hasta,v_subalm.cod_subalm,v_cod_prod,v_cod_central;
               EXECUTE IMMEDIATE v_insert_cat
               USING v_desde,v_hasta,v_subalm.cod_subalm,v_cod_prod,v_cod_central,v_cod_cat;
               EXECUTE IMMEDIATE v_insert_uso
               USING v_desde,v_hasta,v_subalm.cod_subalm,v_cod_prod,v_cod_central,v_cod_cat,v_cod_uso,v_libres,v_desde;
            END IF;
         END IF;
         CLOSE c_central;
     END LOOP; --Cursor GA_CELNUM_SUBALM
     -- Si c_subalm%ROWCOUNT=0 ==> Sin Datos Subalm: No se hace nada
     CLOSE c_subalm;
EXCEPTION
     WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20120, 'Error(ADN_RANGOS_FALTANTES_PR) Retorna mas Registros que lo Esperado ' );
     WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20130, 'Error(ADN_RANGOS_FALTANTES_PR) No hay Informacion ' );
     WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_RANGOS_FALTANTES_PR ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_RANGOS_FALTANTES_PR;

PROCEDURE ADN_ACTUALIZA_DEVUELTOS_PR(
   p_num_desde  ga_celnum_uso.num_desde%type,
   p_num_hasta  ga_celnum_uso.num_hasta%type)
IS
      v_desde       ga_celnum_uso.num_desde%type;
      v_hasta       ga_celnum_uso.num_hasta%type;
      v_desder      ga_celnum_uso.num_desde%type;
      v_hastar      ga_celnum_uso.num_hasta%type;
      v_totbloques  ga_celnum_uso.num_libres%type;
        v_bloque      ga_celnum_uso.num_desde%type;
      v_devuelto    PLS_INTEGER;
      v_delete_dev  VARCHAR2(250);
BEGIN
     v_desde:=p_num_desde -1;
     v_hasta:=p_num_hasta;
     v_delete_dev:='DELETE FROM adn_celnum_devueltos_to WHERE substr(num_desde,1,7)=:bloque';

     SELECT val_parametro
     INTO v_totbloques
     FROM ged_parametros
     WHERE nom_parametro ='CANTIDAD_BLOQUE'
     AND   cod_modulo='AD'
     AND   cod_producto=1;

     WHILE (v_desde <= v_hasta) LOOP
        v_desder:=v_desde + 1;
        v_hastar:=v_desder + v_totbloques - 1;
        v_devuelto:=adn_es_devuelto_fn(v_desder);
        IF v_devuelto = 1 THEN
          --dbms_output.put_line('Bloque: '||to_char(v_bloque));
          v_bloque:=substr(v_desder,1,7);
          EXECUTE IMMEDIATE  v_delete_dev
          USING v_bloque;
        END IF;
        v_desde:=v_hastar;
     END LOOP;
EXCEPTION
         WHEN TOO_MANY_ROWS THEN
              RAISE_APPLICATION_ERROR(-20120, 'Error(ADN_ACTUALIZA_DEVUELTOS_PR) Retorna mas Registros que lo Esperado ' );
         WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20130, 'Error(ADN_ACTUALIZA_DEVUELTOS_PR) No hay Informacion ' );
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ACTUALIZA_DEVUELTOS_PR ' || to_char(SQLCODE) || ': ' || SQLERRM);

END ADN_ACTUALIZA_DEVUELTOS_PR;

PROCEDURE ADN_DISPONIBILIZA_RANGO_PR (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
IS
-- ************************************************************************************
-- * DESCRIPCION : Este proceso disponibiliza TODOS los numeros de un rango de uso    *
-- *               entre el numero desde hasta el numero anterior al numero siguiente *
-- ************************************************************************************
 v_cod_subalm ga_celnum_uso.cod_subalm%TYPE;
 v_cod_producto ga_celnum_uso.cod_producto%TYPE;
 v_cod_central ga_celnum_uso.cod_central%TYPE;
 v_cod_cat ga_celnum_uso.cod_cat%TYPE;
 v_cod_uso ga_celnum_uso.cod_uso%TYPE;
 v_num_libres ga_celnum_uso.num_libres%TYPE;
 v_num_siguiente ga_celnum_uso.num_siguiente%TYPE;
 v_ind_contaminado ga_celnum_uso.ind_contaminado%TYPE;
 v_desde ga_celnum_uso.num_desde%TYPE;
 v_hasta ga_celnum_uso.num_hasta%TYPE;
 v_DiasHib al_usos.num_dias_hibernacion%TYPE;
BEGIN
    EXECUTE IMMEDIATE 'SELECT cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres, num_siguiente, ind_contaminado FROM ga_celnum_uso WHERE num_desde=:p_num_desde AND num_hasta=:p_num_hasta'
    INTO v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso,v_num_libres,v_num_siguiente,v_ind_contaminado
    USING p_num_desde,p_num_hasta;

    v_DiasHib:=ge_fn_dias_hibernacion(v_cod_uso);

    v_desde:=p_num_desde;

    IF v_num_libres = 0 THEN
      v_hasta:=p_num_hasta;
    ELSE
      v_hasta:=v_num_siguiente -1;
    END IF;

    WHILE (v_desde <= v_hasta) LOOP
        IF adn_es_nro_contaminado_fn(v_desde)=0 THEN
           INSERT INTO ga_celnum_reutil (num_celular,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,fec_baja,ind_equipado, uso_anterior)
           VALUES(v_desde,v_cod_subalm,v_cod_producto,v_cod_central,v_cod_cat,v_cod_uso,(sysdate - v_DiasHib),1,v_cod_uso)
           ;
        END IF;
        v_desde:=v_desde + 1 ;
   END LOOP;

   EXCEPTION
         WHEN TOO_MANY_ROWS THEN
              RAISE_APPLICATION_ERROR(-20120, 'Error(ADN_DISPONIBILIZA_RANGO_PR) Retorna mas Registros que lo Esperado ' );
         WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20130, 'Error(ADN_DISPONIBILIZA_RANGO_PR) No hay Informacion ' );
         WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_DISPONIBILIZA_RANGO_PR ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_DISPONIBILIZA_RANGO_PR;


PROCEDURE ADN_ABERTURA_RANGO_PORTADO_PR (
      p_celular  IN ga_celnum_reutil.num_celular%TYPE)
IS
-- ************************************************************************************
-- * DESCRIPCION : Este procedimiento habrira los rangos de las tablas de numeracion  *
-- *               para re-ingresar un numero que es Portado y que esta en el sistema *
-- *               como numero contaminado.                                           *
-- ************************************************************************************
 v_desde     ga_celnum_uso.num_desde%TYPE;
 v_hasta     ga_celnum_uso.num_hasta%TYPE;
 v_inicio1   ga_celnum_uso.num_desde%TYPE;
 v_fin1      ga_celnum_uso.num_hasta%TYPE;
 v_inicio2   ga_celnum_uso.num_desde%TYPE;
 v_fin2      ga_celnum_uso.num_hasta%TYPE;
 v_subalm    ga_celnum_uso.cod_subalm%TYPE;
 v_central   ga_celnum_uso.cod_central%TYPE;
 v_cat       ga_celnum_uso.cod_cat%TYPE;
 v_uso       ga_celnum_uso.cod_uso%TYPE;
 v_libres    ga_celnum_uso.num_libres%TYPE;
 v_libres1   ga_celnum_uso.num_libres%TYPE;
 v_libres2   ga_celnum_uso.num_libres%TYPE;
 v_producto  ga_celnum_uso.cod_producto%TYPE;
 v_siguiente   ga_celnum_uso.num_siguiente%TYPE;
 v_siguiente1  ga_celnum_uso.num_siguiente%TYPE;
 v_siguiente2  ga_celnum_uso.num_siguiente%TYPE;
 v_contamina   ga_celnum_uso.ind_contaminado%TYPE;
 v_observacion adn_contaminados_th.observacion%type;
 v_fecha       adn_contaminados_th.fec_baja%type;
 v_nivel     VARCHAR2(10);
 v_ind       pls_integer;

 v_insert_uso  varchar2(250);
 v_insert_cat  varchar2(250);
 v_insert_cen  varchar2(250);
 v_insert_sub  varchar2(250);
 v_update_uso  varchar2(250);
 v_update_cat  varchar2(250);
 v_update_cen  varchar2(250);
 v_update_sub  varchar2(250);
 v_delete_uso  varchar2(250);
 v_delete_cat  varchar2(250);
 v_delete_cen  varchar2(250);
 v_delete_sub  varchar2(250);
 v_delete_con  varchar2(250);
 v_update_conh varchar2(250);

BEGIN
   IF adn_es_nro_contaminado_fn(p_celular)=1 THEN
      BEGIN
        v_insert_uso:='INSERT INTO ga_celnum_uso (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat,cod_uso,num_libres,num_siguiente,ind_contaminado) ';
        v_insert_uso:= v_insert_uso||'VALUES(:desde,:hasta,:subalm,:producto,:central,:categoria,:uso,:libres,:sig,:cont)';

        v_insert_cat:='INSERT INTO ga_celnum_cat (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,cod_cat) ';
        v_insert_cat:=v_insert_cat||'VALUES(:desde,:hasta,:subalm,:producto,:central,:cat)';

        v_insert_cen:='INSERT INTO ga_celnum_central (num_desde,num_hasta,cod_subalm,cod_producto,cod_central,ind_equipado) ';
        v_insert_cen:=v_insert_cen||'VALUES(:desde,:hasta,:subalm,:producto,:central,1)';

        v_insert_sub:='INSERT INTO ga_celnum_subalm (num_desde,num_hasta,cod_subalm,ind_contaminado) ';
        v_insert_sub:=v_insert_sub||'VALUES(:desde,:hasta,:subalm,:ind)';

        v_delete_uso:='DELETE FROM ga_celnum_uso WHERE num_desde=:desde';
        v_delete_cat:='DELETE FROM ga_celnum_cat WHERE num_desde=:desde';
         v_delete_cen:='DELETE FROM ga_celnum_central WHERE num_desde=:desde';
        v_delete_sub:='DELETE FROM ga_celnum_subalm WHERE num_desde=:desde';
        v_delete_con:='DELETE FROM adn_contaminados_td WHERE num_celular=:celular';

        v_update_conh:='UPDATE adn_contaminados_th SET observacion=:obs WHERE num_celular=:celular and trunc(fec_baja)=:fecha';
        v_update_uso :='UPDATE ga_celnum_uso SET num_hasta=:hasta, num_libres=:libres, num_siguiente=:sig WHERE num_desde=:desde';
        v_update_cat :='UPDATE ga_celnum_cat SET num_hasta=:hasta WHERE num_desde=:desde';
        v_update_cen :='UPDATE ga_celnum_central SET num_hasta=:hasta WHERE num_desde=:desde';
        v_update_sub :='UPDATE ga_celnum_subalm SET num_hasta=:hasta, ind_contaminado=:cont WHERE num_desde=:desde';

        BEGIN
          v_nivel:='Uso';
          SELECT num_desde,num_hasta,cod_subalm,cod_central,cod_cat, cod_uso, num_libres,num_siguiente,cod_producto
          INTO v_desde,v_hasta,v_subalm,v_central,v_cat,v_uso,v_libres,v_siguiente,v_producto
          FROM ga_celnum_uso
          WHERE p_celular between num_desde and num_hasta
          FOR UPDATE NOWAIT;
           IF v_desde=p_celular THEN
             EXECUTE IMMEDIATE v_delete_uso
             USING v_desde;

             v_inicio1:= p_celular + 1;
             v_fin1:=v_hasta;
             v_libres1:=v_libres;
                         v_siguiente1:=v_siguiente;
             IF v_libres<>0 THEN
               IF v_siguiente=v_desde THEN
                 v_siguiente1:= v_inicio1;
               END IF;
               v_libres1:=v_fin1 - v_inicio1 +1;
             END IF;

             EXECUTE IMMEDIATE v_insert_uso
             USING v_inicio1,v_fin1,v_subalm,v_producto,v_central,v_cat,v_uso,v_libres1,v_siguiente1,adn_es_rango_contaminado_fn(v_inicio1,v_fin1);
          ELSE
             IF v_hasta=p_celular THEN
               v_inicio1 :=v_desde;
               v_fin1:= v_hasta - 1;
               v_libres1:=v_libres;
               IF v_libres =0 THEN
                 v_siguiente1:=v_fin1;
               ELSE
                 IF v_siguiente=v_desde THEN
                   v_siguiente1:= v_inicio1;
                 END IF;
                 v_libres1:=v_fin1 - v_inicio1 +1;
               END IF;
               EXECUTE IMMEDIATE v_update_uso
               USING v_fin1,v_libres1,v_siguiente1,v_inicio1;

             ELSE -- p_celular > v_desde y < v_hasta
               v_inicio1 :=v_desde;
               v_fin1:= p_celular - 1;

               IF v_siguiente <= v_fin1 THEN
                  v_siguiente1:=v_siguiente;
                  IF v_siguiente=v_fin1 THEN
                     v_siguiente1:=v_siguiente -1 ;
                  END IF;
                  IF v_siguiente1=v_fin1 THEN
                    v_libres1:=0;
                  ELSE
                    v_libres1:=v_fin1 - v_siguiente1 + 1;
                  END IF;
               ELSE
                  v_siguiente1:=v_inicio1;
                  v_libres1:=v_fin1 - v_siguiente1 + 1;
               END IF;
               EXECUTE IMMEDIATE v_update_uso
               USING v_fin1,v_libres1,v_siguiente1,v_inicio1;

               v_inicio2:= p_celular + 1;
               v_fin2:=v_hasta;
               IF v_siguiente > p_celular THEN
                 v_siguiente2:= v_siguiente;
                 IF v_siguiente=v_fin2 THEN
                   v_siguiente2:=v_siguiente -1 ;
                 END IF;
                 IF v_siguiente2=v_fin2 THEN
                   v_libres2:=0;
                 ELSE
                   v_libres2:=v_fin2 - v_siguiente2 + 1;
                 END IF;
               ELSE
                  v_siguiente2:=v_inicio2;
                  v_libres2:=v_fin2 - v_siguiente2 + 1;
               END IF;

               EXECUTE IMMEDIATE v_insert_uso
                 USING v_inicio2,v_fin2,v_subalm,v_producto,v_central,v_cat,v_uso,v_libres2,v_siguiente2,adn_es_rango_contaminado_fn(v_inicio2,v_fin2);
             END IF;
          END IF;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               null;
        END;

        BEGIN
          v_nivel:='Categoria';
          SELECT num_desde,num_hasta,cod_central,cod_subalm,cod_producto
          INTO v_desde,v_hasta,v_central,v_subalm,v_producto
          FROM ga_celnum_cat
          WHERE p_celular between num_desde and num_hasta
          FOR UPDATE NOWAIT
          ;

          IF v_desde=p_celular THEN
             EXECUTE IMMEDIATE v_delete_cat
             USING v_desde;
             v_inicio1:= p_celular + 1;
             v_fin1:=v_hasta;

             EXECUTE IMMEDIATE v_insert_cat
             USING  v_inicio1,v_fin1,v_subalm,v_producto,v_central,v_cat;
          ELSE
             IF v_hasta=p_celular THEN
               v_inicio1 :=v_desde;
               v_fin1:= v_hasta - 1;
               EXECUTE IMMEDIATE v_update_cat
               USING v_fin1,v_inicio1;

             ELSE -- p_celular > v_desde y < v_hasta
               v_inicio1 :=v_desde;
               v_fin1:= p_celular - 1;
               EXECUTE IMMEDIATE v_update_cat
               USING v_fin1,v_inicio1;

               v_inicio2:= p_celular + 1;
               v_fin2:=v_hasta;
               EXECUTE IMMEDIATE v_insert_cat
               USING  v_inicio2,v_fin2,v_subalm,v_producto,v_central,v_cat;

             END IF;
          END IF;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               null;
        END;

        BEGIN
          v_nivel:='Central';
          SELECT num_desde,num_hasta,cod_central,cod_subalm,cod_producto
          INTO v_desde,v_hasta,v_central,v_subalm,v_producto
          FROM ga_celnum_central
          WHERE p_celular between num_desde and num_hasta
          FOR UPDATE NOWAIT
          ;

          IF v_desde=p_celular THEN
             EXECUTE IMMEDIATE v_delete_cen
             USING v_desde;

             v_inicio1:= p_celular + 1;
             v_fin1:=v_hasta;

             EXECUTE IMMEDIATE v_insert_cen
             USING v_inicio1,v_fin1,v_subalm,v_producto,v_central;
          ELSE
             IF v_hasta=p_celular THEN
               v_inicio1 :=v_desde;
               v_fin1:= v_hasta - 1;

               EXECUTE IMMEDIATE v_update_cen
               USING v_fin1,v_inicio1;
             ELSE -- p_celular > v_desde y < v_hasta
               v_inicio1 :=v_desde;
               v_fin1:= p_celular - 1;
               EXECUTE IMMEDIATE v_update_cen
               USING v_fin1,v_inicio1;

               v_inicio2:= p_celular + 1;
               v_fin2:=v_hasta;
               EXECUTE IMMEDIATE v_insert_cen
               USING v_inicio2,v_fin2,v_subalm,v_producto,v_central;
             END IF;
          END IF;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               null;
        END;

        BEGIN
          v_nivel:='Subalm';
          SELECT num_desde,num_hasta,cod_subalm
          INTO v_desde,v_hasta,v_subalm
          FROM ga_celnum_subalm
          WHERE p_celular between num_desde and num_hasta
          FOR UPDATE NOWAIT
          ;


          IF v_desde=p_celular THEN
             EXECUTE IMMEDIATE v_delete_sub
             USING v_desde;

             v_inicio1:= p_celular + 1;
             v_fin1:=v_hasta;
             EXECUTE IMMEDIATE v_insert_sub
             USING v_inicio1,v_fin1,v_subalm,adn_es_rango_contaminado_fn(v_inicio1,v_fin1);

          ELSE
             IF v_hasta=p_celular THEN
               v_inicio1 :=v_desde;
               v_fin1:= v_hasta - 1;
               EXECUTE IMMEDIATE v_update_sub
               USING v_fin1,adn_es_rango_contaminado_fn(v_inicio1,v_fin1),v_inicio1;

             ELSE -- p_celular > v_desde y < v_hasta
               v_inicio1 :=v_desde;
               v_fin1:= p_celular - 1;
               EXECUTE IMMEDIATE v_update_sub
               USING v_fin1,adn_es_rango_contaminado_fn(v_inicio1,v_fin1),v_inicio1;

               v_inicio2:= p_celular + 1;
               v_fin2:=v_hasta;
               EXECUTE IMMEDIATE v_insert_sub
               USING v_inicio2,v_fin2,v_subalm,adn_es_rango_contaminado_fn(v_inicio2,v_fin2);

             END IF;
          END IF;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
               null;
        END;

      EXCEPTION
           WHEN OTHERS THEN
              IF (SQLCODE=-54 OR SQLCODE=-60) THEN
                 RAISE_APPLICATION_ERROR (-20002,'Problemas con Numero Portado (Nivel '|| v_nivel ||' ): Intentelo mas tarde');
              ELSE
                RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ABERTURA_RANGO_PORTADO_PR ' || to_char(SQLCODE) || ': ' || SQLERRM);
              END IF;
      END;

      v_fecha:=sysdate;
      EXECUTE IMMEDIATE v_delete_con
      USING p_celular;

      v_observacion:='Numero Re-Ingresado Por Portabilidad';
      EXECUTE IMMEDIATE v_update_conh
      USING v_observacion,p_celular,trunc(v_fecha);
   END IF;
 EXCEPTION
    WHEN OTHERS THEN
       RAISE_APPLICATION_ERROR(-20100, 'Error En ADN_ABERTURA_RANGO_PORTADO_PR ' || to_char(SQLCODE) || ': ' || SQLERRM);
END ADN_ABERTURA_RANGO_PORTADO_PR;


END ADN_NUMERACION_PG; 
/
SHOW ERRORS