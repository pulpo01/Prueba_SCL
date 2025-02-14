CREATE OR REPLACE PACKAGE BODY GA_ELIGEDIRECCION_PG IS

PROCEDURE GA_DATOSCLIENTE_PR (EV_cod_cliente IN OUT NOCOPY VARCHAR2,
                              EV_apellido    IN OUT NOCOPY VARCHAR2,
                              EV_salida      IN OUT NOCOPY VARCHAR2) AS
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "GA_DATOSCLIENTE" Lenguaje="PL/SQL" Fecha="23-04-2007" Versión="1.0.0" Diseñador="Gonzalo Salas" Programador="Gonzalo Salas" Ambiente="BD">
<Retorno>NA</Retorno>

<Descripción>Procedimeinto que entrega como resultado el primer apellido del cliente y el codigo del cliente.</Descripción>
<Parámetros>

    <Entrada>
        <param nom="EV_COD_CLIENTE" Tipo="VARCHAR2">Cocigo del Cliente</param>
        <param nom="EV_APELLIDO" Tipo="VARCHAR2">Primer apellido del cliente</param>
        <param nom="EV_SALIDA" Tipo="VARCHAR2">Entrega un mensaje de error si lo ubiese</param>
    </Entrada>

    <Salida>
        <param nom="EV_APELLIDO" Tipo="VARCHAR2">Retorna el primer apellido del cliente</param>
        <param nom="EV_SALIDA" Tipo="VARCHAR2">Entrega un mensaje de error si lo ubiese</param>
    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

v_COD_CLIENTE  GE_CLIENTES.NUM_IDENT%TYPE;
v_Apellido1    GE_CLIENTES.NOM_APECLIEN1%TYPE;
BEGIN
   Begin
      SELECT cli.NUM_IDENT , cli.NOM_APECLIEN1
          INTO v_COD_CLIENTE , v_Apellido1
      FROM GE_CLIENTES cli
          Where cli.COD_CLIENTE = EV_COD_CLIENTE
          And cli.COD_TIPIDENT = '01';

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
           v_COD_CLIENTE := '0';
           v_Apellido1 := '0';
       EV_salida := '(NDF) Error al buscar Datos del cliente'||sqlerrm;
     WHEN OTHERS THEN
           v_COD_CLIENTE := '0';
           v_Apellido1 := '0';
       EV_salida := 'OTHERS '|| substr(sqlerrm,1,50);
   End;

   EV_cod_cliente   := v_COD_CLIENTE;
   EV_apellido      := v_Apellido1;

END GA_DATOSCLIENTE_PR;




PROCEDURE GA_IP_COLOMBIA_PR (EV_ip          IN OUT NOCOPY VARCHAR2,
                             EV_puerto      IN OUT NOCOPY VARCHAR2,
                             EV_codregistro IN OUT NOCOPY VARCHAR2,
                             EV_salida      IN OUT NOCOPY VARCHAR2) AS
/*
<Documentación TipoDoc = "Procedure">
<Elemento Nombre = "GA_IP_COLOMBIA_PR" Lenguaje="PL/SQL" Fecha="23-04-2007" Versión="1.0.0" Diseñador="Gonzalo Salas" Programador="Gonzalo Salas" Ambiente="BD">
<Retorno>NA</Retorno>

<Descripción>Procedimiento que entrega como resultado la IP, el puerto de comunicacion y ademas un codigo de seleccion de registro.</Descripción>
<Parámetros>

    <Entrada>
        <param nom="EV_IP" Tipo="VARCHAR2">IP del servido a conectarce</param>
        <param nom="EV_PUERTO" Tipo="VARCHAR2">Puerto abilitado</param>
        <param nom="EV_CODREGISTRO" Tipo="VARCHAR2">Codigo de seleccion de registro</param>
    </Entrada>

    <Salida>
        <param nom="EV_IP" Tipo="VARCHAR2">IP del servido a conectarce</param>
        <param nom="EV_PUERTO" Tipo="VARCHAR2">Puerto abilitado</param>
        <param nom="EV_CODREGISTRO" Tipo="VARCHAR2">Codigo de seleccion de registro</param>
        <param nom="EV_SALIDA" Tipo="VARCHAR2">Entrega un mensaje de error si lo ubiese</param>    </Salida>
</Parámetros>
</Elemento>
</Documentación>
*/

v_sIp          VARCHAR2(15);
v_sPuerto      VARCHAR2(5);
v_sCodRegistro VARCHAR2(5);

BEGIN
   EV_SALIDA  := null;

   Begin
      SELECT VALOR_TEXTO
      Into v_sIp
      FROM   GA_PARAMETROS_SIMPLES_VW
      Where NOM_PARAMETRO IN ('IP_CONEXION_SERV');
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       EV_salida := '(NDF)Error al buscar IP'||sqlerrm;
   End;

   Begin
      SELECT VALOR_TEXTO
      Into v_sPuerto
      FROM   GA_PARAMETROS_SIMPLES_VW
      Where NOM_PARAMETRO IN ('PUERTO_CONEX_SERV');
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       EV_salida := '(NDF)Error al buscar PUERTO'||sqlerrm;
   End;
   Begin
      SELECT VALOR_NUMERICO
          Into v_sCodRegistro
      FROM   GA_PARAMETROS_SIMPLES_VW
      WHERE  NOM_PARAMETRO IN ('COD_RETORNO_EXTERNO');
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       EV_salida := '(NDF)Error al buscar CODIGO'||sqlerrm;
   End;

   EV_ip          := v_sIp;
   EV_puerto      := v_sPuerto;
   EV_codregistro := v_sCodRegistro;


   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       EV_salida := 'NO_DATA_FOUND';
     WHEN OTHERS THEN
       EV_salida := 'OTHERS'|| substr(sqlerrm,1,50);
END GA_IP_COLOMBIA_PR;


END GA_ELIGEDIRECCION_PG;
/
SHOW ERRORS
