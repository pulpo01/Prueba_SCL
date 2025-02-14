CREATE OR REPLACE PACKAGE SE_LC_PLAN_ADICIONAL_PG IS

TYPE refCursor IS REF CURSOR;
CV_error_no_clasif      CONSTANT VARCHAR2 (50) := 'No es posible clasificar el error';
CV_cod_modulo           CONSTANT VARCHAR2 (2)  := 'SE';
CV_version              CONSTANT VARCHAR2 (2)  := '1';


   PROCEDURE SE_OBTIENE_LC_PR(
    EO_PLANES_ADIC       IN  SE_DETALLE_ESPEC_TO_QT,
	EN_COD_CLIENTE      IN GE_CLIENTES.COD_CLIENTE%TYPE,
    SO_LIMITES			OUT NOCOPY	refcursor,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
    ) ;

PROCEDURE SE_INSERTA_LC_PR(
	EO_LIMITES   IN     SE_LC_LISTA_QT,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
);

PROCEDURE SE_ACTUALIZA_LC_PR(
	EO_PRODUCTOS        IN         PR_PRODUCTO_DES_LST_QT,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
);

PROCEDURE SE_CAMBIO_LC_PR(
	EO_PRODUCTOS        IN         PR_PRODUCTO_DES_LST_QT,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
);

PROCEDURE SE_CONSULTA_ABONO_PR(
	EN_COD_CLIENTE       IN ga_abocel.cod_cliente%TYPE,
	EN_NUM_ABONADO     	 IN ga_abocel.num_abonado%TYPE,
	SO_LIMITES			OUT NOCOPY	refcursor,
	SN_cod_retorno      OUT NOCOPY ge_errores_pg.coderror,
	SV_mens_retorno     OUT NOCOPY ge_errores_pg.msgerror,
	SN_num_evento       OUT NOCOPY ge_errores_pg.evento
);

END SE_LC_PLAN_ADICIONAL_PG;
/
