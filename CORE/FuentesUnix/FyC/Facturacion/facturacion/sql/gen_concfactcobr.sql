--GENERA ARCHIVO CONCEPTOS FACTURACION/COBROS
--
set serverout on echo off tab off feedback off linesize 240 newpage 0 pagesize 0 space 0 trimspool on colsep ',';
--
select a.*,trunc(to_char(fec_alta,'YYYYMMDD'),8) fec_alta
FROM GA_ABOCEL B,
		(
		SELECT  FAC.COD_TIPDOCUM        ,
		        FAC.FEC_EMISION         ,
		        FAC.COD_CICLFACT        ,
		        FAC.FEC_VENCIMIE        ,
		        FAC.NUM_FOLIO           ,
		        SUM(DET.IMP_FACTURABLE) ,
		        FAC.COD_CLIENTE         ,
		        DET.NUM_ABONADO         ,
		        DET.NUM_TERMINAL        ,
		        DET.COD_CONCCOBR        ,
		        DET.COD_NEGOCIO         ,
		        FAC.NUM_FOLIOREL        ,
		        FAC.FEC_FACTURAREL      ,
		        FAC.IND_PASOCOBRO   
		FROM    OPS$XPFACTUR.XPF_LISTADO01       FAC,
		        OPS$XPFACTUR.XPF_LISTADO01_001   DET
		WHERE   DET.IND_ORDENTOTAL = FAC.IND_ORDENTOTAL
		GROUP BY FAC.COD_TIPDOCUM       ,
		        FAC.FEC_EMISION         ,
		        FAC.COD_CICLFACT        ,
		        FAC.FEC_VENCIMIE        ,
		        FAC.NUM_FOLIO           ,
		        FAC.COD_CLIENTE         ,
		        DET.NUM_ABONADO         ,
		        DET.NUM_TERMINAL        ,
		        DET.COD_CONCCOBR        ,
		        DET.COD_NEGOCIO         ,
		        FAC.NUM_FOLIOREL        ,
		        FAC.FEC_FACTURAREL      ,
		        FAC.IND_PASOCOBRO       
		) A
WHERE A.NUM_ABONADO=B.NUM_ABONADO;
--
EXIT;
/