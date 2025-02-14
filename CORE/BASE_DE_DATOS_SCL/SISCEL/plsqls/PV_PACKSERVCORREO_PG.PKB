CREATE OR REPLACE PACKAGE BODY Pv_Packservcorreo_Pg AS



        FUNCTION  PV_INVIERTE_FC  (EV_caracter VARCHAR2) RETURN VARCHAR2

        IS

                /*

                <Documentaci¢n TipoDoc = "funcion">

                <Elemento Nombre = "PV_INVIERTE_FC" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="JORGE RUZ" Programador="JORGE RUZ" Ambiente="BD">

                <Retorno>varchar2</Retorno>

                <Descripci¢n>invierte el string</Descripci¢n>

                <Par?metros>

                    <Entrada>

                        <param nom="EV_caracter" Tipo="NUMBER">Numero del Abonado</param>

                    </Entrada>

                </Par?metros>

                </Elemento>

                </Documentaci¢n>

                */

                LN_I NUMBER;

                LV_PASO  VARCHAR2(5):='';

        BEGIN

        FOR LN_I IN (0)..LENGTH(EV_caracter)-1 LOOP

           LV_PASO :=LV_PASO ||SUBSTR(EV_caracter, LENGTH(EV_caracter)-LN_I, 1);

        END LOOP;

        RETURN LV_PASO;

        END PV_INVIERTE_FC;





        FUNCTION PV_ClaseServicio_FN (

                          EV_ClaseServ IN VARCHAR2,

                          EV_ClaseInOut IN VARCHAR2)

        /*

        <Documentaci¢n TipoDoc = "funcion">

        <Elemento Nombre = "PV_ClaseServicio_FN" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Retorno>varchar2</Retorno>

        <Descripci¢n>gestiona la adicion o sustraccion de servicio, para dar formato a la clase de servicio del abonado (ver ga_Abocel)</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EV_ClaseServ" Tipo="VARCHAR2">Clase de servicio</param>

            </Entrada>

            <Entrada>

                <param nom="EV_ClaseInOut" Tipo="VARCHAR2">Servicio a gestionar</param>

            </Entrada>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

        RETURN VARCHAR2 IS tmpClaseServicio VARCHAR2(255);



        LV_ClasServ              VARCHAR2(255);

        LV_SinClase              VARCHAR2(255);



        BEGIN

                   SELECT

                                  REPLACE (EV_ClaseServ,EV_ClaseInOut,'') SinClase,

                                  EV_ClaseServ || EV_ClaseInOut           ConClase

                   INTO

                                  LV_SinClase,

                                  LV_ClasServ

                   FROM

                   DUAL;



                   IF EV_ClaseServ=LV_SinClase THEN

                          tmpClaseServicio := LV_ClasServ;

                   ELSE

                      tmpClaseServicio := LV_SinClase;

                   END IF;

           RETURN tmpClaseServicio;

        END pv_ClaseServicio_fn;





        FUNCTION PV_ISTHELAST_FC

        (

                EN_num_abonado     IN           GA_ABOCEL.num_abonado%TYPE,

                EV_msgerror        IN OUT       NOCOPY VARCHAR2

        )RETURN BOOLEAN

        IS

        /*

        <Documentaci¢n TipoDoc = "funcion">

        <Elemento Nombre = "PV_ISTHELAST_FC" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Retorno>BOOLEAN</Retorno>

        <Descripci¢n>Verifica si el abonado solo posee un servicio restrictivo del servicio de correo</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del Abonado</param>

            </Entrada>

            <Salida>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

        LV_cod_servdef  GA_SERVSUPLABO.COD_SERVICIO%TYPE;

        LV_des_servicio GA_SERVSUPL.DES_SERVICIO%TYPE;

        BEGIN

                BEGIN

                        SELECT

                                a.cod_servicio,

                                a.COD_SERVSUPL

                        INTO

                                LV_cod_servdef,

                                LV_des_servicio

                        FROM

                                GA_SERVSUPLABO A

                                ,GA_SERVSUPL B

                        WHERE

                                a.num_abonado = EN_num_abonado

                                AND a.ind_estado<3

                                AND a.cod_servicio IN (SELECT cod_servdef FROM ga_servsup_def WHERE (SYSDATE BETWEEN  fec_desde AND  fec_hasta)  AND cod_Servicio IN (

                                SELECT cod_Servicio FROM

                                ga_servsuplabo a

                                WHERE

                                a.num_Abonado = EN_num_abonado AND

                                a.cod_servicio IN (SELECT b.cod_servicio FROM GA_SERVSUPL b WHERE a.cod_servicio=b.cod_servicio ) AND

                                a.cod_servsupl IN ((SELECT NOM_COLUMNA  FROM GED_CODIGOS  WHERE COD_MODULO ='IC' AND  NOM_TABLA = GV_srv_blackberry OR  NOM_TABLA  = GV_srv_correo_mov GROUP BY NOM_COLUMNA)) AND

                                a.ind_estado<3

                                ))

                                AND a.cod_servsupl=b.cod_servsupl

                                AND a.cod_servicio=b.cod_servicio

                                AND a.ind_estado<3

                                AND a.cod_nivel=b.cod_nivel;

                                RETURN TRUE;

                EXCEPTION

                        WHEN TOO_MANY_ROWS THEN

                                                EV_msgerror:='EL ABONADO POSEE MAS DE UN SERVICIO RESTRICTIVO DE CORREO';

                                                RETURN FALSE;

                                WHEN NO_DATA_FOUND THEN

                                                EV_msgerror:='EL ABONADO NO POSEE SERVICIOS DE CORREO';

                                                RETURN FALSE;

                                WHEN OTHERS THEN

                                                EV_msgerror:='Error Oracle :' || SQLERRM;

                                                RETURN FALSE;

                END;

        END PV_ISTHELAST_FC;



        FUNCTION PV_ISBLACKBERRY_FC

        (

                EN_num_abonado     IN           GA_ABOCEL.num_abonado%TYPE

        )RETURN VARCHAR

        IS

        /*

        <Documentaci¢n TipoDoc = "funcion">

        <Elemento Nombre = "PV_ISBLACKBERRY_FC" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Retorno>VARCHAR</Retorno>

        <Descripci¢n>Verifica si el abonado posee un equipo asociado al servicio de correo BlackBerry</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del Abonado</param>

            </Entrada>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

        LV_servicio VARCHAR(3):= '';

        LN_count NUMBER;

        BEGIN

                BEGIN

                        SELECT COUNT(1)

                        INTO LN_count

                        FROM ga_equipaboser a,

                             gad_servsup_art b,

                                 ged_codigos d

                        WHERE

                            a.num_abonado  = EN_num_abonado

                        AND a.cod_producto = b.cod_producto

                        AND a.fec_alta     = (SELECT MAX(fec_alta)

                                              FROM ga_equipaboser

                                                              WHERE num_abonado=EN_num_abonado   AND

                                                                    tip_terminal =GV_terminal ) --- Evalua si es terminal......

                        AND a.cod_articulo = b.cod_articulo

                        AND d.cod_modulo   = 'GA'

                        AND (d.nom_tabla   = 'GA_SERVSUPL')

                        AND d.nom_columna = 'COD_SERVICIO'

                        AND d.cod_valor    = b.cod_servicio

                        AND SYSDATE  BETWEEN b.fec_desde AND  b.fec_hasta;



                    IF LN_count = 0 THEN

                                LV_servicio:='L/N';

                        END IF;

                EXCEPTION

                    WHEN TOO_MANY_ROWS THEN

                                LV_servicio:='TBB';

                END;

                RETURN LV_servicio;

        END PV_ISBLACKBERRY_FC;





        PROCEDURE PV_EQUIPOBB_PR

        (

                EN_num_abonado     IN           GA_ABOCEL.num_abonado%TYPE,

                cur_equipoabo_out  OUT          REFCURSOR,

                EV_msgerror        IN OUT NOCOPY        VARCHAR2

        ) IS

        /*

        <Documentaci¢n TipoDoc = "Procedimiento">

        <Elemento Nombre = "PV_EQUIPOBB_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Descripci¢n>Retorna datos del equipo del abonado, adicionando una columna que indica si este equipo esta o no asociado al servicio de correo blackberry</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del Abonado</param>

            </Entrada>

            <Salida>

                <param nom="cur_equipoabo_out" Tipo="REFCURSOR">Cursor que devuelve datos del equipo de un abonado</param>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

        BEGIN

                BEGIN



                        OPEN cur_equipoabo_out FOR

                        SELECT

                           a.num_abonado

                           ,c.cod_tecnologia

                           ,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(c.cod_tecnologia) tecnologia

                           ,DECODE(

                                           ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(c.cod_tecnologia)

                                           ,'GSM',a.num_serie

                                           ,a.num_imei) num_serie

                           ,b.ind_seriado

                           ,b.cod_articulo

                           ,b.des_articulo

                           ,b.cod_modelo

                           ,Pv_Packservcorreo_Pg.PV_ISBLACKBERRY_FC( EN_NUM_ABONADO ) esBlackBerry

                        FROM

                           GA_EQUIPABOSER A

                           ,AL_ARTICULOS B

                           ,GA_ABOCEL C

                        WHERE

                           a.num_abonado=EN_num_abonado AND

                           c.num_abonado=a.num_abonado AND

                           a.cod_articulo=b.cod_articulo AND

                           a.FEC_ALTA = (SELECT MAX(fec_alta) FROM ga_equipaboser WHERE num_abonado=EN_num_abonado) AND

                           b.ind_seriado=1 AND

                           a.tip_terminal='T'
                           UNION --Para equipos con tecnologia CDMA o TDMA
                                SELECT
                                  a.num_abonado                            ,
                                  c.cod_tecnologia                         ,
                                  ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(c.cod_tecnologia) tecnologia                          ,
                                  c.num_serie                              ,
                                  b.ind_seriado                            ,
                                  b.cod_articulo                           ,
                                  b.des_articulo                           ,
                                  b.cod_modelo                             ,
                                  Pv_Packservcorreo_Pg.PV_ISBLACKBERRY_FC( EN_num_abonado ) esBlackBerry
                                FROM
                                  GA_EQUIPABOSER a                         ,
                                  AL_ARTICULOS b                           ,
                                  GA_ABOCEL c
                                WHERE
                                  c.num_abonado=a.num_abonado AND
                                  c.num_serie = a.num_serie AND
                                  c.num_abonado = EN_num_abonado        AND
                                  a.FEC_ALTA = (SELECT MAX(fec_alta) FROM ga_equipaboser d WHERE d.num_abonado = EN_num_abonado AND d.num_serie=c.num_serie) AND
                                  a.cod_articulo = b.cod_articulo AND
                                  NOT a.tip_terminal IN ('T','G')
                                  AND b.ind_seriado = 1;

                EXCEPTION

                        WHEN OTHERS THEN

                                EV_msgerror :=  SQLERRM;

                END;

        END PV_EQUIPOBB_PR;



        PROCEDURE PV_SERVSUPLXABONADO_PR

        (

                EN_num_abonado  IN      NUMBER,

                curserv_out             OUT     NOCOPY REFCURSOR,

                EV_msgerror             IN      OUT     NOCOPY VARCHAR2

        )

        IS

        /*

        <Documentaci¢n TipoDoc = "PROCEDURE">

        <Elemento Nombre = "PV_SERVSUPLXABONADO_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Descripci¢n>Retorna una lista con los servicios suplementarios que posea el abonado consultado</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del Abonado</param>

            </Entrada>

            <Salida>

                <param nom="curserv_out" Tipo="REFCURSOR">Retorna los servicios suplementarios que posee el abonado</param>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */



        VcodigoPlanServicio VARCHAR(3):= '';

        BEGIN

                BEGIN



                DBMS_OUTPUT.PUT_LINE('Cantidad reg: entre' );

                 SELECT COD_PLANSERV--A.COD_PLANSERV

                  INTO VcodigoPlanServicio

                 FROM --GA_INTARCEL A, GA_ABOCEL B
				 GA_ABOCEL
                        WHERE

                                                       -- A.NUM_ABONADO = EN_num_abonado
									NUM_ABONADO = EN_num_abonado;
                                                --AND     B.NUM_ABONADO = A.NUM_ABONADO

                                              --  AND     A.COD_CLIENTE = B.COD_CLIENTE

                                                --AND SYSDATE BETWEEN A.FEC_DESDE AND A.FEC_HASTA;



                DBMS_OUTPUT.PUT_LINE('Cantidad reg: ' ||VcodigoPlanServicio);



                        OPEN CURSERV_OUT FOR

                    SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL

                        FROM dual

                        WHERE ROWNUM <1;





                        OPEN CURSERV_OUT FOR

                    SELECT SSA.ind_estado, e.cod_tiplan, SSA.cod_servicio ,SS.des_servicio ,SSA.cod_servsupl ,SSA.cod_nivel

                        ,SSA.fec_altabd, SSA.fec_altacen, c.num_abonado, (d.nom_cliente || ' ' || d.nom_apeclien1  || ' ' || d.nom_apeclien2) nom_cliente

                        ,c.num_celular, DECODE(SSA.cod_servicio,(SELECT COD_VALOR

                                                                                   FROM GED_CODIGOS

                                                                                   WHERE COD_MODULO = 'GA'

                                                                                   AND NOM_TABLA = 'GA_SERVSUPL'

                                                                                   AND NOM_COLUMNA = 'COD_SERVICIO'

                                                                                   AND COD_VALOR =SSA.cod_servicio),SSA.cod_servicio,'N/A') servcorreo

                        ,NVL(tarifas_conexion.imp_tarifa,0) AS imp_tarifa,

                                                NVL(moneda_conexion.des_moneda,'Sin Glosa') AS des_moneda,

                                                NVL(tarifas_mensual.imp_tarifa,0)  AS imp_tarifamen,

                                                NVL(moneda_mensual.des_moneda, 'Sin Glosa')  AS des_monedamen

                  FROM

                        GA_SERVSUPLABO SSA

                        ,GA_SERVSUPL SS

                        ,GA_ABOCEL C

                        ,GE_CLIENTES D

                        ,TA_PLANTARIF E

                        ,ga_actuaserv ss_actuacion_conexion, ga_tarifas tarifas_conexion, ge_monedas moneda_conexion

                        ,ga_actuaserv ss_actuacion_mensual,  ga_tarifas tarifas_mensual,  ge_monedas moneda_mensual

                 WHERE

                        SSA.num_abonado = EN_num_abonado

                       AND e.cod_plantarif = c.cod_plantarif

                       AND c.num_abonado = SSA.num_abonado

                       AND d.cod_cliente = c.cod_cliente

                       AND SSA.ind_estado<3

                       AND SS.cod_producto = 1

                       AND SS.cod_servicio = SSA.cod_servicio

                       AND SS.cod_servsupl = SSA.cod_servsupl

                       AND SS.cod_nivel=SSA.cod_nivel

                       AND ss_actuacion_conexion.cod_actabo(+)= 'SS'

                       AND ss_actuacion_conexion.cod_producto(+) = SS.cod_producto

                       AND ss_actuacion_conexion.cod_servicio(+) =SS.cod_servicio

                       AND tarifas_conexion.cod_producto(+) = ss_actuacion_conexion.cod_producto

                       AND tarifas_conexion.cod_actabo(+) = ss_actuacion_conexion.cod_actabo

                       AND tarifas_conexion.cod_tipserv(+) = ss_actuacion_conexion.cod_tipserv

                       AND tarifas_conexion.cod_servicio(+) = ss_actuacion_conexion.cod_servicio

                                           AND tarifas_conexion.cod_planserv(+) = VcodigoPlanServicio

                       AND SYSDATE BETWEEN tarifas_conexion.fec_desde(+) AND NVL(tarifas_conexion.fec_hasta(+), SYSDATE)

                       AND moneda_conexion.cod_moneda(+) = tarifas_conexion.cod_moneda

                       AND ss_actuacion_mensual.cod_producto(+) = SSA.cod_producto

                       AND ss_actuacion_mensual.cod_servicio(+) = SSA.cod_servicio

                       AND ss_actuacion_mensual.cod_actabo(+)= 'FA'

                       AND tarifas_mensual.cod_producto(+) = ss_actuacion_mensual.cod_producto

                       AND tarifas_mensual.cod_actabo(+) = ss_actuacion_mensual.cod_actabo

                       AND tarifas_mensual.cod_tipserv(+) = ss_actuacion_mensual.cod_tipserv

                       AND tarifas_mensual.cod_servicio(+) = ss_actuacion_mensual.cod_servicio

                       AND tarifas_mensual.cod_planserv(+) = VcodigoPlanServicio

                       AND SYSDATE BETWEEN tarifas_mensual.fec_desde(+) AND NVL(tarifas_mensual.fec_hasta(+), SYSDATE)

                       AND moneda_mensual.cod_moneda(+) = tarifas_mensual.cod_moneda;





                                           DBMS_OUTPUT.PUT_LINE('Cantidad reg fin: ' ||VcodigoPlanServicio);







                        EXCEPTION

                        WHEN NO_DATA_FOUND THEN --PARA EL CASO QUE NO EXISTA O ESTE EN PRE-PAGO

                                EV_msgerror :=  '1: Abonado tiene plan Prepago';

                                BEGIN

                                         SELECT

                                                 COD_PLANTARIF

                                         INTO

                                                 EV_msgerror

                                         FROM

                                                 GA_ABOAMIST

                                         WHERE

                                                 num_abonado=EN_num_abonado;

                    EXCEPTION

                                         WHEN NO_DATA_FOUND THEN

                                         EV_msgerror :=  '2: Abonado no existe';

                                END;

                        WHEN OTHERS THEN

                                EV_msgerror :=  SUBSTR(SQLERRM,1,1000);

                END;



        END PV_SERVSUPLXABONADO_PR;



        PROCEDURE PV_ADDABOMAIL_PR(

                EV_cod_servicio         IN      GA_ABOMAIL_TO.COD_SERVICIO%TYPE,

                EN_num_abonado          IN      GA_ABOMAIL_TO.NUM_ABONADO%TYPE,

                EV_abomail              IN      GA_ABOMAIL_TO.ABOMAIL%TYPE,

                EV_username             IN      GA_ABOMAIL_TO.USERNAME%TYPE,

                EV_passwabo                     IN      GA_ABOMAIL_TO.PASSWABO%TYPE,

                EV_observacion          IN      GA_ABOMAIL_TO.OBSERVACION%TYPE,

                EV_msgerror                     IN      OUT     NOCOPY VARCHAR2

        )IS

        /*

        <Documentaci¢n TipoDoc = "Procedimiento">

        <Elemento Nombre = "PV_ADDABOMAIL_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Descripci¢n>Inserta en tabla GA_ABOMAIL_TO datos del abonado, con respecto a su servicio de correo y los datos que esta necesita (Correo,usuario,clave)</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EV_cod_servicio" Tipo="VARCHAR">Codigo de servicio de correo</param>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del abonado</param>

                <param nom="EV_abomail" Tipo="VARCHAR">Correo Electronico del abonado</param>

                <param nom="EV_username" Tipo="VARCHAR">Usuario del correo</param>

                <param nom="EV_passwabo" Tipo="VARCHAR">Password del correo</param>

                <param nom="EV_observacion" Tipo="VARCHAR">Observacion del abonado</param>

            </Entrada>

            <Salida>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

        BEGIN

                BEGIN

                        INSERT INTO GA_ABOMAIL_TO (

                                cod_servicio

                                ,num_abonado

                                ,abomail

                                ,username

                                ,passwabo

                                ,usuario

                                ,fecha_alta

                                ,observacion

                        )

                        VALUES (

                                EV_cod_servicio

                                ,EN_num_abonado

                                ,EV_abomail

                                ,EV_username

                                ,EV_passwabo

                                ,USER

                                ,SYSDATE

                                ,EV_observacion

                        );

                EXCEPTION

                        WHEN DUP_VAL_ON_INDEX THEN

                                 UPDATE GA_ABOMAIL_TO SET

                                         cod_servicio = EV_cod_servicio,

                                         num_abonado  = EN_num_abonado,

                                         abomail          = EV_abomail,

                                         username         = EV_username,

                                         passwabo         = EV_passwabo,

                                         usuario          = USER,

                                         fecha_alta       =     SYSDATE,

                                         observacion  = EV_observacion

                                 WHERE

                                         num_abonado=EN_num_abonado;

                        WHEN OTHERS THEN

                                 EV_msgerror :=SQLERRM;

                END;



        END PV_ADDABOMAIL_PR;



        PROCEDURE PV_SERVICIOSCORREO_PR

        (

                EN_COD_ARTICULO         IN      AL_ARTICULOS.COD_ARTICULO%TYPE,

                EV_msgerror                     IN      OUT     NOCOPY VARCHAR2,

                SERVCORREO_OUT          OUT     NOCOPY REFCURSOR

        )IS

        /*

        <Documentaci¢n TipoDoc = "procedimiento">

        <Elemento Nombre = "PV_SERVICIOSCORREO_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Descripci¢n>Lista las servicios de correos, junto con sus servicios prerequisitos</Descripci¢n>

        <Par?metros>

            <Salida>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

                <param nom="SERVCORREO_OUT" Tipo="CURSOR">Descripci¢n Parametro2</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

        BEGIN

                BEGIN



                        OPEN SERVCORREO_OUT FOR

                        SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL

                        FROM dual

                        WHERE ROWNUM <1;

                        DBMS_OUTPUT.PUT_LINE('Cantidad reg: pase1');

                        OPEN SERVCORREO_OUT FOR

                                SELECT ss_relacion.cod_producto,ss_correo.des_servicio SERVCORREO,ss_correo.cod_servicio,ss_relacion.cod_servdef ,ss_prerequisito.des_servicio des_servdef,ss_relacion.fec_desde,ss_relacion.fec_hasta,ss_correo.cod_nivel,ss_relacion.cod_servorig,ss_relacion.tip_relacion,ss_relacion.cod_actabo

                                FROM ga_servsup_def ss_relacion,GA_SERVSUPL ss_correo, GA_SERVSUPL ss_prerequisito,gad_servsup_art ss_art

                                WHERE ss_correo.cod_producto = 1

                                AND ss_relacion.tip_relacion = 5

                                AND ss_relacion.cod_servicio = ss_correo.cod_servicio

                                AND ss_relacion.cod_producto = ss_correo.cod_producto

                                AND ss_prerequisito.cod_servicio = ss_relacion.cod_servdef

                                AND ss_prerequisito.cod_producto = ss_relacion.cod_producto

                                AND ss_art.cod_producto = ss_correo.cod_producto

                                AND ss_art.cod_servicio = ss_correo.cod_servicio

                                AND ss_art.cod_articulo = EN_COD_ARTICULO

                                AND SYSDATE BETWEEN ss_art.fec_desde AND ss_art.fec_hasta

                                AND ss_correo.cod_servicio IN (

                                                                       SELECT cod_valor

                                                                                           FROM ged_codigos

                                                                                           WHERE cod_modulo = 'GA'

                                                                                           AND nom_tabla = 'GA_SERVSUPL'

                                                                                           AND nom_columna = 'COD_SERVICIO'

                                                                                           AND cod_valor =ss_correo.cod_servicio

                                                                                  )

                                AND SYSDATE BETWEEN  ss_relacion.fec_desde AND ss_relacion.fec_hasta;

                                DBMS_OUTPUT.PUT_LINE('Cantidad reg: PASE2');



                        EXCEPTION

                        WHEN OTHERS THEN

                                EV_msgerror :=  SQLERRM;

                        END;

        END PV_SERVICIOSCORREO_PR;



        PROCEDURE PV_ADDSERVCORREOXABONADO_PR

        (

                EN_num_abonado  IN      GA_SERVSUPLABO.num_abonado%TYPE,

                EV_cod_servicio IN      GA_SERVSUPLABO.COD_SERVICIO%TYPE,

                EN_cod_nivel    IN      GA_SERVSUPLABO.COD_NIVEL%TYPE,

                EV_msgerror             IN OUT  NOCOPY VARCHAR2

        ) IS

        /*

        <Documentaci¢n TipoDoc = "Procedimiento">

        <Elemento Nombre = "PV_ADDSERVCORREOXABONADO_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Descripci¢n>Agrega un servicio de correo a un abonado, en el caso que el abonado posea ya un servicio de correo, este queda desactivado y se inserta el nuevo servicio de correo</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del Abonado</param>

                <param nom="EV_cod_servicio" Tipo="VARCHAR">Servicio de correo</param>

                <param nom="EN_cod_nivel" Tipo="NUMBER">Nivel del servicio de correo</param>

            </Entrada>

            <Salida>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

                LV_des_error        GE_errores_pg.DesEvent;

                sSql                GE_errores_pg.vQuery;

                SN_cod_retorno      GE_errores_PG.CodError;

                SV_mens_retorno     GE_errores_PG.MsgError;

                SN_num_evento       GE_errores_PG.Evento;

                LN_num_terminal     GA_ABOCEL.NUM_CELULAR%TYPE;



                LN_Cant_ServCorreo  NUMBER(10);

                LN_grupo_correo         NUMBER(2);

                LN_ind_estado           NUMBER(2);

                LN_cod_nivel            GA_SERVSUPLABO.COD_NIVEL%TYPE;

        BEGIN

                EV_msgerror := GV_Perfecto;

                SELECT

                        num_celular

                INTO

                        LN_num_terminal

                FROM

                        ga_abocel

                WHERE

                        num_abonado = EN_num_abonado;



                LN_grupo_correo:=0;



                BEGIN

                        SELECT

                                COD_SERVSUPL,

                                IND_ESTADO,

                                cod_nivel

                        INTO

                                LN_grupo_correo,

                                LN_ind_estado,

                                LN_cod_nivel

                        FROM

                                GA_SERVSUPLABO

                        WHERE

                                num_abonado  = EN_num_abonado AND

                         --       cod_producto = 1 AND

                                cod_servicio = EV_cod_servicio AND

                                ind_estado   < 3;

                EXCEPTION

                        WHEN NO_DATA_FOUND THEN

                    LN_ind_estado:=0;

                END;

                -- ESTA CONDICION CONFIRMA SI EL ABONADO POSEIA O NO YA UN SERVICIO DE CORREO

                IF LN_ind_estado < 3   THEN

                    BEGIN

                                UPDATE GA_SERVSUPLABO SET

                                        ind_estado   = 3,

                                        fec_bajabd   = SYSDATE,

                                        nom_usuarora = USER

                        WHERE

                                        num_abonado  = EN_num_abonado AND

                                       -- cod_producto = 1 AND

                                        cod_servicio IN (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = 'GA' AND NOM_TABLA = 'GA_SERVSUPL' AND NOM_COLUMNA = 'COD_SERVICIO' ) AND

                                        ind_estado   < 3;

                        EXCEPTION

                           WHEN OTHERS  THEN

                                        EV_msgerror := SQLERRM;

                                        SN_cod_retorno := 4;

                                        EV_msgerror := SUBSTR(SQLERRM,1,255);

                                        SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento,'GA',SV_mens_retorno, '1.0', USER,'PACKSERVCORREO.PV_ADDSERVCORREOXABOANDO_PR',

                                        NULL, SQLCODE, LV_des_error );

                        END;

                END IF;

                -- LUEGO DE VALIDAR QUE CUALQUIER SERVICIO DE CORREO SERA DADO DE BAJA

                -- INSERTO EL NUEVO SERVICIO DE CORREO



                BEGIN



           SELECT COD_SERVSUPL, COD_NIVEL

           INTO

                                LN_grupo_correo,

                            LN_cod_nivel

                   FROM GA_SERVSUPL

                   WHERE COD_PRODUCTO = 1 AND

                         COD_SERVICIO = EV_cod_servicio;



                   INSERT INTO GA_SERVSUPLABO

                   (

                                cod_producto,

                                num_abonado,

                                cod_servicio, --SERVICIO COMERCIAL := 'CMC','CMI','CMI','BBI','BBC'

                                fec_altabd,

                                cod_servsupl, -- 62 ¢ 61

                                cod_nivel,    -- 1,2,3,4,5

                                num_terminal,

                                nom_usuarora

                   )

                   VALUES

                   (

                                1,

                                EN_num_abonado,

                                EV_cod_servicio,

                                SYSDATE,

                                LN_grupo_correo, -- <== GRUPO DEL SERVICIO DE CORREO

                                LN_cod_nivel,

                                LN_num_terminal,

                                USER

                        );

                EXCEPTION

                   WHEN OTHERS  THEN

                                EV_msgerror := SQLERRM;

                                SN_cod_retorno := 4;

                                EV_msgerror := SUBSTR(SQLERRM,1,255);

                                SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento,'GA',SV_mens_retorno, '1.0', USER,'PACKSERVCORREO.PV_ADDSERVCORREOXABOANDO_PR',

                                NULL, SQLCODE, LV_des_error );

                END;





        END PV_ADDSERVCORREOXABONADO_PR;



        PROCEDURE PV_ADDICCMOVIMIENTO_PR(

                EN_num_abonado          IN              ga_abocel.num_abonado%TYPE,

                EV_cod_servicios        IN              VARCHAR2,

                SV_des_error            IN OUT  NOCOPY VARCHAR2

        ) AS

        /*

        <Documentaci¢n TipoDoc = "Procedimiento">

        <Elemento Nombre = "PV_ADDICCMOVIMIENTO_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Descripci¢n>Crea el movimiento para la activacion o desactivacion de un servicio de correo , en el caso que el valor EV_cod_servicios venga NULL , el procedimiento dara de baja el servicio de correo que tenga el abonado</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del abonado</param>

                <param nom="EV_cod_servicios" Tipo="VARCHAR">Servicio de correo a activar</param>

            </Entrada>

            <Salida>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */

                err_ins_iccmov          EXCEPTION;

                LV_v_verror                     VARCHAR2(255);

                LN_movimiento       ICC_MOVIMIENTO.NUM_MOVIMIENTO%TYPE;

                LV_cod_servicios        ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;

                LV_cod_actabo           GA_ACTABO.COD_ACTABO%TYPE;

                LN_cod_tiplan_ini       TA_PLANTARIF.COD_TIPLAN%TYPE;

                LN_cod_tiplan_fin       TA_PLANTARIF.COD_TIPLAN%TYPE;

                LN_tipplanhib           GED_PARAMETROS.VAL_PARAMETRO%TYPE;

                LN_tipplanpos           GED_PARAMETROS.VAL_PARAMETRO%TYPE;

                LN_num_celular          GA_ABOCEL.NUM_CELULAR%TYPE;

                LN_cod_central          GA_ABOCEL.COD_CENTRAL%TYPE;

                LV_cod_grupo_tec        AL_GRUPO_TECNOLOGIA_TD.COD_GRUPO%TYPE;

                LV_num_seriehex         ICC_MOVIMIENTO.NUM_SERIE%TYPE;

                LV_tip_terminal         GA_ABOCEL.TIP_TERMINAL%TYPE;

                LV_cod_tecnologia       GA_ABOCEL.COD_TECNOLOGIA%TYPE;

                LV_num_serie            GA_ABOCEL.NUM_SERIE%TYPE;

                LV_num_imei                     GA_ABOCEL.NUM_IMEI%TYPE;

                LN_cod_producto         GA_ABOCEL.COD_PRODUCTO%TYPE;

                LV_num_min                      ICC_MOVIMIENTO.NUM_MIN%TYPE;

                LN_cod_actuacion        ICC_MOVIMIENTO.COD_ACTUACION%TYPE;

                LV_icc                          ICC_MOVIMIENTO.ICC%TYPE:=NULL;

                LV_grupo_gsm            GED_PARAMETROS.VAL_PARAMETRO%TYPE;

                LV_param_codactabo      CONSTANT        VARCHAR2(16) := 'HE_INPUT_HIBRIDO';

                CN_carga                        CONSTANT        NUMBER(1) := 0;

                LN_p_correlativo        icc_movimiento.num_movimiento%TYPE;

                LN_p_filasafectas       NUMBER;

                LN_p_retornora          NUMBER;

                LN_p_nroevento          NUMBER;

                LV_p_vcod_retorno       VARCHAR2(10);

                EV_error                        VARCHAR2(10);

                LV_des_error        GE_errores_pg.DesEvent;

                sSql                GE_errores_pg.vQuery;

                SN_cod_retorno      GE_errores_PG.CodError;

                SV_mens_retorno     GE_errores_PG.MsgError;

                SN_num_evento       GE_errores_PG.Evento;

                LV_imsi             ICC_MOVIMIENTO.IMSI%TYPE:=NULL;

                LV_imei             ICC_MOVIMIENTO.IMEI%TYPE:=NULL;



                LV_icc_movientos   ICC_MOVIMIENTO.COD_SERVICIOS%TYPE;

                LV_cod_serv_alta   VARCHAR(255);

                LV_cod_serv_baja   VARCHAR(255);

                LV_serviciobaja    GA_SERVSUPL.COD_SERVICIO%TYPE;

                LV_clase_servicio  GA_ABOCEL.CLASE_SERVICIO%TYPE;



                LV_cod_serv_baja_clase VARCHAR(255);

                LV_ClaseServicio        VARCHAR(255);



        BEGIN



                SN_cod_retorno   := 0;

                SV_des_error     := GV_Perfecto;

                SN_num_evento    := 0;



        SELECT GA_SEQ_TRANSACABO.NEXTVAL INTO LN_movimiento FROM DUAL;



                BEGIN

                        SELECT cod_actabo INTO LV_cod_actabo

                        FROM pv_actabo_tiplan

                        WHERE cod_tipmodi = LV_cod_actabo

                        AND cod_tiplan  = LN_cod_tiplan_fin;

                EXCEPTION

                        WHEN NO_DATA_FOUND THEN

                                NULL;

                END;

                -- OBTENGO LOS VALORES PARA LV_IMSI Y IMEI

                SELECT

                        FN_RECUPERA_IMSI(num_serie) imsi,

                        num_imei

                INTO

                        LV_imsi,

                        LV_imei

                FROM

                        ga_abocel

                WHERE

                        num_abonado =EN_num_abonado;



                SELECT

                        num_celular,

                        cod_central,

                        ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),

                        num_seriehex,

                        tip_terminal,

                        cod_tecnologia,

                        num_serie,

                        num_imei,

                        cod_producto,

                        al_fn_prefijo_numero(num_celular),

                        clase_servicio

                INTO

                        LN_num_celular,

                        LN_cod_central,

                        LV_cod_grupo_tec,

                        LV_num_seriehex,

                        LV_tip_terminal,

                        LV_cod_tecnologia,

                        LV_num_serie,

                        LV_num_imei,

                        LN_cod_producto,

                        LV_num_min,

                        LV_cod_servicios

                FROM

                        ga_abocel

                WHERE

                num_abonado = EN_num_abonado;



                LN_cod_actuacion := FN_CODACTCEN(1,'SS','GA',LV_COD_TECNOLOGIA);



                IF LN_cod_actuacion IS NULL THEN

           RAISE err_ins_iccmov;

                END IF;



