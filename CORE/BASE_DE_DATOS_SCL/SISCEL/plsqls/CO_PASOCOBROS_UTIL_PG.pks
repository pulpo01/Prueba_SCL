CREATE OR REPLACE package co_pasocobros_util_pg as

    CV_VERSION constant varchar2(10) :='1.0';

	CV_SINGLE_HOST constant varchar2(40) :='DEFAULT_HOST';
    CV_PROGRAMA_ID constant varchar2(40) :='PASOCOBROSCICLO';

	CV_SINONIMO_DOCUMENTOS constant varchar2(30) :='FA_DOCUMENTOS_SY';
	CV_SINONIMO_CONCEPTOS  constant varchar2(30) :='FA_CONCEPTOSDOC_CICLO_SY';
	CN_EXITO constant number :=0;

	CN_ERROR_PARAMETROS constant number :=1;
    CN_ERROR_PROCESO constant number :=2;

	procedure co_inicializar_pasocobros_fn (
	    en_ciclo in number,
		ev_host  in varchar2,
		sn_error out nocopy number,
		sv_mensaje out nocopy varchar2
	);

    procedure co_finalizar_pasocobros_fn (
	    en_ciclo in number,
		ev_host  in varchar2,
		sn_error out nocopy number,
		sv_mensaje out nocopy varchar2
	);

end;
/
SHOW ERRORS
