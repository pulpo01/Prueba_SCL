CREATE OR REPLACE PACKAGE BODY IC_MOVIMIENTO_SP_PG AS

PROCEDURE IC_INSERTA_MOV_PR ( EO_MOVIM IN OUT NOCOPY ICC_MOVIMIENTO_QT,
                                                    SN_ERROR OUT NOCOPY NUMBER, 
                                                    SV_MENSAJE OUT NOCOPY VARCHAR2,
                                                    SN_EVENTO OUT NOCOPY NUMBER )
/*
<Documentación
   TipoDoc = "Procedimiento">
   <Elemento
      Nombre = "IC_MOVIMIENTO_SP_PG"
      Lenguaje="PL/SQL"
      Fecha creación="06-09-2007"
      Creado por="Juan Gonzalez C."
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>n/a</Retorno>
      <Descripción>Inserta Datos en tabla ICC_MOVIMIENTOS </Descripción>
      <Parámetros>
         <Entrada>
            <param nom="EO_MOVIM"         Tipo="OBJETO"> Object Type de la tabla ICC_MOVIMIENTO </param>
         </Entrada>
         <Salida>
            <param nom="EO_MOVIM"         Tipo="OBJETO"> Object Type de la tabla ICC_MOVIMIENTO </param>
            <param nom="SN_ERROR"       Tipo="NUMERICO">Numero de Reclamo a Generar</param>
            <param nom="SV_MENSAJE"       Tipo="NUMERICO">Codigo de Retorno</param>
            <param nom="SN_EVENTO"      Tipo="CARACTER">Mensaje de Retorno</param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/
IS
LV_Sql VARCHAR2(3000);
LN_Movimiento ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;

BEGIN
SN_ERROR := 0;
SV_MENSAJE := 'Movimiento creado';
SN_EVENTO := 0;

LV_Sql := 'INSERT INTO ICC_MOVIMIENTO (';
LV_Sql := LV_Sql || ' NUM_MOVIMIENTO,NUM_ABONADO,COD_ESTADO,COD_ACTABO,COD_MODULO,NUM_INTENTOS,COD_CENTRAL_NUE,';
LV_Sql := LV_Sql || ' DES_RESPUESTA,COD_ACTUACION,NOM_USUARORA,FEC_INGRESO,TIP_TERMINAL,COD_CENTRAL,FEC_LECTURA,';
LV_Sql := LV_Sql || ' IND_BLOQUEO,FEC_EJECUCION,TIP_TERMINAL_NUE,NUM_MOVANT,NUM_CELULAR,NUM_MOVPOS,NUM_SERIE,';
LV_Sql := LV_Sql || ' NUM_PERSONAL,NUM_CELULAR_NUE,NUM_SERIE_NUE,NUM_PERSONAL_NUE,NUM_MSNB,NUM_MSNB_NUE,COD_SUSPREHA,';
LV_Sql := LV_Sql || ' COD_SERVICIOS,NUM_MIN,NUM_MIN_NUE,STA,COD_MENSAJE,PARAM1_MENS,PARAM2_MENS,PARAM3_MENS,PLAN,';
LV_Sql := LV_Sql || ' CARGA,VALOR_PLAN,PIN,FEC_EXPIRA,DES_MENSAJE,COD_PIN,COD_IDIOMA,COD_ENRUTAMIENTO,TIP_ENRUTAMIENTO,';
LV_Sql := LV_Sql || ' DES_ORIGEN_PIN,NUM_LOTE_PIN,NUM_SERIE_PIN,TIP_TECNOLOGIA,IMSI,IMSI_NUE,IMEI,IMEI_NUE,ICC,ICC_NUE,';
LV_Sql := LV_Sql || ' FEC_ACTIVACION,COD_ESPEC_PROV,COD_PROD_CONTRATADO,IND_BAJATRANS )';
LV_Sql := LV_Sql || ' VALUES';
LV_Sql := LV_Sql || ' (';
LV_Sql := LV_Sql || ' NVL( EO_MOVIM.NUM_MOVIMIENTO, ICC_SEQ_NUMMOV.NEXTVAL),';
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_ABONADO||',';
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_ESTADO||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_ACTABO||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_MODULO||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_INTENTOS||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_CENTRAL_NUE||',';       
LV_Sql := LV_Sql || ' ' || EO_MOVIM.DES_RESPUESTA||',';         
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_ACTUACION||',';         
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NOM_USUARORA||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.FEC_INGRESO||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.TIP_TERMINAL||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_CENTRAL||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.FEC_LECTURA||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.IND_BLOQUEO||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.FEC_EJECUCION||',';         
LV_Sql := LV_Sql || ' ' || EO_MOVIM.TIP_TERMINAL_NUE||',';      
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_MOVANT||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_CELULAR||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_MOVPOS||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_SERIE||',';             
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_PERSONAL||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_CELULAR_NUE||',';       
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_SERIE_NUE||',';         
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_PERSONAL_NUE||',';      
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_MSNB||',';              
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_MSNB_NUE||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_SUSPREHA||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_SERVICIOS||',';         
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_MIN||',';               
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_MIN_NUE||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.STA||',';                   
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_MENSAJE||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.PARAM1_MENS||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.PARAM2_MENS||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.PARAM3_MENS||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.PLAN||',';                  
LV_Sql := LV_Sql || ' ' || EO_MOVIM.CARGA||',';                 
LV_Sql := LV_Sql || ' ' || EO_MOVIM.VALOR_PLAN||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.PIN||',';                   
LV_Sql := LV_Sql || ' ' || EO_MOVIM.FEC_EXPIRA||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.DES_MENSAJE||',';           
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_PIN||',';               
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_IDIOMA||',';            
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_ENRUTAMIENTO||',';      
LV_Sql := LV_Sql || ' ' || EO_MOVIM.TIP_ENRUTAMIENTO||',';      
LV_Sql := LV_Sql || ' ' || EO_MOVIM.DES_ORIGEN_PIN||',';        
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_LOTE_PIN||',';          
LV_Sql := LV_Sql || ' ' || EO_MOVIM.NUM_SERIE_PIN||',';         
LV_Sql := LV_Sql || ' ' || EO_MOVIM.TIP_TECNOLOGIA||',';        
LV_Sql := LV_Sql || ' ' || EO_MOVIM.IMSI||',';                  
LV_Sql := LV_Sql || ' ' || EO_MOVIM.IMSI_NUE||',';              
LV_Sql := LV_Sql || ' ' || EO_MOVIM.IMEI||',';                  
LV_Sql := LV_Sql || ' ' || EO_MOVIM.IMEI_NUE||',';              
LV_Sql := LV_Sql || ' ' || EO_MOVIM.ICC||',';                   
LV_Sql := LV_Sql || ' ' || EO_MOVIM.ICC_NUE||',';               
LV_Sql := LV_Sql || ' ' || EO_MOVIM.FEC_ACTIVACION||',';        
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_ESPEC_PROV||',';        
LV_Sql := LV_Sql || ' ' || EO_MOVIM.COD_PROD_CONTRATADO||',';   
LV_Sql := LV_Sql || ' ' || EO_MOVIM.IND_BAJATRANS||',';         
LV_Sql := LV_Sql || ' ) RETURNING NUM_MOVIMIENTO INTO LN_Movimiento';

INSERT INTO ICC_MOVIMIENTO
(
        NUM_MOVIMIENTO,
        NUM_ABONADO,
        COD_ESTADO,
        COD_ACTABO,
        COD_MODULO,
        NUM_INTENTOS,
        COD_CENTRAL_NUE,
        DES_RESPUESTA,
        COD_ACTUACION,
        NOM_USUARORA,
        FEC_INGRESO,
        TIP_TERMINAL,
        COD_CENTRAL,
        FEC_LECTURA,
        IND_BLOQUEO,
        FEC_EJECUCION,
        TIP_TERMINAL_NUE,
        NUM_MOVANT,
        NUM_CELULAR,
        NUM_MOVPOS,
        NUM_SERIE,
        NUM_PERSONAL,
        NUM_CELULAR_NUE,
        NUM_SERIE_NUE,
        NUM_PERSONAL_NUE,
        NUM_MSNB,
        NUM_MSNB_NUE,
        COD_SUSPREHA,
        COD_SERVICIOS,
        NUM_MIN,
        NUM_MIN_NUE,
        STA,
        COD_MENSAJE,
        PARAM1_MENS,
        PARAM2_MENS,
        PARAM3_MENS,
        PLAN,
        CARGA,
        VALOR_PLAN,
        PIN,
        FEC_EXPIRA,
        DES_MENSAJE,
        COD_PIN,
        COD_IDIOMA,
        COD_ENRUTAMIENTO,
        TIP_ENRUTAMIENTO,
        DES_ORIGEN_PIN,
        NUM_LOTE_PIN,
        NUM_SERIE_PIN,
        TIP_TECNOLOGIA,
        IMSI,
        IMSI_NUE,
        IMEI,
        IMEI_NUE,
        ICC,
        ICC_NUE,
        FEC_ACTIVACION,
        COD_ESPEC_PROV,
        COD_PROD_CONTRATADO,
        IND_BAJATRANS
)
VALUES
(
        NVL( EO_MOVIM.NUM_MOVIMIENTO, ICC_SEQ_NUMMOV.NEXTVAL),
        EO_MOVIM.NUM_ABONADO, -- NN --
        EO_MOVIM.COD_ESTADO, -- NN defecto 1 --
        EO_MOVIM.COD_ACTABO, -- NN defecto 'XX' --
        EO_MOVIM.COD_MODULO, -- NN --
        EO_MOVIM.NUM_INTENTOS, -- NN defecto cero --
        EO_MOVIM.COD_CENTRAL_NUE,
        EO_MOVIM.DES_RESPUESTA, -- NN defecto 'PENDIENTE' --
        EO_MOVIM.COD_ACTUACION, -- NN --
        EO_MOVIM.NOM_USUARORA, -- NN defecto 'USER'--
        EO_MOVIM.FEC_INGRESO, -- NN defecto SYSDATE--
        EO_MOVIM.TIP_TERMINAL, -- NN --
        EO_MOVIM.COD_CENTRAL, -- NN --
        EO_MOVIM.FEC_LECTURA,
        EO_MOVIM.IND_BLOQUEO, -- NN defecto 0--
        EO_MOVIM.FEC_EJECUCION,
        EO_MOVIM.TIP_TERMINAL_NUE,
        EO_MOVIM.NUM_MOVANT,
        EO_MOVIM.NUM_CELULAR, -- NN --
        EO_MOVIM.NUM_MOVPOS,
        EO_MOVIM.NUM_SERIE, -- NN --
        EO_MOVIM.NUM_PERSONAL,
        EO_MOVIM.NUM_CELULAR_NUE,
        EO_MOVIM.NUM_SERIE_NUE,
        EO_MOVIM.NUM_PERSONAL_NUE,
        EO_MOVIM.NUM_MSNB,
        EO_MOVIM.NUM_MSNB_NUE,
        EO_MOVIM.COD_SUSPREHA,
        EO_MOVIM.COD_SERVICIOS,
        EO_MOVIM.NUM_MIN,
        EO_MOVIM.NUM_MIN_NUE,
        EO_MOVIM.STA,
        EO_MOVIM.COD_MENSAJE,
        EO_MOVIM.PARAM1_MENS,
        EO_MOVIM.PARAM2_MENS,
        EO_MOVIM.PARAM3_MENS,
        EO_MOVIM.PLAN,
        EO_MOVIM.CARGA,
        EO_MOVIM.VALOR_PLAN,
        EO_MOVIM.PIN,
        EO_MOVIM.FEC_EXPIRA,
        EO_MOVIM.DES_MENSAJE,
        EO_MOVIM.COD_PIN,
        EO_MOVIM.COD_IDIOMA,
        EO_MOVIM.COD_ENRUTAMIENTO,
        EO_MOVIM.TIP_ENRUTAMIENTO,
        EO_MOVIM.DES_ORIGEN_PIN,
        EO_MOVIM.NUM_LOTE_PIN,
        EO_MOVIM.NUM_SERIE_PIN,
        EO_MOVIM.TIP_TECNOLOGIA,
        EO_MOVIM.IMSI,
        EO_MOVIM.IMSI_NUE,
        EO_MOVIM.IMEI,
        EO_MOVIM.IMEI_NUE,
        EO_MOVIM.ICC,
        EO_MOVIM.ICC_NUE,
        EO_MOVIM.FEC_ACTIVACION,
        EO_MOVIM.COD_ESPEC_PROV,
        EO_MOVIM.COD_PROD_CONTRATADO,
        EO_MOVIM.IND_BAJATRANS
) RETURNING NUM_MOVIMIENTO INTO LN_Movimiento;

EO_MOVIM.NUM_MOVIMIENTO := LN_Movimiento;

EXCEPTION
        WHEN OTHERS THEN
                SN_ERROR := 1006;
                SV_MENSAJE := SQLERRM;
                SN_EVENTO := GE_ERRORES_PG.GRABARPL(0, 'IC_MOVIMIENTO_SP_PG.IC_INSERTA_MOV_PR', SQLERRM, CV_version,USER, 'IC_MOVIMIENTO_SP_PG', LV_Sql, SN_ERROR, SV_MENSAJE );
END IC_INSERTA_MOV_PR;

END IC_MOVIMIENTO_SP_PG;
/
SHOW ERRORS