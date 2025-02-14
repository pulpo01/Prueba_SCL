CREATE OR REPLACE TRIGGER PV_GA_INFACCEL_BEIN_TG
BEFORE INSERT ON GA_INFACCEL REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
  n_es_detllam   GA_SERVSUPL.COD_SERVICIO%TYPE;
  n_es_fyfcel    GA_SERVSUPL.COD_SERVICIO%TYPE;
  n_estado       GA_SERVSUPLABO.IND_ESTADO%TYPE;
  s_cod_cliente  GA_ABOCEL.COD_CLIENTE%TYPE;
  n_ciclo        GA_ABOCEL.COD_CICLO%TYPE;
  s_cod_ciclo    GA_INFACCEL.COD_CICLFACT%TYPE;

--        Autor : Andrés Osorio
--   Fecha:   11/09/2008

BEGIN

        :new.IND_DETALLE := 0;
/*
        SELECT a.COD_SERVICIO
        INTO   n_es_detllam
        FROM   GA_GRUPOS_SERVSUP a, GA_SERVSUPLABO b
        WHERE  a.COD_GRUPO = 'DETLLAM'
        AND    SYSDATE   BETWEEN a.fec_desde AND nvl(a.fec_hasta, SYSDATE)
        AND    b.num_abonado  = :new.NUM_ABONADO
        AND    a.COD_PRODUCTO = 1
        and    b.cod_producto = 1
        and    b.ind_estado  <= 2
        and    a.cod_servicio = b.cod_servicio;
*/
        select a.COD_SERVICIO
        INTO   n_es_detllam
        from   ga_servsuplabo A
	where  A.num_abonado   = :new.NUM_ABONADO
	and    A.cod_servicio IN (select B.cod_servicio
                                  from   ga_grupos_servsup B
                                  where  B.cod_grupo = 'DETLLAM')
        AND    A.IND_ESTADO < 3
        AND ROWNUM=1;

        IF (n_es_detllam IS NOT NULL) THEN
           :new.IND_DETALLE := 1;
        ELSE
           :new.IND_DETALLE := 0;
        END IF;

EXCEPTION
        WHEN OTHERS THEN
                 NULL;

END PV_GA_INFACCEL_BEIN_TG;
/
SHOW ERRORS
