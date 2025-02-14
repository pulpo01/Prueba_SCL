CREATE OR REPLACE PACKAGE BODY Fa_Marca_Promo_Pg IS

SN_cod_retornoau   ge_errores_td.cod_msgerror%TYPE;
SV_mens_retornoau  ge_errores_td.det_msgerror%TYPE;
SN_num_eventoau    ge_errores_pg.Evento;
SN_num_transaccion NUMBER(16);--ge_auditoria_to.num_ticket%TYPE;
ERR_MOAUDITORIA    EXCEPTION;
ERR_AGAUDITORIA    EXCEPTION;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE FA_MARCA_PROMO_PR        (EN_Digito	        IN NUMBER,
   									EN_Cod_cliente      IN NUMBER,
   			 						EN_Cod_ciclo        IN NUMBER,
   			 						ED_Fec_llamada      IN DATE,
   			 						SN_Cod_retorno      OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  	SV_Mens_retorno     OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  	SN_Num_evento       OUT NOCOPY ge_errores_pg.evento)
IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "FA_MARCA_PROMO_PR"
      Fecha modificacion=" "
      Fecha creacion="08-03-2007"
      Programador="Javier Garcia"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>Indica en la estructura de detalle de llamadas, marcas de promociones definidas por el usuario</Descripcion>
      <Parametros>
         <Entrada>
			 <param nom="EN_Digito" Tipo="numerico">Dígito que indicará la tabla a actualizar, parámetro obligatorio</param>
			 <param nom="EN_Cod_cliente" Tipo="numerico">Código del cliente, opcional</param>
			 <param nom="EN_Cod_ciclo" Tipo="caracter">Código de ciclo, opcional</param>
			 <param nom="ED_Fec_llamada" Tipo="numerico">Fecha de la llamada</param>
         </Entrada>
         <Salida>
            <param nom="SN_cod_retorno"       Tipo="NUMERICO">Codigo de retorno</param>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SN_num_evento"        Tipo="NUMERICO">Numero de Evento</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_des_error       ge_errores_pg.DesEvent;
LV_sSql            ge_errores_pg.vQuery;


error_proceso 	   EXCEPTION;
error_validacion   EXCEPTION;



TYPE EmpTabTyp IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
LA_Parametros EmpTabTyp;



CURSOR LC_promociones IS
SELECT COD_PROMOCION
	  ,DES_PROMOCION
	  ,VAL_MARCA
	  ,IND_IMPRESION
	  ,IND_ACTIVO
	  ,NUM_PRIORIDAD
	  ,FEC_ULTMOD
	  ,NOM_USUARIO
  FROM FA_MARCAPROMOCION_TD
 WHERE TRIM(Ind_activo) = '1' ORDER BY num_prioridad DESC;



CURSOR LC_Det_promo (EN_cod_promocion VARCHAR2) IS
SELECT COD_PROMOCION
	  ,NOM_CAMPO
	  ,TIP_CAMPO
	  ,VAL_CAMPO
  FROM FA_DETMARCAPROMO_TD -- ALL_IND_COLUMNS
 WHERE COD_PROMOCION =TO_CHAR(EN_cod_promocion);






LR_promo     					  LC_promociones%ROWTYPE;
LR_Det_promo 					  LC_Det_promo%ROWTYPE;

sSql   		 					  VARCHAR2(32000);
I 			   					  NUMBER;
L			   					  NUMBER;

