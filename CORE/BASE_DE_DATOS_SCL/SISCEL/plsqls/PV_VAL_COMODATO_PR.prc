CREATE OR REPLACE PROCEDURE PV_VAL_COMODATO_PR (
          EV_param_entrada IN VARCHAR2,
          SV_resultado	   OUT NOCOPY VARCHAR2,
		  SV_mensaje	   OUT NOCOPY ga_transacabo.des_cadena%TYPE
/*<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "PV_VAL_COMODATO_PR" Lenguaje="PL/SQL" Fecha="08-06-2005" Versión="1.2.0" Programador="Patricia Castro" Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Restricción que realiza la validacion del equipo como dato</Descripción>
<Parámetros>
<Entrada>
<param nom="EV_param_entrada" Tipo="VARCHAR2"> Cadena de entrada</param>
</Entrada>
<Salida>
<param nom="SV_resultado" Tipo="VARCHAR2">Resultado de la restricción</param>
<param nom="SV_mensaje" Tipo="VARCHAR2">Mensaje de salida</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>
*/
) IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

---- parametros reales de entrada --------------

     GN_num_abonado    	   ga_abocel.num_abonado%TYPE;
     GN_comodato		   NUMBER;

BEGIN

	SV_resultado := 'TRUE';
	SV_mensaje   := '';

	Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(EV_param_entrada, string);

    GN_num_abonado 		:= TO_NUMBER(string(5));


	BEGIN
		 SELECT NVL(abo.ind_eqprestado,0)
		   INTO GN_comodato
		   FROM ga_abocel abo
		  WHERE abo.num_abonado = GN_num_abonado;

		 IF GN_comodato = 1 THEN
		 	SV_mensaje   := 'OK';
 		    SV_resultado := 'FALSE';
		 END IF;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		 SV_mensaje   := 'OK';
 		 SV_resultado := 'FALSE';
	END;

EXCEPTION

    WHEN OTHERS THEN
		SV_resultado := 'FALSE';
		SV_resultado := 'ERROR EN PV_VAL_COMODATO_PR: NO SE PUEDE VALIDAR SI EL EQUIPO ES COMODATO.';
END;
/
SHOW ERRORS
