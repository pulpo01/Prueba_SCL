CREATE OR REPLACE FUNCTION PV_TOTALABONOSPERIODO_FN (
   ET_COD_CLIENTE  in ga_abocel.COD_CLIENTE%type,
   EV_FECHA_PERIODO IN varchar2) RETURN NUMBER IS
/*
<Documentación
  TipoDoc = "Funcion">
   <Elemento
      Nombre = "PV_TOTALABONOSPERIODO_FN"
      Lenguaje="PL/SQL"
      Fecha creación="28-02-2007"
      Creado por="Gonzalo Salas Paillao"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>La suma completa de abono de un cliente</Retorno>
      <Descripción>Permite la consulta de abonos</Descripción>
      <Parámetros>
         <Entrada>
            <param nom="ET_COD_CLIENTE" Tipo="NUMBER">Codigo del cliente</param>
            <param nom="EV_FECHA_PERIODO" Tipo="VARCHAR">Fecha perteneciente a un periodo</param>
         </Entrada>
         <Salida>
           <param nom="v_abono" Tipo="NUMBER">suma de abonos </param>
         </Salida>
      </Parámetros>
   </Elemento>
</Documentación>
*/


v_FecPeriodo   date;
v_abono        number;
BEGIN

   v_FecPeriodo := to_date(nvl(EV_FECHA_PERIODO, sysdate));

   Begin
      Begin-- Revision de abonos en el periodo.

        SELECT nvl(sum(imp_pago),0) abonos
        INTO v_abono
        FROM tol_pago_limite_to p, fa_ciclfact c
        where  cod_cliente = ET_COD_CLIENTE
        and p.cod_ciclo = c.cod_ciclo
        and p.fec_efectividad between c.FEC_DESDELLAM and c.FEC_HASTALLAM
        and v_FecPeriodo between c.FEC_DESDELLAM and c.FEC_HASTALLAM;

      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         v_abono := null;
        WHEN OTHERS THEN
         v_abono := null;
      end;
   End;

   RETURN v_abono;

END PV_TOTALABONOSPERIODO_FN;
/
SHOW ERRORS
