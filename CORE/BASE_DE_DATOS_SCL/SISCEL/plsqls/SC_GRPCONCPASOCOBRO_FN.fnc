CREATE OR REPLACE FUNCTION SC_GRPCONCPASOCOBRO_FN(vp_Ciclo      IN  FA_ENLACEHIST.COD_CICLFACT%TYPE,         --1-Ciclo.
                                                   vp_TipComis   IN  GA_CUENTAS.COD_TIPCOMIS%TYPE,            --2-Tipo de Comision.
                                                   vp_NumPasocob IN  FA_REPPASOCOBROS.NUM_PROCPASOCOB%TYPE,   --3-Numero de PasoCobro.
                                                   vp_Operadora  IN  FA_REPDETALLE_TO.COD_OPERADORA_SCL%TYPE, --4-Operadora.
                                                   vp_CatPrepago IN  NUMBER  ,                                --5-Categoria de Prepago.
                                                   vp_Decimal    IN  NUMBER  ,                                --6-Precision Decimal.
                                                   szhMensaje    OUT VARCHAR2
                                                   ) RETURN  NUMBER IS

szyyyymm                VARCHAR2(6);
szCERO                  VARCHAR2(1);
iValor_uno              NUMBER;
iValor_cinco            NUMBER;
iValor_cien             NUMBER;
iValor_unoNeg           NUMBER;
v_StrSql                VARCHAR2(3020);
iCountGabocel           NUMBER;
szSentencia             VARCHAR2(100);

szTablaConceptos        FA_ENLACEHIST.FA_HISTCONC%TYPE;
szTablaDocumentos       FA_ENLACEHIST.FA_HISTDOCU%TYPE;
szTablaTecnologia       FA_ENLACEHIST.FA_TECNOLOGIAS_TH%TYPE;

iCod_Tipdocum           FA_REPPASOCOBROS.NUM_PROCPASOCOB%TYPE;
iCodConcepto            FA_DETPASOCOBROS.COD_CONCEPTO%TYPE;
lPerContable            FA_DETPASOCOBROS.PER_CONTABLE%TYPE;
dImpFacturable          FA_DETPASOCOBROS.IMP_CONCEPTO%TYPE;
iCodCategoria           FA_DETPASOCOBROS.COD_CATEGORIA%TYPE;
lCod_Cliente            GA_ABOCEL.COD_CLIENTE%TYPE;
szCodApertura           FA_FACTECNO_TO_NOCICLO.COD_OFICINA_PRINCIPAL%TYPE;
szCodTecnologia         FA_DETPASOCOBROS.COD_TECNOLOGIA%TYPE;
szCod_Tipcomis          GA_CUENTAS.COD_TIPCOMIS%TYPE;
iCategoria              FA_DETPASOCOBROS.COD_CATEGORIA%TYPE;

--CON EL CICLO SE DEBEN OBTENER LOS NOMBRES DE LAS TABLAS DE FACTURACION DE LA TABLA DE ENLACE
--EL QUERY RETORNARA LOS CARGOS AGRUPADOS SEGUN LOS CAMPOS PK DE LA TABLA FA_DETPASOCOBROS

TYPE TipCursor IS REF CURSOR;
Cur_Doctos   TipCursor;

