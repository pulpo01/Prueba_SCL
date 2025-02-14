CREATE OR REPLACE FUNCTION GE_FN_VALIDA_IDENTCLIE_TMM
 (v_num_ident IN VARCHAR2
 ,v_tip_ident IN VARCHAR2
 )
 RETURN VARCHAR2
 IS

CV_codmodulo           GED_PARAMETROS.COD_MODULO%TYPE:='GA';
CV_parametroCDINT      GED_PARAMETROS.NOM_PARAMETRO%TYPE:='LARGO_CEDIDENT';
CV_parametroCDJURID    GED_PARAMETROS.NOM_PARAMETRO%TYPE:='LARGO_CEDJURID';
CV_parametroCDRESIDENT GED_PARAMETROS.NOM_PARAMETRO%TYPE:='LARGO_CEDRESIDNT';
CV_parametroPASAPORT   GED_PARAMETROS.NOM_PARAMETRO%TYPE:='LARGO_PASAPORTE';
CV_parametroOTROS   GED_PARAMETROS.NOM_PARAMETRO%TYPE:='LARGO_OTROS';




LV_LargoIdent    GED_PARAMETROS.VAL_PARAMETRO%TYPE;
LV_RESULTADO     VARCHAR2(5);
LV_NUMERIC       VARCHAR2(100);

BEGIN
      --PL que realiza Validacion del Número de identificacion 

  IF V_TIP_IDENT  = '01' THEN  --CEDULA DE IDENTIDAD
       
          SELECT VAL_PARAMETRO
          INTO LV_LargoIdent
          FROM GED_PARAMETROS
          WHERE NOM_PARAMETRO=CV_parametroCDINT
          AND COD_MODULO = CV_codmodulo;

      If Length (v_num_ident) <> LV_LargoIdent Then
         RETURN  'FALSE';
      End If;
    
      select LENGTH(TRIM(TRANSLATE (v_num_ident, ' +-.0123456789',' '))) 
      INTO LV_NUMERIC
      from dual;
      
      IF LV_NUMERIC IS NULL THEN
          LV_RESULTADO  := 'TRUE';
      else
          RETURN  'FALSE';
      End if; 

    End If;
 
 If V_TIP_IDENT = '02' Then  --Cedula juridica
  SELECT VAL_PARAMETRO
  INTO LV_LargoIdent
  FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO= CV_parametroCDJURID
  AND COD_MODULO = CV_codmodulo;

     If Length (v_num_ident) <> LV_LargoIdent Then
       RETURN 'FALSE';
       
    End If;
    
     select LENGTH(TRIM(TRANSLATE (v_num_ident, ' +-.0123456789',' '))) 
      INTO LV_NUMERIC
      from dual;
      
      IF LV_NUMERIC IS NULL THEN
          LV_RESULTADO  := 'TRUE';
      else
         RETURN 'FALSE';
      End if; 
 End If;
 
 If V_TIP_IDENT = '03' Then  --Cedula residencia
  SELECT VAL_PARAMETRO
  INTO LV_LargoIdent
  FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO= CV_parametroCDRESIDENT
  AND COD_MODULO = CV_codmodulo;
  
    If Length((v_num_ident)) > LV_LargoIdent Or Length((v_num_ident)) = 0 Then
       RETURN 'FALSE';
    End If;
 End If;
 
 
 If V_TIP_IDENT = '04' Then -- pasaporte
  SELECT VAL_PARAMETRO
  INTO LV_LargoIdent
  FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO= CV_parametroPASAPORT
  AND COD_MODULO = CV_codmodulo;
  
    If Length((v_num_ident)) > LV_LargoIdent Or Length((v_num_ident)) = 0 Then
       RETURN 'FALSE';
    End If;
 End If;
 

 If V_TIP_IDENT = '05' Then -- otros
 SELECT VAL_PARAMETRO
  INTO LV_LargoIdent
  FROM GED_PARAMETROS
  WHERE NOM_PARAMETRO= CV_parametroOTROS
  AND COD_MODULO = CV_codmodulo;
  
    If Length((v_num_ident)) > LV_LargoIdent Or Length((v_num_ident)) = 0 Then
       RETURN 'FALSE';
    End If;
 End If ;
       
  RETURN 'TRUE';
END; 
/

