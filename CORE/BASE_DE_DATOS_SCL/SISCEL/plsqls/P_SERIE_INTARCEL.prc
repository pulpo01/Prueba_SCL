CREATE OR REPLACE PROCEDURE P_SERIE_INTARCEL(
  VP_ABONADO IN NUMBER ,
  VP_SERIEHEX IN VARCHAR2 ,
  VP_SERIEANTHEX IN VARCHAR2 ,
  VP_ERROR IN OUT VARCHAR2 )
IS
--
-- *************************************************************
-- * procedimiento      : P_SERIE_INTARCEL
-- * Descripcion        : Procedimiento de Actualizacion de fechas de activacion/desactivacion
-- *                      en central de abonados roaming visitantes.
-- * Fecha de creacion  :
-- * Responsable        : Tarificacion
-- *************************************************************
--
  V_NUM_IMSI GA_INTARCEL.NUM_IMSI%TYPE;
  V_NUM_SERIE GA_ABOCEL.NUM_SERIE%TYPE;
  V_TECNOLOGIA GA_ABOCEL.COD_TECNOLOGIA%TYPE;
  V_TECNOLOGIA_GSM GA_ABOCEL.COD_TECNOLOGIA%TYPE;
BEGIN
  BEGIN
        V_TECNOLOGIA_GSM := GE_FN_DEVVALPARAM('GA',1,'TECNOLOGIA_GSM');

        SELECT NUM_SERIE, COD_TECNOLOGIA
      INTO V_NUM_SERIE, V_TECNOLOGIA
      FROM GA_ABOCEL
      WHERE NUM_ABONADO = VP_ABONADO;

      IF V_TECNOLOGIA = V_TECNOLOGIA_GSM THEN
                SELECT FRECUPERSIMCARD_FN(V_NUM_SERIE, 'IMSI') INTO  V_NUM_IMSI
                FROM DUAL;
        END IF;

        UPDATE GA_INTARCEL
        SET NUM_SERIE = VP_SERIEHEX,
            NUM_IMSI = V_NUM_IMSI
        WHERE NUM_ABONADO  = VP_ABONADO
        AND NUM_SERIE = VP_SERIEANTHEX;

  EXCEPTION
     WHEN OTHERS THEN
          VP_ERROR := 4;
  END;
END P_SERIE_INTARCEL;
/
SHOW ERRORS
