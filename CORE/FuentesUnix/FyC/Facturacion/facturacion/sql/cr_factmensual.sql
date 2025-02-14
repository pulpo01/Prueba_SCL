--  Archivo : cr_factmensual.sql
--
set echo off verify off  feedback off;
--
--ELIMINA TABLA TEMPORAL DE DOCUMENTOS
--
prompt **** Crea Tabla XPF_LISTADO01
--
DROP TABLE XPF_LISTADO01;
--
--CREA TABLA TEMPORAL DE DOCUMENTOS
--
CREATE TABLE   XPF_LISTADO01
TABLESPACE ITS_TAB        
STORAGE( INITIAL    5 M 
         NEXT       1 M)
AS
SELECT  HIS.IND_ORDENTOTAL          ,
        HIS.COD_TIPDOCUM            ,
        HIS.FEC_EMISION             ,
        HIS.COD_CICLFACT            ,
        HIS.FEC_VENCIMIE            ,
        HIS.NUM_FOLIO               ,
        HIS.TOT_FACTURA             ,
        HIS.COD_CLIENTE             ,
        HIS.IND_PASOCOBRO           ,
        HIS.IND_ANULADA             ,
        HIS.NUM_SECUREL             ,
        HIS.COD_TIPDOCUMREL         ,
        HIS.COD_VENDEDOR_AGENTEREL  ,
        HIS.LETRAREL                ,
        HIS.COD_CENTRREL            ,
        HIS.NUM_FOLIO       AS NUM_FOLIOREL     ,
        HIS.FEC_VENCIMIE    AS FEC_FACTURAREL   
FROM    FA_HISTDOCU HIS
WHERE   HIS.NUM_SECUENCI > 0
AND     HIS.COD_TIPDOCUM > 0
AND     HIS.COD_VENDEDOR_AGENTE > 0
AND     HIS.LETRA IN ('I','X')
AND     HIS.IND_ANULADA = 0
AND     HIS.FEC_EMISION >= TO_DATE('&1','DDMMYYYY')
AND     HIS.FEC_EMISION <  TO_DATE('&2','DDMMYYYY')
UNION ALL
SELECT  HIS.IND_ORDENTOTAL          ,
        HIS.COD_TIPDOCUM            ,
        HIS.FEC_EMISION             ,
        HIS.COD_CICLFACT            ,
        HIS.FEC_VENCIMIE            ,
        HIS.NUM_FOLIO               ,
        HIS.TOT_FACTURA             ,
        HIS.COD_CLIENTE             ,
        HIS.IND_PASOCOBRO           ,
        HIS.IND_ANULADA             ,
        HIS.NUM_SECUREL             ,
        HIS.COD_TIPDOCUMREL         ,
        HIS.COD_VENDEDOR_AGENTEREL  ,
        HIS.LETRAREL                ,
        HIS.COD_CENTRREL            ,
        HIS.NUM_FOLIO       AS NUM_FOLIOREL     ,
        HIS.FEC_VENCIMIE    AS FEC_FACTURAREL   
FROM    FA_FACTDOCU_NOCICLO HIS
WHERE   HIS.NUM_SECUENCI > 0
AND     HIS.COD_TIPDOCUM > 0
AND     HIS.COD_VENDEDOR_AGENTE > 0
AND     HIS.LETRA IN ('I','X')
AND     HIS.IND_ANULADA = 0
AND     HIS.FEC_EMISION >= TO_DATE('&1','DDMMYYYY')
AND     HIS.FEC_EMISION <  TO_DATE('&2','DDMMYYYY');
--
COMMIT;
--
prompt **** Update Folio Relacionado a XPF_LISTADO01
--
UPDATE  XPF_LISTADO01
SET     NUM_FOLIOREL    = 0, 
        FEC_FACTURAREL  = NULL;
--
COMMIT;
--        
--
--
prompt **** Crea Indice (COD_TIPDOCUMREL) a XPF_LISTADO01
--
-- CREA INDICE PARA ACTUALIZAR NOTAS DE CREDITO (FACTURA ASOCIADA)
--            
CREATE INDEX    XPF_LISTADO01_IDX1
        ON      XPF_LISTADO01
              ( COD_TIPDOCUMREL         )
