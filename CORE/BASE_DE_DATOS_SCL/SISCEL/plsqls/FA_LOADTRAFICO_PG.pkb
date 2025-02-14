CREATE OR REPLACE PACKAGE BODY FA_LOADTRAFICO_PG AS

  /* Variables Globales */
  GV_Cod_Carg           NUMBER(5);
  GV_Tip_Unidad         VARCHAR2(5);
  GV_Factor             NUMBER;
  GV_Tip_Unidad_Factor  VARCHAR2(5);
  --
  GV_des_Auxiliar       GE_ERRORES_PG.VQUERY;   /* Sub tipo asociado a paquete de errores */
  GV_cod_Retorno        VARCHAR2(6);
  GV_msg_Retorno        VARCHAR2(100);


  MSG_ERROR_NOCLASIF    VARCHAR2(50):= 'No es posible clasificar el error';
  MSG_ERROR_PROCEDURE   VARCHAR2(50):= 'Falla controlada en procedure.';

FUNCTION FA_TIPOLLAMADAUNIDAD_FN ( EN_Cod_Carg        IN NUMBER,
                                   EN_cod_ciclfact    IN FA_CICLFACT.COD_CICLFACT%TYPE,
                                   EN_digito          IN NUMBER)
RETURN VARCHAR2 IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_TIPOLLAMADAUNIDAD_FN" Lenguaje="PL/SQL" Fecha="06-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>VARCHAR2</Retorno>
4.  <Descripción>Funcion para recuperar Tipo Unidad</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_Cod_Carg" Tipo="NUMBER">Código Concepto</param>
7.  <param nom="EN_cod_ciclfact" Tipo="NUMBER">Código Ciclo Facturación</param>
7.  <param nom="EN_digito" Tipo="NUMBER">Dígito</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/
--
    LV_Tip_Unidad             VARCHAR(5):= '';
    MSG_ERROR_UPDATE          VARCHAR2(60):= 'No se pudo recuperar datos';
    LV_parametros             VARCHAR2(2000);
    SN_cod_CodMegError        GE_ERRORES_TD.COD_MSGERROR%TYPE;
    SV_msg_DetMsgError        GE_ERRORES_TD.DET_MSGERROR%TYPE;
    SN_num_Evento             GE_EVENTO_DETALLE_TO.EVENTO%TYPE :=0;
