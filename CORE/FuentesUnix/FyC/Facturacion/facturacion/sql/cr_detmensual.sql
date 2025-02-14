--  Archivo : cr_detmansual.sql
--
set echo off verify off  feedback off;
--
--
define      cod_ciclfact='&1'
define      tab_conceptos='&2'
define      tab_aboncelu='&3'
define      tab_abonbeep='&4'
--
--
prompt **** Crea Tabla XPF_LISTADO01_001
--
-- ELIMINA TABLA DE DETALLE DE FACTURAS 
--
DROP TABLE XPF_LISTADO01_001;
--
--
--  CREA TABLA DE DETALLE DE FACTURAS POR ABONADO Y CONCEPTO DE COBROS
--
CREATE  TABLE XPF_LISTADO01_001
TABLESPACE ITS_TAB      
STORAGE( INITIAL    3 M 
         NEXT       1 M)
AS  SELECT  HIS.IND_ORDENTOTAL          ,
            HIS.NUM_ABONADO             ,
            HIS.COD_PRODUCTO            ,
            HIS.COD_CONCEPTO            ,
            COB.COD_CONCCOBR            ,    
            HIS.IMP_FACTURABLE          ,
            0   AS NUM_TERMINAL         ,
            1   AS COD_NEGOCIO
    FROM    &&tab_conceptos     HIS,
            XPF_LISTADO01       XPF,
            FA_FACTCOBR         COB
    WHERE   XPF.COD_CICLFACT    = &&cod_ciclfact
    AND     XPF.IND_ORDENTOTAL  = HIS.IND_ORDENTOTAL
    AND     HIS.COD_CONCEPTO    = COB.COD_CONCFACT 
    UNION ALL
    SELECT  HIS.IND_ORDENTOTAL          ,
            HIS.NUM_ABONADO             ,
            HIS.COD_PRODUCTO            ,
            HIS.COD_CONCEPTO            ,
            COB.COD_CONCCOBR            ,    
            HIS.IMP_FACTURABLE          ,
            0   AS NUM_TERMINAL         ,
            1   AS COD_NEGOCIO
    FROM    FA_FACTCONC_NOCICLO HIS,
            XPF_LISTADO01       XPF,
            FA_FACTCOBR         COB
    WHERE   XPF.COD_CICLFACT    = &&cod_ciclfact
    AND     XPF.IND_ORDENTOTAL  = HIS.IND_ORDENTOTAL
    AND     HIS.COD_CONCEPTO    = COB.COD_CONCFACT;
--
--
--
COMMIT;
--                                      
prompt **** Crea Indice (IND_ORDENTOTAL + ABONADO) XPF_LISTADO01_001
--
-- CREA INDICE A DETALLE DE FACTURAS IND_ORDENTOTAL + ABONADO                                      
--
CREATE INDEX    XPF_LISTADO01_001_IDX1
        ON      XPF_LISTADO01_001
              ( IND_ORDENTOTAL, NUM_ABONADO)
TABLESPACE   ITS_IDX
STORAGE ( INITIAL 1 M NEXT 800 K);
--
--
-- ACTUALIZA NUMERO DE TERMINAL PARA EL ABONADO
--
--
prompt **** Marca Numero de Terminal
--
UPDATE  XPF_LISTADO01_001 XPF
SET     NUM_TERMINAL    = ( SELECT ABO.NUM_BEEPER
                            FROM    &&tab_abonbeep  ABO
                            WHERE   ABO.IND_ORDENTOTAL = XPF.IND_ORDENTOTAL
                            AND     ABO.NUM_ABONADO    = XPF.NUM_ABONADO
                            UNION ALL
                            SELECT ABO.NUM_BEEPER
                            FROM    FA_FACTABON_NOCICLO  ABO
                            WHERE   ABO.IND_ORDENTOTAL = XPF.IND_ORDENTOTAL
                            AND     ABO.NUM_ABONADO    = XPF.NUM_ABONADO)
WHERE   IND_ORDENTOTAL IN ( SELECT  ABO.IND_ORDENTOTAL
                            FROM    &&tab_abonbeep  ABO
                            WHERE   ABO.IND_ORDENTOTAL = XPF.IND_ORDENTOTAL
                            AND     ABO.NUM_ABONADO    = XPF.NUM_ABONADO 
                            UNION ALL
                            SELECT  ABO.IND_ORDENTOTAL
                            FROM    FA_FACTABON_NOCICLO  ABO
                            WHERE   ABO.IND_ORDENTOTAL = XPF.IND_ORDENTOTAL
                            AND     ABO.NUM_ABONADO    = XPF.NUM_ABONADO );
--                                
COMMIT;
--
--                   
GRANT SELECT ON XPF_LISTADO01       TO PUBLIC;
--
GRANT SELECT ON XPF_LISTADO01_001   TO PUBLIC;
--                                            
COMMIT;
--                                  
prompt **** Crea Indice (COD_PRODUCTO ,NUM_TERMINAL ) a XPF_LISTADO01_001
--
-- ELIMINA INDICE DE DETALLE
--
DROP INDEX XPF_LISTADO01_001_IDX1;
--
-- CREA INDICE A DETALLE DE FACTURAS COD_PRODUCTO
--
CREATE INDEX    XPF_LISTADO01_001_IDX1
        ON      XPF_LISTADO01_001
                (COD_PRODUCTO ,NUM_TERMINAL )
TABLESPACE   ITS_IDX
STORAGE ( INITIAL 1 M NEXT 800 K);
--
--
prompt **** Marca Negocio 2 
--
UPDATE  XPF_LISTADO01_001
SET     COD_NEGOCIO  = 2 
WHERE   COD_PRODUCTO = 2;
--
COMMIT;
--
prompt **** Marca Negocio 3 
--
UPDATE  XPF_LISTADO01_001
SET     COD_NEGOCIO  = 3
WHERE   COD_PRODUCTO = 2
AND     NUM_TERMINAL > 9000000;
--                             
COMMIT;
--
-- ELIMINA INDICE DE DETALLE
--
prompt **** Crea Indice (IND_ORDENTOTAL, NUM_ABONADO, NUM_TERMINAL, COD_CONCCOBR, COD_NEGOCIO ) a XPF_LISTADO01_001
--
DROP INDEX XPF_LISTADO01_001_IDX1;
--
--
-- CREA INDICE A DETALLE DE FACTURAS IND_ORDENTOTAL + ABONADO                                      
--
CREATE INDEX    XPF_LISTADO01_001_IDX1
        ON      XPF_LISTADO01_001
              ( IND_ORDENTOTAL, NUM_ABONADO, NUM_TERMINAL, COD_CONCCOBR, COD_NEGOCIO )
TABLESPACE   ITS_IDX
STORAGE ( INITIAL 2 M NEXT 800 K);
--
--
COMMIT;
--
prompt **** Fin de Creacion de Tabla de Documenrtos XPF_LISTADO01_001
--
exit
/
--
--  Fin Archivo : cr_detmansual.sql