BEGIN
    SN_Cod_retorno 	:= 0;
    SV_Mens_retorno := 'ok';
    SN_Num_evento 	:= 0;


	IF EN_Cod_cliente IS NOT NULL AND EN_Digito <> MOD(EN_Cod_cliente,10) THEN
 	  SN_cod_retorno := 877;
	  LV_des_error	 :='FA_INS_DCTO_CLTE_BLSDINAM_PR(); - no coinciden los parametros';
	  RAISE error_validacion;
	END IF;


	 OPEN LC_promociones;
	 LOOP
	 	 FETCH LC_promociones INTO LR_promo;
		 EXIT WHEN LC_promociones%NOTFOUND;

		 I:=0;
		 --DBMS_OUTPUT.PUT_LINE('Promocion   :' || LR_promo.COD_PROMOCION);
		 --DBMS_OUTPUT.PUT_LINE('Desc        :' || LR_promo.DES_PROMOCION);
		 --DBMS_OUTPUT.PUT_LINE('-----------------------------------------');

		 sSql:= ' UPDATE TOL_DETFACTURA_0' || EN_Digito; -- DIGITO
		 sSql:=sSql || ' SET COD_MARCA = ' || CHR(39) || LR_promo.VAL_MARCA || CHR(39) || ',';
		 sSql:=sSql || '     IND_IMPRESION = ' || CHR(39) || LR_promo.IND_IMPRESION || CHR(39);


		 IF EN_Cod_cliente IS NOT NULL OR EN_Cod_ciclo IS NOT NULL OR ED_fec_llamada IS NOT NULL THEN
		 	 sSql:=sSql || ' WHERE ';

        	 IF EN_Cod_cliente IS NOT NULL THEN
        	    I:=I+1;
        	 	LA_Parametros(i):= ' NUM_CLIE = ' || EN_cod_cliente;
        	 END IF;

        	 IF EN_Cod_ciclo IS NOT NULL THEN
        	    I:=I+1;
        	    LA_Parametros(i):= ' COD_CICLFACT = ' || EN_cod_ciclo;
        	 END IF;

        	 IF ED_fec_llamada IS NOT NULL THEN
        	    I:=I+1;
        	    LA_Parametros(i):= ' DATE_START_CHARG = ' || CHR(39) || TO_CHAR(ED_fec_llamada,'YYYYMMDD') || CHR(39);
		     END IF;

		  	 FOR L IN 1..LA_Parametros.COUNT LOOP
			 	 IF L = 1 THEN
				 	sSql:=sSql || LA_Parametros(L);
				 ELSE
				 	sSql:=sSql || ' AND ' || LA_Parametros(L);
				 END IF;

			 END LOOP;
		 END IF;

		 OPEN LC_Det_promo (LR_promo.COD_PROMOCION);
		 LOOP
		 	 FETCH LC_Det_promo INTO LR_Det_promo;
		 	 EXIT WHEN LC_Det_promo%NOTFOUND;

			 IF LA_Parametros.COUNT>0 OR I>0 THEN
			 	sSql:=sSql || ' AND ';
			 ELSIF i=0 THEN
			 	sSql:=sSql || ' WHERE ';
				i:=1;
			 END IF;

			 IF LR_Det_promo.TIP_CAMPO='VARCHAR2' THEN
			 	sSql := sSql || LR_Det_promo.NOM_CAMPO || '=' || CHR(39) || LR_Det_promo.VAL_CAMPO || CHR(39);
			 ELSIF LR_Det_promo.TIP_CAMPO='NUMBER' THEN
			 	sSql := sSql || LR_Det_promo.NOM_CAMPO || '=' || LR_Det_promo.VAL_CAMPO;
			 /*ELSIF LR_Det_promo.TIP_CAMPO='DATE' THEN
			    sSql := sSql || LR_Det_promo.NOM_CAMPO;*/
			 END IF;

			 --DBMS_OUTPUT.PUT_LINE('--->Nom_campo   :' || LR_Det_promo.NOM_CAMPO);
		     --DBMS_OUTPUT.PUT_LINE('--->Valor       :' || LR_Det_promo.VAL_CAMPO);

		 END LOOP;
		 CLOSE LC_Det_promo;

		 LA_Parametros.DELETE;

		 --DBMS_OUTPUT.PUT_LINE('*********');
	     --DBMS_OUTPUT.PUT_LINE(SUBSTR(sSql,1,200));
	     --DBMS_OUTPUT.PUT_LINE(SUBSTR(sSql,201,200));

		 EXECUTE IMMEDIATE sSql;
		 COMMIT;
	 END LOOP;
	 CLOSE LC_promociones;


EXCEPTION
  WHEN error_proceso THEN
      NULL;

  WHEN error_validacion THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_MARCA_PROMO_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_MARCA_PROMO_PR.Fa_Marca_Promo_Pg', LV_sSQL, SN_cod_retorno, LV_des_error );

  WHEN OTHERS THEN

      IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
         SV_mens_retorno := cv_error_no_clasif;
      END IF;
	  LV_des_error   := 'FA_MARCA_PROMO_PR('||'); - ' || SQLERRM;
      SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'FA', SV_mens_retorno, CV_version, USER, 'FA_MARCA_PROMO_PR.Fa_Marca_Promo_Pg', LV_sSQL, SN_cod_retorno, LV_des_error );

END FA_MARCA_PROMO_PR;
END Fa_Marca_Promo_Pg;
/
SHOW ERRORS