BEGIN

  	szyyyymm := 'yyyymm';
	iValor_cinco := 5;
	iValor_unoNeg:= -1;
	szCERO := '0';
	iValor_cien:= 100;
	iValor_uno := 1;

   szSentencia:='Sentencia : SELECT FA_ENLACEHIST';
   SELECT FA_HISTCONC,
          FA_HISTDOCU,
          FA_TECNOLOGIAS_TH
   INTO   szTablaConceptos ,
          szTablaDocumentos,
          szTablaTecnologia
   FROM   FA_ENLACEHIST
   WHERE  COD_CICLFACT = vp_Ciclo;

   v_StrSql := 'SELECT A.COD_TIPDOCUM,';
	v_StrSql := v_StrSql || '      B.COD_GRPCONCEPTO,';
	v_StrSql := v_StrSql || '      SUM(B.IMP_FACTURABLE),';
	v_StrSql := v_StrSql || '      TO_CHAR( A.FEC_EMISION, :v1 ),';         /* yyyymm */
	v_StrSql := v_StrSql || '      NVL( C.COD_CATEGORIA, :v2 ),';           /* 5      */
	v_StrSql := v_StrSql || '      NVL( C.COD_CLIENTE, :v3 ),';             /* -1     */
	v_StrSql := v_StrSql || '      NVL( B.COD_OFICINA_PRINCIPAL, :v4 ),';   /* '0'    */
	v_StrSql := v_StrSql || '      B.COD_TECNOLOGIA,';
	v_StrSql := v_StrSql || '      :v5 ';                                    /* vp_TipComis */
	v_StrSql := v_StrSql || 'FROM  GE_CLIENTES C, ';
	v_StrSql := v_StrSql || '     (  SELECT C.IND_ORDENTOTAL, ';
	v_StrSql := v_StrSql || '               T.COD_GRPCONCEPTO, ';
	v_StrSql := v_StrSql || '               C.IMP_FACTURABLE * ( T.PRC_TECNOLOGIA / :v6 ) IMP_FACTURABLE, ';  /* 100  */
	v_StrSql := v_StrSql || '               T.COD_TECNOLOGIA, ';
	v_StrSql := v_StrSql || '               T.COD_OFICINA_PRINCIPAL ';
	v_StrSql := v_StrSql || '        FROM   '||szTablaDocumentos||' D , '||szTablaConceptos||' C, '||szTablaTecnologia||' T ';
	v_StrSql := v_StrSql || '        WHERE  T.IND_ORDENTOTAL   = C.IND_ORDENTOTAL  ';
	v_StrSql := v_StrSql || '        AND    T.COD_CONCEPTO     = C.COD_CONCEPTO ';
	v_StrSql := v_StrSql || '        AND    T.COLUMNA          = C.COLUMNA ';
	v_StrSql := v_StrSql || '        AND    C.IND_ORDENTOTAL   = D.IND_ORDENTOTAL  ';
	v_StrSql := v_StrSql || '        AND    D.NUM_PROCPASOCOBRO= :v7 ';  /* vp_NumPasocob */
	v_StrSql := v_StrSql || '        AND    D.IND_PASOCOBRO    = :v8 ';  /* 1             */
	v_StrSql := v_StrSql || '        AND    D.COD_OPERADORA    = :v9 '; /* vp_Operadora   */
	v_StrSql := v_StrSql || '        UNION ALL ';
	v_StrSql := v_StrSql || '        SELECT C.IND_ORDENTOTAL, ';
	v_StrSql := v_StrSql || '               T.COD_GRPCONCEPTO, ';
	v_StrSql := v_StrSql || '               C.IMP_FACTURABLE * ( T.PRC_TECNOLOGIA / :v10 ) IMP_FACTURABLE, '; /* 100  */
	v_StrSql := v_StrSql || '               T.COD_TECNOLOGIA, ';
	v_StrSql := v_StrSql || '               T.COD_OFICINA_PRINCIPAL ';
	v_StrSql := v_StrSql || '        FROM   FA_FACTCONC_NOCICLO C,FA_FACTDOCU_NOCICLO D, FA_FACTECNO_TO_NOCICLO T ';
	v_StrSql := v_StrSql || '        WHERE  T.IND_ORDENTOTAL   = C.IND_ORDENTOTAL ';
	v_StrSql := v_StrSql || '        AND    T.COD_CONCEPTO     = C.COD_CONCEPTO ';
	v_StrSql := v_StrSql || '        AND    T.COLUMNA          = C.COLUMNA ';
	v_StrSql := v_StrSql || '        AND    D.IND_ORDENTOTAL   = C.IND_ORDENTOTAL ';
	v_StrSql := v_StrSql || '        AND    D.NUM_PROCPASOCOBRO= :v11 ';  /* vp_NumPasocob   */
	v_StrSql := v_StrSql || '        AND    D.IND_PASOCOBRO    = :v12 ';  /* 1               */
	v_StrSql := v_StrSql || '        AND    D.COD_OPERADORA    = :v13 ';  /* vp_Operadora    */
	v_StrSql := v_StrSql || '        AND    C.IND_ORDENTOTAL   = T.IND_ORDENTOTAL ';
	v_StrSql := v_StrSql || '        AND    C.COD_CONCEPTO     = T.COD_CONCEPTO ';
	v_StrSql := v_StrSql || '        AND    C.COLUMNA          = T.COLUMNA ) B, ';
	v_StrSql := v_StrSql || '     (  SELECT E.NUM_PROCPASOCOBRO, ';
	v_StrSql := v_StrSql || '               E.COD_TIPDOCUM, ';
	v_StrSql := v_StrSql || '               E.IND_ORDENTOTAL, ';
	v_StrSql := v_StrSql || '               E.FEC_EMISION, ';
	v_StrSql := v_StrSql || '               E.COD_CLIENTE, ';
	v_StrSql := v_StrSql || '               E.COD_OPERADORA ';
	v_StrSql := v_StrSql || '        FROM   FA_FACTDOCU_NOCICLO E ';
	v_StrSql := v_StrSql || '        WHERE  E.NUM_PROCPASOCOBRO= :v14 ';  /* vp_NumPasocob */
	v_StrSql := v_StrSql || '         AND    E.IND_PASOCOBRO    = :v15 ';  /* 1            */
	v_StrSql := v_StrSql || '         AND    E.COD_OPERADORA    = :v16 ';  /* vp_Operadora */
	v_StrSql := v_StrSql || '         UNION ALL ';
	v_StrSql := v_StrSql || '         SELECT E.NUM_PROCPASOCOBRO, ';
	v_StrSql := v_StrSql || '                E.COD_TIPDOCUM, ';
	v_StrSql := v_StrSql || '                E.IND_ORDENTOTAL, ';
	v_StrSql := v_StrSql || '                E.FEC_EMISION, ';
	v_StrSql := v_StrSql || '                E.COD_CLIENTE, ';
	v_StrSql := v_StrSql || '                E.COD_OPERADORA ';
	v_StrSql := v_StrSql || '         FROM   '||szTablaDocumentos||' E ';          /* szTablaDocumentos  */
	v_StrSql := v_StrSql || '         WHERE  E.NUM_PROCPASOCOBRO= :v17 ';  /* vp_NumPasocob   */
	v_StrSql := v_StrSql || '         AND    E.COD_OPERADORA    = :v18 ) A, GA_CUENTAS D  ';   /* vp_Operadora  */
	v_StrSql := v_StrSql || 'WHERE A.NUM_PROCPASOCOBRO= :v19  ';  /* vp_NumPasocob   */
	v_StrSql := v_StrSql || 'AND   A.IND_ORDENTOTAL = B.IND_ORDENTOTAL  ';
	v_StrSql := v_StrSql || 'AND   A.COD_CLIENTE    = C.COD_CLIENTE  ';
	v_StrSql := v_StrSql || 'AND   D.COD_CUENTA     = C.COD_CUENTA   ';
	v_StrSql := v_StrSql || 'GROUP BY A.NUM_PROCPASOCOBRO, A.COD_TIPDOCUM, B.COD_GRPCONCEPTO, A.FEC_EMISION,  ';
	v_StrSql := v_StrSql || 'C.COD_CATEGORIA, C.COD_CLIENTE, A.COD_OPERADORA, B.COD_OFICINA_PRINCIPAL, B.COD_TECNOLOGIA,:v20  '; /* vp_TipComis */

   szSentencia:='Sentencia : OPEN Cur_Doctos';
   OPEN Cur_Doctos FOR v_StrSql USING szyyyymm, iValor_cinco, iValor_unoNeg, szCERO, vp_TipComis, iValor_cien,
                                      vp_NumPasocob, iValor_uno, vp_Operadora, iValor_cien ,vp_NumPasocob,
                                      iValor_uno, vp_Operadora, vp_NumPasocob, iValor_uno, vp_Operadora,
                                      vp_NumPasocob, vp_Operadora, vp_NumPasocob, vp_TipComis;
   LOOP
   	szSentencia:='Sentencia : FETCH Cur_Doctos';
      FETCH Cur_Doctos
      INTO iCod_Tipdocum  , iCodConcepto   , dImpFacturable,
           lPerContable   , iCodCategoria  , lCod_Cliente  ,
           szCodApertura  , szCodTecnologia, szCod_Tipcomis;
      EXIT WHEN Cur_Doctos%NOTFOUND;

   	szSentencia:='Sentencia : SELECT COUNT(1) GA_ABOAMIST';
      SELECT COUNT(1)
      INTO  iCountGabocel
      FROM  GA_ABOAMIST
      WHERE COD_CLIENTE = lCod_Cliente
      AND   ROWNUM < 2;

      IF (iCountGabocel > 0)  THEN
          iCategoria := vp_CatPrepago;  /*cliente prepago*/
      ELSE
          iCategoria := iCodCategoria;  /*cliente contrato */
      END IF;

      -- RECORRER LOS CAMPOS DE COLECCION
      BEGIN --(
   	   szSentencia:='Sentencia : INSERT INTO FA_DETPASOCOBROS';
         INSERT INTO FA_DETPASOCOBROS
                (NUM_PROCPASOCOBRO, COD_TIPDOCUM  , COD_CONCEPTO     , PER_CONTABLE  , IMP_CONCEPTO  ,
                 COD_CATEGORIA    , COD_TIPCOMIS  , COD_OPERADORA_SCL, COD_APERTURA  , COD_TECNOLOGIA )
         VALUES (vp_NumPasocob    , iCod_Tipdocum , iCodConcepto     , lPerContable  , GE_PAC_GENERAL.REDONDEA( dImpFacturable, vp_Decimal, 0 ),
					  iCategoria       , vp_TipComis   , vp_Operadora     , szCodApertura , szCodTecnologia);


         EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
               BEGIN
   	            szSentencia:='Sentencia : UPDATE FA_DETPASOCOBROS SET';
                  UPDATE FA_DETPASOCOBROS SET
                        IMP_CONCEPTO = IMP_CONCEPTO + GE_PAC_GENERAL.REDONDEA( dImpFacturable, vp_Decimal, 0 )
                  WHERE  NUM_PROCPASOCOBRO= vp_NumPasocob
                  AND    COD_TIPDOCUM     = iCod_Tipdocum
                  AND    COD_CONCEPTO     = iCodConcepto
                  AND    PER_CONTABLE     = lPerContable
                  AND    COD_CATEGORIA    = iCategoria
                  AND    COD_TIPCOMIS     = vp_TipComis
                  AND    COD_OPERADORA_SCL= vp_Operadora
                  AND    COD_APERTURA     = szCodApertura
                  AND    COD_TECNOLOGIA   = szCodTecnologia;

                  EXCEPTION
                     WHEN OTHERS THEN
                        szhMensaje:=szSentencia||' - '||SQLERRM;
                        RETURN -3;
                        RAISE_APPLICATION_ERROR( -20101, 'ERROR EN UPDATE FA_DETPASOCOBROS : '||SQLERRM||' - '||szSentencia);

               END;
            WHEN OTHERS THEN
               szhMensaje:=szSentencia||' - '||SQLERRM;
               RETURN -2;
               RAISE_APPLICATION_ERROR( -20101, 'ERROR EN INSERT FA_DETPASOCOBROS : '||SQLERRM||' - '||szSentencia);
      END;

   END LOOP;

   szSentencia:='Sentencia : CLOSE Cur_Doctos';
   CLOSE Cur_Doctos;

   szSentencia:='Sentencia : UPDATE FA_REPDETALLE_TO SET';
   UPDATE FA_REPDETALLE_TO SET
          FEC_GENINTCON  = SYSDATE
   WHERE  NUM_PROCPASOCOBRO = vp_NumPasocob
   AND    COD_OPERADORA_SCL = vp_Operadora;

   szSentencia:='Sentencia : COMMIT WORK';
   COMMIT WORK;
   szhMensaje:='OK';
   RETURN 0;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
     szhMensaje:=szSentencia||' - '||SQLERRM;
     RETURN 1403;
  WHEN OTHERS THEN
     szhMensaje:=szSentencia||' - '||SQLERRM;
     RETURN -1;
     ROLLBACK WORK;
     RAISE_APPLICATION_ERROR( -20101, 'ERROR EN LA APLICACION : '||SQLERRM||' - '||szSentencia);

END SC_GRPCONCPASOCOBRO_FN;
/
SHOW ERRORS
