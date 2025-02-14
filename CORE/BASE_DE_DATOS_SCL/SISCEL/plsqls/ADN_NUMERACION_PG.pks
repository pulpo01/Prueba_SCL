CREATE OR REPLACE PACKAGE ADN_NUMERACION_PG IS
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
  ;
  FUNCTION ADN_ES_NRO_CONTAMINADO_FN(
      p_num_celular IN adn_contaminados_td.num_celular%TYPE)
      RETURN PLS_INTEGER
  ;
  FUNCTION ADN_ES_RANGO_CONTAMINADO_FN(
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN PLS_INTEGER
  ;
  FUNCTION ADN_DISPONIBLES_USO_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_INTERMEDIOS_KIT_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_RESERVADOS_RESER_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_HIBERNADOS_REUTIL_GA_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_ACTIVOS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_DISPONIBLES_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_PRE_ACTIVOS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_ASIGNADOS_CEL_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_ASIGNADOS_AMIS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_ADMINISTRATIVOS_AMIS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_ADMINISTRATIVOS_CEL_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_TOTAL_RANGO_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_ES_DEVUELTO_FN (p_num_desde IN  ga_celnum_uso.num_desde%type)
      RETURN PLS_INTEGER
  ;
  FUNCTION ADN_DISPONIBLES_OTROS_FN (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
      RETURN ga_celnum_uso.num_libres%TYPE
  ;
  FUNCTION ADN_NROSIG_FN (
      p_num_desde  ga_celnum_uso.num_desde%TYPE,
      p_tabla VARCHAR2)
      RETURN  ga_celnum_uso.num_desde%TYPE
  ;
  FUNCTION ADN_ES_PORTADO_IN_FN (
      p_num_celular IN  ga_celnum_uso.num_desde%type)
      RETURN PLS_INTEGER
  ;
  PROCEDURE ADN_GENERA_RANGOS_PR
  ;
  PROCEDURE ADN_DEVUELVE_RANGO_PR (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE,
      p_num_inf    IN adn_celnum_devueltos_to.num_informe%TYPE)
  ;
  PROCEDURE ADN_HOME_DEFAULT_PR (
      p_num_desde IN ga_celnum_uso.num_desde%TYPE,
      p_central OUT ga_celnum_uso.num_desde%TYPE,
      p_cat OUT ga_celnum_uso.num_desde%TYPE,
      p_uso OUT ga_celnum_uso.num_desde%TYPE)
  ;
  PROCEDURE ADN_RANGOS_FALTANTES_PR(
   p_num_desde  ga_celnum_uso.num_desde%type,
   p_num_hasta  ga_celnum_uso.num_hasta%type)
  ;
  PROCEDURE ADN_ACTUALIZA_DEVUELTOS_PR(
      p_num_desde  ga_celnum_uso.num_desde%type,
      p_num_hasta  ga_celnum_uso.num_hasta%type)
  ;
  PROCEDURE ADN_DISPONIBILIZA_RANGO_PR (
      p_num_desde  IN ga_celnum_uso.num_desde%TYPE,
      p_num_hasta  IN ga_celnum_uso.num_hasta%TYPE)
  ;

  PROCEDURE ADN_ABERTURA_RANGO_PORTADO_PR (
      p_celular  IN ga_celnum_reutil.num_celular%TYPE)
  ;
END ADN_NUMERACION_PG; 
/
SHOW ERRORS