------------------------------------------------------------------------------------------------------------------------------------------

                IF EV_Cod_servicios IS NULL THEN

                        BEGIN

                                -- select que me da el ultimo servicio de correo activo para luego.... (1)

                                SELECT

                                        cod_servicio

                                INTO

                                        LV_serviciobaja

                                FROM

                                        GA_SERVSUPLABO

                                WHERE

                                        NUM_ABONADO = EN_num_abonado AND

                                        COD_SERVICIO IN (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = 'GA' AND NOM_TABLA = 'GA_SERVSUPL' AND NOM_COLUMNA = 'COD_SERVICIO' ) AND

                                        fec_ALTAbd IN (

                                        SELECT

                                                MAX(FEC_ALTABD)

                                        FROM

                                                GA_SERVSUPLABO

                                        WHERE

                                                NUM_ABONADO = EN_num_abonado AND

                                                COD_SERVICIO  IN (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = 'GA' AND NOM_TABLA = 'GA_SERVSUPL' AND NOM_COLUMNA = 'COD_SERVICIO') AND

                                                IND_ESTADO < 3

                                        )AND

                                        IND_ESTADO < 3;

                        EXCEPTION

                                        WHEN NO_DATA_FOUND THEN

                                        LV_serviciobaja:='XXX';

                                        SV_des_error:='No encontro el servicio de correo anterior';

                        END;

                    BEGIN

                                -- (1) dar el formato de baja e insertarlo a la ICC_MOVIMIENTOS

                                SELECT

                                          RPAD(LPAD(cod_servsupl,2,'0'),6,'0') codigo_baja,

                                          LPAD(cod_servsupl,2,'0')|| LPAD(cod_nivel,4,'0') cod_clase_desac

                                INTO

                                        LV_cod_serv_baja,

                                        LV_cod_serv_baja_clase

                                FROM

                                        GA_SERVSUPL

                                WHERE

                                        COD_SERVICIO = LV_serviciobaja AND

                                        COD_NIVEL < 10;

                        EXCEPTION

                                WHEN NO_DATA_FOUND THEN

                                SV_des_error:='No encontro el servicio de correo anterior';

                        END;

                        --Antes de dar la baja a ICC_MOVIMIENTOS doy de baja en la ga_servsuplabo

                        UPDATE GA_SERVSUPLABO SET

                                ind_estado   = 3,

                                fec_bajabd   = SYSDATE,

                                nom_usuarora = USER

                WHERE

                                num_abonado  = EN_num_abonado AND

                                --cod_producto = 1 AND

                                cod_servicio IN (SELECT COD_VALOR FROM GED_CODIGOS

                                                 WHERE COD_MODULO = 'GA'

                                                                   AND NOM_TABLA = 'GA_SERVSUPL'

                                                                   AND NOM_COLUMNA = 'COD_SERVICIO') AND

                                ind_estado   < 3;



                        BEGIN

                                SELECT clase_servicio

                                INTO   LV_clase_servicio

                                FROM   ga_abocel

                                WHERE  num_Abonado = EN_num_abonado;

                        EXCEPTION

                                WHEN NO_DATA_FOUND THEN

                                SV_des_error:='No encontro el servicio de correo anterior';

                        END;



                        BEGIN

                                 LV_ClaseServicio := pv_ClaseServicio_fn(LV_clase_servicio,LV_cod_serv_baja_clase);



                                UPDATE ga_abocel SET

                                clase_servicio = LV_ClaseServicio

                                WHERE  num_Abonado = EN_num_abonado;

                        EXCEPTION

                                WHEN OTHERS THEN

                                SV_des_error:='Error al actualizar ga_Abocel';

                        END;

                        LV_icc_movientos:=LV_cod_serv_baja;

                ELSE