TABLESPACE   ITS_IDX;
--                                                
--
--
prompt **** Actualiza Datos de Facturas Asociadas a N. Credito
--
-- ACTUALIZA DATOS DE FACTURA PARA LA NOTA DE CREDITO
--   
--VARIABLE V_NUMFOLIO     NUMBER  ;
--VARIABLE V_FECEMISION   DATE    ;
--
DECLARE 
CURSOR NOTAS_CREDITO IS
    SELECT  ROWID                   ,
            NUM_SECUREL             ,
            COD_TIPDOCUMREL         ,
            COD_VENDEDOR_AGENTEREL  ,
            LETRAREL                ,
            COD_CENTRREL
    FROM    XPF_LISTADO01  
    WHERE   COD_TIPDOCUM = 25;   
--
V_NUMFOLIO     NUMBER;
V_FECEMISION   DATE;
--    
BEGIN
    FOR T IN NOTAS_CREDITO LOOP
    BEGIN
        SELECT  NUM_FOLIO    , FEC_EMISION
        INTO    V_NUMFOLIO   , V_FECEMISION
        FROM    FA_HISTDOCU 
        WHERE   NUM_SECUENCI        = T.NUM_SECUREL
        AND     COD_TIPDOCUM        = T.COD_TIPDOCUMREL         
        AND     COD_VENDEDOR_AGENTE = T.COD_VENDEDOR_AGENTEREL  
        AND     LETRA               = T.LETRAREL                
        AND     COD_CENTREMI        = T.COD_CENTRREL;
--
        UPDATE  XPF_LISTADO01
        SET     NUM_FOLIOREL    = V_NUMFOLIO	,
                FEC_FACTURAREL  = V_FECEMISION
        WHERE   ROWID           = T.ROWID;                
    
        EXCEPTION        
            WHEN NO_DATA_FOUND THEN
                NULL;
     END;
     END LOOP;
END;        
/

DECLARE 
CURSOR NOTAS_CREDITO_NOCICLO IS
    SELECT  ROWID                   ,
            NUM_SECUREL             ,
            COD_TIPDOCUMREL         ,
            COD_VENDEDOR_AGENTEREL  ,
            LETRAREL                ,
            COD_CENTRREL
    FROM    XPF_LISTADO01  
    WHERE   COD_TIPDOCUM = 25
    AND		NUM_FOLIOREL = 0; 
    
--
V_NUMFOLIO     NUMBER;
V_FECEMISION   DATE;
--    

BEGIN
    FOR T IN NOTAS_CREDITO_NOCICLO LOOP
    BEGIN
        SELECT  NUM_FOLIO    , FEC_EMISION
        INTO    V_NUMFOLIO   , V_FECEMISION
        FROM    FA_FACTDOCU_NOCICLO 
        WHERE   NUM_SECUENCI        = T.NUM_SECUREL
        AND     COD_TIPDOCUM        = T.COD_TIPDOCUMREL         
        AND     COD_VENDEDOR_AGENTE = T.COD_VENDEDOR_AGENTEREL  
        AND     LETRA               = T.LETRAREL                
        AND     COD_CENTREMI        = T.COD_CENTRREL;
--
        UPDATE  XPF_LISTADO01
        SET     NUM_FOLIOREL    = V_NUMFOLIO	,
                FEC_FACTURAREL  = V_FECEMISION
        WHERE   ROWID           = T.ROWID;                
    
        EXCEPTION        
            WHEN NO_DATA_FOUND THEN
                NULL;
     END;
     END LOOP;
END;        
/

--  
-- ELIMINA INDICE 
--
--
prompt **** Crea PK (COD_CICLFACT, IND_ORDENTOTAL) a XPF_LISTADO01
--
DROP INDEX XPF_LISTADO01_IDX1;
--
--                       
--  CREA PK PARA FACTURAS
--
ALTER TABLE XPF_LISTADO01
    ADD CONSTRAINT PK_XPF_LISTADO01
    PRIMARY KEY (COD_CICLFACT, IND_ORDENTOTAL)
    USING INDEX
    PCTFREE 5
    TABLESPACE ITS_IDX;                       
--
-- FIN  Archivo  : cr_factmensual.sql
--
prompt **** Fin de Creacion de Tabla de Documenrtos XPF_LISTADO01
--
EXIT
/