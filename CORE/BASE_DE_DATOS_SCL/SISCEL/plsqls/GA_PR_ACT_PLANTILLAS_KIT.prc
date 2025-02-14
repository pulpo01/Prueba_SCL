CREATE OR REPLACE PROCEDURE        GA_PR_ACT_PLANTILLAS_KIT(
pCodKit in varchar2,
pCodArticulo in varchar2,
pCargaInicial in varchar2)
IS
-- Procedimiento que es llamado desde Promocion Amistar Carga KIT Prepago (VB )
-- para la vigencia de carga asociadas a KIT
-- Creacion : 31 de mayo de 2002
-- Autor : Alejandra Montealegre
   sFecha VARCHAR2(10);
   sFechaComp VARCHAR2(19);
   sHoraI VARCHAR2(8) := '00:00:01';
   sHoraT VARCHAR2(8) :='23:59:59';
   dfec_inicio ga_plantillas_kit.fec_inicio%TYPE;
   dfec_termino ga_plantillas_kit.fec_termino%TYPE;
   sFmtFecha VARCHAR2(20);
   sFmtFechaComp VARCHAR2(21);
   vDescError VARCHAR2(50);
   nContador NUMBER;
BEGIN

        SELECT GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL2') INTO sFmtFecha FROM dual;
    SELECT GE_FN_DEVVALPARAM('GE',1,'FORMATO_SEL7') INTO sFmtFechaComp FROM dual;
        sFmtFechaComp := sFmtFecha||' '||sFmtFechaComp;
--
    sFecha := to_char(sysdate,sFmtFecha);
--
        sFechaComp := sFecha || ' ' || sHoraT;
        dfec_termino := to_date(sFechaComp,sFmtFechaComp)-1;
--
        sFechaComp := to_char(to_date(sFecha,sFmtFecha),sFmtFecha);
        sFechaComp := sFechaComp || ' ' || sHoraI;
        dfec_inicio := to_date(sFechaComp,sFmtFechaComp);
--
    SELECT COUNT(*) INTO nContador
        FROM GA_PLANTILLAS_KIT
        WHERE fec_inicio = dfec_inicio
          AND cod_kit = pCodKit
          AND cod_articulo = pCodArticulo;
        IF nContador = 1 THEN
       UPDATE GA_PLANTILLAS_KIT
           SET carga_inicial = pCargaInicial,
               cod_usua = user,
               fec_ultmod = sysdate
           WHERE cod_kit = pCodKit
             AND cod_articulo = pCodArticulo
             AND fec_inicio = dfec_inicio;
    ELSE
       UPDATE GA_PLANTILLAS_KIT
           SET fec_termino = dfec_termino,
               cod_usua = user,
               fec_ultmod = sysdate
           WHERE cod_kit = pCodKit
             AND COD_ARTICULO = pCodArticulo
             AND fec_inicio <= sysdate
             AND fec_termino >= sysdate;
--
       INSERT INTO GA_PLANTILLAS_KIT
           (COD_KIT, COD_ARTICULO, CARGA_INICIAL, FEC_INICIO, FEC_TERMINO, COD_USUA, FEC_ULTMOD)
       VALUES
           (pCodKit,pCodArticulo,pCargaInicial,dfec_inicio,dfec_inicio+365,user,sysdate);
    END IF;
    COMMIT;
--
EXCEPTION
WHEN NO_DATA_FOUND THEN
    ROLLBACK;
        vDescError := 'No se encontro el registro a modificar';
        RAISE_APPLICATION_ERROR(-20001, vDescError);
WHEN DUP_VAL_ON_INDEX THEN
    ROLLBACK;
        vDescError := 'El registro ya existe en la Base de datos.';
        RAISE_APPLICATION_ERROR(-20002, vDescError);
WHEN OTHERS THEN
   ROLLBACK;
   vDescError := 'Error inesperado, Codigo:'||SQLCODE||'  Descripcion:'||SQLERRM;
   RAISE_APPLICATION_ERROR(-20004, vDescError);
END;
/
SHOW ERRORS