---------------------------------------------------------------------------------------------------------------------------------------

                ---INICIO : formar el codigo de servicio para el formato icc_movimiento

                SELECT

                        LPAD(cod_servsupl,2,'0')|| LPAD(cod_nivel,4,'0') iic_movimiento

                INTO

                        LV_cod_serv_alta

                FROM

                        GA_SERVSUPL

                WHERE

                        COD_SERVICIO=EV_cod_servicios AND

                        cod_nivel <10;

                ---FIN : formar el codigo de servicio para el formato icc_movimiento



                LV_icc_movientos:=LV_cod_serv_alta;



                -- INICIO : BUSCO EL ULTIMO SERVICIO DE CORREO DADO DE BAJA {

                BEGIN

                        SELECT

                                cod_servicio

                        INTO

                                LV_serviciobaja

                        FROM

                                GA_SERVSUPLABO

                        WHERE

                                NUM_ABONADO = EN_num_abonado AND

                                COD_SERVICIO  IN (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = 'GA' AND NOM_TABLA = 'GA_SERVSUPL' AND NOM_COLUMNA = 'COD_SERVICIO') AND

                                fec_bajabd IN (

                                SELECT

                                        MAX(FEC_BAJABD)

                                FROM

                                        GA_SERVSUPLABO

                                WHERE

                                        NUM_ABONADO = EN_num_abonado AND

                                        COD_servicio IN (SELECT COD_VALOR FROM GED_CODIGOS WHERE COD_MODULO = 'GA' AND NOM_TABLA = 'GA_SERVSUPL' AND NOM_COLUMNA = 'COD_SERVICIO') AND

                                        IND_ESTADO = 3

                                )AND

                                IND_ESTADO = 3;

                EXCEPTION

                                WHEN NO_DATA_FOUND THEN

                                LV_serviciobaja:='XXX';

                                SV_des_error:='No encontro el servicio de correo anterior';

                END;

                LV_cod_serv_baja := NULL;

                IF LV_serviciobaja<>'XXX' THEN

                    BEGIN

                                -- SELECT QUE DA FORMATO A LA BAJA DEL SERVICIO DE CORREO CONTATADO ANTERIORMENTE

                                SELECT

                                         RPAD(LPAD(cod_servsupl,2,'0'),6,'0') codigo_baja,

                                         LPAD(cod_servsupl,2,'0')|| LPAD(cod_nivel,4,'0') cod_clase_desac

                                INTO

                                        LV_cod_serv_baja,

                                        LV_cod_serv_baja_clase

                                FROM

                                        GA_SERVSUPL

                                WHERE

                                        COD_SERVICIO = LV_serviciobaja; --and

                                        --COD_NIVEL < 10;

                        EXCEPTION

                                WHEN NO_DATA_FOUND THEN

                                SV_des_error:='No encontro el servicio de correo anterior';

                        END;







                        --Actualizar GA_ABOCEL.

                        -- actualiza la baja en clase_Servicio.

                        BEGIN

                                SELECT clase_servicio

                                INTO   LV_clase_servicio

                                FROM   ga_abocel

                                WHERE  num_Abonado = EN_num_abonado;

                        EXCEPTION

                                WHEN NO_DATA_FOUND THEN

                                SV_des_error:='No encontro el servicio de correo anterior';

                        END;



                        LV_ClaseServicio := pv_ClaseServicio_fn(LV_clase_servicio,LV_cod_serv_baja_clase);



                        BEGIN

                                UPDATE ga_abocel SET

                                clase_servicio = LV_ClaseServicio

                                WHERE  num_Abonado = EN_num_abonado;

                        EXCEPTION

                                WHEN OTHERS THEN

                                SV_des_error:='Error al actualizar ga_Abocel';

                        END;

                END IF;

                -- } FIN :  BUSCO SI TIENE UN SERVICIO DE CORREO DADO DE BAJA





                        -- actualiza la alta en clase_Servicio.

                        BEGIN

                                SELECT clase_servicio

                                INTO   LV_clase_servicio

                                FROM   ga_abocel

                                WHERE  num_Abonado = EN_num_abonado;

                        EXCEPTION

                                WHEN NO_DATA_FOUND THEN

                                SV_des_error:='No encontro el servicio de correo anterior';

                        END;







                        LV_ClaseServicio := pv_ClaseServicio_fn(LV_clase_servicio,LV_cod_serv_alta);



                        BEGIN

                                UPDATE ga_abocel SET

                                clase_servicio = LV_ClaseServicio

                                WHERE  num_Abonado = EN_num_abonado;

                        EXCEPTION

                                WHEN OTHERS THEN

                                SV_des_error:='Error al actualizar ga_Abocel';

                        END;

                        LV_icc_movientos:=LV_cod_serv_baja || LV_cod_serv_alta; --6000060002

                END IF;

