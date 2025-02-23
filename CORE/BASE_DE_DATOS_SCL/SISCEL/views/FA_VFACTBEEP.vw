CREATE OR REPLACE FORCE VIEW FA_VFACTBEEP(
   IND_ORDENTOTAL
 , COD_CONCEPTO
 , COLUMNA
 , COD_MONEDA
 , COD_PRODUCTO
 , COD_TIPCONCE
 , FEC_VALOR
 , FEC_EFECTIVIDAD
 , IMP_CONCEPTO
 , COD_REGION
 , COD_PROVINCIA
 , COD_CIUDAD
 , IMP_MONTOBASE
 , IND_FACTUR
 , IMP_FACTURABLE
 , IND_SUPERTEL
 , NUM_ABONADO
 , COD_PORTADOR
 , COD_CLIENTE
 , DES_CONCEPTO
 , NUM_CUOTAS
 , ORD_CUOTA
 , NUM_UNIDADES
 , NUM_SERIEMEC
 , NUM_SERIELE
 , PRC_IMPUESTO
 , VAL_DTO
 , TIP_DTO
 , MES_GARANTIA
 , NUM_GUIA
 , IND_ALTA
 , NUM_PAQUETE
 , FLAG_IMPUES
 , FLAG_DTO
 , COD_CONCEREL
 , COLUMNA_REL
 , SEQ_CUOTAS
 ) AS 
SELECT
       "IND_ORDENTOTAL"
     , "COD_CONCEPTO"
     , "COLUMNA"
     , "COD_MONEDA"
     , "COD_PRODUCTO"
     , "COD_TIPCONCE"
     , "FEC_VALOR"
     , "FEC_EFECTIVIDAD"
     , "IMP_CONCEPTO"
     , "COD_REGION"
     , "COD_PROVINCIA"
     , "COD_CIUDAD"
     , "IMP_MONTOBASE"
     , "IND_FACTUR"
     , "IMP_FACTURABLE"
     , "IND_SUPERTEL"
     , "NUM_ABONADO"
     , "COD_PORTADOR"
     , "COD_CLIENTE"
     , "DES_CONCEPTO"
     , "NUM_CUOTAS"
     , "ORD_CUOTA"
     , "NUM_UNIDADES"
     , "NUM_SERIEMEC"
     , "NUM_SERIELE"
     , "PRC_IMPUESTO"
     , "VAL_DTO"
     , "TIP_DTO"
     , "MES_GARANTIA"
     , "NUM_GUIA"
     , "IND_ALTA"
     , "NUM_PAQUETE"
     , "FLAG_IMPUES"
     , "FLAG_DTO"
     , "COD_CONCEREL"
     , "COLUMNA_REL"
     , "SEQ_CUOTAS"
 FROM FA_FACTBEEP0
  UNION ALL
   SELECT
  "IND_ORDENTOTAL","COD_CONCEPTO","COLUMNA","COD_MONEDA","COD_PRODUCTO"
 ,"COD_TIPCONCE","FEC_VALOR","FEC_EFECTIVIDAD","IMP_CONCEPTO",
 "COD_REGION","COD_PROVINCIA","COD_CIUDAD","IMP_MONTOBASE","IND_FACTUR"
 ,"IMP_FACTURABLE","IND_SUPERTEL","NUM_ABONADO","COD_PORTADOR",
 "COD_CLIENTE",
 "DES_CONCEPTO","NUM_CUOTAS","ORD_CUOTA","NUM_UNIDADES","NUM_SERIEMEC",
 "NUM_SERIELE","PRC_IMPUESTO","VAL_DTO","TIP_DTO","MES_GARANTIA",
 "NUM_GUIA","IND_ALTA","NUM_PAQUETE", "FLAG_IMPUES","FLAG_DTO","COD_CONCEREL","COLUMNA_REL","SEQ_CUOTAS"
  FROM FA_FACTBEEP1
/
SHOW ERRORS
