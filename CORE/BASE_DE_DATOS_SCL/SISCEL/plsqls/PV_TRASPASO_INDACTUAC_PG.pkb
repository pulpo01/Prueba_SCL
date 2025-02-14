CREATE OR REPLACE PACKAGE BODY Pv_traspaso_IndActuac_pg AS


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




PROCEDURE GA_Actualiza_IndActuac_PR(EN_num_abonado IN NUMBER,
                                    EN_cod_cliente IN NUMBER,
                                    EN_CicloFact      IN NUMBER,
                    SV_mens_retorno     OUT NOCOPY VARCHAR2,
                    SV_cod_retorno      OUT NOCOPY NUMBER
                                                         ) IS
/*
<Documentacion TipoDoc = "Procedure">
   <Elemento
      Nombre = "ga_traspado_IndActuac_pg"
      Fecha modificacion=" "
      Fecha creacion="15/06/2007"
      Programador="José Jara"
      Diseñador=""
      Ambiente Desarrollo="BD">
      <Retorno>N/A</Retorno>
      <Descripcion>busca en ga_infaccel registro de traspaso ya realizado con ind_actuac = 3</Descripcion>
      <Parametros>
         <Entrada>
                         <param nom="EN_num_abonado" Tipo="numerico">Numero Abonado </param>
                         <param nom="EN_cod_cliente" Tipo="numerico">Codigo Cliente </param>
                         <param nom="EN_CicloFact" Tipo="numerico">Ciclo de facturacion</param>
         </Entrada>
         <Salida>
            <param nom="SV_mens_retorno"      Tipo="CARACTER">Mensaje de Retorno</param>
            <param nom="SV_cod_retorno"      Tipo="CARACTER">Codigo de Retorno</param>
         </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
LV_Ind_Atuac      ga_infaccel.IND_ACTUAC%TYPE;
vv_MensajeErr              VARCHAR2(255);
vv_CodigoErr               number;


BEGIN
    vv_MensajeErr   := '';
    sv_mens_retorno := NULL;
    SV_cod_retorno  := 0;

        SELECT val_parametro into LV_Ind_Atuac
        FROM ged_parametros
        WHERE nom_parametro = 'IND_ACTUAC_TRASPASO';


        UPDATE ga_infaccel
        SET ind_actuac = LV_Ind_Atuac
        WHERE cod_cliente = EN_cod_cliente
        and num_abonado = EN_num_abonado
        and cod_ciclfact = EN_CicloFact
        and ind_actuac = 3
        and fec_alta = (  select max(fec_alta) from ga_infaccel
                                          where COD_CICLFACT= EN_CicloFact
                                          and cod_cliente = EN_cod_cliente
                                          and num_abonado = EN_num_abonado
                                          and ind_actuac = 3
                                   );


EXCEPTION
  WHEN OTHERS THEN
      vv_MensajeErr := 'Error al actualizar ind_actuac en ga_infaccel, al realizar traspaso u/o reordenamiento';
          vv_CodigoErr :=       SQLCODE;
      INSERT INTO GA_ERRORES ( COD_ACTABO, CODIGO, FEC_ERROR, COD_PRODUCTO, NOM_PROC, NOM_TABLA, COD_ACT,COD_SQLCODE, COD_SQLERRM )
      VALUES ('GA', EN_num_abonado,  SYSDATE, 1, 'GA_Actualiza_IndActuac_PR', 'ga_infaccel', 'U', vv_CodigoErr, vv_MensajeErr);
      SV_cod_retorno := 4;
      SV_mens_retorno := vv_MensajeErr;
END GA_Actualiza_IndActuac_PR;


END Pv_traspaso_IndActuac_pg;
/
SHOW ERRORS
