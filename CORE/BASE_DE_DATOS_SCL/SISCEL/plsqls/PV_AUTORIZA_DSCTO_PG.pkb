CREATE OR REPLACE PACKAGE BODY PV_AUTORIZA_DSCTO_PG AS

FUNCTION retorna_version RETURN VARCHAR2
IS
--
  p_version    constant VARCHAR2(3) := '001';
  p_subversion constant VARCHAR2(3) := '001';
--
BEGIN
  --
   RETURN('Version : '||p_version||' <--> SubVersion : '||p_subversion);
   --
END;

PROCEDURE PV_INSERTA_AUTORIZA_PR(p_NUM_VENTA IN GA_AUTORIZA.NUM_VENTA%type,p_LIN_AUTORIZA IN GA_AUTORIZA.LIN_AUTORIZA%type,p_COD_OFICINA IN GA_AUTORIZA.COD_OFICINA%type,
                          p_COD_ESTADO IN GA_AUTORIZA.COD_ESTADO%type,p_NUM_AUTORIZA IN GA_AUTORIZA.NUM_AUTORIZA%type,p_COD_VENDEDOR IN GA_AUTORIZA.COD_VENDEDOR%type,
                          p_NUM_UNIDADES IN GA_AUTORIZA.NUM_UNIDADES%type,p_PRC_ORIGIN IN GA_AUTORIZA.PRC_ORIGIN%type,
                          p_IND_TIPVENTA IN GA_AUTORIZA.IND_TIPVENTA%type,p_COD_CLIENTE IN GA_AUTORIZA.COD_CLIENTE%type,p_COD_MODVENTA IN GA_AUTORIZA.COD_MODVENTA%type,
                          p_NOM_USUAR_VTA IN GA_AUTORIZA.NOM_USUAR_VTA%type,p_COD_CONCEPTO IN GA_AUTORIZA.COD_CONCEPTO%type,p_IMP_CARGO IN GA_AUTORIZA.IMP_CARGO%type,
                          p_COD_MONEDA IN GA_AUTORIZA.COD_MONEDA%type,p_NUM_ABONADO IN GA_AUTORIZA.NUM_ABONADO%type,p_NUM_SERIE IN GA_AUTORIZA.NUM_SERIE%type,
                          p_COD_CONCEPTO_DTO IN GA_AUTORIZA.COD_CONCEPTO_DTO%type,p_VAL_DTO IN GA_AUTORIZA.VAL_DTO%type,p_TIP_DTO IN GA_AUTORIZA.TIP_DTO%type,
                          p_IND_MODIFI IN GA_AUTORIZA.IND_MODIFI%type,p_ORIGEN IN GA_AUTORIZA.ORIGEN%type,p_ERROR OUT VARCHAR2,p_DesERROR OUT VARCHAR2)
AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
        p_ERROR := '0';
              INSERT INTO GA_AUTORIZA ( NUM_VENTA,
			                LIN_AUTORIZA,
			                COD_OFICINA,
			                COD_ESTADO,
			                NUM_AUTORIZA,
			                COD_VENDEDOR,
			                NUM_UNIDADES,
			                FEC_VENTA,
			                PRC_ORIGIN,
			                IND_TIPVENTA,
			                COD_CLIENTE,
			                COD_MODVENTA,
			                NOM_USUAR_VTA,
			                COD_CONCEPTO,
			                IMP_CARGO,
			                COD_MONEDA,
			                NUM_ABONADO,
			                NUM_SERIE,
			                COD_CONCEPTO_DTO,
			                VAL_DTO,
			                TIP_DTO,
			                IND_MODIFI,
			                ORIGEN )
			                VALUES (
			                p_NUM_VENTA,
			                p_LIN_AUTORIZA,
			                p_COD_OFICINA,
			                p_COD_ESTADO,
			                p_NUM_AUTORIZA,
			                p_COD_VENDEDOR,
			                p_NUM_UNIDADES,
			                SYSDATE,
			                p_PRC_ORIGIN,
			                p_IND_TIPVENTA,
			                p_COD_CLIENTE,
			                p_COD_MODVENTA,
			                p_NOM_USUAR_VTA,
			                p_COD_CONCEPTO,
			                p_IMP_CARGO,
			                p_COD_MONEDA,
			                p_NUM_ABONADO,
			                p_NUM_SERIE,
			                p_COD_CONCEPTO_DTO,
			                p_VAL_DTO,
			                p_TIP_DTO,
			                p_IND_MODIFI,
			                p_ORIGEN);

			p_DesERROR := 'Insercion GA_AUTORIZA OK';

            COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
			p_ERROR := TO_CHAR(SQLCODE);
            p_DesERROR := 'ERROR PV_INSERTA_AUTORIZA_PR : SQLCODE:' || p_ERROR || ' SQLERRM:' || SQLERRM;
    END PV_INSERTA_AUTORIZA_PR;
END PV_AUTORIZA_DSCTO_PG;
/
SHOW ERRORS