--
BEGIN

    IF (NVL(GV_Cod_Carg, 0) != EN_Cod_Carg) THEN -- 117380 - 23-02-2010 - Se agrega el NVL para que funcione 

        GV_des_Auxiliar := 'SELECT G.TIP_UNIDAD FROM  FAD_IMPCONCEPTOS C, ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' FAD_IMPSUBGRUPOS S, ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' FAD_IMPGRUPOS G ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' WHERE C.COD_CONCEPTO = ' || En_Cod_Carg;
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   C.COD_SUBGRUPO = S.COD_SUBGRUPO ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   S.COD_GRUPO    = G.COD_GRUPO ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   EXISTS (SELECT 1 FROM FAD_PARAMETROS P ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' WHERE P.COD_MODULO = ' ||''''||'FA'||''''||'';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   P.COD_PARAMETRO = 12 ';
        GV_des_Auxiliar := GV_des_Auxiliar || ' AND   P.VAL_NUMERICO = G.COD_FORMULARIO) ';

        BEGIN
            SELECT G.TIP_UNIDAD
              INTO LV_Tip_Unidad
              FROM FAD_IMPCONCEPTOS C,
                   FAD_IMPSUBGRUPOS S,
                   FAD_IMPGRUPOS G
              WHERE C.COD_CONCEPTO = En_Cod_Carg
              AND   C.COD_SUBGRUPO = S.COD_SUBGRUPO
              AND   S.COD_GRUPO    = G.COD_GRUPO
              AND   EXISTS (SELECT 1
                            FROM FAD_PARAMETROS P
                            WHERE P.COD_MODULO    = 'FA'
                            AND P.COD_PARAMETRO = 12
                            AND P.VAL_NUMERICO  = G.COD_FORMULARIO);

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                GV_Cod_Carg   := EN_Cod_Carg;
                GV_Tip_Unidad := LV_Tip_Unidad;
                LV_parametros := 'LOADTRAFICO(' || EN_cod_ciclfact || '|';
                LV_parametros := LV_parametros || EN_digito || '|)';

                GV_cod_Retorno     := '1'; --'No se pudo recuperar datos'
                IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
                    GV_msg_Retorno := MSG_ERROR_UPDATE;
                END IF;
                SN_num_Evento :=0;
                SN_num_Evento := Ge_Errores_Pg.Grabarpl( SN_num_Evento
                                                        , 'FA'
                                                        , GV_msg_Retorno
                                                        , '1.0'
                                                        , USER
                                                        , 'FA_TIPOLLAMADAUNIDAD_FN'
                                                        , GV_des_Auxiliar
                                                        , SQLCODE
                                                        , LV_parametros || '-' || SQLERRM);

               LV_Tip_Unidad := 'NK';
               RETURN LV_Tip_Unidad;
       END;

       GV_Cod_Carg   := EN_Cod_Carg;
       GV_Tip_Unidad := LV_Tip_Unidad;

    END IF;

    RETURN GV_Tip_Unidad;

END FA_TIPOLLAMADAUNIDAD_FN;

FUNCTION FA_GETFACTOR_FN ( EV_Tip_Unidad IN VARCHAR2 ) 
RETURN NUMBER IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_GETFACTOR_FN" Lenguaje="PL/SQL" Fecha="06-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Funcion recuperar factor de conversion</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EV_Tip_Unidad" Tipo="VARCHAR2">Tipo Unidad</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LN_factor NUMBER := 1;

BEGIN

    IF (NVL(GV_Tip_Unidad_factor, ' ') != EV_Tip_Unidad) THEN -- 117380 - 23-02-2010 - Se agrega el NVL para que funcione 
        BEGIN
          SELECT TO_NUMBER(DESCRIPCION_VALOR)
          INTO   LN_factor
          FROM   FA_FACTOR_TIPO_UNIDAD_VW
         WHERE   TRIM(VALOR) = TRIM(EV_Tip_Unidad);

        END;

        GV_Factor            := LN_Factor;
        GV_Tip_Unidad_factor := EV_Tip_Unidad;

    END IF;

    RETURN GV_Factor;

END FA_GETFACTOR_FN;

FUNCTION FA_CALCPULSO_FN ( EN_Dur_Real IN NUMBER,
                           EN_factor IN NUMBER)
RETURN NUMBER IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_CALCPULSO_FN" Lenguaje="PL/SQL" Fecha="06-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Funcion para calculo de pulso</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_Dur_Real" Tipo="NUMBER">Duración real llamada</param>
8.  <param nom="EN_factor" Tipo="NUMBER">Factor de conversión</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LN_pulso     NUMBER := 0;

BEGIN

    IF (EN_Dur_Real > 0) AND (EN_factor > 0) THEN
        LN_pulso := CEIL(EN_Dur_Real / EN_factor);
    END IF;

    RETURN LN_pulso;

END FA_CALCPULSO_FN;

FUNCTION FA_CALCVALORUNIDAD_FN ( EN_mto_real IN NUMBER,
                                 EN_num_pulso IN NUMBER)
RETURN NUMBER IS
/*
1.  <Documentación TipoDoc = "Función">
2.  <Elemento Nombre = "FA_CALCVALORUNIDAD_FN" Lenguaje="PL/SQL" Fecha="26-12-2007" Versión="1" Diseñador="****" Programador="****" Ambiente="BD">
3.  <Retorno>NUMBER</Retorno>
4.  <Descripción>Funcion para calculo de valor unidad</Descripción>
5.  <Parámetros>
6.  <Entrada>
7.  <param nom="EN_mto_real" Tipo="NUMBER">Monto real</param>
7.  <param nom="EN_num_pulso" Tipo="NUMBER">Número pulso</param>
10. </Entrada>
16. </Parámetros>
17. </Elemento>
18. </Documentación>
*/

    LN_valor_unidad          PF_TOLTARIFICA.mto_real%TYPE;

BEGIN

    LN_valor_unidad := 0;

    IF (EN_mto_real > 0) AND (EN_num_pulso > 0) THEN
        LN_valor_unidad := EN_mto_real / EN_num_pulso;
    END IF;

    RETURN LN_valor_unidad;

END FA_CALCVALORUNIDAD_FN;


FUNCTION FA_LOADTRAFICO_FN (vp_Cod_Ciclfact IN NUMBER, vp_Digito IN NUMBER)
RETURN NUMBER IS

    a                          NUMBER(15);
    v_mensaje                  VARCHAR2(200);
    STMT                       VARCHAR2(5000):='';
    STMT2                      VARCHAR2(10000):='';
    LV_parametros              VARCHAR2(2000);
    v_cod_marca                VARCHAR2(6);
    v_ind_impresion            VARCHAR2(2);
    v_cod_promo                VARCHAR2(10);
    v_cod_marca2               VARCHAR2(6);
    v_ind_impresion2           VARCHAR2(2);
    LN_num_pulso               NUMBER(15):=0;

    LV_cod_marca               PF_TOLTARIFICA.cod_marca%TYPE;
    LV_ind_impresion           PF_TOLTARIFICA.ind_impresion%TYPE;
    LN_valor_unidad            NUMBER(15,5);
    LN_mto_real                PF_TOLTARIFICA.mto_real%TYPE;
    LV_valor_generico          PF_TOLTARIFICA.cod_tdir%TYPE;
    LN_toltarif_mtoreal        PF_TOLTARIFICA.mto_real%TYPE;
    SN_num_Evento              GE_EVENTO_DETALLE_TO.EVENTO%TYPE;
    LN_CANTIDAD                NUMBER;
    LV_toltarif_tipdcto        VARCHAR(5);
    LV_toltarif_coddcto        VARCHAR(5);
    LV_toltarif_codsubfranja   VARCHAR(5);
    LV_toltarif_codtdir        VARCHAR(5);
    LN_toltarif_codcarg        NUMBER(5);
    LN_toltarif_durreal        NUMBER(6);
    LV_toltarif_codmarcamp     VARCHAR2(6);
    LV_toltarif_indimpresionmp VARCHAR2(2);
    LV_toltarif_codmarcam      VARCHAR2(6);
    LV_toltarif_indimpresionm  VARCHAR2(2);

    LB_si_direccion            VARCHAR2(1) :='N';
    LB_si_subfranja1           VARCHAR2(1) :='N';
    LB_si_subfranja2           VARCHAR2(1) :='N';

    LV_TIP_UNIDAD              VARCHAR2(5):= '';
    LN_factor                  NUMBER;

    --TYPE cursor_cli IS TABLE OF TOL_SISCEL.TOL_DETFACTURA_07%ROWTYPE;
    TYPE cursor_cli IS TABLE OF TOL_DETFACTURA_07%ROWTYPE;      
    
    C_cursor_clientes SYS_REFCURSOR;
    reg_clientes cursor_cli;

BEGIN

    

    a:=0;
    stmt := '';
    stmt := stmt || 'SELECT /*+ RULE */ ';
    stmt := stmt || 'DET.* ';
    stmt := stmt || 'FROM TOL_DETFACTURA_0' || vp_Digito || ' DET ';
    stmt := stmt || 'WHERE DET.COD_CICLFACT = ' || vp_Cod_Ciclfact || ' ';
    stmt := stmt || 'AND EXISTS ';
    stmt := stmt || '(SELECT NULL FROM FA_CICLOCLI B ';
    stmt := stmt || 'WHERE B.COD_CLIENTE=DET.NUM_CLIE ';
    stmt := stmt || 'AND B.IND_MASCARA=1 ';
    stmt := stmt || 'AND SUBSTR(B.COD_CLIENTE,LENGTH((B.COD_CLIENTE)),1)= ' || vp_Digito || ')';
        

    OPEN C_cursor_clientes for stmt;
    LOOP    
      FETCH C_cursor_clientes  BULK COLLECT INTO reg_clientes LIMIT 10000;
      EXIT WHEN reg_clientes.COUNT = 0;

      FOR i IN reg_clientes.FIRST .. reg_clientes.LAST  LOOP

      LV_parametros := 'LOADTRAFICO(' || vp_Cod_Ciclfact || '|';
      LV_parametros := LV_parametros || vp_Digito || '|)';

      GV_des_Auxiliar            :='';
      
	  BEGIN
				SELECT NVL(MP.COD_MARCA,'SM'),NVL(MP.IND_IMPRESION,'SI'),MP.COD_PROMO,  NVL(M.COD_MARCA,'SM'), NVL(M.IND_IMPRESION,'SI')
				INTO v_cod_marca,v_ind_impresion,v_cod_promo, v_cod_marca2 , v_ind_impresion2
				FROM FA_MARCAPROMO_TD MP, FA_MARCA_TD M
				WHERE MP.TIP_MARCA = 'PR'
				AND M.TIP_MARCA='ML'
				AND MP.COD_PROMO=reg_clientes(i).COD_DCTO
				AND M.TIP_MARCA=reg_clientes(i).TIP_DCTO;

		EXCEPTION WHEN NO_DATA_FOUND THEN
				v_cod_marca:='SM';
				v_ind_impresion:='SI';
				v_cod_promo:='XX';
				v_cod_marca2:='SM';
				v_ind_impresion2:='SI';
		WHEN OTHERS THEN
				v_cod_marca:='SM';
				v_ind_impresion:='SI';
				v_cod_promo:='XX';
				v_cod_marca2:='SM';
				v_ind_impresion2:='SI';
		END;

     LV_toltarif_tipdcto        :=reg_clientes(i).TIP_DCTO;
     LV_toltarif_coddcto        :=reg_clientes(i).COD_DCTO;
     LV_toltarif_codsubfranja   :=reg_clientes(i).COD_SUBFRANJA;
     LV_toltarif_codtdir        :=reg_clientes(i).COD_TDIR;
     LN_toltarif_codcarg        :=reg_clientes(i).COD_CARG;
     LN_toltarif_durreal        :=reg_clientes(i).DUR_REAL;
     LV_toltarif_codmarcamp     :=v_cod_marca;
     LV_toltarif_indimpresionmp :=v_ind_impresion;
     LV_toltarif_codmarcam      :=v_cod_marca2;
     LV_toltarif_indimpresionm  :=v_ind_impresion2;
     LN_toltarif_mtoreal        :=reg_clientes(i).MTO_REAL;

     LB_si_subfranja1 :='N';
     LB_si_subfranja2 :='N';
     LB_si_direccion  :='N';

     LV_cod_marca     :=v_cod_marca;
     LV_ind_impresion :=v_ind_impresion;
     LN_valor_unidad  :=0;
     LV_valor_generico:='';


     IF LTRIM(RTRIM(LV_toltarif_tipdcto)) = 'PR' THEN
        LV_cod_marca     := LV_toltarif_codmarcamp;
        LV_ind_impresion := LV_toltarif_indimpresionmp;

     ELSE
        IF LTRIM(RTRIM(LV_toltarif_tipdcto)) = 'ML' THEN
            LV_cod_marca     := LV_toltarif_codmarcam;
            LV_ind_impresion := LV_toltarif_indimpresionm;

        ELSE
            GV_des_Auxiliar := 'SELECT COUNT(1) FROM FA_DIRECCION_LLAMADA_VW';
            GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(VALOR)) = ' || RTRIM(LTRIM(LV_toltarif_codsubfranja));

            LN_CANTIDAD     := 0;

            SELECT COUNT(1)
            INTO  LN_CANTIDAD
            FROM  FA_DIRECCION_LLAMADA_VW
            WHERE RTRIM(LTRIM(VALOR)) = RTRIM(LTRIM(LV_toltarif_codtdir));

            LB_si_direccion :='S';

            IF (LN_CANTIDAD = 0) THEN
                GV_des_Auxiliar := 'SELECT COUNT(1) FROM  FA_SUBFRANJA_1_VW';
                GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(VALOR)) = ' || RTRIM(LTRIM(LV_toltarif_codsubfranja));

                LN_CANTIDAD     := 0;

                SELECT COUNT(1)
                INTO  LN_CANTIDAD
                FROM  FA_SUBFRANJA_1_VW
                WHERE RTRIM(LTRIM(VALOR)) = RTRIM(LTRIM(LV_toltarif_codsubfranja));

                LB_si_subfranja1 :='S';

                IF (LN_CANTIDAD = 0) THEN
                    GV_des_Auxiliar := 'SELECT SELECT COUNT(1 FROM FA_SUBFRANJA_2_VW ';
                    GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(VALOR)) = ' || RTRIM(LTRIM(LV_toltarif_codsubfranja));

                    LN_CANTIDAD     := 0;

                    SELECT COUNT(1)
                    INTO  LN_CANTIDAD
                    FROM  FA_SUBFRANJA_2_VW
                    WHERE RTRIM(LTRIM(VALOR)) = RTRIM(LTRIM(LV_toltarif_codsubfranja));

                    LB_si_subfranja2 :='S';

                    IF (LN_CANTIDAD = 0) THEN
                        GV_cod_Retorno := '600'; --'No se cumple ninguna condicion '
                        IF NOT Ge_Errores_Pg.MENSAJEERROR(GV_cod_Retorno,GV_msg_Retorno) THEN
                            GV_msg_Retorno := MSG_ERROR_NOCLASIF;
                        END IF;
                        SN_num_Evento      := Ge_Errores_Pg.Grabarpl(SN_num_Evento
                                                                    ,'FA'
                                                                    ,GV_msg_Retorno
                                                                    ,'1.0'
                                                                    ,USER
                                                                    ,'FA_LOADTRAFICO'
                                                                    ,GV_des_Auxiliar
                                                                    ,SQLCODE
                                                                    ,LV_parametros || '-' || SQLERRM);
                        LB_si_subfranja1 :='N';
                        LB_si_subfranja2 :='N';
                        LB_si_direccion  :='N';
                    END IF;
                END IF;
            END IF;

            IF LB_si_direccion ='S'      THEN
                LV_valor_generico := LV_toltarif_codtdir;
            ELSIF (LB_si_subfranja1 ='S' OR LB_si_subfranja2 ='S') THEN
                LV_valor_generico := LV_toltarif_codsubfranja;
            END IF;

            IF (LB_si_direccion ='S' OR LB_si_subfranja1 ='S' OR LB_si_subfranja2 ='S') THEN
                GV_des_Auxiliar := 'SELECT COD_MARCA, IND_IMPRESION  ';
                GV_des_Auxiliar := GV_des_Auxiliar || 'FROM FA_MARCA_TD ';
                GV_des_Auxiliar := GV_des_Auxiliar || 'WHERE RTRIM(LTRIM(TIP_MARCA)) = ' || RTRIM(LTRIM(LV_valor_generico));
                GV_des_Auxiliar := GV_des_Auxiliar || ' AND rownum < 2';
                BEGIN
                    SELECT COD_MARCA, IND_IMPRESION
                    INTO LV_cod_marca, LV_ind_impresion
                    FROM FA_MARCA_TD
                    WHERE RTRIM(LTRIM(TIP_MARCA)) = RTRIM(LTRIM(LV_valor_generico))
                      AND ROWNUM < 2;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                         NULL;
                END;
            END IF;
        END IF;
     END IF;

	 /* Recuperacion Tipo de Unidad */
	 LV_tip_unidad   := FA_TIPOLLAMADAUNIDAD_FN(LN_toltarif_codcarg, vp_Cod_Ciclfact,vp_Digito);

	 /* Si Tipo de Unidad no Existe entonces ERROR */
	 IF LV_tip_unidad = 'NK' THEN
			RETURN SQLCODE;
	 END IF;

	 /* Recuperacion Factor con Tipo de Unidad */
	 LN_factor       := FA_GETFACTOR_FN(LV_tip_unidad);

	 /* Calculo de Numero de Pulso */
	 LN_num_pulso    := FA_CALCPULSO_FN(LN_toltarif_durreal,LN_factor);

	 /* Calculo de Valor Unidad */
	 LN_valor_unidad := FA_CALCVALORUNIDAD_FN(LN_toltarif_mtoreal,LN_num_pulso);

	 BEGIN
        
         STMT2 := '';
		 STMT2 := STMT2 || 'INSERT INTO PF_TOLTARIFICA_' || vp_Cod_Ciclfact || ' ( ';                
         STMT2 := STMT2 || 'SEC_EMPA, ';    
         STMT2 := STMT2 || 'SEC_CDR, ';
         STMT2 := STMT2 || 'RECORD_TYPE, ';
         STMT2 := STMT2 || 'A_SUSC_NUMBER, ';
         STMT2 := STMT2 || 'A_SUSC_MS_NUMBER, ';
         STMT2 := STMT2 || 'B_SUSC_NUMBER, ';
         STMT2 := STMT2 || 'B_SUSC_MS_NUMBER, ';
         STMT2 := STMT2 || 'A_CATEGORY, ';
         STMT2 := STMT2 || 'IND_BILLETE, ';
         STMT2 := STMT2 || 'DATE_START_CHARG, ';
         STMT2 := STMT2 || 'TIME_START_CHARG, ';
         STMT2 := STMT2 || 'CHARGABLE_DURAT, ';
         STMT2 := STMT2 || 'DATE_SEND_CHARG, ';
         STMT2 := STMT2 || 'TIME_SEND_CHARG, ';
         STMT2 := STMT2 || 'SEND_DURAT, ';
         STMT2 := STMT2 || 'COD_CCC, ';
         STMT2 := STMT2 || 'OUTGOING_ROUTE, ';
         STMT2 := STMT2 || 'INCOMING_ROUTE, ';
         STMT2 := STMT2 || 'INSI_CODE, ';
         STMT2 := STMT2 || 'COD_AGRL, ';
         STMT2 := STMT2 || 'COD_SENT, ';
         STMT2 := STMT2 || 'COD_LLAM, ';
         STMT2 := STMT2 || 'COD_TDIR, ';
         STMT2 := STMT2 || 'COD_TCOR, ';
         STMT2 := STMT2 || 'COD_THOR, ';
         STMT2 := STMT2 || 'COD_TDIA,  ';
         STMT2 := STMT2 || 'COD_FCOB, ';
         STMT2 := STMT2 || 'IND_TABLA, ';
         STMT2 := STMT2 || 'COD_CARG, ';
         STMT2 := STMT2 || 'COD_CARR, ';
         STMT2 := STMT2 || 'COD_GRUPO, ';
         STMT2 := STMT2 || 'NUM_CLIE, ';
         STMT2 := STMT2 || 'NUM_ABON, ';
         STMT2 := STMT2 || 'COD_PLAN, ';
         STMT2 := STMT2 || 'COD_CICL, ';
         STMT2 := STMT2 || 'COD_CICLFACT, ';
         STMT2 := STMT2 || 'COD_AREAC, ';
         STMT2 := STMT2 || 'COD_ALMC, ';
         STMT2 := STMT2 || 'COD_LIMITE, ';
         STMT2 := STMT2 || 'IND_APLICA, ';
         STMT2 := STMT2 || 'COD_BOLSA, ';
         STMT2 := STMT2 || 'IND_APLB, ';
         STMT2 := STMT2 || 'COD_OPERA, ';
         STMT2 := STMT2 || 'COD_TOPRA, ';
         STMT2 := STMT2 || 'COD_DOPERA, ';
         STMT2 := STMT2 || 'COD_TRANA, ';
         STMT2 := STMT2 || 'COD_ALMA, ';
                STMT2 := STMT2 || 'COD_AREAA, ';
                STMT2 := STMT2 || 'COD_LOCAA, ';
                STMT2 := STMT2 || 'COD_OPERB, ';
                STMT2 := STMT2 || 'COD_TOPRB, ';
                STMT2 := STMT2 || 'COD_DOPEB, ';
                STMT2 := STMT2 || 'COD_TRANB, ';
                STMT2 := STMT2 || 'COD_ALMB, ';
                STMT2 := STMT2 || 'COD_AREAB, ';
                STMT2 := STMT2 || 'COD_LOCAB, '; 
                STMT2 := STMT2 || 'COD_PAIS, ';
                STMT2 := STMT2 || 'COD_SUBFRANJA, ';
                STMT2 := STMT2 || 'IND_DCTO_MLIB, ';
                STMT2 := STMT2 || 'IND_MUESTRA_LLAM, ';
                STMT2 := STMT2 || 'DUR_REAL, ';
                STMT2 := STMT2 || 'NUM_PULSO, ';
                STMT2 := STMT2 || 'DUR_FACT, ';
                STMT2 := STMT2 || 'TIP_MONE, ';
                STMT2 := STMT2 || 'MTO_REAL, ';
                STMT2 := STMT2 || 'TIP_DCTO, ';
                STMT2 := STMT2 || 'COD_DCTO, ';
                STMT2 := STMT2 || 'ITM_DCTO, ';
                STMT2 := STMT2 || 'DUR_DCTO, ';
                STMT2 := STMT2 || 'MTO_FACT, ';
                STMT2 := STMT2 || 'MTO_DCTO, ';
                STMT2 := STMT2 || 'IND_EXEDENTE, ';
                STMT2 := STMT2 || 'COD_UMBRAL, ';
                STMT2 := STMT2 || 'DES_DESTINO, ';                                    
                STMT2 := STMT2 || 'DES_LLAMADA, ';
                STMT2 := STMT2 || 'COD_MARCA, ';
                STMT2 := STMT2 || 'IND_IMPRESION, ';                                
                STMT2 := STMT2 || 'VALOR_UNIDAD) VALUES ( ';                
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';                        
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';						
                stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';						
                stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';                                                                                                                                                                                                                                                                                                                        
                stmt2 := stmt2 || ' :a, ';
                stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
                stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';                        
                stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';                 
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';
				stmt2 := stmt2 || ' :a, ';                                                                                                                                                       						
                stmt2 := stmt2 || ' :a) ';           
                
				execute immediate stmt2 using
						reg_clientes(i).SEC_EMPA ,
						reg_clientes(i).SEC_CDR ,
						reg_clientes(i).RECORD_TYPE ,
						reg_clientes(i).A_SUSC_NUMBER ,
						reg_clientes(i).A_SUSC_MS_NUMBER ,
						reg_clientes(i).B_SUSC_NUMBER ,
						reg_clientes(i).B_SUSC_MS_NUMBER ,
						reg_clientes(i).A_CATEGORY ,                                                                                                                        
						reg_clientes(i).IND_BILLETE ,
						reg_clientes(i).DATE_START_CHARG ,
						reg_clientes(i).TIME_START_CHARG ,
						reg_clientes(i).CHARGABLE_DURAT ,
						reg_clientes(i).DATE_SEND_CHARG ,
						reg_clientes(i).TIME_SEND_CHARG ,
						reg_clientes(i).SEND_DURAT ,                                                                                                                                                                                                
						reg_clientes(i).COD_CCC ,                        
						reg_clientes(i).OUTGOING_ROUTE ,
						reg_clientes(i).INCOMING_ROUTE ,                        
						reg_clientes(i).INSI_CODE ,
						reg_clientes(i).COD_AGRL ,
						reg_clientes(i).COD_SENT ,
						reg_clientes(i).COD_LLAM ,
						reg_clientes(i).COD_TDIR ,                        
						reg_clientes(i).COD_TCOR ,						
                        reg_clientes(i).COD_THOR ,
						reg_clientes(i).COD_TDIA ,
						reg_clientes(i).COD_FCOB ,
						reg_clientes(i).IND_TABLA ,
						reg_clientes(i).COD_CARG ,
						reg_clientes(i).COD_CARR ,                        
						NVL(reg_clientes(i).COD_GRUPO,0) ,                        
						NVL(reg_clientes(i).NUM_CLIE,0) ,
						NVL(reg_clientes(i).NUM_ABON,0) ,						
                        reg_clientes(i).COD_PLAN ,
						reg_clientes(i).COD_CICL ,
						reg_clientes(i).COD_CICLFACT ,
						reg_clientes(i).COD_AREAC ,
						reg_clientes(i).COD_ALMC ,
						reg_clientes(i).COD_LIMITE ,
						reg_clientes(i).IND_APLICA ,
						reg_clientes(i).COD_BOLSA ,						
                        reg_clientes(i).IND_APLB ,
						reg_clientes(i).COD_OPERA ,
						reg_clientes(i).COD_TOPRA ,
						reg_clientes(i).COD_DOPERA ,
						reg_clientes(i).COD_TRANA ,
						reg_clientes(i).COD_ALMA ,
						reg_clientes(i).COD_AREAA ,
						reg_clientes(i).COD_LOCAA ,						
                        reg_clientes(i).COD_OPERB ,
						reg_clientes(i).COD_TOPRB ,
						reg_clientes(i).COD_DOPEB ,                                                
						reg_clientes(i).COD_TRANB ,
						reg_clientes(i).COD_ALMB ,
						reg_clientes(i).COD_AREAB ,
						reg_clientes(i).COD_LOCAB ,
						reg_clientes(i).COD_PAIS ,						
                        reg_clientes(i).COD_SUBFRANJA ,
						reg_clientes(i).IND_DCTO_MLIB ,
						reg_clientes(i).IND_MUESTRA_LLAM ,
						reg_clientes(i).DUR_REAL ,
						NVL(LN_num_pulso,0),
						reg_clientes(i).DUR_FACT ,						
                        reg_clientes(i).TIP_MONE ,
						reg_clientes(i).MTO_REAL ,
						reg_clientes(i).TIP_DCTO ,
						reg_clientes(i).COD_DCTO ,
						reg_clientes(i).ITM_DCTO ,
						reg_clientes(i).DUR_DCTO ,
						reg_clientes(i).MTO_FACT ,						
                        reg_clientes(i).MTO_DCTO ,
						reg_clientes(i).IND_EXEDENTE ,
						reg_clientes(i).COD_UMBRAL ,
						reg_clientes(i).DES_DESTINO ,
						reg_clientes(i).DES_LLAMADA,
						NVL(LV_cod_marca, ' '),
          	            NVL(LV_ind_impresion, ' '),
                        NVL(LN_valor_unidad, 0);
	          a:=a+1;
	          IF a=1000 Then
	             commit;
	             a:=0;
	          END IF;
     EXCEPTION
          	WHEN OTHERS  THEN
							RETURN SQLCODE;
     END;
   	END LOOP;

  COMMIT;
 END LOOP;
RETURN 0;

EXCEPTION
  	WHEN OTHERS  THEN
			RETURN SQLCODE;
END FA_LOADTRAFICO_FN;


END FA_LOADTRAFICO_PG;
/
SHOW ERRORS