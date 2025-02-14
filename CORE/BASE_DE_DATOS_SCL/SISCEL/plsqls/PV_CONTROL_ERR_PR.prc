CREATE OR REPLACE PROCEDURE PV_CONTROL_ERR_PR
(
TN_NumOs       in PV_IORSERV.num_os%TYPE,    /* numero de os */
TV_CodOs       in CI_TIPORSERV.cod_os%TYPE,  /* codigo de os  */
TV_CodError    in PV_ERRORES_OOSS_TO.cod_error%TYPE,  /* codigo error  */
PV_GlsError    in VARCHAR2,  /* Glosa error   */
PV_NomPrc      in VARCHAR2,  /* procedimiento */
SV_CodError    OUT VARCHAR2,
SV_DesError    OUT VARCHAR2

)
/*
<NOMBRE>	: PV_CONTROL_ERR_PR </NOMBRE>
<FECHACREA>	: 29/07/2004 <FECHACREA/>
<MODULO >	: Gestion Abonados </MODULO >
<AUTOR >    : Patricio Gallegos C. </AUTOR >
<VERSION >    	: 1.0 </VERSION >
<DESCRIPCION> : Inserta resgistro en la tabla PV_ERRORES_OOSS_TO </DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripcion de Modificacion </DESCMOD >
<ParamSal >  : SV_error,SV_desError </ParamSal>
*/
IS

TN_NumError  PV_ERRORES_OOSS_TO.num_error%TYPE;
TV_GlsError  PV_ERRORES_OOSS_TO.gls_error%TYPE;  /* Glosa error   */
TV_NomPrc    PV_ERRORES_OOSS_TO.nom_proc%TYPE;  /* procedimiento */

BEGIN

SELECT pv_errores_sq.NEXTVAL INTO TN_NumError FROM dual;

TV_GlsError:= substr(PV_GlsError,1,250);
TV_NomPrc:= substr(PV_NomPrc,1,100);

INSERT INTO PV_ERRORES_OOSS_TO
 (num_error,num_os, cod_os,cod_error,
  gls_error,nom_proc,fec_error, nom_usuario)
VALUES (TN_NumError,TN_NumOs,TV_CodOs,TV_CodError,
  TV_GlsError,TV_NomPrc,SYSDATE,USER);

EXCEPTION
     WHEN OTHERS THEN
	      SV_CodError := SQLCODE;
          SV_DesError := substr(SQLERRM,1,255);

END PV_CONTROL_ERR_PR;
/
SHOW ERRORS
