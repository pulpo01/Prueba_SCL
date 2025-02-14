CREATE OR REPLACE PROCEDURE PV_VAL_ABOPOSPAGO_MSG_PR (
      EV_param_entrada IN VARCHAR2,
      SV_resultado	   OUT NOCOPY VARCHAR2,
	  SV_mensaje	   OUT NOCOPY ga_transacabo.des_cadena%TYPE

   )
   IS
      string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
      GN_num_abonado    	   ga_abocel.num_abonado%TYPE;
   BEGIN
      SV_resultado := 'TRUE';
      SV_mensaje   := '';
      Ge_Pac_Arreglopr.GE_PR_RetornaArreglo(EV_param_entrada, string);
      GN_num_abonado 		:= TO_NUMBER(string(5));

      SELECT abo.num_abonado
        INTO GN_num_abonado
        FROM ga_abocel abo
       WHERE abo.num_abonado = GN_num_abonado;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            SV_mensaje   := 'ERROR: EL ABONADO NO PUEDE SER PREPAGO, DEBER SER POSPAGO O CUENTA CONTROLADA';
            SV_resultado := 'FALSE';

         WHEN OTHERS THEN
            SV_mensaje  := 'ERROR: NO SE PUEDE VALIDAR SI EL ABONADO ES POSPAGO O CUENTA CONTROLADA.';
            SV_resultado := 'FALSE';
   END;
/
SHOW ERRORS
