CREATE OR REPLACE FUNCTION        AL_OBTIENE_SUBLOCK_FN(vp_Num_Serie IN ICT_AKEYS.NUM_ESN%type) RETURN VARCHAR2
IS
-- *************************************************************
-- * Funcion	           :  AL_OBTIENE_SUBLOCK_FN
-- * Entrada               :  Nuemro de Serie.
-- * Salida     		   :  Codigos de entrada a programacion del equipo.
-- * Descripcion    	   :  Funcion que retorna el codigo de entrada de programacion de equipos para una Serie
-- * Fecha de creacion	   :  12 Agosto de 2002
-- * Responsable    	   :  J.L.R.
-- *************************************************************
aux_PRIMER_CODIGO ICT_AKEYS.PRIMER_CODIGO%type;
BEGIN
	aux_PRIMER_CODIGO:=Null;
    If vp_Num_Serie is Null then
        Return Null;
    Else
        Select PRIMER_CODIGO into aux_PRIMER_CODIGO
        From   ICT_AKEYS
	    Where NUM_ESN=vp_Num_Serie;
    End If;
    Return aux_PRIMER_CODIGO;
END AL_OBTIENE_SUBLOCK_FN;
/
SHOW ERRORS
