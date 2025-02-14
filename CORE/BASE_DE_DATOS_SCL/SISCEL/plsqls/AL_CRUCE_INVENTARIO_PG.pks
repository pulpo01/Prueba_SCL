CREATE OR REPLACE PACKAGE AL_CRUCE_INVENTARIO_PG
 IS
  CV_version                  CONSTANT  VARCHAR2(5):='1.0';
  CV_error_no_clasif          CONSTANT  VARCHAR2(30):='Error no clasificado';
  TYPE refcursor              IS REF CURSOR;
  CV_cod_modulo               CONSTANT   ged_parametros.cod_modulo%TYPE:='AL';
  CN_largoquery               CONSTANT   NUMBER:=3000;
  CN_largoerrtec              CONSTANT   NUMBER:=500;
  CN_largodesc                CONSTANT   NUMBER:=1000;
  CV_formato                   CONSTANT  VARCHAR2(25):= 'dd-mm-yyyy hh24:mi:ss';
  CV_dd_mm_yyyy                CONSTANT  VARCHAR2(25):= 'dd-mm-yyyy';
  CV_cero  NUMBER(1)   :=0;
  CV_uno  NUMBER(1)   :=1;

TYPE cur_typ  IS REF CURSOR;

TYPE RT_ARTICULOS_STOCK IS RECORD (num_cruce al_cruce_series_inv_tt.num_cruce%TYPE,
                    cod_bodega al_cruce_series_inv_tt.cod_bodega%TYPE,
                    cod_articulo al_stock.cod_articulo%TYPE,
                    num_serie al_cruce_series_inv_tt.num_Serie%type,
                    can_stock al_stock.can_stock%type);

TYPE t_articulos_stock IS TABLE OF RT_ARTICULOS_STOCK;


------------------------------------------------------------------------------------------------------
PROCEDURE AL_INSERTA_SERIESART_INV_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EN_bodega       IN AL_CRUCE_TO.cod_bodega%TYPE,
EV_stock        IN VARCHAR2);
PROCEDURE AL_INSERTA_SERIESARTMAS_INV_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EN_bodega       IN AL_CRUCE_TO.cod_bodega%TYPE,
EV_stock        IN VARCHAR2,
EN_IND_SERIADO  IN AL_ARTICULOS.ind_seriado%TYPE);
------------------------------------------------------------------------------------------------------
PROCEDURE AL_VALIDA_SERIES_CRUCE_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EV_stock        IN VARCHAR2);
------------------------------------------------------------------------------------------------------
PROCEDURE AL_FINALIZA_CRUCE_PR
(EN_numcruce    IN AL_CRUCE_TO.num_cruce%TYPE,
EV_estado       IN AL_CRUCE_TO.EST_CRUCE%TYPE);
------------------------------------------------------------------------------------------------------
procedure Al_GENERA_RANGOS_TRASPASOS_pr
(EN_num_traspaso IN AL_TRASPASOS.num_traspaso%TYPE,
EN_tipo_articulo in al_articulos.tip_articulo%TYPE,
SV_mens_retorno     OUT NOCOPY ge_errores_pg.MsgError);
------------------------------------------------------------------------------------------------------
END AL_CRUCE_INVENTARIO_PG;
/
SHOW ERRORS

