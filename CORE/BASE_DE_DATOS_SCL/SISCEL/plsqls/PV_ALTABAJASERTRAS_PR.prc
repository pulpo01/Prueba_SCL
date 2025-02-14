CREATE OR REPLACE procedure PV_ALTABAJASERTRAS_PR
(VP_PRODUCTO IN NUMBER,
 VP_ABONADO  IN NUMBER,
 VP_PROC     IN OUT VARCHAR2,
 VP_TABLA    IN OUT VARCHAR2,
 VP_ACT      IN OUT VARCHAR2,
 VP_SQLCODE  IN OUT VARCHAR2,
 VP_SQLERRM  IN OUT VARCHAR2,
 VP_ERROR    IN OUT VARCHAR2)
IS
-- PL/SQL Specification
--
-- *************************************************************
-- * procedimiento      : PV_ALTABAJASERTRAS_PR
-- * Descripcisn        :    Procedimiento que refleja la baja POR TRASPASO  de abonados marcando fecha fin vigencia
                          -- en las tablas de interfase con tarificacion y facturacion
                          -- Ademas permite dar de baja servicios suplementarios en Base de Dato
                          --            Los posibles retornos del procedimiento son :
                          --                - '0' Actualizaciones realizadas correctamente
                          --                - '4' Error en el proceso
-- * Fecha de creacisn  : 13-01-2003 15:00
-- * Responsable        : Area Postventa
-- *************************************************************
   CURSOR C1 IS
   SELECT ROWID,COD_SERVICIO --AHOTT 28/01/2006 RA-594
   FROM GA_SERVSUPLABO
   WHERE NUM_ABONADO = VP_ABONADO
         AND IND_ESTADO < 3;

   V_ROWID               ROWID;
   V_ESTADO_BAJA NUMBER;
   -- Inicio modificacion by SAQL/Soporte 30/01/2006 - RA-200601160594
   V_SERVICIO GA_SERVSUPLABO.COD_SERVICIO%TYPE;
   V_SERVICIO2 GA_SERVSUPLABO.COD_SERVICIO%TYPE;
   -- Fin modificacion by SAQL/Soporte 30/01/2006 - RA-200601160594

   V_CICLFACT GA_INFACCEL.COD_CICLFACT%TYPE;
BEGIN
   V_ESTADO_BAJA  :=4;
   VP_PROC                := 'PV_ALTABAJASERTRAS_PR';
   VP_TABLA       := 'C1';
   VP_ACT                 := 'O';

   OPEN C1;
   LOOP

   VP_TABLA := 'GA_SERVSUPLABO';
   VP_ACT   := 'I';
   FETCH C1 INTO V_ROWID,V_SERVICIO; --AHOTT 28/01/2006 RA-594
   -- Nuevo registro con los mismos SS , pero con fecha de alta en central y base de datos igual a sysdate
   --TM-200404160627, German Espinoza Z. 23/04/2004; 10:15 hrs.
   --del select se inicializaron las fechas FEC_BAJABD y FEC_BAJACEN a null estaban en TO_DATE('31-12-3000','DD-MM-YYYY')
   --AHOTT 28/01/2006 RA-594
   BEGIN

   SELECT COD_SERVICIO INTO V_SERVICIO2
   FROM GA_SERVSUPLABO
   WHERE NUM_ABONADO=VP_ABONADO
   AND COD_SERVICIO=V_SERVICIO
   AND FEC_ALTABD=SYSDATE;

   EXCEPTION

   WHEN NO_DATA_FOUND THEN
   --AHOTT 28/01/2006 RA-594
         INSERT INTO  GA_SERVSUPLABO
         (
         NUM_ABONADO,COD_SERVICIO,FEC_ALTABD,COD_SERVSUPL,
         COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,NOM_USUARORA,
         IND_ESTADO,FEC_ALTACEN,FEC_BAJABD,FEC_BAJACEN,
         COD_CONCEPTO,NUM_DIASNUM
         )
     SELECT
         NUM_ABONADO,COD_SERVICIO,SYSDATE,COD_SERVSUPL,
         COD_NIVEL,COD_PRODUCTO,NUM_TERMINAL,
		 --NOM_USUARORA,  RRG 76758 23-01-2009 col
		 user, --		  RRG 76758 23-01-2009 col
		 2,
--         SYSDATE,TO_DATE('31-12-3000','DD-MM-YYYY'),TO_DATE('31-12-3000','DD-MM-YYYY'),
		 SYSDATE,null,null,
         COD_CONCEPTO,NUM_DIASNUM
         FROM  GA_SERVSUPLABO
         WHERE
         ROWID           = V_ROWID
         AND NUM_ABONADO = VP_ABONADO
         AND IND_ESTADO  < 3;
   --FIN TM-200404160627, German Espinoza Z. 23/04/2004; 10:15 hrs.
   -- Nuevo registro con los mismos SS , pero con fecha de baja en central y base de datos igual a sysdate
   END; --AHOTT 28/01/2006 RA-594
         UPDATE GA_SERVSUPLABO
     SET FEC_BAJABD  = SYSDATE,
                  FEC_BAJACEN = SYSDATE,
          IND_ESTADO  = V_ESTADO_BAJA
     WHERE ROWID     = V_ROWID;

     EXIT WHEN C1%NOTFOUND;

   END LOOP;
   CLOSE C1;
   VP_ERROR:='0';
EXCEPTION
   WHEN OTHERS THEN
        VP_SQLCODE := SQLCODE;
        VP_SQLERRM := SQLERRM;
        VP_ERROR := '4';
END;
/
SHOW ERRORS
