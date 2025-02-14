CREATE OR REPLACE PACKAGE BODY pv_nro_piloto_pg
IS

  PROCEDURE pv_borra_nropiloto_pr(SN_num_piloto      IN  ga_nro_piloto_rango_to.num_piloto%TYPE,
                                  SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
       /* <Documentación
           TipoDoc = "Procedure">
            <Elemento
               Nombre = "pv_borra_nropiloto_pr"
               Lenguaje="PL/SQL"
               Fecha creación="14-07-2010"
               Creado por="Vladimir Maureira "
               Fecha modificacion=""
               Modificado por=""
               Ambiente Desarrollo="BD">
               <Retorno>null</Retorno>
               <Descripción>Prestacion E1 - Borra abonados segun su numero Piloto</Descripción>
               <Parámetros>
                  <Entrada>
                     <param nom="SN_num_piloto"     Tipo="NUMERICO">numero piloto abonado prestacion E1</param>
                  </Entrada>
                  <Salida>
                     <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                     <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                     <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                  </Salida>
               </Parámetros>
            </Elemento>
         </Documentación>
         */
   IS
     E_EXCEPTION   Exception;
     p_num_celular ga_abocel.num_celular%TYPE;
     
    CURSOR C_NRO_PILOTO IS
    SELECT  RANGOS.NUM_DESDE,RANGOS.NUM_HASTA
      FROM  GA_NRO_PILOTO_RANGO_TO NRO,GA_ABOCEL ABO,GA_RANGOS_FIJOS_TO RANGOS
     WHERE  ABO.NUM_CELULAR  = SN_num_piloto
       AND RANGOS.NUM_DESDE  = SN_num_desde
       AND  ABO.NUM_CELULAR  = NRO.NUM_PILOTO
       AND  RANGOS.NUM_DESDE = NRO.NUM_DESDE;
   
        TYPE ARR_NUM_DESDE IS TABLE OF GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE;
        TYPE ARR_NUM_HASTA IS TABLE OF GA_RANGOS_FIJOS_TO.NUM_HASTA%TYPE;
        cNUM_DESDE  ARR_NUM_DESDE; 
        cNUM_HASTA  ARR_NUM_HASTA;
   BEGIN
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
   

         -- DELETE ABONADOS CON E1

        OPEN C_NRO_PILOTO;
        LOOP
        FETCH C_NRO_PILOTO BULK COLLECT INTO cNUM_DESDE,
                                             cNUM_HASTA
                                             LIMIT 5000;

        FORALL I IN 1 .. cNUM_DESDE.COUNT
            DELETE FA_CICLOCLI GA
            WHERE GA.NUM_ABONADO IN (SELECT  ABO.NUM_ABONADO FROM  GA_ABOCEL ABO
                                     WHERE   ABO.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I));
                                
        FORALL I IN 1 .. cNUM_DESDE.COUNT
         DELETE GA_LIMITE_CLIABO_TO GA
         WHERE GA.NUM_ABONADO IN (SELECT  ABO.NUM_ABONADO FROM  GA_ABOCEL ABO
                                     WHERE   ABO.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I));
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
         DELETE GA_INTARCEL_ACCIONES_TO GA
         WHERE GA.NUM_ABONADO IN (SELECT  ABO.NUM_ABONADO FROM  GA_ABOCEL ABO
                                     WHERE   ABO.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I));

        FORALL I IN 1 .. cNUM_DESDE.COUNT
         DELETE GA_ABOCEL GA
         WHERE GA.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
          DELETE  GA_INFACCEL GA 
          WHERE GA.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
          DELETE GA_INTARCEL GA
          WHERE GA.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
          DELETE GA_SERVSUPLABO GA
          WHERE GA.NUM_ABONADO > 0 AND  
                GA.NUM_TERMINAL BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
           DELETE ga_celnum_subalm
           where num_desde >= cNUM_DESDE(I) and num_hasta <=cNUM_HASTA(I);
        
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           DELETE ga_celnum_min_td
           where num_desde >= cNUM_DESDE(I) and num_hasta <=cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           DELETE ga_celnum_central
           where num_desde >= cNUM_DESDE(I) and num_hasta <=cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           DELETE ga_celnum_cat
           where num_desde >= cNUM_DESDE(I) and num_hasta <=cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           DELETE ga_celnum_uso
           where num_desde >= cNUM_DESDE(I) and num_hasta <=cNUM_HASTA(I);

         EXIT WHEN C_NRO_PILOTO%NOTFOUND;
        END LOOP;
        CLOSE C_NRO_PILOTO; 
        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'pv_borra_nropiloto_pr('||SN_num_piloto||','||SN_num_desde||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_borra_nropiloto_pr', sSql, SN_cod_retorno, V_des_error );
   END;
    
   PROCEDURE pv_baja_nropiloto_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                  SV_cod_causa       IN  ga_abocel.cod_causabaja%TYPE,
                                  SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
       /* <Documentación
           TipoDoc = "Procedure">
            <Elemento
               Nombre = "pv_baja_nropiloto_pr"
               Lenguaje="PL/SQL"
               Fecha creación="14-07-2010"
               Creado por="Vladimir Maureira "
               Fecha modificacion=""
               Modificado por=""
               Ambiente Desarrollo="BD">
               <Retorno>null</Retorno>
               <Descripción>Prestacion E1 - Baja abonados segun su numero Piloto</Descripción>
               <Parámetros>
                  <Entrada>
                     <param nom="SN_num_abonado"    Tipo="NUMERICO">numero abonado prestacion E1</param>
                     <param nom="SV_cod_causa"      Tipo="CARACTER">causa baja</param>
                  </Entrada>
                  <Salida>
                     <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                     <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                     <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                  </Salida>
               </Parámetros>
            </Elemento>
         </Documentación>
         */
   IS
     E_EXCEPTION   Exception;
     p_num_celular ga_abocel.num_celular%TYPE;
     
    CURSOR C_NRO_PILOTO IS
    SELECT  RANGOS.NUM_DESDE,RANGOS.NUM_HASTA
      FROM  GA_NRO_PILOTO_RANGO_TO NRO,GA_ABOCEL ABO,GA_RANGOS_FIJOS_TO RANGOS
     WHERE  ABO.NUM_ABONADO  = SN_num_abonado
       AND  RANGOS.NUM_DESDE = SN_num_desde
       AND  ABO.NUM_CELULAR  = NRO.NUM_PILOTO
       AND  RANGOS.NUM_DESDE = NRO.NUM_DESDE;
   
        TYPE ARR_NUM_DESDE IS TABLE OF GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE;
        TYPE ARR_NUM_HASTA IS TABLE OF GA_RANGOS_FIJOS_TO.NUM_HASTA%TYPE;
        cNUM_DESDE  ARR_NUM_DESDE; 
        cNUM_HASTA  ARR_NUM_HASTA;
   BEGIN
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
   
      BEGIN
        SELECT  abo.num_celular
          INTO  p_num_celular   
          FROM  GA_ABOCEL ABO
        WHERE   ABO.num_abonado  = SN_num_abonado
          AND   ABO.cod_prestacion = '06';
  
        EXCEPTION
            WHEN OTHERS THEN
                p_num_celular:= NULL;
      END;
      
      IF p_num_celular IS NOT NULL THEN

         -- UPDATE ABONADOS CON E1

        OPEN C_NRO_PILOTO;
        LOOP
        FETCH C_NRO_PILOTO BULK COLLECT INTO cNUM_DESDE,
                                             cNUM_HASTA
                                             LIMIT 5000;
                                
          FORALL I IN 1 .. cNUM_DESDE.COUNT
         UPDATE GA_ABOCEL GA
          SET   GA.COD_SITUACION= 'BAA',
                GA.FEC_BAJA     = SYSDATE,
                GA.FEC_ULTMOD   = SYSDATE,
                GA.COD_CAUSABAJA= SV_cod_causa
         WHERE GA.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);
        /*
        FORALL I IN 1 .. cNUM_DESDE.COUNT
          UPDATE  GA_INFACCEL GA SET
                GA.FEC_BAJA = SYSDATE
          WHERE GA.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
          UPDATE GA_INTARCEL GA SET
                GA.FEC_HASTA = SYSDATE 
          WHERE GA.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
          UPDATE GA_SERVSUPLABO GA SET
                 GA.FEC_BAJABD  = SYSDATE
                ,GA.FEC_BAJACEN = SYSDATE
                ,GA.IND_ESTADO  = 3
          WHERE GA.NUM_TERMINAL BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I);

        FORALL I IN 1 .. cNUM_DESDE.COUNT
            UPDATE GA_LIMITE_CLIABO_TO GA SET
                GA.FEC_HASTA = SYSDATE
            WHERE GA.NUM_ABONADO IN (SELECT  ABO.NUM_ABONADO FROM  GA_ABOCEL ABO
                                     WHERE   ABO.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I));
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
            UPDATE GA_INTARCEL_ACCIONES_TO GA SET
                GA.COD_ACTABO = 'BA'
            WHERE GA.NUM_ABONADO IN (SELECT  ABO.NUM_ABONADO FROM  GA_ABOCEL ABO
                                     WHERE   ABO.NUM_CELULAR BETWEEN cNUM_DESDE(I) AND cNUM_HASTA(I));
        */
         EXIT WHEN C_NRO_PILOTO%NOTFOUND; 
        END LOOP;
        CLOSE C_NRO_PILOTO; 
        
         --ELIMINAR ABONADOS E1
         /*UPDATE GA_RANGOS_FIJOS_TO GA
         SET GA.ESTADO=1
         WHERE GA.NUM_DESDE IN (SELECT NRO.NUM_DESDE
                                FROM GA_NRO_PILOTO_RANGO_TO NRO
                                WHERE NRO.NUM_PILOTO = p_num_celular);
         
         DELETE FROM GA_NRO_PILOTO_RANGO_TO
         WHERE NUM_PILOTO= p_num_celular;*/

      END IF;  
        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'pv_baja_nropiloto_pr('||SN_num_abonado||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_baja_nropiloto_pr', sSql, SN_cod_retorno, V_des_error );
    END;   


   PROCEDURE pv_enlace_vpn_rango_pr(SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                    SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                    SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
       /* <Documentación
           TipoDoc = "Procedure">
            <Elemento
               Nombre = "pv_enlace_vpn_pr"
               Lenguaje="PL/SQL"
               Fecha creación="14-07-2010"
               Creado por="Vladimir Maureira "
               Fecha modificacion=""
               Modificado por=""
               Ambiente Desarrollo="BD">
               <Retorno>null</Retorno>
               <Descripción>Prestacion E1 - Inserta abonados segun su numero Piloto</Descripción>
               <Parámetros>
                  <Entrada>
                     <param nom="SN_num_piloto"    Tipo="NUMERICO">numero piloto abonado prestacion E1</param>
                  </Entrada>
                  <Salida>
                     <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                     <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                     <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                  </Salida>
               </Parámetros>
            </Elemento>
         </Documentación>
         */
   IS
     E_EXCEPTION       Exception;
     E_NO_DATA_FOUND   Exception;
     p_num_abonado ga_abocel.num_abonado%TYPE;
     LV_operacion GA_NRO_PILOTO_ABO_TO.OPERACION%TYPE;
     LN_num_desde GA_NRO_PILOTO_ABO_TO.NUM_DESDE%TYPE;
     LV_nom_usuarora GA_NRO_PILOTO_ABO_TO.NOM_USUARORA%TYPE;
     LV_estado GA_NRO_PILOTO_ABO_TO.ESTADO%TYPE;
     LN_num_celularabo GA_NRO_PILOTO_ABO_TO.NUM_PILOTO%TYPE;
     LN_contador NUMBER(9);
     
    CURSOR C_NRO_PILOTO IS
     SELECT ra.NUM_PILOTO,ra.NUM_DESDE,ra.NOM_USUARORA,ra.ESTADO,ra.ULTIMO_CREADO,ra.OPERACION,ra.NUM_VENTA
      FROM GA_NRO_PILOTO_ABO_TO ra
      WHERE ra.ESTADO NOT IN('TERMINADO','ERRONEO') AND ra.NUM_VENTA IS NULL ORDER BY ra.FECHA_REGISTRO ASC; --REVISAR

        cAbo C_NRO_PILOTO%RowType;     
   BEGIN
        SN_cod_retorno := 0;
        SV_mens_retorno:= '';
        SN_num_evento  := 0;
        LN_contador    := 0;
        LV_estado      := '';
        
        OPEN C_NRO_PILOTO;
        LOOP 
    FETCH C_NRO_PILOTO INTO cAbo;
      EXIT WHEN C_NRO_PILOTO%NOTFOUND; 
    
         LN_num_celularabo := cAbo.NUM_PILOTO;
         LV_operacion   := cAbo.OPERACION;
         LN_num_desde   := cAbo.NUM_DESDE;
         LV_nom_usuarora:= cAbo.NOM_USUARORA;
         LN_contador    := LN_contador +1;
         LV_estado      := 'TERMINADO';
         
          BEGIN
            SELECT abo.num_abonado INTO  p_num_abonado FROM  GA_ABOCEL ABO
             WHERE ABO.NUM_CELULAR  = LN_num_celularabo AND  ABO.cod_prestacion = '06' --SN_num_piloto
             AND ABO.cod_situacion NOT IN ('BAA','BAP');--revisar CPP etc 
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  raise E_NO_DATA_FOUND;
          END;
           
          --dbms_output.PUT_LINE('--------LV_operacion   '||LV_operacion||'  ---LN_contador '||LN_contador);
          if LV_operacion = 'CREAR' then --num_piloto
             pv_abocel_pr(p_num_abonado,LN_num_desde,SN_cod_retorno,SV_mens_retorno,SN_num_evento);--, LN_num_celularabo
             V_des_error := 'pv_abocel_pr(' || p_num_abonado;

             if SN_cod_retorno = 0 then 
               pv_servsuplabo_pr(p_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_servsuplabo_pr(' || p_num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_infaccel_pr(p_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_infaccel_pr(' || p_num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_intarcel_pr(p_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_intarcel_pr(' || p_num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_intarcel_acciones_pr(p_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_intarcel_acciones_pr(' || p_num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_limite_cliabo_pr(p_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_limite_cliabo_pr(' || p_num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_rangos_numericos_pr(p_num_abonado,LN_num_desde,SN_cod_retorno,SV_mens_retorno,SN_num_evento); 
               V_des_error := 'pv_rangos_numericos_pr(' || p_num_abonado;
             end if;
             if SN_cod_retorno = 0 then 
               pv_ciclocli_pr(p_num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento); 
               V_des_error := 'pv_ciclocli_pr(' || p_num_abonado;
             end if;       
          end if;
          
          if LV_operacion = 'ELIMINAR' then
            --dbms_output.PUT_LINE('--Dando de baja abonados--'); 
            --pv_baja_nropiloto_pr(p_num_abonado,'46',LN_num_desde,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
            pv_borra_nropiloto_pr(LN_num_celularabo ,LN_num_desde,SN_cod_retorno,SV_mens_retorno,SN_num_evento);                                                
          end if;
         
          if  SN_cod_retorno <> 0 then
             LV_estado      := 'ERRONEO';
             SN_cod_retorno :=0;   
             --RAISE E_EXCEPTION;
          end if;           
          
          UPDATE GA_NRO_PILOTO_ABO_TO ra SET ra.ESTADO = LV_estado
           WHERE ra.NUM_PILOTO   = LN_num_celularabo AND ra.NUM_DESDE = LN_num_desde
             AND ra.NOM_USUARORA = LV_nom_usuarora   AND ra.OPERACION = LV_operacion;          

        END LOOP;

        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'pv_enlace_vpn_rango_pr(); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_enlace_vpn_rango_pr', sSql, SN_cod_retorno, V_des_error );
    END; 

    PROCEDURE pv_numero_piloto_pr(SN_num_venta     IN  ga_abocel.num_venta%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
   
     CURSOR C_NRO_PILOTO IS
        SELECT abo.num_abonado 
        FROM ga_abocel abo
        WHERE abo.num_venta = SN_num_venta
          AND abo.cod_prestacion = '06';
     cnro_piloto C_NRO_PILOTO%RowType;
     
     E_EXCEPTION  Exception;
    BEGIN
       /* <Documentación
           TipoDoc = "Procedure">
            <Elemento
               Nombre = "pv_numero_piloto_pr"
               Lenguaje="PL/SQL"
               Fecha creación="26-05-2010"
               Creado por="Vladimir Maureira "
               Fecha modificacion=""
               Modificado por=""
               Ambiente Desarrollo="BD">
               <Retorno>null</Retorno>
               <Descripción>Prestacion E1 - Inserta abonados segun su numero Piloto</Descripción>
               <Parámetros>
                  <Entrada>
                     <param nom="SN_num_venta"    Tipo="NUMERICO">numero venta prestacion E1</param>
                  </Entrada>
                  <Salida>
                     <param nom="SN_cod_retorno"    Tipo="NUMERICO">Codigo de Retorno</param>
                     <param nom="SV_mens_retorno"   Tipo="CARACTER">Mensaje de Retorno</param>
                     <param nom="SN_num_evento"     Tipo="NUMERICO">Numero de Evento</param>
                  </Salida>
               </Parámetros>
            </Elemento>
         </Documentación>
         */

        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        SN_num_evento :=0;
        
        OPEN C_NRO_PILOTO;
        LOOP 
    FETCH C_NRO_PILOTO INTO cnro_piloto;
      EXIT WHEN C_NRO_PILOTO%NOTFOUND; 
    
             --pv_abocel_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
             V_des_error := 'pv_abocel_pr(' || cnro_piloto.num_abonado;
             
             if SN_cod_retorno = 0 then 
               pv_servsuplabo_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_servsuplabo_pr(' || cnro_piloto.num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_infaccel_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_infaccel_pr(' || cnro_piloto.num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_intarcel_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_intarcel_pr(' || cnro_piloto.num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_intarcel_acciones_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_intarcel_acciones_pr(' || cnro_piloto.num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
               pv_limite_cliabo_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento);
               V_des_error := 'pv_limite_cliabo_pr(' || cnro_piloto.num_abonado;
             end if;  
             if SN_cod_retorno = 0 then 
              -- pv_rangos_numericos_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento); 
               V_des_error := 'pv_rangos_numericos_pr(' || cnro_piloto.num_abonado;
             end if;
             if SN_cod_retorno = 0 then 
               pv_ciclocli_pr(cnro_piloto.num_abonado,SN_cod_retorno,SV_mens_retorno,SN_num_evento); 
               V_des_error := 'pv_ciclocli_pr(' || cnro_piloto.num_abonado;
             end if;
             
             if  SN_cod_retorno <> 0 then 
                 RAISE E_EXCEPTION;
             end if;    
        END LOOP;
        
        EXCEPTION
            WHEN E_EXCEPTION THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_numero_piloto_pr('||SN_num_venta||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_numero_piloto_pr', sSql, SN_cod_retorno, V_des_error );
  
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_numero_piloto_pr('||SN_num_venta||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_numero_piloto_pr', sSql, SN_cod_retorno, V_des_error );
    END;
   
    PROCEDURE pv_rangos_numericos_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                     SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                                     SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                     SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                     SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS

    CURSOR C_NRO_PILOTO IS
    SELECT  RANGOS.NUM_DESDE,RANGOS.NUM_HASTA
      FROM  GA_NRO_PILOTO_RANGO_TO NRO,GA_ABOCEL ABO,GA_RANGOS_FIJOS_TO RANGOS
     WHERE  ABO.NUM_ABONADO  = SN_num_abonado
       AND  RANGOS.NUM_DESDE = SN_num_desde
       AND  ABO.NUM_CELULAR  = NRO.NUM_PILOTO
       AND  RANGOS.NUM_DESDE = NRO.NUM_DESDE;
   
        TYPE ARR_NUM_DESDE IS TABLE OF GA_RANGOS_FIJOS_TO.NUM_DESDE%TYPE;
        TYPE ARR_NUM_HASTA IS TABLE OF GA_RANGOS_FIJOS_TO.NUM_HASTA%TYPE;
        cNUM_DESDE  ARR_NUM_DESDE; 
        cNUM_HASTA  ARR_NUM_HASTA;
        p_cod_subalm ge_subalms.cod_subalm%type; 
 
    BEGIN
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
   
        SELECT COD_SUBALM INTO p_cod_subalm FROM GE_SUBALMS;
 
         
        OPEN C_NRO_PILOTO;
        LOOP
        FETCH C_NRO_PILOTO BULK COLLECT INTO cNUM_DESDE,
                                             cNUM_HASTA
                                             LIMIT 5000;
                                
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           INSERT INTO ga_celnum_subalm
           select tm.num_celular,tm.num_celular,p_cod_subalm,'502','502',0,0,0
           from ga_abocel tm
           where num_celular between cNUM_DESDE(I) and cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
            INSERT INTO ga_celnum_min_td
           select tm.num_celular,tm.num_celular,NULL,NULL,tm.num_celular,tm.num_celular,'S',sysdate,sysdate,USER
           from ga_abocel tm
           where num_celular between cNUM_DESDE(I) and cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           INSERT INTO ga_celnum_central
           select tm.num_celular,tm.num_celular,p_cod_subalm,1,tm.cod_central,1
           from ga_abocel tm
           where num_celular between cNUM_DESDE(I) and cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           INSERT INTO ga_celnum_cat
           select tm.num_celular,tm.num_celular,p_cod_subalm,1,tm.cod_central,1
           from ga_abocel tm
           where num_celular between cNUM_DESDE(I) and cNUM_HASTA(I);
    
        FORALL I IN 1 .. cNUM_DESDE.COUNT
           INSERT INTO ga_celnum_uso
           select tm.num_celular,tm.num_celular,p_cod_subalm,1,tm.cod_central,1,tm.cod_uso,0,tm.num_celular,0
           from ga_abocel tm
           where num_celular between cNUM_DESDE(I) and cNUM_HASTA(I);

        EXIT WHEN C_NRO_PILOTO%NOTFOUND;

        END LOOP;
        CLOSE C_NRO_PILOTO;
        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'pv_rangos_numericos_pr('||SN_num_abonado||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_rangos_numericos_pr', sSql, SN_cod_retorno, V_des_error );
    END;   
    
    PROCEDURE pv_abocel_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                           --SN_num_piloto      IN  ga_nro_piloto_rango_to.num_piloto%TYPE,
                           SN_num_desde       IN  ga_rangos_fijos_to.num_desde%TYPE,
                           SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                           SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                           SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR C_NRO_PILOTO IS
    SELECT  abo.cod_producto,
            abo.cod_cliente,
            abo.cod_cuenta,
            abo.cod_subcuenta,
            abo.cod_usuario,
            abo.cod_region,
            abo.cod_provincia,
            abo.cod_ciudad,
            abo.cod_celda,
            abo.cod_central,
            abo.cod_uso,
            abo.cod_situacion,
            abo.ind_procalta,
            abo.ind_procequi,
            abo.cod_vendedor,
            abo.cod_vendedor_agente,
            abo.tip_plantarif,
            abo.tip_terminal,
            abo.cod_plantarif,
            abo.cod_cargobasico,
            abo.cod_planserv,
            abo.cod_limconsumo,
            abo.num_serie,
            abo.num_seriehex,
            abo.nom_usuarora,
            abo.fec_alta,
            abo.num_percontrato,
            abo.cod_estado,
            abo.cod_empresa,
            abo.cod_grpserv,
            abo.ind_supertel,
            abo.num_telefija,
            abo.cod_opredfija,
            abo.cod_carrier,
            abo.ind_prepago,
            abo.ind_plexsys,
            abo.num_venta,
            abo.cod_modventa,
            abo.cod_tipcontrato,
            abo.num_contrato,
            abo.num_anexo,
            abo.fec_cumplan,
            abo.cod_credmor,
            abo.cod_credcon,
            abo.cod_ciclo,
            abo.ind_factur,
            abo.ind_suspen,
            abo.ind_rehabi,
            abo.ind_insguias,
            abo.fec_fincontra,
            abo.fec_recdocum,
            abo.fec_cumplimen,
            abo.fec_acepventa,
            abo.fec_actcen,
            abo.fec_baja,
            abo.fec_bajacen,
            abo.fec_ultmod,
            abo.cod_causabaja,
            abo.ind_seguro,
            abo.clase_servicio,
            abo.perfil_abonado,
            abo.num_min,
            abo.cod_vendealer,
            abo.ind_disp,
            abo.cod_password,
            abo.ind_password,
            abo.cod_afinidad,
            abo.fec_prorroga,
            abo.ind_eqprestado,
            abo.flg_contdigi,
            abo.fec_altantras,
            abo.cod_indemnizacion,
            abo.num_imei,
            abo.cod_tecnologia,
            abo.fec_activacion,
            abo.ind_telefono,
            abo.cod_oficina_principal,
            abo.cod_prestacion,
            abo.mto_valor_referencia,
            abo.cod_moneda,
            abo.tipo_primariacarrier,
            abo.obs_instancia,
            abo.cod_causa_venta,
            abo.cod_operacion,
            rangos.num_desde,
            rangos.num_hasta
    FROM    GA_NRO_PILOTO_RANGO_TO NRO,GA_ABOCEL ABO,GA_RANGOS_FIJOS_TO RANGOS
    WHERE   ABO.NUM_ABONADO  = SN_num_abonado
        AND NRO.NUM_DESDE    = SN_num_desde
        AND ABO.NUM_CELULAR  = NRO.NUM_PILOTO
        AND RANGOS.NUM_DESDE = NRO.NUM_DESDE;

        cAbo C_NRO_PILOTO%RowType;
 
    BEGIN
        SN_cod_retorno:=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
        LN_record.delete;
        OPEN C_NRO_PILOTO;
        LOOP 
    FETCH C_NRO_PILOTO INTO cAbo;
      EXIT WHEN C_NRO_PILOTO%NOTFOUND; 
    
          FOR LN_numero IN cAbo.NUM_DESDE .. cAbo.NUM_HASTA
          LOOP
                  SELECT GA_SEQ_NUMABO.NEXTVAL INTO LN_num_abonado FROM DUAL; --Nuevo abonado E1
                  LN_num_celular := LN_numero;
                  LN_record(LN_indice).num_abonado_seq := ln_num_abonado;
                  LN_record(LN_indice).num_celular     := ln_num_celular;
                  LN_indice := LN_indice + 1;
              
                   INSERT  /*+ append */ INTO GA_ABOCEL
                (num_abonado,cod_producto,cod_cliente,cod_cuenta,
                         cod_subcuenta,cod_usuario,cod_region,cod_provincia,
                         cod_ciudad,cod_celda,cod_central,cod_uso,
                         cod_situacion,ind_procalta,ind_procequi,cod_vendedor,
                         cod_vendedor_agente,tip_plantarif,tip_terminal,cod_plantarif,
                         cod_cargobasico,cod_planserv,cod_limconsumo,num_serie,
                         num_seriehex,nom_usuarora,fec_alta,num_percontrato,
                         cod_estado,cod_empresa,cod_grpserv,ind_supertel,
                         num_telefija,cod_opredfija,cod_carrier,ind_prepago,
                         ind_plexsys,num_venta,cod_modventa,cod_tipcontrato,
                         num_contrato,num_anexo,fec_cumplan,cod_credmor,
                         cod_credcon,cod_ciclo,ind_factur,ind_suspen,
                         ind_rehabi,ind_insguias,fec_fincontra,fec_recdocum,
                         fec_cumplimen,fec_acepventa,fec_actcen,fec_baja,
                         fec_bajacen,fec_ultmod,cod_causabaja,ind_seguro,
                         clase_servicio,perfil_abonado,num_min,cod_vendealer,
                         ind_disp,cod_password,ind_password,cod_afinidad,
                         fec_prorroga,ind_eqprestado,flg_contdigi,fec_altantras,
                         cod_indemnizacion,num_imei,cod_tecnologia,fec_activacion,
                         ind_telefono,cod_oficina_principal,cod_prestacion,mto_valor_referencia,
                         cod_moneda, tipo_primariacarrier,
                         obs_instancia,cod_causa_venta,cod_operacion,num_celular,num_min_mdn)
                VALUES ( ln_num_abonado,cAbo.cod_producto, cAbo.cod_cliente, cAbo.cod_cuenta,
                         cAbo.cod_subcuenta, cAbo.cod_usuario,cAbo.cod_region, cAbo.cod_provincia,
                         cAbo.cod_ciudad, cAbo.cod_celda,cAbo.cod_central, cAbo.cod_uso,
                         'AAA', cAbo.ind_procalta,cAbo.ind_procequi, cAbo.cod_vendedor,
                         cAbo.cod_vendedor_agente, cAbo.tip_plantarif, cAbo.tip_terminal, cAbo.cod_plantarif,
                         cAbo.cod_cargobasico, cAbo.cod_planserv,cAbo.cod_limconsumo, cAbo.num_serie,
                         cAbo.num_seriehex,cAbo.nom_usuarora,cAbo.fec_alta, cAbo.num_percontrato,
                         cAbo.cod_estado, cAbo.cod_empresa,cAbo.cod_grpserv, '7',
                         cAbo.num_telefija, cAbo.cod_opredfija,cAbo.cod_carrier, cAbo.ind_prepago,
                         cAbo.ind_plexsys, cAbo.num_venta,cAbo.cod_modventa,cAbo.cod_tipcontrato,
                         cAbo.num_contrato,cAbo.num_anexo,cAbo.fec_cumplan,cAbo.cod_credmor,
                         cAbo.cod_credcon,cAbo.cod_ciclo,cAbo.ind_factur,cAbo.ind_suspen,
                         cAbo.ind_rehabi,cAbo.ind_insguias,cAbo.fec_fincontra,cAbo.fec_recdocum,
                         cAbo.fec_cumplimen,cAbo.fec_acepventa,cAbo.fec_actcen,cAbo.fec_baja,
                         cAbo.fec_bajacen,cAbo.fec_ultmod,cAbo.cod_causabaja,cAbo.ind_seguro,
                         cAbo.clase_servicio,cAbo.perfil_abonado,cAbo.num_min,cAbo.cod_vendealer,
                         cAbo.ind_disp,cAbo.cod_password,cAbo.ind_password,cAbo.cod_afinidad,
                         cAbo.fec_prorroga,cAbo.ind_eqprestado,cAbo.flg_contdigi,cAbo.fec_altantras,
                         cAbo.cod_indemnizacion,cAbo.num_imei,cAbo.cod_tecnologia,cAbo.fec_activacion,
                         cAbo.ind_telefono,cAbo.cod_oficina_principal,cAbo.cod_prestacion,cAbo.mto_valor_referencia,
                         cAbo.cod_moneda,cAbo.tipo_primariacarrier,cAbo.obs_instancia,cAbo.cod_causa_venta,cAbo.cod_operacion,
                         ln_num_celular,ln_num_celular);
          END LOOP; 
        END LOOP;
        CLOSE C_NRO_PILOTO;
        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
                IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
                END IF;
                V_des_error := 'pv_abocel_pr('||SN_num_abonado||'); - ' || SQLERRM;
                SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_abocel_pr', sSql, SN_cod_retorno, V_des_error );
    END;    
    
    PROCEDURE pv_equipaboser_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR C_EQUIP IS
    SELECT  EQUIP.IMP_CARGO,
            EQUIP.COD_VERSION,
            EQUIP.COD_FRECUENCIA,
            EQUIP.COD_PROTOCOLO,
            EQUIP.NUM_SERIE,
            EQUIP.COD_PRODUCTO,
            EQUIP.IND_PROCEQUI,
            EQUIP.FEC_ALTA,
            EQUIP.IND_PROPIEDAD,
            EQUIP.COD_BODEGA,
            EQUIP.TIP_STOCK,
            EQUIP.COD_ARTICULO,
            EQUIP.IND_EQUIACC,
            EQUIP.COD_MODVENTA,
            EQUIP.TIP_TERMINAL,
            EQUIP.COD_USO,
            EQUIP.COD_CUOTA,
            EQUIP.COD_ESTADO,
            EQUIP.CAP_CODE,
            EQUIP.NUM_VELOCIDAD,
            EQUIP.NUM_SERIEMEC,
            EQUIP.DES_EQUIPO,
            EQUIP.COD_PAQUETE,
            EQUIP.NUM_MOVIMIENTO,
            EQUIP.COD_CAUSA,
            EQUIP.IND_EQPRESTADO,
            EQUIP.NUM_IMEI,
            EQUIP.COD_TECNOLOGIA,
            EQUIP.TIP_DTO,
            EQUIP.VAL_DTO,
            EQUIP.PRC_VENTA
    FROM    GA_EQUIPABOSER EQUIP 
    WHERE   EQUIP.NUM_ABONADO = SN_num_abonado;

     cEquip C_EQUIP%RowType;
     BEGIN
        SN_cod_retorno :=0; 
        SV_mens_retorno:='';
        SN_num_evento := 0;
        
        OPEN C_EQUIP;
        LOOP 
        FETCH C_EQUIP INTO cEquip;
      
        EXIT WHEN C_EQUIP%NOTFOUND;
               
          FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
               INSERT  /*+ append */ INTO GA_EQUIPABOSER
            (num_abonado,imp_cargo,cod_version,cod_frecuencia,
                         cod_protocolo,num_serie,cod_producto,ind_procequi,  
                         fec_alta,ind_propiedad,cod_bodega,tip_stock,     
                         cod_articulo,ind_equiacc,cod_modventa,tip_terminal,  
                         cod_uso,cod_cuota,cod_estado,cap_code,      
                         num_velocidad,num_seriemec,des_equipo,cod_paquete,   
                         num_movimiento,cod_causa,ind_eqprestado,num_imei,      
                         cod_tecnologia,tip_dto,val_dto,prc_venta)           
        VALUES ( ln_num_abonado,cequip.imp_cargo,cequip.cod_version,cequip.cod_frecuencia,
                         cequip.cod_protocolo,cequip.num_serie,cequip.cod_producto,cequip.ind_procequi,  
                         cequip.fec_alta,cequip.ind_propiedad,cequip.cod_bodega,cequip.tip_stock,     
                         cequip.cod_articulo,cequip.ind_equiacc,cequip.cod_modventa,cequip.tip_terminal,  
                         cequip.cod_uso,cequip.cod_cuota,cequip.cod_estado,cequip.cap_code,      
                         cequip.num_velocidad,cequip.num_seriemec,cequip.des_equipo,cequip.cod_paquete,   
                         cequip.num_movimiento,cequip.cod_causa,cequip.ind_eqprestado,cequip.num_imei,      
                         cequip.cod_tecnologia,cequip.tip_dto,cequip.val_dto,cequip.prc_venta); 
         END LOOP; 
        END LOOP;
        CLOSE C_EQUIP;
  
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_equipaboser_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_equipaboser_pr', sSql, SN_cod_retorno, V_des_error );
    END;

    PROCEDURE pv_servsuplabo_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR CUR_SERV IS
    SELECT  SERV.COD_SERVICIO,
            SERV.FEC_ALTABD,
            SERV.COD_SERVSUPL,
            SERV.COD_NIVEL,
            SERV.COD_PRODUCTO,
            SERV.NOM_USUARORA,
            SERV.IND_ESTADO,
            SERV.FEC_ALTACEN,
            SERV.FEC_BAJABD,
            SERV.FEC_BAJACEN,
            SERV.COD_CONCEPTO,
            SERV.NUM_DIASNUM
    FROM    GA_SERVSUPLABO SERV 
    WHERE   SERV.NUM_ABONADO = SN_num_abonado
      AND   SERV.IND_ESTADO = 2 ;
        cServ CUR_SERV%RowType;
 
    BEGIN
        SN_cod_retorno :=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
        
        OPEN CUR_SERV;       
        LOOP                 
    FETCH CUR_SERV INTO cServ;  
                                      
         EXIT WHEN CUR_SERV%NOTFOUND; 
                                     
          FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
                LN_num_celular := LN_record(LN_indice).num_celular;
        
        INSERT  /*+ append */ INTO GA_SERVSUPLABO
            (num_abonado,cod_servicio,fec_altabd,cod_servsupl,
                         cod_nivel,cod_producto,num_terminal,nom_usuarora,
                         ind_estado,fec_altacen,fec_bajabd,fec_bajacen,cod_concepto,num_diasnum)
                VALUES (ln_num_abonado,cServ.cod_servicio,cServ.fec_altabd,  
                        cServ.cod_servsupl,cServ.cod_nivel,cServ.cod_producto,ln_num_celular,
                        cServ.nom_usuarora,cServ.ind_estado,cServ.fec_altacen,cServ.fec_bajabd,  
                        cServ.fec_bajacen,cServ.cod_concepto,cServ.num_diasnum);
          END LOOP;                                           
        END LOOP;   
        CLOSE CUR_SERV;
                
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_servsuplabo_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_servsuplabo_pr', sSql, SN_cod_retorno, V_des_error );
    END;
    
    PROCEDURE pv_infaccel_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                             SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR CUR_INF IS
    SELECT  INF.COD_CLIENTE,
            INF.COD_CICLFACT,
            INF.FEC_ALTA,
            INF.FEC_BAJA,
            INF.IND_ACTUAC,
            INF.FEC_FINCONTRA,
            INF.IND_ALTA,
            INF.IND_DETALLE,
            INF.IND_FACTUR,
            INF.IND_CUOTAS,
            INF.IND_ARRIENDO,
            INF.IND_CARGOS,
            INF.IND_PENALIZA,
            INF.IND_SUPERTEL,
            INF.NUM_TELEFIJA,
            INF.IND_CARGOPRO,
            INF.IND_CUENCONTROLADA,
            INF.IND_BLOQUEO,
            INF.FEC_RECARGA
    FROM    GA_INFACCEL INF 
    WHERE   INF.NUM_ABONADO = SN_num_abonado
      AND   SYSDATE BETWEEN INF.FEC_ALTA AND INF.FEC_BAJA;
 
        cInf CUR_INF%RowType;
    BEGIN
        SN_cod_retorno :=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
        OPEN CUR_INF;
        LOOP 
    FETCH CUR_INF INTO cInf;
         EXIT WHEN CUR_INF%NOTFOUND; 
       
          FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
                LN_num_celular := LN_record(LN_indice).num_celular;
        INSERT  /*+ append */ INTO GA_INFACCEL
            (num_abonado,num_celular,cod_cliente,cod_ciclfact,fec_alta,fec_baja,ind_actuac,
                         fec_fincontra,ind_alta,ind_detalle,ind_factur,
                         ind_cuotas,ind_arriendo,ind_cargos,ind_penaliza,
                         ind_supertel,num_telefija,ind_cargopro,
                         ind_cuencontrolada,ind_bloqueo,fec_recarga)
        VALUES ( ln_num_abonado,ln_num_celular,cInf.cod_cliente,cInf.cod_ciclfact,
                         cInf.fec_alta,cInf.fec_baja,cInf.ind_actuac,cInf.fec_fincontra,
                         cInf.ind_alta,cInf.ind_detalle,cInf.ind_factur,cInf.ind_cuotas,
                         cInf.ind_arriendo,cInf.ind_cargos,cInf.ind_penaliza,cInf.ind_supertel,
                         cInf.num_telefija,cInf.ind_cargopro,cInf.ind_cuencontrolada,
                         cInf.ind_bloqueo,cInf.fec_recarga);
         END LOOP;     
        END LOOP;           
        CLOSE CUR_INF;  
                        
         EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_infaccel_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_infaccel_pr', sSql, SN_cod_retorno, V_des_error );
   END;                

    PROCEDURE pv_intarcel_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                             SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR CUR_INT IS
    SELECT  INT.COD_CLIENTE,
            INT.IND_NUMERO,
            INT.FEC_DESDE,
            INT.FEC_HASTA,
            INT.IMP_LIMCONSUMO,
            INT.IND_FRIENDS,
            INT.IND_DIASESP,
            INT.COD_CELDA,
            INT.TIP_PLANTARIF,
            INT.COD_PLANTARIF,
            INT.NUM_SERIE,
            INT.COD_CARGOBASICO,
            INT.COD_CICLO,
            INT.COD_PLANCOM,
            INT.COD_PLANSERV,
            INT.COD_GRPSERV,
            INT.COD_PORTADOR,
            INT.COD_USO,
            INT.NUM_IMSI,
            INT.COD_GRUPO
    FROM    GA_INTARCEL INT 
    WHERE   INT.NUM_ABONADO = SN_num_abonado
      AND   SYSDATE BETWEEN INT.FEC_DESDE AND INT.FEC_HASTA;
           cInt CUR_INT%RowType;
    BEGIN
        SN_cod_retorno :=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
        OPEN CUR_INT;
        LOOP 
    FETCH CUR_INT INTO cInt;
          
         EXIT WHEN CUR_INT%NOTFOUND; 
          FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
                LN_num_celular := LN_record(LN_indice).num_celular;
                       
        INSERT  /*+ append */ INTO GA_INTARCEL
            (cod_cliente,num_abonado,ind_numero,        
                         fec_desde,fec_hasta,imp_limconsumo,ind_friends,       
                         ind_diasesp,cod_celda,tip_plantarif,cod_plantarif,
                         num_serie,num_celular,cod_cargobasico,cod_ciclo,         
                         cod_plancom,cod_planserv,cod_grpserv,cod_portador,cod_uso,           
                         num_imsi,num_min_mdn,cod_grupo)
        values ( cint.cod_cliente, ln_num_abonado,
                         cint.ind_numero, cint.fec_desde,
                         cint.fec_hasta, cint.imp_limconsumo,
                         cint.ind_friends, cint.ind_diasesp,
                         cint.cod_celda, cint.tip_plantarif,
                         cint.cod_plantarif, cint.num_serie,
                         ln_num_celular, cint.cod_cargobasico,
                         cint.cod_ciclo, cint.cod_plancom,
                         cint.cod_planserv, cint.cod_grpserv,
                         cint.cod_portador, cint.cod_uso, 
                         cint.num_imsi, ln_num_celular,
                         cint.cod_grupo); 
          END LOOP;
        END LOOP;                
        CLOSE CUR_INT;  
                        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_intarcel_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_intarcel_pr', sSql, SN_cod_retorno, V_des_error );
    END;                

    PROCEDURE pv_intarcel_acciones_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                       SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                       SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                       SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR CUR_INT IS
    SELECT  INT.COD_CLIENTE,
            INT.IND_NUMERO,
            INT.FEC_DESDE,
            INT.COD_ACTABO,
            INT.NOM_USUARORA,
            INT.FEC_INGRESO
    FROM    GA_INTARCEL_ACCIONES_TO INT 
    WHERE   INT.NUM_ABONADO = SN_num_abonado
      AND   INT.FEC_DESDE = (SELECT MAX(GA.FEC_DESDE) FROM GA_INTARCEL_ACCIONES_TO GA WHERE GA.NUM_ABONADO =SN_num_abonado); 

         cInt CUR_INT%RowType;
  
    BEGIN
        SN_cod_retorno :=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
     
        OPEN CUR_INT;
        LOOP 
        FETCH CUR_INT INTO cInt;
           
        EXIT WHEN CUR_INT%NOTFOUND; 
       
        FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
                INSERT  /*+ append */ INTO GA_INTARCEL_ACCIONES_TO
                (cod_cliente,num_abonado,ind_numero,fec_desde,cod_actabo, nom_usuarora,fec_ingreso)
        VALUES  ( cInt.COD_CLIENTE   , LN_num_abonado   ,
                         cInt.IND_NUMERO    , cInt.FEC_DESDE     ,
                         cInt.COD_ACTABO    , cInt.NOM_USUARORA  ,
                         cInt.FEC_INGRESO    ); 
          END LOOP;           
       END LOOP;           
       CLOSE CUR_INT;  
                        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_intarcel_acciones_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_intarcel_acciones_pr', sSql, SN_cod_retorno, V_des_error );
    END;                

    PROCEDURE pv_limite_cliabo_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                                  SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                                  SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                                  SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR CUR_INT IS
    SELECT  INT.COD_CLIENTE,                    
            INT.COD_LIMCONS,                               
            INT.FEC_DESDE,     
            INT.FEC_HASTA,     
            INT.NOM_USUARORA,                              
            INT.FEC_ASIGNACION,
            INT.EST_APLICA_TOL,                 
            INT.FEC_APLICA_TOL,
            INT.COD_PLANTARIF                         
    FROM    GA_LIMITE_CLIABO_TO INT 
    WHERE   INT.NUM_ABONADO = SN_num_abonado
      AND   INT.FEC_DESDE = (SELECT MAX(GA.FEC_DESDE) FROM ga_limite_cliabo_to GA WHERE GA.NUM_ABONADO =SN_num_abonado);
    cInt CUR_INT%RowType;
  
    BEGIN
        SN_cod_retorno :=0;
        SV_mens_retorno:='';
        SN_num_evento := 0;
        OPEN CUR_INT;
        LOOP 
    FETCH CUR_INT INTO cInt;
      
      EXIT WHEN CUR_INT%NOTFOUND; 
     
      FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
                INSERT  /*+ append */ INTO GA_LIMITE_CLIABO_TO
                (cod_cliente,num_abonado,cod_limcons,fec_desde,fec_hasta,        
                 nom_usuarora,fec_asignacion,est_aplica_tol,fec_aplica_tol,cod_plantarif)
        VALUES ( cint.cod_cliente       , ln_num_abonado       , cint.cod_limcons       ,
                 cint.fec_desde         , cint.fec_hasta       , cint.nom_usuarora      , 
                 cint.fec_asignacion    , cint.est_aplica_tol  , cint.fec_aplica_tol    ,  cint.cod_plantarif); 
          END LOOP;    
        END LOOP;           
        CLOSE CUR_INT;  
                        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_limite_cliabo_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_limite_cliabo_pr', sSql, SN_cod_retorno, V_des_error );
    END;

    PROCEDURE pv_ciclocli_pr(SN_num_abonado     IN  ga_abocel.num_abonado%TYPE,
                             SN_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,
                             SV_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
                             SN_num_evento      OUT NOCOPY ge_errores_pg.evento)
    IS
    CURSOR CUR_INT IS
   SELECT  INT.cod_producto,
            INT.num_proceso,
            INT.cod_calclien,
            INT.ind_cambio,
            INT.nom_usuario,
            INT.nom_apellido1,
            INT.nom_apellido2,
            INT.cod_credmor,
            INT.ind_debito,
            INT.cod_ciclonue,
            INT.fec_alta,
            INT.num_terminal,
            INT.fec_ultfact,
            INT.ind_mascara,
            INT.cod_despacho,
            INT.cod_prioridad,
            INT.cod_cliente,
            INT.cod_ciclo,
            INT.cod_courrier,
            INT.cod_zonacourrier            
    FROM    fa_ciclocli INT 
    WHERE   INT.NUM_ABONADO = SN_num_abonado
      AND   INT.FEC_ULTFACT = (SELECT MAX(INT1.FEC_ULTFACT) FROM fa_ciclocli INT1 WHERE INT1.num_abonado = SN_num_abonado)
      AND   rownum = 1;
 
    cInt CUR_INT%RowType;
  
    BEGIN
        SN_cod_retorno :=0;
        SV_mens_retorno:='';
        SN_num_evento  :=0;
        OPEN CUR_INT;
        LOOP 
        FETCH CUR_INT INTO cInt;
      
          EXIT WHEN CUR_INT%NOTFOUND; 
     
          FOR LN_indice in 0 .. LN_record.count - 1 
          LOOP
                LN_num_abonado := LN_record(LN_indice).num_abonado_seq;
                INSERT  /*+ append */ INTO fa_ciclocli
                (cod_producto,num_abonado,num_proceso, cod_calclien, ind_cambio,nom_usuario,   
                 nom_apellido1,nom_apellido2,cod_credmor,ind_debito,cod_ciclonue, fec_alta,num_terminal, fec_ultfact,   
                 ind_mascara,cod_despacho,cod_prioridad,cod_cliente,cod_ciclo,cod_courrier, cod_zonacourrier)
                VALUES (cint.cod_producto,LN_num_abonado,cint.num_proceso,cint.cod_calclien,   
                        cint.ind_cambio,cint.nom_usuario,cint.nom_apellido1,cint.nom_apellido2,   
                        cint.cod_credmor,cint.ind_debito,cint.cod_ciclonue,cint.fec_alta,   
                        cint.num_terminal,cint.fec_ultfact,cint.ind_mascara,cint.cod_despacho,   
                        cint.cod_prioridad,cint.cod_cliente,cint.cod_ciclo,cint.cod_courrier,cint.cod_zonacourrier);
          END LOOP;    
        END LOOP;           
        CLOSE CUR_INT;  
                        
        EXCEPTION
            WHEN OTHERS THEN
              SN_cod_retorno:=156;
              IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                SV_mens_retorno := CV_error_no_clasif;
              END IF;
              V_des_error := 'pv_ciclocli_pr('||SN_num_abonado||'); - ' || SQLERRM;
              SN_num_evento := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, '1.0', USER, 'pv_nro_piloto_pg.pv_ciclocli_pr', sSql, SN_cod_retorno, V_des_error );
    END;      
END;
/
SHOW ERRORS