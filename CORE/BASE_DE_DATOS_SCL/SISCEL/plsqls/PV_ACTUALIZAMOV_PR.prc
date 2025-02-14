CREATE OR REPLACE procedure PV_ACTUALIZAMOV_PR(
           TN_nummovimiento     in ICC_MOVIMIENTO.num_movimiento%TYPE,
           TV_codmodulo in ICC_MOVIMIENTO.cod_modulo%TYPE,
           TN_codestado in ICC_INTERFAZ_CONSULTAS_TO.cod_estado%TYPE
)
/*
<NOMBRE>        : PV_ACTUALIZAMOV_PR.</NOMBRE>
<FECHACREA>     : 01/04/2004 <FECHACREA/>
<MODULO >       : Gesti�n Abonados </MODULO >
<AUTOR >    : Patricio Gallegos C. </AUTOR >
<VERSION >      : 1.0 </VERSION >
<DESCRIPCION> : Actualiza estado del movimiento en tablas CI_ORSERV � PV_MOVIMIENTOS
seg�n corresponda.</DESCRIPCION>
<FECHAMOD >    : DD/MM/YYYY </FECHAMOD >
<DESCMOD >     : Breve descripci�n de Modificaci�n </DESCMOD >
<ParamEnt >  : N�mero Movimiento (TN_nummovimiento)
                         : C�digo Modulo (TV_codmodulo)
                         :C�digo Estado Movimiento (TN_codestado) </ParamEnt>
<ParamSal >  : </ParamSal>
*/
IS
BEGIN

        IF TV_codmodulo='GA' THEN
           BEGIN

                        UPDATE CI_ORSERV
                        SET cod_estado = TN_codestado
                        WHERE num_movimiento = TN_nummovimiento
                        AND cod_estado != TN_codestado;

                        IF SQL%NOTFOUND THEN

                                UPDATE PV_MOVIMIENTOS
                                SET cod_estado = TN_codestado
                                WHERE num_movimiento = TN_nummovimiento
                                AND cod_estado != TN_codestado;

                                IF SQL%NOTFOUND THEN

                                        UPDATE PVH_MOVIMIENTOS
                                        SET cod_estado = TN_codestado
                                        WHERE num_movimiento = TN_nummovimiento
                                        AND cod_estado != TN_codestado;

                                END IF;
                        END IF;

                        IF SQL%FOUND THEN
                           COMMIT;
                        END IF;

           EXCEPTION
                        WHEN OTHERS THEN
                                 ROLLBACK;
           END;
        END IF;
END;
/
SHOW ERRORS
