CREATE OR REPLACE PROCEDURE VE_ACEPTACION_VENTA_PR(
P_SINDPROCESO    IN VARCHAR2,
P_NNUMVENTA      IN NUMBER,
P_NNUMTIPDOC     IN NUMBER,
P_NNUMFOLIO      IN NUMBER,
P_SESTDESTINO    IN VARCHAR2,
P_SCAUSARECHAZO  IN VARCHAR2,
P_SINDSUSPENSION IN VARCHAR2,
O_ERROR          OUT VARCHAR2,
O_MENSAJE        OUT VARCHAR2 )
AS
--
--Desarrollo :   Optimizacion del Circuito de la venta
--Procedure  :   VE_ACEPTACION_VENTA_PR()
--Descripcion:   Proceso de anulacion rechazo
--Obtenido de:	 FRMAnrchCe.frm
--Parametros :   Indicador de Proceso    : Indicador de ProcesoO'mitido /R'egular
--               Numero de la Venta      : Ingresada por usuario
--               Numero unidades         :
--               Producto                :
--               Usuario                 : Codigo usuario
--               Codigo cliente          :
--               tabla                   :
--               ALTA_STM                :
--               Estado Destino          :
--               Codigo error            : PL
--               Mensaje del error       : PL
--Retorno    :   O_ERROR
--               '0'   se hizo todo correcto
--               '1'   se produjeron errores
--
-- Declaracion de variables Cursor

strQuery         VARCHAR2(1000):='';
v_nexception     NUMBER:=0;
v_nParam         BOOLEAN:=true;
v_num_secuencia  VARCHAR2(20);
v_count          NUMBER;
v_actabo         VARCHAR2(2):='AV';
v_ind_promocion  VARCHAR2(1):='F';
v_ind_estventa   VARCHAR2(2):='AC';
-- Declaracion de variables SQL fetch
v_num_abonado    ga_abocel.num_abonado%type;
v_num_celular    ga_abocel.num_celular%type;
v_num_serie      ga_abocel.num_serie%type;
v_cod_cliente    ga_abocel.cod_cliente%type;
v_cod_situacion  ga_abocel.cod_situacion%type;
v_ind_supertel   ga_abocel.ind_supertel%type;
v_num_telefija   ga_abocel.num_telefija%type;
v_var1           VARCHAR2(2):='';
v_var2           VARCHAR2(2):='';
v_var3           VARCHAR2(2):='';
v_var4           VARCHAR2(2):='';
v_var5           VARCHAR2(2):='';
v_var6           VARCHAR2(2):='';
v_NomTablaAbo	 VARCHAR2(12):='';
TYPE CursorType IS REF CURSOR;  -- define Control REF CURSOR type  --
curRow   CursorType;            -- declare cursor variable         --

P_NUMUNIDADES     GA_VENTAS.NUM_UNIDADES%TYPE;
P_SCODCLIENTE     GA_VENTAS.COD_CLIENTE%TYPE;
P_NPRODUCTO       GE_DATOSGENER.PROD_CELULAR%TYPE;

P_VP_ORIGEN       GA_TRANSACABO.COD_RETORNO%TYPE;
P_VP_DESTINO      GA_TRANSACABO.DES_CADENA%TYPE;

