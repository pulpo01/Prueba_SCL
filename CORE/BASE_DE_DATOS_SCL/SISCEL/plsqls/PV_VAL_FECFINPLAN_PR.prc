CREATE OR REPLACE PROCEDURE PV_VAL_FECFINPLAN_PR  (
    EV_Param_Entrada  IN   VARCHAR2,
    SV_Resultado      OUT  NOCOPY VARCHAR2,
    SV_Mensaje        OUT  NOCOPY GA_TRANSACABO.DES_CADENA%TYPE
        )
IS

/*<Documentación TipoDoc = "Función">
<Elemento Nombre = "PV_VAL_FECFINPLAN_PR" Lenguaje="PL/SQL" Fecha="12-05-2005" Versión="1.0" Diseñador=PBARRIA Programador=PBARRIA Ambiente="BD">
<Retorno>NA</Retorno>
<Descripción>Valida si el Abonado cumple con fecha de Fin de Plan para realizar Cambio de PLan Tarifario</Descripción>
<Parámetros>
<Entrada>
	<param nom="EV_Param_Entrada" Tipo="VARCHAR2">Datos_OOSS</param>
</Entrada>
<Salida>
	<param nom="SV_Resultado" Tipo="VARCHAR2">Resultado de la Ejecución</param>
	<param nom="SV_Mensaje" Tipo="GA_TRANSACABO.DES_CADENA%TYPE">Mensaje de Salida</param>
</Salida>
</Parámetros>
</Elemento>
</Documentación>   */

-- Versión 1.0, PBARRIA Inc. RA-200511290219 12-05-2005

        string siscel.GE_TABTYPE_VCH2ARRAY:= siscel.GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

	LV_CodCli           GA_ABOCEL.COD_CLIENTE%TYPE;
	LV_Abonado          GA_ABOCEL.NUM_ABONADO%TYPE;
     	LV_Actabo           GA_ACTABO.COD_ACTABO%TYPE;
     	LD_FechaAux          DATE;
		LS_FormatoFecha      VARCHAR2(20);
     	LV_CodSituacion     GA_ABOCEL.COD_SITUACION%TYPE;
     	LN_Dias             NUMBER;
		LS_FormatoFechaHora varchar(30);
	LS_Sql	            VARCHAR(2000);
BEGIN

     GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_Param_Entrada, string);

	 LS_FormatoFecha := GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL2');
	 LS_FormatoFechaHora := GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL7');

     LV_CodCli   :=TO_NUMBER(STRING(6));
     LV_Abonado  := TO_NUMBER(string(5));
     LV_Actabo   := string(4);
     SV_Resultado:='TRUE';

     LS_Sql:='SELECT fec_cumplan,cod_situacion';
     LS_Sql:=LS_Sql || ' FROM ga_abocel';
     LS_Sql:=LS_Sql || ' WHERE cod_cliente = :v1';
     LS_Sql:=LS_Sql || ' AND num_abonado = :v2';

     EXECUTE IMMEDIATE LS_Sql into LD_FechaAux,LV_CodSituacion USING LV_CodCli,LV_Abonado;

     IF LV_CodSituacion ='AAA' THEN

      	  LN_Dias := TO_DATE(TO_CHAR(SYSDATE,LS_FormatoFecha),LS_FormatoFecha) - TO_DATE(TO_CHAR(LD_FechaAux,LS_FormatoFecha),LS_FormatoFecha);
          IF LN_Dias > 0 THEN
		  	 SV_Resultado := 'TRUE';
		  ELSE
           	SV_Resultado := 'FALSE';
           	SV_Mensaje   := 'El Abonado no cumple las condiciones para ejecutar una OOSS ya que le quedan '||ABS(LN_Dias)||' dias para cumplir fecha del termino del Plan Tarifario anterior';
          END IF;
     ELSE
        SV_Resultado := 'FALSE';
        SV_Mensaje   := 'SITUACION DE ABONADO NO ES PERMITIDA PARA ESTA OPERACION';
     END IF;

     EXCEPTION
     WHEN OTHERS THEN
          SV_Resultado := 'FALSE';
          SV_Mensaje   := 'NO SE PUEDE VALIDAR NRO. DE DIAS PARA CUMPLIR TÉRMINO DEL PLAN.';
END;
/
SHOW ERRORS
