CREATE OR REPLACE PROCEDURE pv_rstrccn_valida_vendedor_Pr (
          v_param_entrada IN  VARCHAR2,
          bRESULTADO      OUT VARCHAR2,
          vMENSAJE        OUT GA_TRANSACABO.DES_CADENA%TYPE
) IS

         cv_error_no_clasif       CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
         TYPE refCursor IS REF CURSOR;
         string                   GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');

         LN_cod_vendedor          ve_vendedores.cod_vendedor%TYPE;
         LO_pv_comis_ooss         PV_COMIS_OOSS_QT := NEW PV_COMIS_OOSS_QT;
         LC_CURSOR                refCursor;
         LN_cod_retorno           ge_errores_td.cod_msgerror%TYPE;
         LV_mens_retorno          ge_errores_td.det_msgerror%TYPE;
         LN_num_evento            ge_errores_pg.evento;

         programa                 VARCHAR2(10);
         error_apl_vb             EXCEPTION;

         V_des_error              Ge_Errores_Pg.DesEvent;
         sSql                     Ge_Errores_Pg.vQuery;
         SN_cod_retorno           Ge_Errores_Pg.CodError := 0;
         SV_mens_retorno          Ge_Errores_Pg.MsgError := '';
         SN_num_evento            Ge_Errores_Pg.Evento   := 0;
         LV_NUM_PIN               VE_VENDEDORES.NUM_PIN%TYPE;

BEGIN
         bRESULTADO := 'FALSE';


		 sSql:= 'SELECT upper(substr(program,length(program)-3,4))'
              ||  ' FROM v$session'
              ||  ' WHERE audsid = '||USERENV('SESSIONID')
              ||  ' AND username = '||USER;

         SELECT upper(substr(program,length(program)-3,4))
           INTO programa
           FROM v$session
          WHERE audsid = USERENV('SESSIONID')
            AND username = USER;

                 IF programa = '.EXE' THEN
                    RAISE error_apl_vb;
                 END IF;

         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(v_param_entrada, string);

         LN_cod_vendedor := TO_NUMBER(string(10));

         LO_pv_comis_ooss.cod_vendedor := LN_cod_vendedor;
         LO_pv_comis_ooss.IND_INTERNO :=1; --INTERNO
         
         
         BEGIN
           
            SELECT NUM_PIN
            INTO LV_NUM_PIN FROM VE_VENDEDORES
            WHERE COD_VENDEDOR =LN_cod_vendedor;

            IF TRIM(LV_NUM_PIN) <>'1' THEN
               LO_pv_comis_ooss.IND_INTERNO:=0; --EXTERNO
            END IF;

         
         EXCEPTION  WHEN NO_DATA_FOUND THEN
	    LO_pv_comis_ooss.IND_INTERNO:=0; --EXTERNO
         END;

         Pv_Comis_Ooss_Pg.PV_OBTIENE_DATOS_VENDEDOR_PR(LO_PV_COMIS_OOSS, LC_CURSOR, LN_cod_retorno, LV_mens_retorno, LN_num_evento );

         IF LN_cod_retorno = 0 THEN
                bRESULTADO := 'TRUE';
         ELSE
                vMENSAJE := SUBSTR('N° evento:' || LN_num_evento || '. ' || LV_mens_retorno,1,255);
         END IF;

        EXCEPTION
	     WHEN NO_DATA_FOUND THEN
             
             SN_cod_retorno := '302'; -- Nuevo Error
             IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
             END IF;
             
             V_des_error := 'NO_DATA_FOUND: ppv_rstrccn_valida_vendedor_Pr('||v_param_entrada||'); - ' || SQLERRM;
             SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'VE', SN_cod_retorno||' -- '||SV_mens_retorno, '1.0', USER, 'pv_rstrccn_valida_vendedor_Pr', sSql, SQLCODE, V_des_error );
             vMENSAJE := SUBSTR('Error en pv_rstrccn_valida_vendedor_Pr: -'||SN_num_evento||'--' || SQLERRM, 1, 255);

         WHEN error_apl_vb THEN
            bRESULTADO := 'TRUE';
         WHEN OTHERS THEN
            vMENSAJE := SUBSTR('Error en pv_rstrccn_valida_vendedor_Pr: ' || SQLERRM, 1, 255);
END;
/
SHOW ERRORS
