CREATE OR REPLACE PACKAGE fa_intcontable_pg IS

PROCEDURE fa_apertura_ciclo_pr (p_n_indordentotal IN NUMBER,
						  p_v_factdocu IN VARCHAR2,
						  p_v_factconc IN VARCHAR2,
						  p_v_factecno IN VARCHAR2,
						  p_v_apetecno IN VARCHAR2,
						  p_v_apeofici IN VARCHAR2,
						  p_v_valtecno IN VARCHAR2,
						  p_v_valofici IN VARCHAR2,
						  p_v_modprorr IN VARCHAR2 );

PROCEDURE fa_apertura_nociclo_pr (p_n_indordentotal IN NUMBER,
						  p_v_factdocu IN VARCHAR2,
						  p_v_factconc IN VARCHAR2,
						  p_v_factecno IN VARCHAR2,
						  p_v_apetecno IN VARCHAR2,
						  p_v_apeofici IN VARCHAR2,
						  p_v_valtecno IN VARCHAR2,
						  p_v_valofici IN VARCHAR2,
						  p_v_modprorr IN VARCHAR2 );

PROCEDURE fa_apertura_nc_pr (p_n_indordentotal IN NUMBER,
						  p_v_factdocu IN VARCHAR2,
						  p_v_factconc IN VARCHAR2,
						  p_v_factecno IN VARCHAR2);

v_glosaerr 	VARCHAR2(1000);

END fa_intcontable_pg;
/
SHOW ERRORS
