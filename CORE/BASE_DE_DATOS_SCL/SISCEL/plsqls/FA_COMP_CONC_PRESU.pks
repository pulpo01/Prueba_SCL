CREATE OR REPLACE PACKAGE        fa_comp_conc_presu is
  Procedure p_concepto(v_rec_histdocu in out Fa_HistDocu%ROWTYPE,
		       v_rec_presupuesto in out Fa_Presupuesto%ROWTYPE,
		       v_rec_histconccelu in out Fa_HistConcCelu%ROWTYPE,
                       v_rec_datosgener in Ge_DatosGener%ROWTYPE,
                       v_cod_monefact in out Fa_DatosGener.Cod_MoneFact%TYPE);
  Procedure p_buildconc  (v_rec_histdocu in Fa_HistDocu%ROWTYPE,
			  v_rec_presupuesto in Fa_Presupuesto%ROWTYPE,
			  v_rec_histconccelu out Fa_HistConcCelu%ROWTYPE,
                          v_cod_monefact in Fa_DatosGener.Cod_MoneFact%TYPE);
  Procedure p_insertbeep  (v_rec_histconcbeep in Fa_HistConcBeep%ROWTYPE);
  Procedure p_insertcelu  (v_rec_histconccelu in Fa_HistConcCelu%ROWTYPE);
  Procedure p_inserttrek  (v_rec_histconctrek in Fa_HistConcTrek%ROWTYPE);
  Procedure p_inserttrunk (v_rec_histconctrunk in Fa_HistConcTrunk%ROWTYPE);
  Procedure p_insertgene  (v_rec_histconcgene in Fa_HistConcGene%ROWTYPE);
end fa_comp_conc_presu;
/
SHOW ERRORS
