CREATE OR REPLACE PACKAGE PV_PRECIOS_DEDUCIBLE_PG AS

 
   CV_ErrorNoCla     CONSTANT VARCHAR2(20) := 'Error no clasificado';
   ERROR_CONTROLADO    EXCEPTION;
   
   TYPE TCabPrecios IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_TO%ROWTYPE INDEX BY BINARY_INTEGER;
   TYPE TDetPrecios   IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_TD%ROWTYPE  INDEX BY BINARY_INTEGER ; 
   TYPE TPrecios     IS TABLE OF AL_PRECIOS_DEDUCIBLE_TO%ROWTYPE INDEX BY BINARY_INTEGER;

   TYPE TDetArticulo IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_Td.cod_articulo%type INDEX BY BINARY_INTEGER;
   TYPE TDetMoneda IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_Td.cod_moneda%type INDEX BY BINARY_INTEGER;
   TYPE TDetFecha IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_Td.FEC_DESDE%type INDEX BY BINARY_INTEGER; 
   TYPE TDetPrecio     IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_Td.PRC_DEDUCIBLE%type INDEX BY BINARY_INTEGER;   
   type Trowid       is table of urowid    index by binary_integer;
   TYPE TDetObs      IS TABLE OF AL_PRECIOS_DEDUCIBLE_MAS_Td.OBSERVACION%type INDEX BY BINARY_INTEGER;

    tab_rowid       Trowid;
    tab_articulo    TDetArticulo;
    tab_moneda      TDetMoneda;
    tab_fecha       TDetFecha;
    tab_precio      TDetPrecio;
    tab_obs         TDetObs;
    
   
  PROCEDURE PV_MASIVO_PRECIOS_DEDUCIBLE_PR(EVNombreArchivo IN AL_PRECIOS_DEDUCIBLE_MAS_TO.NOM_ARCHIVO%type,
                                     ENCarga         IN AL_PRECIOS_DEDUCIBLE_MAS_TO.COD_PROCESO%type,
                                     ev_usuario      IN AL_PRECIOS_DEDUCIBLE_MAS_TO.NOM_USUARIO%type,
                                     sn_cod_retorno      OUT NOCOPY      ge_errores_td.cod_msgerror%TYPE,
                                     sv_mens_retorno     OUT NOCOPY      ge_errores_td.det_msgerror%TYPE,
                                     sn_num_evento       OUT NOCOPY      ge_errores_pg.evento);

END PV_PRECIOS_DEDUCIBLE_PG;
/
SHOW ERRORS