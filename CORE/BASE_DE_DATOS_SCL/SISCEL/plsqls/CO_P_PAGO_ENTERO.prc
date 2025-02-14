CREATE OR REPLACE procedure CO_P_PAGO_ENTERO
(
  VP_CLIENTE                  IN VARCHAR2 ,
  VP_NUM_SECUENCI             IN VARCHAR2 ,
  VP_COD_TIPDOCUM             IN VARCHAR2 ,
  VP_COD_VENDEDOR_AGENTE      IN VARCHAR2 ,
  VP_LETRA                    IN VARCHAR2 ,
  VP_COD_CENTREMI             IN VARCHAR2 ,
  VP_NUM_SECUENCI_PAGO        IN VARCHAR2 ,
  VP_COD_TIPDOCUM_PAGO        IN VARCHAR2 ,
  VP_COD_VENDEDOR_AGENTE_PAGO IN VARCHAR2 ,
  VP_LETRA_PAGO               IN VARCHAR2 ,
  VP_COD_CENTREMI_PAGO        IN VARCHAR2 ,
  VP_NUM_CUOTA                IN VARCHAR2 ,
  VP_FEC_PAGO_CLIENTE         IN VARCHAR2
  )
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : CO_P_PAGO_ENTERO
-- * Descripcion        :
-- * Fecha de creacion  : 27-01-2003 20:20
-- * Responsable        :
-- * Observacion        : Optimizado por Proyecto infraestructura
-- *************************************************************
--
IS
  g_cod_cliente               co_cartera.cod_cliente%TYPE := to_number(vp_cliente);
  g_cod_centremi              co_cartera.cod_centremi%TYPE := to_number(vp_cod_centremi);
  g_num_secuenci              co_cartera.num_secuenci%TYPE := to_number(vp_num_secuenci);
  g_cod_tipdocum              co_cartera.cod_tipdocum%TYPE := to_number(vp_cod_tipdocum);
  g_cod_vendedor_agente       co_cartera.cod_vendedor_agente%TYPE := to_number(vp_cod_vendedor_agente);
  g_letra                     co_cartera.letra%TYPE := vp_letra;
  g_cod_centremi_pago         co_cartera.cod_centremi%TYPE := to_number(vp_cod_centremi_pago);
  g_num_secuenci_pago         co_cartera.num_secuenci%TYPE := to_number(vp_num_secuenci_pago);
  g_cod_tipdocum_pago         co_cartera.cod_tipdocum%TYPE := to_number(vp_cod_tipdocum_pago);
  g_cod_vendedor_agente_pago  co_cartera.cod_vendedor_agente%TYPE := to_number(vp_cod_vendedor_agente_pago);
  g_letra_pago                co_cartera.letra%TYPE := vp_letra_pago;

  g_num_cuota                 co_cartera.sec_cuota%TYPE;


  BEGIN

	 IF  g_cod_tipdocum=59 THEN  /* SI ES CHEQUE */
         UPDATE CO_DOCUMENTOS SET COD_ESTADO=4
	     WHERE NUM_SECUENCI= g_num_secuenci
	     AND   NUM_DOCUMENTO=(SELECT NUM_FOLIO FROM CO_CARTERA WHERE
	            cod_cliente          = g_cod_cliente
            AND num_secuenci         = g_num_secuenci
            AND cod_tipdocum         = g_cod_tipdocum
            AND cod_vendedor_agente  = g_cod_vendedor_agente
            AND letra                = g_letra
            AND cod_centremi         = g_cod_centremi);
     END IF;

     IF vp_num_cuota!='NULL' THEN
        g_num_cuota           := to_number(vp_num_cuota);
        INSERT INTO CO_CANCELADOS (
               COD_CLIENTE              ,                COD_TIPDOCUM             ,                COD_CENTREMI             ,
               NUM_SECUENCI             ,                COD_VENDEDOR_AGENTE      ,                LETRA                    ,
               COD_CONCEPTO             ,                COLUMNA                  ,                COD_PRODUCTO             ,
               IMPORTE_HABER            ,                NUM_TRANSACCION          ,                IMPORTE_DEBE             ,
               IND_CONTADO              ,                IND_FACTURADO            ,                FEC_EFECTIVIDAD          ,
               FEC_CANCELACION          ,                IND_PORTADOR             ,                FEC_PAGO                 ,
               FEC_CADUCIDA             ,                FEC_ANTIGUEDAD           ,                FEC_VENCIMIE             ,
               NUM_CUOTA                ,                SEC_CUOTA                ,                NUM_VENTA                ,
               NUM_ABONADO              ,                NUM_FOLIO                ,                PREF_PLAZA				,
			   NUM_FOLIOCTC             ,				 COD_OPERADORA_SCL		  ,				   COD_PLAZA				)
       SELECT  COD_CLIENTE              ,                COD_TIPDOCUM             ,                COD_CENTREMI             ,
               NUM_SECUENCI             ,                COD_VENDEDOR_AGENTE      ,                LETRA                    ,
               COD_CONCEPTO             ,                COLUMNA                  ,                COD_PRODUCTO             ,
               IMPORTE_DEBE             ,                0                        ,                IMPORTE_DEBE             ,
               IND_CONTADO              ,                IND_FACTURADO            ,                FEC_EFECTIVIDAD          ,
               TO_DATE(VP_FEC_PAGO_CLIENTE,'DD-MM-YYYY HH24:MI:SS') , 0           ,                SYSDATE                  ,
               FEC_CADUCIDA             ,                FEC_ANTIGUEDAD           ,                FEC_VENCIMIE             ,
               NUM_CUOTA                ,                SEC_CUOTA                ,                NUM_VENTA                ,
               NUM_ABONADO              ,                NUM_FOLIO                ,                PREF_PLAZA				,
			   NUM_FOLIOCTC				,				 COD_OPERADORA_SCL		  ,				   COD_PLAZA
       FROM    CO_CARTERA
       WHERE   COD_CLIENTE                  = g_cod_cliente
       AND     NUM_SECUENCI         		= g_num_secuenci
       AND     COD_TIPDOCUM         		= g_cod_tipdocum
       AND     COD_VENDEDOR_AGENTE  		= g_cod_vendedor_agente
       AND     LETRA                		= g_letra
       AND     COD_CENTREMI         		= g_cod_centremi
       AND     SEC_CUOTA            		= g_num_cuota;

       INSERT INTO CO_PAGOSCONC  (
              COD_TIPDOCUM                 ,              COD_CENTREMI                 ,              NUM_SECUENCI            ,
              COD_VENDEDOR_AGENTE          ,              NUM_SECUREL                  ,              LETRA                   ,
              IMP_CONCEPTO                 ,              COD_PRODUCTO                 ,              COD_TIPDOCREL           ,
              COD_AGENTEREL                ,              NUM_TRANSACCION              ,              LETRA_REL               ,
              COD_CENTRREL                 ,              COD_CONCEPTO                 ,              COLUMNA                 ,
              NUM_ABONADO                  ,              NUM_FOLIO                    ,              PREF_PLAZA			  ,
			  NUM_CUOTA               	   ,			  SEC_CUOTA                    ,              NUM_VENTA				  ,
			  NUM_FOLIOCTC            	   ,			  COD_OPERADORA_SCL			   ,			  COD_PLAZA				  )
       SELECT g_cod_tipdocum_pago          ,              g_cod_centremi_pago          ,              g_num_secuenci_pago	  ,
              g_cod_vendedor_agente_pago   ,              NUM_SECUENCI                 ,              g_letra_pago			  ,
              IMPORTE_DEBE-IMPORTE_HABER   ,              COD_PRODUCTO				   ,              COD_TIPDOCUM			  ,
              COD_VENDEDOR_AGENTE          ,              NUM_TRANSACCION              ,              LETRA					  ,
              COD_CENTREMI                 ,              COD_CONCEPTO                 ,              COLUMNA				  ,
              NUM_ABONADO                  ,              NUM_FOLIO                    ,              PREF_PLAZA			  ,
			  NUM_CUOTA                    ,			  SEC_CUOTA                    ,              NUM_VENTA				  ,
			  NUM_FOLIOCTC				   ,			  COD_OPERADORA_SCL			   ,			  COD_PLAZA
       FROM   CO_CARTERA
       WHERE  COD_CLIENTE                    = g_cod_cliente
          AND NUM_SECUENCI         			 = g_num_secuenci
          AND COD_TIPDOCUM         			 = g_cod_tipdocum
          AND COD_VENDEDOR_AGENTE  			 = g_cod_vendedor_agente
          AND LETRA                			 = g_letra
          AND COD_CENTREMI         			 = g_cod_centremi
          AND SEC_CUOTA            			 = g_num_cuota;

         DELETE FROM CO_CARTERA
         WHERE COD_CLIENTE                   = g_cod_cliente
           AND NUM_SECUENCI         		 = g_num_secuenci
           AND COD_TIPDOCUM         		 = g_cod_tipdocum
           AND COD_VENDEDOR_AGENTE  		 = g_cod_vendedor_agente
           AND LETRA                		 = g_letra
           AND COD_CENTREMI         		 = g_cod_centremi
           AND SEC_CUOTA            		 = g_num_cuota;

     ELSE

         INSERT INTO CO_CANCELADOS       (
                COD_CLIENTE              ,                COD_TIPDOCUM             ,                COD_CENTREMI             ,
                NUM_SECUENCI             ,                COD_VENDEDOR_AGENTE      ,                LETRA                    ,
                COD_CONCEPTO             ,                COLUMNA                  ,                COD_PRODUCTO             ,
                IMPORTE_HABER            ,                NUM_TRANSACCION          ,                IMPORTE_DEBE             ,
                IND_CONTADO              ,                IND_FACTURADO            ,                FEC_EFECTIVIDAD          ,
                FEC_CANCELACION          ,                IND_PORTADOR             ,                FEC_PAGO                 ,
                FEC_CADUCIDA             ,                FEC_ANTIGUEDAD           ,                FEC_VENCIMIE             ,
                NUM_CUOTA                ,                SEC_CUOTA                ,                NUM_VENTA                ,
                NUM_ABONADO              ,                NUM_FOLIO                ,                PREF_PLAZA				 ,
				NUM_FOLIOCTC             ,				  COD_OPERADORA_SCL		   ,				COD_PLAZA				 )
         SELECT
                COD_CLIENTE              ,                COD_TIPDOCUM             ,                COD_CENTREMI             ,
                NUM_SECUENCI             ,                COD_VENDEDOR_AGENTE      ,                LETRA                    ,
                COD_CONCEPTO             ,                COLUMNA                  ,                COD_PRODUCTO             ,
                IMPORTE_DEBE             ,                0                        ,                IMPORTE_DEBE             ,
                IND_CONTADO              ,                IND_FACTURADO            ,                FEC_EFECTIVIDAD          ,
                TO_DATE(VP_FEC_PAGO_CLIENTE,'DD-MM-YYYY HH24:MI:SS') , 0           ,                SYSDATE                  ,
                FEC_CADUCIDA             ,                FEC_ANTIGUEDAD           ,                FEC_VENCIMIE             ,
                NUM_CUOTA                ,                SEC_CUOTA                ,                NUM_VENTA                ,
                NUM_ABONADO              ,                NUM_FOLIO                ,                PREF_PLAZA				 ,
				NUM_FOLIOCTC			 ,				  COD_OPERADORA_SCL		   ,				COD_PLAZA
         FROM   CO_CARTERA
         WHERE  COD_CLIENTE                   = g_cod_cliente
            AND NUM_SECUENCI         		  = g_num_secuenci
            AND COD_TIPDOCUM         		  = g_cod_tipdocum
            AND COD_VENDEDOR_AGENTE  		  = g_cod_vendedor_agente
            AND LETRA                		  = g_letra
            AND COD_CENTREMI         		  = g_cod_centremi
            AND SEC_CUOTA            		  IS NULL;

         INSERT INTO CO_PAGOSCONC            (
                COD_TIPDOCUM                 ,                COD_CENTREMI                 ,                NUM_SECUENCI                 ,
                COD_VENDEDOR_AGENTE          ,                NUM_SECUREL                  ,                LETRA                        ,
                IMP_CONCEPTO                 ,                COD_PRODUCTO                 ,                COD_TIPDOCREL                ,
                COD_AGENTEREL                ,                NUM_TRANSACCION              ,                LETRA_REL                    ,
                COD_CENTRREL                 ,                COD_CONCEPTO                 ,                COLUMNA                      ,
                NUM_ABONADO                  ,                NUM_FOLIO                    ,                PREF_PLAZA					 ,
				NUM_CUOTA                    ,				  SEC_CUOTA                    ,                NUM_VENTA                    ,
				NUM_FOLIOCTC				 ,				  COD_OPERADORA_SCL			   ,				COD_PLAZA					 )
         SELECT
                g_cod_tipdocum_pago          ,                g_cod_centremi_pago          ,                g_num_secuenci_pago          ,
                g_cod_vendedor_agente_pago   ,                NUM_SECUENCI                 ,                g_letra_pago                 ,
                IMPORTE_DEBE-IMPORTE_HABER   ,                COD_PRODUCTO                 ,                COD_TIPDOCUM                 ,
                COD_VENDEDOR_AGENTE          ,                NUM_TRANSACCION              ,                LETRA                        ,
                COD_CENTREMI                 ,                COD_CONCEPTO                 ,                COLUMNA                      ,
                NUM_ABONADO                  ,                NUM_FOLIO                    ,                PREF_PLAZA				  	 ,
				NUM_CUOTA                    ,				 SEC_CUOTA                     ,                NUM_VENTA                    ,
				NUM_FOLIOCTC				 ,				 COD_OPERADORA_SCL			   ,				COD_PLAZA
         FROM   CO_CARTERA
         WHERE  COD_CLIENTE                   = g_cod_cliente
            AND NUM_SECUENCI         		  = g_num_secuenci
            AND COD_TIPDOCUM         		  = g_cod_tipdocum
            AND COD_VENDEDOR_AGENTE  		  = g_cod_vendedor_agente
            AND LETRA                		  = g_letra
            AND COD_CENTREMI         		  = g_cod_centremi
            AND SEC_CUOTA            		  IS NULL;

         DELETE FROM CO_CARTERA
         WHERE  COD_CLIENTE                   = g_cod_cliente
            AND NUM_SECUENCI         		  = g_num_secuenci
            AND COD_TIPDOCUM         		  = g_cod_tipdocum
            AND COD_VENDEDOR_AGENTE  		  = g_cod_vendedor_agente
            AND LETRA                		  = g_letra
            AND COD_CENTREMI         		  = g_cod_centremi
            AND SEC_CUOTA            		  IS NULL;
  END IF  ;


END;
/
SHOW ERRORS
