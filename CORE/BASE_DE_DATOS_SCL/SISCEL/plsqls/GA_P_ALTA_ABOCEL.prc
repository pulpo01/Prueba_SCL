CREATE OR REPLACE PROCEDURE        GA_P_ALTA_ABOCEL
       (VP_ABOCEL  IN GA_ABOCEL%ROWTYPE,
                                                   VP_PROC     IN OUT VARCHAR2,
                                                   VP_TABLA    IN OUT VARCHAR2,
                                                   VP_SQLCODE  IN OUT VARCHAR2,
                                                   VP_SQLERRM  IN OUT VARCHAR2,
                                                   VP_ERROR    IN OUT VARCHAR2 ) IS
--Procedimiento  de insercion de la tabla ga_ABOCEL
--
--Los valores del codigo de retorno seran los siguientes:
--                -"0" = La insercion se ha realizado correctamente
--                -"4" = Error en proceso
  V_PREFIJO     VARCHAR2(3);
BEGIN
 --- Modificacion para incorporar el num_min en ga_abocel 26/05/99
   SELECT NUM_MIN
     INTO V_PREFIJO
     FROM AL_USOS_MIN
    WHERE COD_USO = VP_ABOCEL.COD_USO
      AND TRUNC(SYSDATE) BETWEEN FEC_DESDE AND NVL(FEC_HASTA,TRUNC(SYSDATE));
 --- Fin modficacion
        VP_PROC := 'GA_P_ALTA_ABOCEL';
        VP_TABLA := 'GA_ABOCEL';
     INSERT INTO GA_ABOCEL
        (NUM_ABONADO,
         NUM_CELULAR,
         COD_PRODUCTO,
         COD_CLIENTE,
         COD_CUENTA,
         COD_SUBCUENTA,
         COD_USUARIO,
         COD_REGION,
         COD_PROVINCIA,
         COD_CIUDAD,
         COD_CELDA,
         COD_CENTRAL,
         COD_USO,
         COD_SITUACION,
         IND_PROCALTA,
         IND_PROCEQUI,
         COD_VENDEDOR,
         COD_VENDEDOR_AGENTE,
         TIP_PLANTARIF,
         TIP_TERMINAL,
         COD_PLANTARIF,
         COD_CARGOBASICO,
         COD_PLANSERV,
         COD_LIMCONSUMO,
         NUM_SERIE,
         NUM_SERIEHEX,
         NOM_USUARORA,
         FEC_ALTA,
         NUM_PERCONTRATO,
         COD_ESTADO,
         NUM_SERIEMEC,
         COD_HOLDING,
         COD_EMPRESA,
         COD_GRPSERV,
         IND_SUPERTEL,
         NUM_TELEFIJA,
         COD_OPREDFIJA,
         COD_CARRIER,
         IND_PREPAGO,
         IND_PLEXSYS,
         COD_CENTRAL_PLEX,
         NUM_CELULAR_PLEX,
         NUM_VENTA,
         COD_MODVENTA,
         COD_TIPCONTRATO,
         NUM_CONTRATO,
         NUM_ANEXO,
         FEC_CUMPLAN,
         COD_CREDMOR,
         COD_CREDCON,
         COD_CICLO,
         IND_FACTUR,
         IND_SUSPEN,
         IND_REHABI,
         IND_INSGUIAS,
         FEC_FINCONTRA,
         FEC_RECDOCUM,
         FEC_CUMPLIMEN,
         FEC_ACEPVENTA,
         FEC_ACTCEN,
         FEC_BAJA,
         FEC_BAJACEN,
         FEC_ULTMOD,
         COD_CAUSABAJA,
         NUM_PERSONAL,
         IND_SEGURO,
         CLASE_SERVICIO,
         PERFIL_ABONADO,
         NUM_MIN)
 VALUES
        (VP_ABOCEL.NUM_ABONADO,
         VP_ABOCEL.NUM_CELULAR,
         VP_ABOCEL.COD_PRODUCTO,
         VP_ABOCEL.COD_CLIENTE,
         VP_ABOCEL.COD_CUENTA,
         VP_ABOCEL.COD_SUBCUENTA,
         VP_ABOCEL.COD_USUARIO,
         VP_ABOCEL.COD_REGION,
         VP_ABOCEL.COD_PROVINCIA,
         VP_ABOCEL.COD_CIUDAD,
         VP_ABOCEL.COD_CELDA,
         VP_ABOCEL.COD_CENTRAL,
         VP_ABOCEL.COD_USO,
         VP_ABOCEL.COD_SITUACION,
         VP_ABOCEL.IND_PROCALTA,
         VP_ABOCEL.IND_PROCEQUI,
         VP_ABOCEL.COD_VENDEDOR,
         VP_ABOCEL.COD_VENDEDOR_AGENTE,
         VP_ABOCEL.TIP_PLANTARIF,
         VP_ABOCEL.TIP_TERMINAL,
         VP_ABOCEL.COD_PLANTARIF,
         VP_ABOCEL.COD_CARGOBASICO,
         VP_ABOCEL.COD_PLANSERV,
         VP_ABOCEL.COD_LIMCONSUMO,
         VP_ABOCEL.NUM_SERIE,
         VP_ABOCEL.NUM_SERIEHEX,
         VP_ABOCEL.NOM_USUARORA,
         VP_ABOCEL.FEC_ALTA,
         VP_ABOCEL.NUM_PERCONTRATO,
         VP_ABOCEL.COD_ESTADO,
         VP_ABOCEL.NUM_SERIEMEC,
         VP_ABOCEL.COD_HOLDING,
         VP_ABOCEL.COD_EMPRESA,
         VP_ABOCEL.COD_GRPSERV,
         VP_ABOCEL.IND_SUPERTEL,
         VP_ABOCEL.NUM_TELEFIJA,
         VP_ABOCEL.COD_OPREDFIJA,
         VP_ABOCEL.COD_CARRIER,
         VP_ABOCEL.IND_PREPAGO,
         VP_ABOCEL.IND_PLEXSYS,
         VP_ABOCEL.COD_CENTRAL_PLEX,
         VP_ABOCEL.NUM_CELULAR_PLEX,
         VP_ABOCEL.NUM_VENTA,
         VP_ABOCEL.COD_MODVENTA,
         VP_ABOCEL.COD_TIPCONTRATO,
         VP_ABOCEL.NUM_CONTRATO,
         VP_ABOCEL.NUM_ANEXO,
         VP_ABOCEL.FEC_CUMPLAN,
         VP_ABOCEL.COD_CREDMOR,
         VP_ABOCEL.COD_CREDCON,
         VP_ABOCEL.COD_CICLO,
         VP_ABOCEL.IND_FACTUR,
         VP_ABOCEL.IND_SUSPEN,
         VP_ABOCEL.IND_REHABI,
         VP_ABOCEL.IND_INSGUIAS,
         VP_ABOCEL.FEC_FINCONTRA,
         VP_ABOCEL.FEC_RECDOCUM,
         VP_ABOCEL.FEC_CUMPLIMEN,
         VP_ABOCEL.FEC_ACEPVENTA,
         VP_ABOCEL.FEC_ACTCEN,
         VP_ABOCEL.FEC_BAJA,
         VP_ABOCEL.FEC_BAJACEN,
         VP_ABOCEL.FEC_ULTMOD,
         VP_ABOCEL.COD_CAUSABAJA,
         VP_ABOCEL.NUM_PERSONAL,
         VP_ABOCEL.IND_SEGURO,
         VP_ABOCEL.CLASE_SERVICIO,
         VP_ABOCEL.PERFIL_ABONADO,
         V_PREFIJO);
  EXCEPTION
       WHEN OTHERS THEN
        VP_SQLCODE :=SQLCODE;
        VP_SQLERRM :=SQLERRM;
        VP_ERROR := '4';
 END;
/
SHOW ERRORS
