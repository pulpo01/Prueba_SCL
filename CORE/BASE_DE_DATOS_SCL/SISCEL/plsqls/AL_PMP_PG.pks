CREATE OR REPLACE PACKAGE AL_PMP_PG IS
   CN_cero           CONSTANT PLS_INTEGER := 0;
   CN_uno            CONSTANT PLS_INTEGER := 1;
   CV_modulo         CONSTANT VARCHAR2(2) := 'AL';
   CV_nom_TipoKit    CONSTANT VARCHAR2(20) := 'TIP_ARTICULO_KIT';
   CV_PmpConKit      CONSTANT VARCHAR2(20) := 'PMP_CONKIT';
   CV_ErrorNoCla     CONSTANT VARCHAR2(20) := 'Error no clasificado';
   ERROR_CONTROLADO EXCEPTION;
   CV_IndCal        CONSTANT VARCHAR2(2) := 'C';
   CV_IndCalD       CONSTANT VARCHAR2(2) := 'D';
   CV_IndCalR       CONSTANT VARCHAR2(2) := 'R';

    PROCEDURE AL_PMP_PR (EN_NumOrdenC   IN al_cabecera_ordenes1.num_orden%TYPE,
                         EN_NumOrdenI   IN al_cabecera_ordenes1.num_orden%TYPE);
----------------------------------------------------------------------------------------------
    PROCEDURE AL_REVERSA_PMP_PR (EN_NumOrdenC    IN al_cabecera_ordenes1.num_orden%TYPE,
                             EN_Precio       IN varchar2,
                             EN_Articulo     IN al_lineas_ordenes1.cod_articulo%TYPE,
                             EV_tipo         IN varchar2);
----------------------------------------------------------------------------------------------
   PROCEDURE AL_RECALCULOXDEV_PMP_PR (EN_NumOrdenD    IN al_cabecera_ordenes3.num_orden%TYPE);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE AL_PMP_DEV_PR (EN_NumOrdenC   IN al_cabecera_ordenes3.num_orden%TYPE,
                             EN_NumOrdenI   IN al_cabecera_ordenes2.num_orden%TYPE);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END AL_PMP_PG; 
/
SHOW ERRORS
