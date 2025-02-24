CREATE OR REPLACE PROCEDURE P_ALTA_NOCICLOCLI(
  VP_PRODUCTO IN NUMBER ,
  VP_CLIENTE IN NUMBER ,
  VP_ABONADO IN NUMBER ,
  VP_CICLO IN NUMBER ,
  VP_INDACREC IN CHAR ,
  VP_AGENTE IN NUMBER ,
  VP_CREDMOR IN CHAR ,
  VP_USUARIO IN NUMBER ,
  VP_PROC IN OUT VARCHAR2 ,
  VP_TABLA IN OUT VARCHAR2 ,
  VP_ACT IN OUT VARCHAR2 ,
  VP_SQLCODE IN OUT VARCHAR2 ,
  VP_SQLERRM IN OUT VARCHAR2 ,
  VP_ERROR IN OUT CHAR )
IS
--
-- Procedimiento que realiza el alta de abonados de producto en la tabla
-- base de abonados no facturables
--
--            Los posibles retornos del procedimiento son :
--                - '0' Actualizaciones realizadas correctamente
--                - '4' Error en el proceso
--
   V_CLIENTE FA_CICLOCLINOFAC.COD_CLIENTE%TYPE;
   V_CICLO FA_CICLOCLINOFAC.COD_CICLO%TYPE;
   V_CALCLIEN FA_CICLOCLINOFAC.COD_CALCLIEN%TYPE;
   V_DEBITO FA_CICLOCLINOFAC.IND_DEBITO%TYPE;
   V_NOMUSU FA_CICLOCLINOFAC.NOM_USUARIO%TYPE;
   V_APEUSU1 FA_CICLOCLINOFAC.NOM_APELLIDO1%TYPE;
   V_APEUSU2 FA_CICLOCLINOFAC.NOM_APELLIDO2%TYPE;
BEGIN
   VP_PROC := 'P_ALTA_NOCICLOCLI';
   IF VP_INDACREC = 'A' THEN
      V_CLIENTE := VP_CLIENTE;
      V_CICLO := VP_CICLO;
   ELSE
      VP_TABLA := 'VE_VENDEDORES';
      VP_ACT := 'S';
      SELECT COD_CLIENTE
        INTO V_CLIENTE
        FROM VE_VENDEDORES
       WHERE COD_VENDEDOR = VP_AGENTE;

	  VP_TABLA := 'GE_CLIENTES';
      VP_ACT := 'S';
      SELECT COD_CICLO
        INTO V_CICLO
        FROM GE_CLIENTES
       WHERE COD_CLIENTE = V_CLIENTE;
   END IF;
   VP_TABLA := 'GA_USUARIOS';
   VP_ACT := 'S';
   SELECT NOM_USUARIO,NOM_APELLIDO1,NOM_APELLIDO2
     INTO V_NOMUSU,V_APEUSU1,V_APEUSU2
     FROM GA_USUARIOS
    WHERE COD_USUARIO = VP_USUARIO;
   dbms_output.put_line ('entra select clientes');
   VP_TABLA := 'GE_CLIENTES';
   SELECT COD_CALCLIEN,DECODE(IND_DEBITO,'A',1,'M',0)
     INTO V_CALCLIEN,V_DEBITO
     FROM GE_CLIENTES
    WHERE COD_CLIENTE = V_CLIENTE;
   dbms_output.put_line ('sale select clientes');
   dbms_output.put_line ('entra insert ciclocli');
   VP_TABLA := 'FA_CICLOCLINOFAC';
   VP_ACT := 'I';
   INSERT INTO FA_CICLOCLINOFAC
                 (COD_CLIENTE,COD_CICLO,COD_PRODUCTO,
                  NUM_ABONADO,COD_CALCLIEN,IND_DEBITO,
    COD_CREDMOR,NOM_USUARIO,NOM_APELLIDO1,
    NOM_APELLIDO2,IND_CAMBIO)
          VALUES (V_CLIENTE,V_CICLO,VP_PRODUCTO,
                  VP_ABONADO,V_CALCLIEN,V_DEBITO,
    VP_CREDMOR,V_NOMUSU,V_APEUSU1,
    V_APEUSU2,0);
   dbms_output.put_line ('sale insert ciclocli');
EXCEPTION
   WHEN OTHERS THEN
 IF SQLCODE = -1 THEN
    NULL;
        ELSE
    VP_SQLCODE := SQLCODE;
    VP_SQLERRM := SQLERRM;
           VP_ERROR := '4';
        END IF;
END;
/
SHOW ERRORS
