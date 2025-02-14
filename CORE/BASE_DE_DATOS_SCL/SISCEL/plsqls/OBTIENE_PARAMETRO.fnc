CREATE OR REPLACE FUNCTION        OBTIENE_PARAMETRO ( nb_param IN varchar2 )
  RETURN  varchar2 IS
-- *************************************************************
-- * Funcion        : OBTIENE_PARAMETRO
-- * Salida         : valor del parmametro indicado
-- * Descripcion    : Funcion que retorna el valor actual del parametro
-- * <nb_param>, obtenido de las tablas GE_PARAMETROS y GE_PARAM_HIST.
-- * se devuelve el valor valido a la fecha actual
-- * Fecha de creacion  : Agosto 2000
-- * Responsable    : Rosa Maria Alvarez (DMR Consulting)
-- *************************************************************
   valor varchar2(10);
BEGIN
    SELECT val_parametro
    into valor
    FROM  geh_parametros_puntaje
    WHERE cod_parametro= (select cod_parametro from ged_parametros_puntaje
                          where nom_parametro=nb_param)
    and fec_inicio_dh = (Select max(fec_inicio_dh)
                         from geh_parametros_puntaje
                         where fec_inicio_dh<=sysdate
                         and cod_parametro= (select cod_parametro from ged_parametros_puntaje
                                             where nom_parametro=nb_param)
                        );
    RETURN valor ;
EXCEPTION
   WHEN no_data_found THEN
       raise_application_error(-20101, 'No se encuentra parametro de carga....' || nb_param);
END;
/
SHOW ERRORS
