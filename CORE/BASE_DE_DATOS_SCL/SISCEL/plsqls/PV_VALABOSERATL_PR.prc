CREATE OR REPLACE PROCEDURE PV_VALABOSERATL_PR(
	   	  		  							EV_param_entrada IN  VARCHAR2,
											SV_RESULTADO   	OUT NOCOPY VARCHAR2,
          									SV_MENSAJE     	OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
/*
<Documentación
  TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "PV_VALABOSERATL_PR"
      Lenguaje="PL/SQL"
      Fecha="05-04-2006"
      Versión="1.0"
      Diseñador="Manuel Acevedo M"
	  Programador="Hector Perez G"
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
	      <Descripción></Descripción>
       <Parámetros>
         <Entrada>
		 	<param nom="EV_param_entrada" 	   Tipo="CARACTER">Cadena de Parametros de Entrada</param>
         </Entrada>
         <Salida>
	     	<param nom="SV_RESULTADO"           Tipo="VARCHAR2">Si resulto OK o No OK/param>
	    	<param nom="SV_MENSAJE"             Tipo="VARCHAR2">Mensaje error retornado</param>
         </Salida>
      </Parámetros>
  </Elemento>
</Documentación>
*/
IS

    string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
	---- parametros reales de entrada --------------
    LT_CodCliente	  GA_ABOCEL.COD_CLIENTE%TYPE;
	------------------------------------------------

	LN_abonado       GA_ABOCEL.NUM_ABONADO%TYPE;
	LV_cantAboAtl    NUMBER;
	LV_cantAboAtlTot NUMBER;
	LV_ServiciosATL  VARCHAR2(200);
	Ssql             VARCHAR2(200);

	CV_codmodulo 	 CONSTANT VARCHAR2(2) := 'GA';
	--CN_indestado 	 CONSTANT NUMBER(1)   := 3;
	CV_Baja 	 	 CONSTANT VARCHAR2(3) := 'BAA';
	CV_Bajaproceso   CONSTANT VARCHAR2(3) := 'BAP';

	 CURSOR C_AbonadosCliente IS
            SELECT NUM_ABONADO
            FROM   GA_ABOCEL
            WHERE  COD_CLIENTE  = LT_CodCliente
              AND  COD_SITUACION <> CV_Baja
			  AND  COD_SITUACION <> CV_Bajaproceso;


BEGIN


    SV_RESULTADO := 'TRUE';
	GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
    LT_CodCliente	:= TO_NUMBER(string(6));


	PV_OBTIENEINFO_ATLANTIDA_PG.PV_CADENASERV_ATLANTIDA_PR(LV_ServiciosATL);
	dbms_output.put_line('LV_ServiciosATL -> [' || LV_ServiciosATL || ']');
	IF LV_ServiciosATL = '' OR LV_ServiciosATL IS NULL THEN
	   SV_MENSAJE := 'Error en obtencion de Servicios Atlantida (GED_CODIGOS)';
	   SV_RESULTADO := 'FALSE';
	END IF;


	IF SV_RESULTADO = 'TRUE' THEN
	    LV_cantAboAtlTot := 0;
		OPEN C_AbonadosCliente;
	        LOOP
                FETCH C_AbonadosCliente INTO LN_abonado;
                EXIT WHEN C_AbonadosCliente%NOTFOUND;

			Ssql:= 'SELECT COUNT(1) ';
	        Ssql:= SSql || ' FROM   GA_SERVSUPLABO A';
	        Ssql:= Ssql || ' WHERE  A.num_abonado =' || LN_abonado;
	        Ssql:= Ssql || ' AND    A.cod_servicio IN (' || LV_ServiciosATL || ')' ;
	        Ssql:= SSql || ' AND    A.ind_estado<3';


		    EXECUTE IMMEDIATE Ssql INTO LV_cantAboAtl; -- Obtiene la diferencia entre tabla origen y


			LV_cantAboAtlTot := LV_cantAboAtlTot + LV_cantAboAtl;


		END LOOP;
        CLOSE C_AbonadosCliente;

		IF LV_cantAboAtlTot > 0 THEN
		   SV_MENSAJE := 'Cliente posee Servicio Suplementario de Atlántida';
		   SV_RESULTADO := 'FALSE';
		ELSE
		   SV_MENSAJE   := '';
		   SV_RESULTADO := 'TRUE';  --CLIENTE SIN SERVICIO SUPLEMENTARIO ATLANTIDA --
		END IF;


	END IF;


EXCEPTION
     WHEN OTHERS THEN
          SV_MENSAJE   := 'ERROR EN PV_VALABOSERATL_PR: NO SE PUEDE VALIDAR EXISTENCIA DE SERVICIO ATLANTIDA.';
		  SV_RESULTADO := 'FALSE';
END PV_VALABOSERATL_PR;
/
SHOW ERRORS
