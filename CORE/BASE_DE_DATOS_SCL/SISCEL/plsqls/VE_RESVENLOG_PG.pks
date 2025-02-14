CREATE OR REPLACE package VE_RESVENLOG_PG is

  -- Author  : Rodrigo Araneda, TmMas
  -- Created : 28-12-2006
  -- Purpose : Registra log del proceso de restauracion de venta


  -- Public function and procedure declarations

function VE_RESVEN_IL_FN (EN_niv_log number,
		 				  EV_msglog varchar2
) return varchar2;

procedure VE_RESVEN_INIT_PR (SN_cod_retorno out nocopy number);

end VE_RESVENLOG_PG;
/
SHOW ERRORS
