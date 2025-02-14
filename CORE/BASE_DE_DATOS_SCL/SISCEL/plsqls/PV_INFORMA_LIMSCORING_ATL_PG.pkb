CREATE OR REPLACE PACKAGE BODY PV_INFORMA_LIMSCORING_ATL_PG IS

PROCEDURE PV_INFORMA_LIMSCORING_ATL_PR (EN_num_celular     IN GA_ABOCEL.num_celular%TYPE,
                                                                         SN_cod_retorno     OUT NOCOPY   ge_errores_pg.CodError,
                                                                         SV_mens_retorno    OUT NOCOPY   ge_errores_pg.MsgError,
                                                                         SN_num_evento      OUT NOCOPY   ge_errores_pg.Evento)
IS

  CV_CODACTABO_LIMSCOR                                   CONSTANT VARCHAR2(2) := 'I1';

  LN_num_abonado                                                 ga_abocel.num_abonado%TYPE;
  LV_tip_plantarif                                               ga_abocel.tip_plantarif%TYPE;
  LV_des_error                                                   VARCHAR2(255);

  abo_no_individual                                              exception;


BEGIN

         SELECT num_abonado,tip_plantarif
         INTO LN_num_abonado, LV_tip_plantarif
         FROM ga_abocel
         WHERE num_celular = EN_num_celular
         AND cod_situacion = 'AAA';

         IF NOT LV_tip_plantarif = 'I' THEN
                raise abo_no_individual;
         END IF;

         PV_OBTIENEINFO_ATLANTIDA_PG.PV_INS_MOV_ATLAN_PR( LN_num_abonado,
                                                                                                          CV_CODACTABO_LIMSCOR,
                                                                                                          NULL,
                                                                                                          NULL,
                                                                                                          SN_cod_retorno,
                                                                                                  SV_mens_retorno,
                                                                                                  SN_num_evento);


EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          SN_cod_retorno := 1;
                          SV_mens_retorno := 'La situación del abonado es distinta a alta activa abonado o número celular no existe.';
                          SN_num_evento := 0;
                 WHEN abo_no_individual THEN
                          SN_cod_retorno := 2;
                          SV_mens_retorno := 'El plan tarifario del abonado no es individual.';
                          SN_num_evento := 0;
                 WHEN OTHERS THEN
                    SN_cod_retorno   := 4;
                        SV_mens_retorno := 'Error no controlado.';
                        LV_des_error := SUBSTR(SQLERRM,1,255);
                        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento,
                                                                                                        'GA',SV_mens_retorno, '1.0', USER,
                                                                                                        'PV_INFORMA_LIMSCORING_ATL_PG.PV_INFORMA_LIMSCORING_ATL_PR',
                                                                                                        NULL, SQLCODE, LV_des_error );
END PV_INFORMA_LIMSCORING_ATL_PR;

END PV_INFORMA_LIMSCORING_ATL_PG;
/
SHOW ERRORS
