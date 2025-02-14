CREATE OR REPLACE PROCEDURE SC_P_ACUMULA_ASIENTO
(p_num_lote            IN   SC_CAB_LOTE.NUM_LOTE%TYPE
,p_cod_cuenta          IN   SC_ASIENTO_LOTE.COD_CUENTA%TYPE
,p_imp_movimiento      IN   SC_LOTE.IMP_MOVIMIENTO%TYPE
,p_ind_imputacion      IN   SC_EVENTO.IND_IMPUTACION%TYPE
,p_ind_agrupacion      IN   SC_EVENTO.IND_AGRUPACION%TYPE
,p_des_transaccion     IN   SC_LOTE.DES_TRANSACCION%TYPE
,p_ind_cuenta          IN   VARCHAR2
,p_cod_operadora       IN   SC_ENT_CAB_LOTE.COD_OPERADORA_SCL%TYPE
)
IS
------------------------------------------------------------------
-- Nombre PL/SQL       : SC_P_ACUMULA_ASIENTO                   --
-- Creado por          :                                        --
-- Fecha Creacion      : 02/08/2000                             --
-- Modificado por      : Marcelo Quiroz G                       --
-- Ultima Modificacion : 09/01/2003                             --
--                                                              --
-- Observacion  : Aplica imputacion contable por Tipo Reg       --
--  09/01/2003  - Se agrega cod_operadora y cod_plaza           --
------------------------------------------------------------------

v_nom_tabla       VARCHAR2(30):= 'SC_ASIENTO_LOTE';
v_des_operacion   VARCHAR2(6);
v_existe_lote     NUMBER;

BEGIN
  SELECT COUNT(*)
    INTO v_existe_lote
    FROM SC_ASIENTO_LOTE
   WHERE NUM_LOTE       = p_num_lote
     AND COD_CUENTA     = p_cod_cuenta
     AND IND_DIR_CUENTA = p_ind_cuenta
     AND COD_OPERADORA_SCL = p_cod_operadora;

  IF p_ind_agrupacion = 0 or p_ind_cuenta = 'C' THEN -- contrapartida
     -- si acumula
     IF v_existe_lote <> 0 THEN
        -- Si existe
        UPDATE SC_ASIENTO_LOTE
           SET IMP_DEBITO  = IMP_DEBITO + decode(p_ind_imputacion,'C',0,p_imp_movimiento),
               IMP_CREDITO = IMP_CREDITO + decode(p_ind_imputacion,'C',p_imp_movimiento,0),
               DES_TRANSACCION = NULL
         WHERE NUM_LOTE       =  p_num_lote
           AND COD_CUENTA     =  p_cod_cuenta
           AND IND_DIR_CUENTA = p_ind_cuenta
           AND COD_OPERADORA_SCL = p_cod_operadora;
     else
        -- No existe
        INSERT INTO SC_ASIENTO_LOTE(
                NUM_LOTE   , COD_CUENTA     ,
                IMP_DEBITO ,
                IMP_CREDITO,
                DES_TRANSACCION, IND_DIR_CUENTA,
                COD_OPERADORA_SCL)
             VALUES (
                p_num_lote , p_cod_cuenta ,
                decode(p_ind_imputacion,'C',0,p_imp_movimiento),
                decode(p_ind_imputacion,'C',p_imp_movimiento,0),
                NULL       , p_ind_cuenta  ,
                p_cod_operadora);
     end if;
  else
     -- no acumula
     INSERT INTO SC_ASIENTO_LOTE(
             NUM_LOTE   , COD_CUENTA,
             IMP_DEBITO ,
             IMP_CREDITO,
             DES_TRANSACCION,IND_DIR_CUENTA,
             COD_OPERADORA_SCL)
           VALUES (
             p_num_lote, p_cod_cuenta,
             decode(p_ind_imputacion,'C',0,p_imp_movimiento),
             decode(p_ind_imputacion,'C',p_imp_movimiento,0),
             p_des_transaccion,p_ind_cuenta,
             p_cod_operadora);
  end if;
END SC_P_ACUMULA_ASIENTO;
/
SHOW ERRORS