---------------------------------------------------------------------------------------------------------------------------------------

                ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(

                        LN_movimiento ,         --      NUMERO DE MOVIMIENTO

                        EN_num_abonado,         --      NUMERO DE ABONADO

                        1,                                      --      CODIGODE ESTADO DE MOVIMIENTO

                        'SS',                           --      CODIGO DE ACTUACION ABONADOS

                        'GA',                           --      CODIGO MODULO ???

                        0,                                      --      NUMERO DE VECES QUE SE LNTENTO EL MOVIMIENTO

                        NULL,                           --      NUEVA CENTRAL PARA EL CAMBIO DE NUMERO

                        'PENDIENTE',            --      RESPUESTA DE EJECUCION DEL MOVIMIENTO

                        LN_cod_actuacion,   --  CODIGO DE ACTUACION EN CENTRALES  ????

                        USER,                           --      NOMBRE DE USUARIO QUE SOLICITA LA ELECUCION DEL MOVIMIENTO

                        SYSDATE,                        --      FECHA DE INGRESO EN LA TABLA

                        LV_tip_terminal,        --      TIPO DE TERMINAL

                        LN_cod_central,         --      CODIGO DE CENTRAL

                        NULL,                           --      FECHA DE INICIO DE PROCESAMIENTO DEL MOVIMIENTO

                        0,                                      --      LNDICADOR DE BLOQUEO DEL MOVIMIENTO

                        NULL,                           --      FECHA DE ELECUCION DEL MOVIMIENTO

                        NULL,                           --      TIPO DE TERMINAL NUEVO PARA EL CAMBIO DE TERMINAL

                        NULL,                           --      NUMERO ANTERIOR DE MOVIMIENTO ENCADENADO

                        LN_num_celular,         --      NUMERO DE CELULAR

                        NULL,                           --      NUMERO POSTERIOR DE MOVIMIENTO ENCADENADO

                        LV_num_serie,       --  NUMERO DE SERIE

                        NULL,                           --      PLN DELABONADO

                        NULL,                           --      NUMERO DE TELEFONO NUEVO PARA EL CAMBIO DE NUMERO

                        NULL,                           --      NUMERO DE SERIE NUEVO PARA EL CAMBIO DE SERIE

                        NULL,                           --      PIN NUEVO PARA EL CAMBIO DE PIN

                        NULL,                           --      NUMERO MUNDIAL DEL ABONADO

                        NULL,                           --      NUEVO NUMERO MUNDIAL DEL ABONADO

                        NULL,                           --      CODIGO DE SUSPENSION / REHABILITACION

                        LV_icc_movientos,       --      SERVICIOS A PROCESAR EN EL MOVIMIENTO

                        LV_num_min,                     --      PREFIJO MLN

                        NULL,                           --      NUMERO NUEVO PARA CAMBIO DE PREFIJO MIN

                        NULL,                           --      ESTADO SUSCRIPTOR DE MENSAJERIA

                        NULL,                           --      C¢DIGO DE MENSALE

                        NULL,                           --      UTILIZADO PARA LNSERTAR ALGUN MENSAJE AL MOVIMIENTO

                        NULL,                           --      UTILIZADO PARA LNSERTAR ALGUN MENSAJE AL MOVIMIENTO

                        NULL,                           --      UTILIZADO PARA LNSERTAR ALGUN MENSAJE AL MOVIMIENTO

                        NULL,                           --      PLAN DE PREPAGO

                        NULL,                           --      MONTO DE TARJETA PREPAGO

                        NULL,                           --      TARIFA DEL CARGO BASICO ASOCIADO AL PLAN TARIFARIO

                        NULL,                           --      CODIGO SECRETO DE TARJETA PREPAGO

                        NULL,                           --      FECHA DE EXPIRACION CARGA PREPAGO

                        NULL,                           --      DESCRIPCION DEL MENSALE

                        NULL,                           --      CODIGO SECRETO DE LA TARJETA DE PREPAGO

                        NULL,                           --      CODIGO DEL IDIOMA

                        NULL,                           --      CODIGO DE NUMERO DE ENRTUTAMIENTO

                        NULL,                           --      TIPO DEL NUMERO DE ENRUTAMIENTO 0-ENTRANTE 1-SALIENTE 2-AMBOS

                        NULL,                           --      PROVEEDOR DE TARJETA PREPAGO

                        NULL,                           --      NUMERO DE LOTE DE TARJETA PREPAGO

                        NULL,                           --      NUMERO DE SERIE TARJETA PREPAGO

                    LV_cod_tecnologia,  --      TIPO DE TECNOLOGIA

                    LV_imsi,                    --      NUMERO DE SERIE TARJETA PREPAGO(LOGICO)

                        NULL,                           --      NUMERO NUEVO PARA EL CAMBIO DE NUMERO DE SERIE DE LA TARJETA PREPAGO

                        LV_imei,                        --      NUMERO DE SERIE DEL EQUIPO

                        NULL,                           --      NUMERO NUEVO PARA CAMBIO DE NUMERO DE SERIE DEL EQUIPO

                        LV_num_serie,           --      NUMERO DE SERIE TARLETA PREPAGO(FISICO) ??

                        NULL,                           --      NUMERO NUEVO PARA EL CAMBIO DE NUMERO DE SERIE DE LA TARLETA PREPAGO

            'PV',                               --  COD_PROGRAMA.

                        LN_p_correlativo,

                        LN_p_filasafectas,

                        LN_p_retornora,

                        LN_p_nroevento,

                        LV_p_vcod_retorno

                );



                IF LV_p_vcod_retorno = GV_C0 THEN

                    EV_error := '0';

                        SV_des_error := GV_Perfecto;

                ELSE

                        RAISE err_ins_iccmov;

                END IF;

        EXCEPTION

                WHEN err_ins_iccmov THEN

                      SN_cod_retorno := 4;

                      SV_des_error := 'Error en inserci¢n en la tabla ICC_MOVIMIENTO. Nø evento es ' || LN_p_nroevento || '.' || LV_p_vcod_retorno;

                              SN_num_evento:= 0;

                                  SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento,'GA',SV_mens_retorno, '1.0', USER,'PACKSERVCORREO.PV_ADDICCMOVIMIENTO_PR',

                                  NULL, SQLCODE, LV_des_error );

                 WHEN OTHERS THEN

                 SN_cod_retorno := 4;

                         SV_des_error := SUBSTR(SQLERRM,1,255);

                         SN_num_evento:= Ge_Errores_Pg.Grabarpl( SN_num_evento,'GA',SV_mens_retorno, '1.0', USER,'PACKSERVCORREO.PV_ADDICCMOVIMIENTO_PR',

                                                                                                        NULL, SQLCODE, LV_des_error );

        END PV_ADDICCMOVIMIENTO_PR;





        PROCEDURE PV_ASIGNAROOSSCORREO_PR(

                EN_num_abonado  IN      GA_SERVSUPLABO.num_abonado%TYPE,

                EV_cod_servicio IN      GA_SERVSUPLABO.COD_SERVICIO%TYPE,

                EN_cod_nivel    IN      GA_SERVSUPLABO.COD_NIVEL%TYPE,

                EV_abomail      IN      GA_ABOMAIL_TO.ABOMAIL%TYPE,

                EV_username     IN      GA_ABOMAIL_TO.USERNAME%TYPE,

                EV_passwabo     IN      GA_ABOMAIL_TO.PASSWABO%TYPE,

                EV_observacion  IN      GA_ABOMAIL_TO.OBSERVACION%TYPE,

                EV_msgerror             IN OUT  NOCOPY VARCHAR2

        ) AS

        /*

        <Documentaci¢n TipoDoc = "Procedimiento">

        <Elemento Nombre = "PV_ASIGNAROOSSCORREO_PR" Lenguaje="PL/SQL" Fecha="06-04-2007" Versi¢n="1.2.0" Dise?ador="FERNANDO MATELUNA" Programador="FERNANDO MATELUNA" Ambiente="BD">

        <Retorno>VARCHAR</Retorno>

        <Descripci¢n>Descripci¢n</Descripci¢n>

        <Par?metros>

            <Entrada>

                <param nom="EN_num_abonado" Tipo="NUMBER">Numero del abonado</param>

                <param nom="EV_cod_servicio" Tipo="VARCHAR2">Codigo de servicio de correo</param>

                <param nom="EN_cod_nivel" Tipo="NUMBER">Codigo Nivel</param>

                <param nom="EV_abomail" Tipo="VARCHAR2">Correo electronico asociado al servicio de correo</param>

                <param nom="EV_username" Tipo="VARCHAR2">Usuario del correo electronico</param>

                <param nom="EV_passwabo" Tipo="VARCHAR2">Contrase?a del correo electronico</param>

                <param nom="EV_observacion" Tipo="VARCHAR2">Observacion del ingreso del servicio</param>

            </Entrada>

            <Salida>

                <param nom="EV_msgerror" Tipo="VARCHAR2">Mensaje de error en caso que lo haya</param>

            </Salida>

        </Par?metros>

        </Elemento>

        </Documentaci¢n>

        */



        Problema_con_Procedimiento EXCEPTION;

        BEGIN

                EV_msgerror:=GV_Perfecto; -- Valor inicial

                BEGIN

                                --ASIGNAR EL SERVICIO A LA GA_SERVUSPL

                                Pv_Packservcorreo_Pg.PV_ADDSERVCORREOXABONADO_PR(

                                        EN_num_abonado,

                                        EV_cod_servicio,

                                        EN_cod_nivel    ,

                                        EV_msgerror

                                );

                                IF EV_msgerror<>GV_Perfecto THEN

                                   RAISE Problema_con_Procedimiento;

                                ELSE

                                   --AGREGAR LOS DATOS A LA TABLA DE LOS DATOS DE LA OOSS DE CORREO

                                   Pv_Packservcorreo_Pg.PV_ADDABOMAIL_PR(

                                                EV_cod_servicio,

                                                EN_num_abonado ,

                                                EV_abomail  ,

                                                EV_username  ,

                                                EV_passwabo     ,

                                                EV_observacion,

                                                EV_msgerror

                                   );

                                   IF EV_msgerror<>GV_Perfecto THEN

                                          RAISE Problema_con_Procedimiento;

                                   ELSE

                                   -- INGRESAR MOVIMIENTO EN ICC_MOVIMIENTO

                                          Pv_Packservcorreo_Pg.PV_ADDICCMOVIMIENTO_PR(EN_num_abonado, EV_cod_servicio,EV_msgerror);

                                          IF EV_msgerror<>GV_Perfecto THEN

                                                 RAISE Problema_con_Procedimiento;

                                          END IF;

                                   END IF;

                                END IF;

                EXCEPTION

                                 WHEN Problema_con_Procedimiento THEN

                                          EV_msgerror:='Error en el procedimiento :' || SQLERRM;

                                 WHEN OTHERS THEN

                                          EV_msgerror:='Error en Oracle :' || SQLERRM;

                END;



        END PV_ASIGNAROOSSCORREO_PR;



    PROCEDURE PV_EVALUA_MOVIL_PR

        (

                EV_cod_servicio IN                 GA_SERVSUPLABO.cod_servicio%TYPE,

                SV_valorMovil   OUT NOCOPY     VARCHAR2,

                EV_msgerror     IN OUT  NOCOPY VARCHAR2

        ) AS

        LN_cod_servsupl    ga_servsuplabo.COD_SERVSUPL%TYPE;

        LN_cod_nivel       ga_servsuplabo.COD_NIVEL%TYPE;



        Error_PV_EVALUA_MOVIL_PR EXCEPTION;



    BEGIN



                SELECT DES_VALOR INTO SV_valorMovil

                FROM GED_CODIGOS

                WHERE COD_MODULO = 'GA'

                AND NOM_TABLA = 'GA_SERVSUPL'

                AND NOM_COLUMNA = 'COD_SERVICIO'

                AND COD_VALOR = EV_cod_servicio;



    EXCEPTION

                WHEN Error_PV_EVALUA_MOVIL_PR THEN

                         SV_valorMovil := '';

                 EV_msgerror:='Error en el procedimiento :' || SQLERRM;

        WHEN OTHERS THEN

                     EV_msgerror:='Error en Oracle :' || SQLERRM;





        END PV_EVALUA_MOVIL_PR;





END Pv_Packservcorreo_Pg;
/
SHOW ERRORS
