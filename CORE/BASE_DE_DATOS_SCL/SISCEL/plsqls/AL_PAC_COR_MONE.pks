CREATE OR REPLACE PACKAGE Al_Pac_Cor_Mone IS
--
PROCEDURE P_AL_CON_ORDENES(
v_num_corre    IN   AL_CAB_COR_MONE.num_corre%TYPE,
v_fec_corre    IN   AL_CAB_COR_MONE.fec_corre%TYPE,
v_ind_proc     IN   AL_ARTICULOS.ind_proc%TYPE,
v_cod_arti     IN   AL_ARTICULOS.cod_articulo%TYPE,
v_tip_arti     IN   AL_ARTICULOS.tip_articulo%TYPE,
v_año          IN   AL_ARTICULOS.des_articulo%TYPE);
--
PROCEDURE P_AL_SIN_ORDENES(
v_num_corre    IN   AL_CAB_COR_MONE.num_corre%TYPE,
v_fec_corre    IN   AL_CAB_COR_MONE.fec_corre%TYPE,
v_ind_proc     IN   AL_ARTICULOS.ind_proc%TYPE,
v_cod_arti     IN   AL_ARTICULOS.cod_articulo%TYPE,
v_tip_arti     IN   AL_ARTICULOS.tip_articulo%TYPE,
v_año          IN   AL_ARTICULOS.des_articulo%TYPE);
--
PROCEDURE P_SEMESTRE2_CON_ORDENES1(
v_num_corre    IN   AL_CAB_COR_MONE.num_corre%TYPE,
v_fec_corre    IN   AL_CAB_COR_MONE.fec_corre%TYPE,
v_ind_proc     IN   AL_ARTICULOS.ind_proc%TYPE,
v_cod_arti     IN   AL_ARTICULOS.cod_articulo%TYPE,
v_tip_arti     IN   AL_ARTICULOS.tip_articulo%TYPE,
v_año   	       IN   AL_ARTICULOS.des_articulo%TYPE);
--
END Al_Pac_Cor_Mone;
/
SHOW ERRORS