BEGIN

	SELECT PROD_CELULAR
	  INTO P_NPRODUCTO
	  FROM GE_DATOSGENER;

	SELECT 'GA_ABOCEL' INTO v_NomTablaAbo FROM GA_ABOCEL WHERE NUM_VENTA = P_NNUMVENTA
	 UNION
	SELECT 'GA_ABOAMIST' FROM GA_ABOAMIST WHERE NUM_VENTA = P_NNUMVENTA;

	SELECT NUM_UNIDADES, COD_CLIENTE
	  INTO P_NUMUNIDADES, P_SCODCLIENTE
	  FROM GA_VENTAS
	 WHERE NUM_VENTA = P_NNUMVENTA;

      IF P_SINDPROCESO='R' THEN
           BEGIN
             UPDATE GA_VENTAS
               SET  IND_ESTVENTA    = P_SESTDESTINO,
                    FEC_ACEPREC     = SYSDATE,
                    NOM_USUAR_ACEREC= USER
             WHERE NUM_VENTA = P_NNUMVENTA;

             EXCEPTION
               WHEN OTHERS THEN
                  v_nexception := 1;
                  GOTO Errores;
           END;
       END IF;

      BEGIN

             UPDATE GE_CLIENTES
               SET NUM_ABOCEL   = NUM_ABOCEL + P_NUMUNIDADES,
                   IND_ACEPVENT = 1,
                   FEC_ACEPVENT = NVL(FEC_ACEPVENT, SYSDATE)
             WHERE COD_CLIENTE = P_SCODCLIENTE;

           EXCEPTION
             WHEN OTHERS THEN
                  v_nexception := 2;
                  GOTO Errores;
      END;


    strQuery := 'SELECT NUM_ABONADO, NUM_CELULAR, NUM_SERIE, COD_CLIENTE, COD_SITUACION,IND_SUPERTEL, NUM_TELEFIJA  ';
    strQuery := strQuery || ' FROM GA_ABOCEL';
    strQuery := strQuery || ' WHERE NUM_VENTA = ' || P_NNUMVENTA;
    strQuery := strQuery || ' AND COD_SITUACION NOT IN(' || '''BAA''' || ', ' || '''BAP''' || ')';
    strQuery := strQuery || ' FOR UPDATE NOWAIT';

    -- Abrimos el cursor
    OPEN curRow FOR strQuery;
    LOOP
            FETCH curRow INTO v_num_abonado,
                              v_num_celular,
                              v_num_serie,
                              v_cod_cliente,
                              v_cod_situacion,
                              v_ind_supertel,
                              v_num_telefija;

            EXIT WHEN curRow%NOTFOUND;

            IF (v_NomTablaAbo <> 'GA_ABOAMIST') THEN
              IF (v_ind_supertel = '0' and length(v_num_telefija) <= 10) THEN  --No es STM

                  strQuery := 'INSERT INTO GA_CTC_MOVIMIENTOS (';
                  strQuery := strQuery || 'NUM_REDFIJA, FEC_MOVIMIENTO, TIP_MOVIMIENTO, NUM_CELULAR1, NUM_CELULAR2 ) ';
                  strQuery := strQuery || ' VALUES (';
                  strQuery := strQuery || ':1,';
                  strQuery := strQuery || ':2,';
                  strQuery := strQuery || ':3,';
                  strQuery := strQuery || ':4,';
                  strQuery := strQuery || ':5)';

                 BEGIN
                     EXECUTE IMMEDIATE strQuery USING v_num_telefija,SYSDATE,0,v_num_celular,0;

                     EXCEPTION
                        WHEN OTHERS THEN
                            v_nexception := 3;
                            GOTO Errores;
                 END;
              END IF; -- IF v_ind_supertel = '0' and length(v_num_telefija) <= 10 THEN 'No es STM

                 BEGIN
                     Select unique 1
					  into v_count
					 From GA_INTARCEL
                     Where cod_cliente = v_cod_cliente
                       And num_abonado = v_num_abonado;

                     EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                          v_nParam:=false;
                      WHEN OTHERS THEN
                          v_nParam:=false;
                          v_nexception := 4;
                          GOTO Errores;
                 END;

                    IF v_nParam THEN --Ejecutando PL de aceptacion
                       BEGIN
                         Select GA_SEQ_TRANSACABO.NEXTVAL
                          Into  v_num_secuencia
                         From DUAL;

                         EXCEPTION
                          WHEN OTHERS THEN
                               v_nexception := 5;
                               GOTO Errores;
                       END;

                       BEGIN
                          P_Interfases_Abonados(   v_num_secuencia,
                                                   v_actabo,
                                                   P_NPRODUCTO,
                                                   v_num_abonado,
                                                   v_var1,
                                                   v_var2,
                                                   v_var3,
                                                   v_var4,
                                                   v_var5,
                                                   v_var6);


                          EXCEPTION
                             WHEN OTHERS THEN
							    v_nParam := false;
                                v_nexception := 6;
                                GOTO Errores;
                       END;

                        IF v_nParam THEN
                           BEGIN
                              SELECT COD_RETORNO, DES_CADENA
							  into  P_VP_ORIGEN,P_VP_DESTINO
                              FROM GA_TRANSACABO
                              WHERE NUM_TRANSACCION = v_num_secuencia;

                              IF sql%rowcount = 1 THEN
                                 DELETE GA_TRANSACABO WHERE NUM_TRANSACCION = v_num_secuencia;
                              END IF;
                           END;
                        END IF;
                    END IF;
              END IF;

              IF (v_cod_situacion <> 'SAA' or
                  v_cod_situacion <> 'STP' or
                  v_cod_situacion <> 'SAO' or
                  v_cod_situacion <> 'SAT' or
				  v_cod_situacion <> 'SCV' or
				  v_cod_situacion <> 'SRD' or
				  v_cod_situacion <> 'AOS' or
				  v_cod_situacion <> 'ATS' or
				  v_cod_situacion <> 'CVS' or
				  v_cod_situacion <> 'RDS' or
				  v_cod_situacion <> 'ERA') THEN

                 strQuery := 'UPDATE GA_ABOCEL';
                 strQuery := strQuery || ' SET COD_SITUACION = :1';
                 strQuery := strQuery || ' WHERE NUM_ABONADO = :2';

                 BEGIN
                   EXECUTE IMMEDIATE strQuery USING  'AAA',v_num_abonado;

                   EXCEPTION
                      WHEN OTHERS THEN
                         v_nexception := 7;
                         GOTO Errores;
                 END;
              END IF; -- IF v_cod_situacion then

              --ModIFica CI PROMOCION
                 BEGIN
                     Select 1
                       into v_count
                     From CI_PROMOCION_ANALOGOS
                     Where IND_PROMOCION = v_ind_promocion
                       and NUM_CELULAR = v_num_celular;

                      IF sql%rowcount = 1 THEN
                       BEGIN
                          Update CI_PROMOCION_ANALOGOS
                            Set FEC_CAMBIO_DH = SYSDATE,
                                NUM_SERIEN    = v_num_serie
                          Where NUM_CELULAR   = v_num_celular;

                          EXCEPTION
                             WHEN OTHERS THEN
                                  v_nexception := 8;
                                  GOTO Errores;
                       END;
                      END IF; --IF sql%rowcount = 1 THEN

                 EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                  null;
                    WHEN OTHERS THEN
                         v_nexception := 11;
                         GOTO Errores;
                 END;
    END LOOP;

   -- Cerramos el cursor
    CLOSE curRow;

  --Actualizando datos del abonado
    strQuery := 'UPDATE GA_ABOCEL';
    strQuery := strQuery || ' SET FEC_ACEPVENTA = TRUNC(SYSDATE),';
    strQuery := strQuery || ' FEC_ULTMOD = TRUNC(SYSDATE) ';
    strQuery := strQuery || ' WHERE NUM_VENTA = :1';

    BEGIN
        EXECUTE IMMEDIATE strQuery USING P_NNUMVENTA;

        EXCEPTION
           WHEN OTHERS THEN
                v_nexception := 9;
                GOTO Errores;
    END;

   --Actualizamos Estado de preliquidacion
   BEGIN

    UPDATE GA_PRELIQUIDACION
    SET FEC_ACEPREC  = SYSDATE,
        IND_ESTVENTA = v_ind_estventa
    WHERE NUM_VENTA  = P_NNUMVENTA;

     EXCEPTION
       WHEN OTHERS THEN
              v_nexception := 10;
              GOTO Errores;
    END;

