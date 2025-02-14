CREATE OR REPLACE PROCEDURE ER_ELIMINAR_PREEVAL_PR(
                                                         SN_codRetorno   OUT NOCOPY ge_errores_pg.CODERROR,
                                                         SV_menRetorno   OUT NOCOPY ge_errores_pg.MSGERROR,
                                                         SN_numEvento    OUT NOCOPY ge_errores_pg.EVENTO)

IS
CN_PRODUCTO              CONSTANT NUMBER       := 1;
CN_CODIGO_DIAS           CONSTANT NUMBER       := 5;
CN_SUBCODIGO_DIAS        CONSTANT NUMBER       := 1;
CN_PARAMETRO_DIAS        CONSTANT NUMBER       := 1;
Cn_Codigo_Estado           CONSTANT NUMBER       := 100;
Cn_Subcodigo_Estado        CONSTANT NUMBER       := 6;
Cn_Parametro_Estado        CONSTANT NUMBER       := 10;
CV_MODULO_GA             CONSTANT VARCHAR2(2)     := 'GA';
LN_CANT_DIAS             NUMBER(6);
can_solic                NUMBER(6);
LN_NUM_SOLICITUD         ERT_SOLICITUD.NUM_SOLICITUD%TYPE;
LV_des_error             VARCHAR2(500);
LV_Sql                   VARCHAR2(4000);
LV_ESTADO_PREEVALUACION  ERT_SOLICITUD.COD_ESTADO%TYPE;

CURSOR EVALUACIONES IS
                         SELECT NUM_SOLICITUD FROM  ERT_SOLICITUD WHERE COD_ESTADO=LV_ESTADO_PREEVALUACION
             AND FEC_INGRESO_H < SYSDATE -LN_CANT_DIAS;
BEGIN


 /**0.- Inicializo Variables de error */

        SN_codRetorno:=0;
        SV_menRetorno:='';
        SN_numEvento:=0;


        SELECT count(1)
		  INTO can_solic
		  FROM ERT_SOLICITUD
		 WHERE COD_ESTADO=LV_ESTADO_PREEVALUACION
           AND FEC_INGRESO_H < SYSDATE -LN_CANT_DIAS;

		DBMS_OUTPUT.Put_Line('Cantidad de solicitudes a eliminar = [' || TO_CHAR(can_solic) ||']');

       /**1.- Obtener Parametro con Dias de Antiguedad*/
        SELECT VAL_PARAMETRO1
        INTO   LN_CANT_DIAS
        FROM   ERD_PARAMETROS
        WHERE  COD_CODIGO=CN_CODIGO_DIAS
        AND COD_SUBCODIGO=CN_SUBCODIGO_DIAS
        AND COD_PARAMETRO=CN_PARAMETRO_DIAS;

        /**Obtener Parametro de Estado*/
        SELECT VAL_PARAMETRO1
        INTO   LV_ESTADO_PREEVALUACION
        FROM   ERD_PARAMETROS
        WHERE  COD_CODIGO=Cn_Codigo_Estado
        AND COD_SUBCODIGO=Cn_Subcodigo_Estado
        AND COD_PARAMETRO=Cn_Parametro_Estado;


     /***2.- Abro el Cursor con los Datos de las Preevaluaciones a eliminar*/

     OPEN EVALUACIONES;
           LOOP
               FETCH EVALUACIONES INTO LN_NUM_SOLICITUD;
           EXIT WHEN EVALUACIONES%NOTFOUND;
       /**3.- De existir Datos se eliminan en las diferentes tablas de acuerdo al numero de soliictud*/
           UPDATE ERT_SOLICITUD
		      SET COD_ESTADO = 9
		    WHERE NUM_SOLICITUD= LN_NUM_SOLICITUD;
			DBMS_OUTPUT.Put_Line('solicitude a eliminar = [' || TO_CHAR(LN_NUM_SOLICITUD) ||']');
       END LOOP;
     CLOSE EVALUACIONES;



   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        SN_codRetorno := 400;
        LV_des_error   := 'ER_PASOHISTORICO_PREEVAL_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'No se encuentra parametro asociado a dias de vigencia de preevaluacion';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_PASOHISTORICO_PREEVAL_PR',LV_Sql, SQLCODE, LV_des_error);
         WHEN OTHERS THEN
        SN_codRetorno := 401;
        LV_des_error   := 'ER_PASOHISTORICO_PREEVAL_PR;- ' || SQLERRM;
        IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_codRetorno,SV_menRetorno) THEN
            SV_menRetorno := 'Error al ejecutar proceso de borrado de solicitudes pendientes';
        END IF;
        SN_numEvento := Ge_Errores_Pg.Grabarpl( SN_numEvento, CV_MODULO_GA,SV_menRetorno, '1.0', USER, 'ER_PASOHISTORICO_PREEVAL_PR',LV_Sql, SQLCODE, LV_des_error);
END ER_ELIMINAR_PREEVAL_PR;
/
SHOW ERRORS
