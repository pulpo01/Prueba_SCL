CREATE OR REPLACE PACKAGE BODY GA_MODCLI_MOD_PG AS

CV_error_no_clasif VARCHAR2(100) := 'Error no clasificado';

  PROCEDURE GA_INSERTA_PR (TE_modcli IN GA_MODCLI%ROWTYPE, SN_COD_RETORNO OUT NOCOPY NUMBER, SV_MENS_RETORNO OUT NOCOPY VARCHAR2, SN_NUM_EVENTO OUT NOCOPY NUMBER)
  AS
/*
<Documentacion
  TipoDoc = Procedimiento">
   <Elemento
      Nombre = "GA_INSERTA_PR"
      Lenguaje="PL/SQL"
      Fecha creacion="01-07-2008"
      Creado por="nn"
      Fecha modificacion=""
      Modificado por=""
      Ambiente Desarrollo="BD">
      <Retorno>NA</Retorno>
      <Descripcion>inserta en GA_cliente_to</Descripcion>
      <Parámetros>
          <Entrada>
         </Entrada>
         <Salida>
                 </Salida>
      </Parametros>
   </Elemento>
</Documentacion>
*/
  Lv_SQL VARCHAR2(100);

  -- Inc 72847 PPV 14/11/2008
  TE2_modcli GA_MODCLI%ROWTYPE;

  BEGIN
     SN_COD_RETORNO := 0;
     SV_mens_retorno := NULL;
     SN_num_evento := 0;

     lv_sql := 'INSERT INTO GA_MODCLI VALUES()';
     INSERT INTO GA_MODCLI VALUES TE_modcli;

  EXCEPTION
    -- Inc 72847 PPV 14/11/2008 Se maneja las claves duplicadas
    WHEN DUP_VAL_ON_INDEX THEN
		 BEGIN
		 	TE2_modcli  := TE_modcli;
		  TE2_modcli.fec_modifica :=  TE_modcli.fec_modifica + (1/24/60/60); --LA FECHA MAS 1 SEGUNDO
		  lv_sql := 'INSERT INTO GA_MODCLI VALUES()';
      INSERT INTO GA_MODCLI VALUES TE2_modcli;
		 EXCEPTION
			WHEN OTHERS THEN
           SN_COD_RETORNO :=1951; -- -90 Error al insertar cambios históricos del cliente
           IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
              SV_mens_retorno := CV_error_no_clasif;
           END IF;
           SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODCLI_MOD_PG.GA_INSERTA_PR', lv_sql, SQLCODE, SQLERRM );
		 END;
	  -- Fin Inc 72847 PPV 14/11/2008
    WHEN OTHERS THEN
            SN_COD_RETORNO :=1951; -- -90 Error al insertar cambios históricos del cliente
            IF NOT Ge_Errores_Pg.MENSAJEERROR(SN_cod_retorno,SV_mens_retorno) THEN
                 SV_mens_retorno := CV_error_no_clasif;
            END IF;

            SN_num_evento  := Ge_Errores_Pg.Grabarpl( SN_num_evento, 'GA', SV_mens_retorno, 1.0, USER, 'GA_MODCLI_MOD_PG.GA_INSERTA_PR', lv_sql, SQLCODE, SQLERRM );
  END;

END;
/
SHOW ERRORS