<<Errores>>

   O_ERROR := SQLCODE;

DBMS_OUTPUT.PUT_LINE( 'Error> ' || O_ERROR);
DBMS_OUTPUT.PUT_LINE( SQLERRM );

   IF SQLCODE = 0 AND v_nexception > 0 THEN

      O_ERROR := TO_CHAR(v_nexception);

   END IF;

DBMS_OUTPUT.PUT_LINE( 'Error2> ' || O_ERROR);


   IF v_nexception = 1 THEN
    O_MENSAJE := 'UPDATE GA_VENTAS (1) (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 2 THEN
    O_MENSAJE := 'UPDATE GE_CLIENTES (2) (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 3 THEN
    O_MENSAJE := 'INSERT GA_CTC_MOVIMIENTOS (3) (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 4 THEN
    O_MENSAJE := 'SELECT GA_INTARCEL COD_CLIENTE = ' || v_cod_cliente || ' COD_ABONADO = ' || v_num_abonado || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 5 THEN
    O_MENSAJE := 'SELECT GA_SEQ_TRANSACABO (5) (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 6 THEN
    O_MENSAJE := 'PL P_Interfases_Abonados SECUENCIA =' || v_num_secuencia || ' COD_ABONADO = ' || v_num_abonado || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 7 THEN
    O_MENSAJE := 'UPDATE GA_ABOCEL COD_ABONADO= ' || v_num_abonado  || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 8 THEN
    O_MENSAJE := 'UPDATE CI_PROMOCION_ANALOGOS NUM_SERIE =' || v_num_serie  || ' NUM_CELULAR =' || v_num_celular || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 9 THEN
    O_MENSAJE := 'UPDATE GA_ABOCEL NUM_VENTA= ' || P_NNUMVENTA  || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 10 THEN
    O_MENSAJE := 'UPDATE GA_PRELIQUIDACION NUM_VENTA =' || P_NNUMVENTA || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

   IF v_nexception = 11 THEN
    O_MENSAJE := 'SELECT I_PROMOCION_ANALOGOS IND_PROMOCION =' || v_ind_promocion || ' NUM_CELULAR =' || v_num_celular || ' (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
   END IF;

--   DBMS_OUTPUT.PUT_LINE ('O_ERROR ' || O_ERROR );
--   DBMS_OUTPUT.PUT_LINE (O_MENSAJE );

EXCEPTION
      WHEN OTHERS THEN
            O_MENSAJE := 'ERROR (PL)VE_ACEPTACION_VENTA_PR ' || SQLERRM;
END VE_ACEPTACION_VENTA_PR;
/
SHOW ERRORS
