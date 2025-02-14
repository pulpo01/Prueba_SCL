CREATE OR REPLACE PROCEDURE ER_P_INTERFACE_PLATAFORMA(
  VP_TRANSAC                  IN VARCHAR2 ,
  VP_NRO_SOLIC                IN VARCHAR2 ,
  VP_CANTIDAD_CELULARES       IN VARCHAR2 ,
  VP_CANTIDAD_ACUMULADO       IN VARCHAR2 ,
  VP_NUM_VENTA                IN VARCHAR2 )
IS
  g_nro_solic                 er_siscel.nro_solic%TYPE;
  g_cantidad_celulares        er_siscel.cant_celulares%TYPE;
  g_cantidad_acumulado        er_siscel.cant_celulares%TYPE;
  g_num_venta                 ga_ventas.num_venta%TYPE;
  v_producto                  GE_PRODUCTOS.COD_PRODUCTO%TYPE;
  v_abonado                   GA_ABOCEL.NUM_ABONADO%TYPE;
  V_TABLA                     VARCHAR2(50);
  V_ACT                       VARCHAR2(1);
  V_PROC                      VARCHAR2(50);
  V_SQLCODE                   VARCHAR2(15);
  V_SQLERRM                   VARCHAR2(60);
  V_ERROR                     VARCHAR2(1) := '0';
  ERROR_PROCESO               EXCEPTION;
  BEGIN
     g_nro_solic                := to_number(vp_nro_solic);
     g_cantidad_celulares       := to_number(vp_cantidad_celulares);
     g_cantidad_acumulado       := to_number(vp_cantidad_acumulado);
     g_num_venta                := to_number(vp_num_venta);
     V_ERROR                   := '0';
     V_PROC       := 'ER_P_INTERFACE_PLATAFORMA';
     V_TABLA      := 'ER_SOLIC_VENTA';
     V_ACT        :='I';
     INSERT INTO er_solic_venta (
                 nro_solic,
                 num_venta
             )
           VALUES
             (
                g_nro_solic,
                g_num_venta
             );
     IF ( g_cantidad_acumulado < g_cantidad_celulares )
         THEN
        V_TABLA      := 'ER_SISCEL';
        V_ACT       :='U';
            UPDATE er_siscel
              SET cant_unid_abonado = g_cantidad_acumulado
            WHERE nro_solic  = g_nro_solic;
         ELSE
        V_TABLA      := 'ERH_PARAMEVAL';
        V_ACT       :='I';
            INSERT INTO erh_parameval
                    (
                     NRO_SOLIC,
                     FEC_PASOHISTORICA_DH,
                     IND_EDAD ,
                     IND_CTA_FINAL,
                     IND_QUIEBRA,
                     IND_CEDULA_ID,
                     IND_CTA_CTE,
                     DOCTOS_MOROSIDAD ,
                     MTO_MOROSIDAD ,
                     CICLOS_DEUDA_CTC ,
                     MTO_DEUDA_CTC,
                     CICLOS_DEUDA_STARTEL,
                     MTO_DEUDA_STARTEL,
                     DOCTOS_PROTESTOS,
                     MTO_PROTESTOS,
                     DEUDA_PREV,
                     TOT_CELULARES,
                     DOCTOS_DEUDAPREV,
                     IND_CLIENTE_ANTIGUO,
                     EQUIPOS_ACTIVOS_ACUM ,
                     EQUIPOS_BAJA_ACUM,
                     IND_ESTUDIANTE,
                     IND_DOCUM_RENTA ,
                     IND_FALLECIDO,
                     PROTMAY24DOC_PJ,
                     PROTMAY24DOC_PN,
                     PROTMEN24DOC_PJ,
                     PROTMEN24DOC_PN,
                     PROTMAY24MTO_PJ,
                     PROTMAY24MTO_PN,
                     PROTMEN24MTO_PJ ,
                     PROTMEN24MTO_PN,
                     MOROMAY24DOC_PJ,
                     MOROMAY24DOC_PN,
                     MOROMEN24DOC_PJ ,
                     MOROMEN24DOC_PN,
                     MOROMAY24MTO_PJ,
                     MOROMAY24MTO_PN,
                     MOROMEN24MTO_PJ,
                     MOROMEN24MTO_PN,
                     DPREVMAY24DOC_PJ,
                     DPREVMAY24DOC_PN,
                     DPREVMEN24DOC_PJ,
                     DPREVMEN24DOC_PN,
                     DPREVMAY24MTO_PJ,
                     DPREVMAY24MTO_PN ,
                     DPREVMEN24MTO_PJ,
                     DPREVMEN24MTO_PN,
                     IND_CASTIGO
                    )
                  SELECT
                       NRO_SOLIC,
                       SYSDATE,
                       IND_EDAD ,
                       IND_CTA_FINAL,
                       IND_QUIEBRA,
                       IND_CEDULA_ID,
                       IND_CTA_CTE,
                       DOCTOS_MOROSIDAD ,
                       MTO_MOROSIDAD ,
                       CICLOS_DEUDA_CTC ,
                       MTO_DEUDA_CTC,
                       CICLOS_DEUDA_STARTEL,
                       MTO_DEUDA_STARTEL,
                       DOCTOS_PROTESTOS,
                       MTO_PROTESTOS,
                       DEUDA_PREV,
                       TOT_CELULARES,
                       DOCTOS_DEUDAPREV,
                       IND_CLIENTE_ANTIGUO,
                       EQUIPOS_ACTIVOS_ACUM ,
                       EQUIPOS_BAJA_ACUM,
                       IND_ESTUDIANTE,
                       IND_DOCUM_RENTA ,
                       IND_FALLECIDO,
                       PROTMAY24DOC_PJ,
                       PROTMAY24DOC_PN,
                       PROTMEN24DOC_PJ,
                       PROTMEN24DOC_PN,
                   PROTMAY24MTO_PJ,
                       PROTMAY24MTO_PN,
                       PROTMEN24MTO_PJ ,
                       PROTMEN24MTO_PN,
                       MOROMAY24DOC_PJ,
                       MOROMAY24DOC_PN,
                       MOROMEN24DOC_PJ ,
                       MOROMEN24DOC_PN,
                   MOROMAY24MTO_PJ,
                       MOROMAY24MTO_PN,
                       MOROMEN24MTO_PJ,
                       MOROMEN24MTO_PN,
                       DPREVMAY24DOC_PJ,
                       DPREVMAY24DOC_PN,
                       DPREVMEN24DOC_PJ,
                       DPREVMEN24DOC_PN,
                       DPREVMAY24MTO_PJ,
                       DPREVMAY24MTO_PN ,
                       DPREVMEN24MTO_PJ,
                       DPREVMEN24MTO_PN,
                       IND_CASTIGO
                    FROM er_parameval
                    WHERE nro_solic = g_nro_solic;
         V_TABLA      := 'ERH_SOLICETEVAL';
         V_ACT       :='I';
             INSERT INTO erh_soliceteval
                    (
                     NRO_SOLIC         	   ,
                     FEC_PASOHISTORICA_DH  ,
                     NUM_IDENT_CL		   ,
                     IND_NOMBRE_CL 		   ,
                     IND_DIRECCION_CL 	   ,
                     NUM_IDENT_USU		   ,
                     OPERADOR_RIESGO	   ,
                     APROBADOR 			   ,
                     IND_PERSONERIA 	   ,
                     TELEFONO_RED_FIJA     ,
                     RTA_LIQ			   ,
                     NOMBRE_CL			   ,
                     CEL_SOLICITADOS 	   ,
                     DIR_CL          	   ,
                     TIPO_DE_PRODUCTO  	   ,
                     TIPO_VENTA			   ,
                     FECHA				   ,
                     ESTADO				   ,
                     NOTA,
                     FECHA_APROBACION	   ,
                     ESTADO_ANTERIOR	   ,
                     NIVEL_SOLICITUD	   ,
                     COD_BANCO			   ,
                     COD_TIPTARJETA		   ,
                     CTA_CORRIENTE		   ,
                     NUM_DOCUMENTO		   ,
                     COD_OFICINA		   ,
                     COD_TIPCOMIS		   ,
                     COD_VENDEDOR 		   ,
                     COD_VENDEDOR_AGENTE   ,
                     COD_VENDEALER		   ,
                     NOTA_CEDULA_IDENTIDAD ,
                     NOTA_DICOM			   ,
                     NOTA_CTC			   ,
                     NOTA_CTA_FINAL_ALIANZA,
                     NOTA_DEUDA_STARTEL		,
                     NOTA_CASTIGO			,
                     NOTA_BAJAS				,
                     NOTA_RENTA				,
                     NOTA_SUSPENSIONES		,
                     NOTA_RECHAZOS			,
                     TIPO_CLIENTE			,
                     TIPO_SOLICITUD			,
                     FEC_ALTA_DH			,
                     TIPO_PLAN				,
                     COD_EJECUTIVO_ASIGNADO	 ,
                     OBSERVACION_PLATAFORMA	 ,
                     OBSERVACION_APROBADOR	 ,
                     FEC_APROBACION_H		 ,
                     NOM_OPERREVISION		 ,
		     FEC_REVISION_H					 ,
		     COD_PLANTARIF					 ,
		     FEC_NACIMIENTO_D				 ,
		    IND_ANTIGUEDAD
                    )
                 SELECT
                     NRO_SOLIC				 ,
                     SYSDATE				 ,
                     NUM_IDENT_CL			 ,
                     IND_NOMBRE_CL 			 ,
                     IND_DIRECCION_CL 		 ,
                     NUM_IDENT_USU			 ,
                     OPERADOR_RIESGO		 ,
                     APROBADOR 				 ,
                     IND_PERSONERIA 		 ,
                     TELEFONO_RED_FIJA  	 ,
                     RTA_LIQ				 ,
                     NOMBRE_CL				 ,
                     CEL_SOLICITADOS 		 ,
                     DIR_CL          		 ,
                     TIPO_DE_PRODUCTO  		 ,
                     TIPO_VENTA				 ,
                     FECHA					 ,
                     8						 ,
                     NOTA					 ,
                     FECHA_APROBACION		 ,
                     ESTADO					 ,
                     NIVEL_SOLICITUD		 ,
                     COD_BANCO				 ,
                     COD_TIPTARJETA			 ,
                     CTA_CORRIENTE			 ,
                     NUM_DOCUMENTO			 ,
                     COD_OFICINA			 ,
                     COD_TIPCOMIS			 ,
                     COD_VENDEDOR			 ,
                     COD_VENDEDOR_AGENTE	 ,
                     COD_VENDEALER			 ,
                     NOTA_CEDULA_IDENTIDAD	 ,
                     NOTA_DICOM				 ,
                     NOTA_CTC				 ,
                     NOTA_CTA_FINAL_ALIANZA	 ,
                     NOTA_DEUDA_STARTEL		 ,
                     NOTA_CASTIGO			 ,
                     NOTA_BAJAS				 ,
                     NOTA_RENTA				 ,
                     NOTA_SUSPENSIONES		 ,
                     NOTA_RECHAZOS			 ,
                     TIPO_CLIENTE			 ,
                     TIPO_SOLICITUD			 ,
                     FEC_ALTA_DH			 ,
                     TIPO_PLAN				 ,
                     COD_EJECUTIVO_ASIGNADO	 ,
                     OBSERVACION_PLATAFORMA	 ,
                     OBSERVACION_APROBADOR	 ,
                     FEC_APROBACION_H		 ,
                     NOM_OPERREVISION		 ,
		     FEC_REVISION_H					 ,
		     COD_PLANTARIF					 ,
		     FEC_NACIMIENTO_D				 ,
		    IND_ANTIGUEDAD
                    FROM er_soliceteval
                    WHERE  nro_solic = g_nro_solic;
         V_TABLA      := 'ERH_SISCEL';
         V_ACT        :='I';
             INSERT INTO erh_siscel
                    (
                        NRO_SOLIC                  ,
                        FEC_PASOHISTORICA_DH       ,
                        NUM_IDENT_CLIENTE          ,
                        CANT_CELULARES             ,
                        ESTADO_SOLIC               ,
                        TIPO_PRODUCTO              ,
                        FEC_SOLICITUD_DH           ,
                        RENTA_LIQUIDA              ,
                        COD_OFICINA                ,
                        COD_TIPCOMIS               ,
                        COD_VENDEDOR               ,
                        COD_VENDEDOR_AGENTE        ,
                        COD_VENDEALER              ,
                        CANT_UNID_ABONADO
                    )
                 SELECT
                        NRO_SOLIC                  ,
                        SYSDATE                    ,
                        NUM_IDENT_CLIENTE          ,
                        CANT_CELULARES             ,
                        ESTADO_SOLIC               ,
                        TIPO_PRODUCTO              ,
                        FEC_SOLICITUD              ,
                        RENTA_LIQUIDA              ,
                        COD_OFICINA                ,
                        COD_TIPCOMIS               ,
                        COD_VENDEDOR               ,
                        COD_VENDEDOR_AGENTE        ,
                        COD_VENDEALER              ,
                        g_cantidad_acumulado
                     FROM er_siscel
                     WHERE nro_solic  = g_nro_solic;
             DELETE FROM er_siscel
                     WHERE nro_solic  = g_nro_solic;
             DELETE FROM er_parameval
                     WHERE nro_solic  = g_nro_solic;
             DELETE FROM er_soliceteval
                     WHERE nro_solic  = g_nro_solic;
     END IF;
     INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                 COD_RETORNO,
                DES_CADENA)
            VALUES (VP_TRANSAC,
                   V_ERROR,
                   NULL);
    EXCEPTION
         WHEN OTHERS THEN
           V_ERROR := 4;
           V_SQLCODE :=  SQLCODE;
           V_SQLERRM :=  SQLERRM;
           ROLLBACK;
           INSERT INTO GA_ERRORES
                      (COD_PRODUCTO,
                       COD_ACTABO,
                       CODIGO,
                       FEC_ERROR,
                       NOM_PROC,
                       NOM_TABLA,
                       COD_ACT,
                       COD_SQLCODE,
                       COD_SQLERRM)
               VALUES (1,
                       'PR',
                       VP_NUM_VENTA,
                       sysdate,
                       V_PROC,
                       V_TABLA,
                       V_ACT,
                       V_SQLCODE,
                       V_SQLERRM);
           COMMIT;
           INSERT INTO GA_TRANSACABO (NUM_TRANSACCION,
                                   COD_RETORNO,
                                   DES_CADENA)
                           VALUES (VP_TRANSAC,
                                   V_ERROR,
                                   NULL);
END;
/
SHOW ERRORS
