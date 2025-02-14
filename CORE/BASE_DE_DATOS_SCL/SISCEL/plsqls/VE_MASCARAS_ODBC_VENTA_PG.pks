CREATE OR REPLACE PACKAGE VE_mascaras_odbc_venta_PG IS
/*
<Documentaci�n
  TipoDoc = "Package">
   <Elemento
      Nombre = "VE_mascaras_odbc_venta_PG"
      Lenguaje="PL/SQL"
      Fecha="13-09-2006"
      Versi�n="1.0"
      Dise�ador="Roberto P�rez"
          Programador="Roberto P�rez"
      Ambiente Desarrollo="DEIMOS_COL">
      <Retorno>NA</Retorno>
      <Descripci�n>Mascaras para llamar pl que tienen parametros de salida en ventas</Descripci�n>
      <Par�metros>
            <Entrada>
                </Entrada>
                <Salida>
            </Salida>
      </Par�metros>
   </Elemento>
</Documentaci�n>
*/
PROCEDURE VE_MASK_NP_ORIGENVENTA_PR(EN_numtrans IN ga_transacabo.num_transaccion%TYPE,
                                                                        EN_numserie IN al_series.num_serie%TYPE,
                                                                        EN_tipproc  IN PLS_INTEGER
                                                                   );

PROCEDURE VE_MASK_ACTIVA_NUMPERS_PR (EN_numtrans    IN ga_transacabo.num_transaccion%TYPE,
                                                                         EV_num_celular IN VARCHAR2,
                                                                         EV_cod_prog    IN VARCHAR2);

PROCEDURE VE_MASK_ACTIVA_NUMPERSONAL_PR(EV_numtrasnsacc   IN ga_transacabo.num_transaccion%TYPE,
                                                                            EV_num_cel_pers       IN VARCHAR2,
                                                                        EV_num_cel_corp   IN VARCHAR2,
                                                                        EN_num_movimiento IN icc_movimiento.num_movant%TYPE,
                                                                        EV_cod_prog               IN VARCHAR2);
END VE_mascaras_odbc_venta_PG;
/
SHOW ERRORS
