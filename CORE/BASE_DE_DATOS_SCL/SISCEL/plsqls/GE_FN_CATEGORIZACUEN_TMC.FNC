CREATE OR REPLACE FUNCTION Ge_Fn_CategorizaCuen_TMC (
   v_num_ident      IN   VARCHAR2,
   v_cod_catribut   IN   VARCHAR2,
   v_tipo_modulo    IN   VARCHAR2
)
Return Varchar2 IS
   v_cod_categoria      gad_categ_catsubcat.cod_categoria%TYPE;
   v_cod_subcategoria   gad_categ_catsubcat.cod_subcategoria%TYPE;
   v_ind_multuso        gat_categ_ctas_potenciales.ind_multuso%TYPE;
   v_des_razon_social   gat_categ_ctas_potenciales.des_razon_social%TYPE;
   v_ind_ctapotencial   CHAR (1)                                           := 'N';
   v_rut                NUMBER;
   v_cadena             ga_transacabo.des_cadena%TYPE                    := NULL;
   error_proceso        EXCEPTION;
BEGIN
   BEGIN

      SELECT cod_categoria, cod_subcategoria, ind_multuso,
             des_razon_social
        INTO v_cod_categoria, v_cod_subcategoria, v_ind_multuso,
             v_des_razon_social
        FROM gat_categ_ctas_potenciales
       WHERE num_ident = v_num_ident
         AND ind_vigencia = 'S';

	  v_ind_ctapotencial := 'S';

   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         BEGIN
		    v_rut := TO_NUMBER (LPAD (v_num_ident, INSTR (v_num_ident, '-') - 1, ' '));

			IF v_rut > 50000000
            THEN
               IF TO_NUMBER(v_tipo_modulo) = 1
               THEN
                  SELECT val_parametro
                    INTO v_cod_categoria
                    FROM ged_parametros
                   WHERE nom_parametro = 'COD_CATEMP_DEFAULT';
               ELSE
                  v_cod_categoria := -1;
               END IF;
            ELSE
               IF v_cod_catribut = 'F'
               THEN
                  v_cod_categoria := 4;
               ELSE
                  v_cod_categoria := 5;
               END IF;
            END IF;
            v_ind_multuso := 'N';
            v_des_razon_social := NULL;

			SELECT cod_subcategoria
              INTO v_cod_subcategoria
              FROM gad_categ_catsubcat
             WHERE cod_categoria = v_cod_categoria
               AND ind_default = 'S';

         	EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_cod_subcategoria := NULL;
         END;

   END;
   RAISE error_proceso;
EXCEPTION
   WHEN OTHERS
   THEN
      v_cadena :=    '/'
                  || TO_CHAR (v_cod_categoria)
                  || '/'
                  || v_cod_subcategoria
                  || '/'
                  || v_ind_multuso
                  || '/'
                  || v_ind_ctapotencial
                  || '/'
                  || v_des_razon_social;

        Return v_cadena;
END;
/
SHOW ERRORS
