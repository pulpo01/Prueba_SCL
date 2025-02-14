CREATE OR REPLACE PACKAGE PV_GARANTIA_DOASWAP_PG IS

PROCEDURE PV_GARANTIA_INI  (
		  				   V_Secuencia In Varchar,
						   Nabonado    In Varchar,
						   Vcodcausa   In Varchar,
						   Nnumserie   In Varchar,
						   Vnomtabla   In Varchar
						   );

PROCEDURE PV_GARANTIA_DOA  (
						   Nabonado    In  Varchar,
						   Nnumserie   In  Varchar,
						   Vnomtabla   In  Varchar,
						   V_Error     Out Varchar2,
   	   					   V_Cadena	   Out Varchar2
						   );

PROCEDURE PV_GARANTIA_SWAP (
						   Nabonado    In  Varchar,
						   Vcodcausa   In  Varchar,
						   Nnumserie   In  Varchar,
						   Vnomtabla   In  Varchar,
						   V_Error     Out Varchar2,
   	   					   V_Cadena	   Out Varchar2
						   );

PROCEDURE PV_PARAMETROS    (
		  				   vNomParametro in  Varchar,
						   vValParametro out Varchar2
						   );

PROCEDURE PV_BUSCA_FECHA   (
		  				   nAbonado       in  varchar,
						   nNumSerie	  in  varchar,
						   vNomTabla      in  varchar,
						   vFecActivacion out varchar,
						   v_Error		  out varchar,
						   v_Cadena		  out varchar
						   );

END PV_GARANTIA_DOASWAP_PG;
/
SHOW ERRORS
