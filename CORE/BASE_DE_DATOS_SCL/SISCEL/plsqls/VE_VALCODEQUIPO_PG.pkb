CREATE OR REPLACE PACKAGE BODY VE_valcodequipo_PG IS

		/*
		<Documentación TipoDoc = "VE_valcodequipo_PG>
		<Elemento Nombre = "Package" Lenguaje="PL/SQL" Fecha="15-06-2005" Versión="1.0.0" Diseñador="Rayen Ceballos" Programador="Roberto Pérez" Ambiente="BD">
		<Retorno>NA</Retorno>
		<Descripción>Body de VE_valcodequipo_PG</Descripción>
		<Parámetros>
		<Entrada>
		<param nom="" Tipo="STRING">Descripción Parametro1</param>
		</Entrada>
		<Salida>
		<param nom="" Tipo="STRING">Descripción Parametro4</param>
		</Salida>
		</Parámetros>
		</Elemento>
		</Documentación>
		*/


           PROCEDURE VE_valida_PR(EV_imsi IN ga_aboamist.num_serie%TYPE,
		                         SN_coderror OUT NOCOPY NUMBER,
							     SV_error OUT NOCOPY VARCHAR2
	   	  		  		   		) IS

		/* <Documentación TipoDoc = "Procedimiento">
		   <Elemento Nombre = "VE_valcodequipo_FN Lenguaje="PL/SQL" Fecha="15-06-2005" Versión="1.0" Diseñador="Rayen Ceballos" Programador="Roberto Perez"
Ambiente="BD">
		   <Retorno>INTEGER</Retorno>
		   <Descripción>Función que determina si una venta fue hecha por un distribuidor o si el equipo est en listas negras o si el equipo esta asociado a otro
abonado</Descripción>
		   <Parámetros>
		   <Entrada>
		   <param nom="EV_imsi" Tipo="STRING">Serie a buscar en listas negras</param>
		   </Entrada>
		   <Salida>
		   <param nom="SN_coderror" Tipo="NUMBER">Código de error parametrico</param>
		   <param nom="SV_error" Tipo="VARCHAR">Descripcion Error</param>
		   </Salida>
		   </Parámetros>
		   </Elemento>
		   </Documentación> */

        LE_fin EXCEPTION;
		LN_record number(3);
		LV_coderror VARCHAR2(64);
		LN_largosimcard ged_parametros.val_parametro%TYPE;
		LV_imsi ga_aboamist.num_serie%TYPE;
		LV_codterminal ged_parametros.val_parametro%TYPE;

		BEGIN
           SN_coderror:=0;

		   BEGIN
		      SELECT p.val_parametro
			  INTO   LN_largosimcard
			  FROM   ged_parametros p
			  WHERE  p.cod_modulo='AL'
			  		 AND p.cod_producto=1
					 AND p.nom_parametro='LARGO_SERIE_GGSM';

              SELECT p.val_parametro
			  INTO   LV_codterminal
			  FROM   ged_parametros p
			  WHERE  p.cod_modulo='AL'
			  		 AND p.cod_producto=1
			  		 -- Inicio modificacion by SAQL/Soporte 13/10/2005 - XO-200510070819
					 --AND p.nom_parametro='COD_TERMINAL_GSM';
					 AND p.nom_parametro='COD_SIMCARD_GSM';
					 --Fin modificacion by SAQL/Soporte 13/10/2005 - XO-200510070819

			  IF LENGTH(EV_imsi)=TO_NUMBER(LN_largosimcard) THEN
			     BEGIN
				    SELECT g.num_serie
					INTO   LV_imsi
					FROM   ga_equipaboser g
					WHERE  g.num_abonado=(SELECT h.num_abonado
						   				  FROM   ga_aboamist h
										  WHERE  h.num_serie=EV_imsi
										     AND   h.cod_situacion = 'AAA') --DMZ/Soporte XO-200510200923
						   AND g.tip_terminal=LV_codterminal;


					EXCEPTION
			           WHEN NO_DATA_FOUND THEN
				          LV_coderror:='ERROR_INTERNO';
					      RAISE LE_fin;
				 END;
			  END IF;

			  EXCEPTION
			     WHEN NO_DATA_FOUND THEN
				     LV_coderror:='ERROR_INTERNO';
					 RAISE LE_fin;
		   END;

		   SELECT COUNT(1)
		   INTO   LN_record
		   FROM   ga_lncelu c
		   WHERE  c.num_serie=LV_imsi;

		   IF LN_record>0 THEN
		    --  RETURN(LN_record);
			  LV_coderror:='ERROR_LISTA_NEGRA';
			  RAISE LE_fin;
		   END IF;

		   SELECT COUNT(1)
		   INTO   LN_record
		   FROM   ga_abocel a
		   WHERE  a.num_serie=EV_imsi
		   AND    a.cod_situacion NOT IN ('BAA','BAP'); --XO-200509260738: German Espinoza Z; 05/10/2005

		   IF LN_record>0 THEN
		  --    RETURN(LN_record);
			  LV_coderror:='ERROR_EXISTE_POSTPAGO';
			  RAISE LE_fin;
		   END IF;

		   SELECT COUNT(1)
		   INTO   LN_record
		   FROM   ga_aboamist b
		   WHERE  b.num_serie=EV_imsi
				  AND b.cod_cliente<>b.cod_cliente_dist
				  AND b.cod_situacion NOT IN ('BAA','BAP'); --XO-200509260738: German Espinoza Z; 05/10/2005

		   IF LN_record>0 THEN
		      LV_coderror:='ERROR_EXISTE_PREPAGO';
		   END IF;

		   --RETURN(LN_record);

		   EXCEPTION
		   WHEN LE_fin THEN

		       SN_coderror:=VE_retornacoderror_PG.VE_RETORNACODERROR_FN(LV_coderror, SV_error);
		   WHEN OTHERS THEN

			   SN_coderror:=VE_retornacoderror_PG.VE_RETORNACODERROR_FN('ERROR_INTERNO', SV_error);
		     --  RETURN(-1);


END VE_valida_PR;

END VE_valcodequipo_PG;
/
SHOW ERRORS
