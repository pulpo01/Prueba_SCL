CREATE OR REPLACE PACKAGE BODY GA_NUMCEL_PERSONAL_PG
IS
/*
<Documentación
TipoDoc = "Package">
 <Elemento
    Nombre = "GA_NUMCEL_PERSONAL_PG"
    Lenguaje="PL/SQL"
    Fecha="23-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción>Package de negocio para activación, desactivación y modificación de números personales
    <Parámetros>
       <Entrada>NA</Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


FUNCTION GA_EXISTE_NUMPERSONAL_FN(EN_num_cel_pers        IN ga_numcel_personal_to.num_cel_pers%TYPE)
RETURN INTEGER
  IS
/*
<Documentación
TipoDoc = "Function">
 <Elemento
    Nombre = "GA_EXISTE_NUMPERSONAL_FN"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Función que retorna si una abonado está o no asignado como número personal
    <Parámetros>
       <Entrada>
           <param nom="EN_num_cel_pers" Tipo="NUMBER">Número celular personal</param>
           </Entrada>
           <Salida>NA</Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


  LN_valor              NUMBER(1);

BEGIN

         SELECT 1 INTO LN_valor
         FROM ga_numcel_personal_to
         WHERE num_cel_pers = EN_num_cel_pers;

         RETURN 1;

EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          RETURN 0;

END GA_EXISTE_NUMPERSONAL_FN;

FUNCTION GA_EXISTE_NUMCORPORATIVO_FN(EN_num_cel_pers     IN ga_numcel_personal_to.NUM_CEL_CORP%TYPE)
RETURN INTEGER
  IS
/*
<Documentación
TipoDoc = "Function">
 <Elemento
    Nombre = "GA_EXISTE_NUMCORPORATIVO_FN"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Función que retorna si una abonado está o no asignado como número corporativo
    <Parámetros>
       <Entrada>
           <param nom="EN_num_cel_pers" Tipo="NUMBER">Número celular personal</param>
           </Entrada>
           <Salida>NA</Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


  LN_valor              NUMBER(1);

BEGIN

         SELECT 1 INTO LN_valor
         FROM ga_numcel_personal_to
         WHERE num_cel_CORP = EN_num_cel_pers;

         RETURN 1;

EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          RETURN 0;

END GA_EXISTE_NUMCORPORATIVO_FN;



FUNCTION GA_EXISTE_NUMPERSONAL2_FN(EN_num_cel_pers       IN ga_numcel_personal_to.num_cel_pers%TYPE)
RETURN INTEGER
  IS
/*
<Documentación
TipoDoc = "Function">
 <Elemento
    Nombre = "GA_EXISTE_NUMPERSONAL2_FN"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Función que retorna si una abonado está o no asignado como número personal
    <Parámetros>
       <Entrada>
           <param nom="EN_num_cel_pers" Tipo="NUMBER">Número celular personal</param>
           </Entrada>
           <Salida>NA</Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


  LN_valor              NUMBER(1);

BEGIN

         SELECT 1 INTO LN_valor
         FROM ga_numcel_personal_to
         WHERE num_cel_pers = EN_num_cel_pers
         AND COD_ESTADO<>4;

         RETURN 1;

EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          RETURN 0;

END GA_EXISTE_NUMPERSONAL2_FN;

FUNCTION GA_EXISTE_NUMCORPORATIVO2_FN(EN_num_cel_pers    IN ga_numcel_personal_to.NUM_CEL_CORP%TYPE)
RETURN INTEGER
  IS
/*
<Documentación
TipoDoc = "Function">
 <Elemento
    Nombre = "GA_EXISTE_NUMCORPORATIVO2_FN"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Función que retorna si una abonado está o no asignado como número corporativo
    <Parámetros>
       <Entrada>
           <param nom="EN_num_cel_pers" Tipo="NUMBER">Número celular personal</param>
           </Entrada>
           <Salida>NA</Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


  LN_valor              NUMBER(1);

BEGIN

         SELECT 1 INTO LN_valor
         FROM ga_numcel_personal_to
         WHERE num_cel_CORP = EN_num_cel_pers
         AND COD_ESTADO<>4;

         RETURN 1;

EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                          RETURN 0;

END GA_EXISTE_NUMCORPORATIVO2_FN;



PROCEDURE GA_VAL_ACTIV_NUMPERS_PR (EV_num_celular        IN VARCHAR2,--ga_abocel.num_celular%TYPE,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_mens_retorno   OUT NOCOPY VARCHAR2)

IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_VAL_ACTIV_NUMPERS_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Función que valida si un número celular puede o no ser asignado como número personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="NUMBER">Número celular personal</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
           <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
           <param nom="SV_mens_retorno" Tipo="NUMBER">Mensaje de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


fin_numperexiste                                  EXCEPTION;
fin_nosituacion                                   EXCEPTION;
fin_noindividual                                  EXCEPTION;
fin_atlantida                                     EXCEPTION;
fin_nogruptec                                     EXCEPTION;
fin_nosituacionAAA                                        EXCEPTION;

LN_num_abonado                            ga_abocel.num_abonado%TYPE;
LV_cod_plantarif                                  ga_abocel.cod_plantarif%TYPE;
LV_tip_plnatarif                                  ga_abocel.tip_plantarif%TYPE;

LV_existe                                               VARCHAR2(5);
LN_cod_retorno                          ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno                 ge_errores_td.det_msgerror%TYPE;
LN_num_evento                   ge_errores_pg.evento;

LN_num_celular                          ga_abocel.num_celular%TYPE;
LN_num_celular_aux                                      ga_abocel.num_celular%TYPE;

LV_grptecdma                            al_grupo_tecnologia_td.cod_grupo%TYPE;
LV_grptecabo                            al_grupo_tecnologia_td.cod_grupo%TYPE;

LV_apltecdma                            ged_parametros.val_parametro%TYPE;
LN_cod_producto                                 ga_abocel.cod_producto%TYPE;

--Inicio MA 36134 Mauricio 11-01-2007
LV_codsituacion                           ga_abocel.cod_situacion%TYPE;

LN_CelCorp                                        ga_numcel_personal_to.NUM_CEL_CORP%TYPE;

BEGIN
         SN_num_evento := 0;
         LN_num_celular := TO_NUMBER(EV_num_celular);

         BEGIN
                 SELECT num_abonado, cod_plantarif,cod_producto,
                 ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_situacion
                 INTO LN_num_abonado, LV_cod_plantarif,LN_cod_producto, LV_grptecabo ,LV_codsituacion
                 FROM ga_abocel
                 WHERE num_celular = LN_num_celular
                 and FEC_ALTA = (select max(c.FEC_ALTA) from ga_abocel c WHERE c.num_celular = LN_num_celular)
-- MA 36134      AND cod_situacion = 'AAA'
                 AND cod_situacion = 'AAA' -- se agrega por incidencia 68377
                 UNION
                 SELECT num_abonado, cod_plantarif,cod_producto,
                 ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_situacion
                 FROM ga_aboamist
                 WHERE num_celular = LN_num_celular
                 and FEC_ALTA = (select max(c.FEC_ALTA) from ga_aboamist c WHERE c.num_celular = LN_num_celular)
-- MA 36134              AND cod_situacion = 'AAA'
                 AND cod_situacion = 'AAA'; -- se agrega por incidencia 68377
         EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                           RAISE fin_nosituacion;
         END;

--Inicio MA 36134 Mauricio 11-01-2007
        IF LV_codsituacion <> 'AAA' THEN
             RAISE fin_nosituacionAAA;
        END IF;
--Fin MA 36134  Mauricio 11-01-2007

        PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_prm_grptecdma,LV_grptecdma);

        PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_PARAM_APLCDMA,LV_apltecdma);

        IF LV_grptecabo = LV_grptecdma THEN
                IF LV_apltecdma = 'FALSE' THEN
                   RAISE fin_nogruptec;
                END IF;
        END IF;


         IF GA_EXISTE_NUMPERSONAL_FN(LN_num_celular) = 1 THEN

                 SELECT NUM_CEL_CORP INTO LN_CelCorp
                 FROM ga_numcel_personal_to
                 WHERE num_cel_pers = LN_num_celular
                           AND COD_ESTADO<>4;

                RAISE fin_numperexiste;
         END IF;

         BEGIN
                 SELECT cod_plantarif
                 INTO LV_cod_plantarif
                 FROM ta_plantarif
                 WHERE cod_plantarif = LV_cod_plantarif
                 AND tip_plantarif= 'I';
         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   RAISE fin_noindividual;
         END;

         PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR(LN_num_abonado,LV_existe,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
         IF LV_existe='TRUE' THEN
            RAISE fin_atlantida;
         END IF;

         SN_cod_retorno := 0;
         SV_mens_retorno := 'OK';
EXCEPTION
                 WHEN fin_nosituacion THEN
                          SN_cod_retorno := 1;
--MA 36134 Mauricio 11-01-2007  SV_mens_retorno := 'EL número celular debe existir en SCL con situación alta activa abonado.';
                          SV_mens_retorno := 'Estado de línea no válido para asignar como número personal debe encontrarse en AAA, Alta Activa Abonado. Actualmente no existe en el Sistema Comercial';
                 WHEN fin_numperexiste THEN
                          SN_cod_retorno := 2;
                          SV_mens_retorno := 'El abonado está asociado a la línea '||LN_CelCorp||' como Número Personal.';
                 WHEN fin_noindividual THEN
                          SN_cod_retorno := 3;
                          SV_mens_retorno := 'EL abonado debe poseer tipo plan tarifario individual.';
                 WHEN fin_atlantida THEN
                          SN_cod_retorno := 4;
                          SV_mens_retorno := 'EL número celular es Atlántida.';
                 WHEN fin_nogruptec THEN
                          SN_cod_retorno := 5;
                          SV_mens_retorno := 'Operación de número personal no disponible para la tecnología del abonado.';
--Inicio MA 36134 Mauricio 11-01-2007
                 WHEN fin_nosituacionAAA THEN
                          SN_cod_retorno := 6;
                          SV_mens_retorno := 'Estado de Línea no válido para asignar número personal debe encontrarse en AAA, Alta Activa Abonado, actualmente se encuentra en ' || LV_codsituacion || '.';
--Fin MA 36134 Mauricio 11-01-2007
                 WHEN OTHERS THEN
                          SN_cod_retorno := 9;
                               SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0, EV_cod_prog, CV_error_no_clasif, CV_1, USER, NULL, NULL, sqlcode, SQLERRM);
                          SV_mens_retorno := SUBSTR('Error desconocido:' || SQLERRM , 1 ,255) ;

END GA_VAL_ACTIV_NUMPERS_PR;




PROCEDURE GA_VAL_ACTIV_NUMPERS_MODIF_PR (EV_num_celular        IN VARCHAR2,--ga_abocel.num_celular%TYPE,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_mens_retorno   OUT NOCOPY VARCHAR2)

IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_VAL_ACTIV_NUMPERS_MODIF_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Función que valida si un número celular puede o no ser asignado como número personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="NUMBER">Número celular personal</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
           <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
           <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
           <param nom="SV_mens_retorno" Tipo="NUMBER">Mensaje de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


fin_numperexiste                                  EXCEPTION;
fin_nosituacion                                   EXCEPTION;
fin_noindividual                                  EXCEPTION;
fin_atlantida                                     EXCEPTION;
fin_nogruptec                                     EXCEPTION;
fin_nosituacionAAA                                        EXCEPTION;

LN_num_abonado                            ga_abocel.num_abonado%TYPE;
LV_cod_plantarif                                  ga_abocel.cod_plantarif%TYPE;
LV_tip_plnatarif                                  ga_abocel.tip_plantarif%TYPE;

LV_existe                                               VARCHAR2(5);
LN_cod_retorno                          ge_errores_td.cod_msgerror%TYPE;
LV_mens_retorno                 ge_errores_td.det_msgerror%TYPE;
LN_num_evento                   ge_errores_pg.evento;

LN_num_celular                          ga_abocel.num_celular%TYPE;
LN_num_celular_aux                                      ga_abocel.num_celular%TYPE;

LV_grptecdma                            al_grupo_tecnologia_td.cod_grupo%TYPE;
LV_grptecabo                            al_grupo_tecnologia_td.cod_grupo%TYPE;

LV_apltecdma                            ged_parametros.val_parametro%TYPE;
LN_cod_producto                                 ga_abocel.cod_producto%TYPE;

--Inicio MA 36134 Mauricio 11-01-2007
LV_codsituacion                           ga_abocel.cod_situacion%TYPE;

LN_CelCorp                                        ga_numcel_personal_to.NUM_CEL_CORP%TYPE;

BEGIN
         SN_num_evento := 0;
         LN_num_celular := TO_NUMBER(EV_num_celular);

         BEGIN
                 SELECT num_abonado, cod_plantarif,cod_producto,
                 ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_situacion
                 INTO LN_num_abonado, LV_cod_plantarif,LN_cod_producto, LV_grptecabo ,LV_codsituacion
                 FROM ga_abocel
                 WHERE num_celular = LN_num_celular
                 and FEC_ALTA = (select max(c.FEC_ALTA) from ga_abocel c WHERE c.num_celular = LN_num_celular)
-- MA 36134      AND cod_situacion = 'AAA'
                 AND cod_situacion = 'AAA' -- se agrega por incidencia 68377
                 UNION
                 SELECT num_abonado, cod_plantarif,cod_producto,
                 ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_situacion
                 FROM ga_aboamist
                 WHERE num_celular = LN_num_celular
                 and FEC_ALTA = (select max(c.FEC_ALTA) from ga_aboamist c WHERE c.num_celular = LN_num_celular)
-- MA 36134              AND cod_situacion = 'AAA'
                 AND cod_situacion = 'AAA'; -- se agrega por incidencia 68377
         EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                           RAISE fin_nosituacion;
         END;

--Inicio MA 36134 Mauricio 11-01-2007
        IF LV_codsituacion <> 'AAA' THEN
             RAISE fin_nosituacionAAA;
        END IF;
--Fin MA 36134  Mauricio 11-01-2007

        PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_prm_grptecdma,LV_grptecdma);

        PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_PARAM_APLCDMA,LV_apltecdma);

        IF LV_grptecabo = LV_grptecdma THEN
                IF LV_apltecdma = 'FALSE' THEN
                   RAISE fin_nogruptec;
                END IF;
        END IF;


         IF GA_EXISTE_NUMPERSONAL_FN(LN_num_celular) = 1 THEN

                 SELECT NUM_CEL_CORP INTO LN_CelCorp
                 FROM ga_numcel_personal_to
                 WHERE num_cel_pers = LN_num_celular
                           AND COD_ESTADO<>4;

                RAISE fin_numperexiste;
         END IF;

         BEGIN
                 SELECT cod_plantarif
                 INTO LV_cod_plantarif
                 FROM ta_plantarif
                 WHERE cod_plantarif = LV_cod_plantarif
                 AND tip_plantarif= 'I';
         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   RAISE fin_noindividual;
         END;

         PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR(LN_num_abonado,LV_existe,LN_cod_retorno,LV_mens_retorno,LN_num_evento);
         IF LV_existe='TRUE' THEN
            begin

                SELECT NUM_CEL_corp
                into LN_num_celular_aux
                FROM GA_NUMCEL_PERSONAL_TO WHERE NUM_CEL_CORP = LN_num_celular;
                exception
                when no_data_found then
                        LN_num_celular_aux:=0;
                end;

                if (LN_num_celular_aux=0)  then
                        RAISE fin_atlantida;
                end if;

         END IF;

         SN_cod_retorno := 0;
         SV_mens_retorno := 'OK';
EXCEPTION
                 WHEN fin_nosituacion THEN
                          SN_cod_retorno := 1;
--MA 36134 Mauricio 11-01-2007  SV_mens_retorno := 'EL número celular debe existir en SCL con situación alta activa abonado.';
                          SV_mens_retorno := 'Estado de línea no válido para asignar como número personal debe encontrarse en AAA, Alta Activa Abonado. Actualmente no existe en el Sistema Comercial';
                 WHEN fin_numperexiste THEN
                          SN_cod_retorno := 2;
                          SV_mens_retorno := 'El abonado está asociado a la línea '||LN_CelCorp||' como Número Personal.';
                 WHEN fin_noindividual THEN
                          SN_cod_retorno := 3;
                          SV_mens_retorno := 'EL abonado debe poseer tipo plan tarifario individual.';
                 WHEN fin_atlantida THEN
                          SN_cod_retorno := 4;
                          SV_mens_retorno := 'EL número celular es Atlántida.';
                 WHEN fin_nogruptec THEN
                          SN_cod_retorno := 5;
                          SV_mens_retorno := 'Operación de número personal no disponible para la tecnología del abonado.';
--Inicio MA 36134 Mauricio 11-01-2007
                 WHEN fin_nosituacionAAA THEN
                          SN_cod_retorno := 6;
                          SV_mens_retorno := 'Estado de Línea no válido para asignar número personal debe encontrarse en AAA, Alta Activa Abonado, actualmente se encuentra en ' || LV_codsituacion || '.';
--Fin MA 36134 Mauricio 11-01-2007
                 WHEN OTHERS THEN
                          SN_cod_retorno := 9;
                               SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0, EV_cod_prog, CV_error_no_clasif, CV_1, USER, NULL, NULL, sqlcode, SQLERRM);
                          SV_mens_retorno := SUBSTR('Error desconocido:' || SQLERRM , 1 ,255) ;

END GA_VAL_ACTIV_NUMPERS_MODIF_PR;





PROCEDURE GA_VAL_ACCESO_NUMPERS_PR (
                                                           EV_param_entrada IN  VARCHAR2,
                                                           SV_resultado      OUT NOCOPY VARCHAR2,
                                                           SV_mensaje        OUT NOCOPY GA_TRANSACABO.DES_CADENA%TYPE)
IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "PV_VAL_ACCESO_NUMPERS_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento tipo restricción que permite o no el acceso a la orde de servicio
        de Mantenimineto de número personal
    <Parámetros>
       <Entrada>
           <param nom="LV_param_entrada" Tipo="VARCHAR">Cadena con parámetros de entrada</param>
           </Entrada>
           <Salida>
           <param nom="LV_resultado" Tipo="VARCHAR">Resultado de la validación</param>
           <param nom="LV_mensaje" Tipo="VARCHAR">mensaje de error en caso de aplicar la restricción</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/

  fin_nogruptec                                    exception;

  string GE_TABTYPE_VCH2ARRAY:= GE_TABTYPE_VCH2ARRAY('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','');
  LN_num_abonado                                ga_abocel.num_celular%TYPE;
  LN_num_celular                                ga_abocel.num_celular%TYPE;
  LV_cod_situacion                              ga_abocel.cod_situacion%TYPE;
  LN_cod_producto                               ga_abocel.cod_producto%TYPE;

  LV_existe                                             VARCHAR2(5);

  LN_cod_retorno                                ge_errores_td.cod_msgerror%TYPE;
  LV_mens_retorno               ge_errores_td.det_msgerror%TYPE;
  LN_num_evento                 ge_errores_pg.evento;

  LV_grptecdma                                  al_grupo_tecnologia_td.cod_grupo%TYPE;
  LV_grptecabo                                  al_grupo_tecnologia_td.cod_grupo%TYPE;

  LV_apltecdma                                  ged_parametros.val_parametro%TYPE;

BEGIN

         SV_resultado := 'FALSE';

         GE_PAC_ArregloPR.GE_PR_RetornaArreglo(EV_param_entrada, string);
         LN_num_abonado := TO_NUMBER(string(5));

         SELECT a.num_celular, a.cod_situacion, a.cod_producto,
         ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(a.cod_tecnologia)
         INTO LN_num_celular,LV_cod_situacion,LN_cod_producto,
         LV_grptecabo
         FROM ga_abocel a
         WHERE a.num_abonado = LN_num_abonado;

         IF LV_cod_situacion NOT IN ('BAA','BAP') THEN

                PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR(LN_num_abonado,LV_existe,LN_cod_retorno,LV_mens_retorno,LN_num_evento);

                IF LV_existe = 'TRUE' THEN --ES ATLANTIDA
                   SV_resultado := 'TRUE';
                ELSE
                        IF LN_cod_retorno = 0 THEN

                                 PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_prm_grptecdma,LV_grptecdma);

                                 IF LV_grptecabo = LV_grptecdma THEN

                                        PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_PARAM_APLCDMA,LV_apltecdma);

                                        IF LV_apltecdma = 'FALSE' THEN
                                           RAISE fin_nogruptec;
                                        END IF;
                                 END IF;

                           IF LV_cod_situacion = 'AAA' THEN
                                  IF GA_EXISTE_NUMPERSONAL_FN(LN_num_celular) = 1 THEN
                                         SV_resultado := 'TRUE';
                                  ELSE
                                         SV_mensaje := 'Número celular del abonado no está asignado como personal.';
                                  END IF;
                           ELSE
                                   SV_mensaje := 'El abonado no se encuentra en situación alta activa.';
                           END IF;
                        ELSE -- Ocurrió un error  al validar --
                                SV_mensaje := 'Ocurrió un error: ' || LV_mens_retorno || '. N°evento: ' || LN_num_evento;
                        END IF;
                END IF;

         ELSE
                 SV_mensaje := 'El abonado se encuentra en situación de baja.';
         END IF;

EXCEPTION
                 WHEN fin_nogruptec THEN
                          SV_mensaje := 'Orden de servicio no está activa para la tecnología del abonado.';
                 WHEN OTHERS THEN
                          SV_resultado := 'FALSE';
                          SV_mensaje := SUBSTR('Error PL PV_VAL_ACCESO_NUMPERS_PR: ' || SQLERRM,1,255);

END GA_VAL_ACCESO_NUMPERS_PR;

PROCEDURE GA_ACTIVA_NUMPERSONAL_PR (
                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                  EV_num_cel_corp        IN VARCHAR2,
                                                                  EN_num_movimiento      IN icc_movimiento.num_movant%TYPE,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  )
IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_ACTIVA_NUMPERSONAL_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento que valida y envia comando de central para la activación de un
        número celular como personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="VARCHAR">Número celular personal</param>
                   <param nom="EV_num_cel_corp" Tipo="VARCHAR">Número celular corporativo (Atlántida)</param>
                   <param nom="EN_num_movimiento" Tipo="NUMBER">Número movimiento central que se desea que se ejecute primero</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
           <param nom="SN_p_correlativo" Tipo="NUMBER">número movimiento ingresado (0 : sin error)</param>
           <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
           <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


  LN_num_cel_pers                                 ga_numcel_personal_to.num_cel_pers%TYPE;
  LN_num_cel_corp                                 ga_numcel_personal_to.num_cel_corp%TYPE;

  fin_NoAtlantida                               EXCEPTION;
  fin_NoPersonal                                EXCEPTION;
  fin_noAgregarNumPer                   EXCEPTION;
  fin_noICC                                     EXCEPTION;

  LV_existe                                             VARCHAR2(5);
  LN_cod_retorno                                ge_errores_td.cod_msgerror%TYPE;

  LN_filasafectas                       INTEGER;
  LV_vcod_retorno                       VARCHAR2(1);

  LV_cod_actabo                                 ga_actabo.cod_actabo%TYPE;
  LN_num_celular                                ga_abocel.num_celular%TYPE;

  LN_num_abo_corp                               ga_abocel.num_abonado%TYPE;
  LN_num_abo_pers                               ga_abocel.num_abonado%TYPE;
  LN_cod_actuacion                              ga_actabo.cod_actcen%TYPE;
  LV_tip_terminal                               ga_abocel.tip_terminal%TYPE;
  LN_cod_central                                ga_abocel.cod_central%TYPE;
  LV_num_seriehex                               ga_abocel.num_seriehex%TYPE;
  LV_num_min                                    ga_abocel.num_min%TYPE;
  LV_cod_tecnologia                             ga_abocel.cod_tecnologia%TYPE;
  LV_imsi                                               icc_movimiento.imsi%TYPE;
  LV_imei                                               icc_movimiento.imei%TYPE;
  LV_icc                                                icc_movimiento.icc%TYPE;
  LV_cod_grupo_tec                              al_grupo_tecnologia_td.cod_grupo%TYPE;
  LV_grupo_gsm                                  al_grupo_tecnologia_td.cod_grupo%TYPE;
  LN_cod_producto                               ga_abocel.cod_producto%TYPE;
  LV_num_serie                                  ga_abocel.num_serie%TYPE;
  LV_num_imei                                   ga_abocel.num_imei%TYPE;
  LV_cod_plantarif                              ga_abocel.cod_plantarif%TYPE;

  LV_sSql          ge_errores_pg.vQuery;

  LN_p_retornora                        NUMBER(15);

BEGIN

         SN_p_correlativo := 0;
         SN_num_evento := 0;


         LN_num_cel_pers := TO_NUMBER(EV_num_cel_pers);
         LN_num_cel_corp := TO_NUMBER(EV_num_cel_corp);

         LV_sSql :=  'ga_abocel';

         SELECT num_abonado
         INTO LN_num_abo_corp
         FROM ga_abocel
         WHERE num_celular = LN_num_cel_corp
         AND cod_situacion NOT IN ('BAA','BAP');

         LV_sSql :=  'PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR';

         PV_OBTIENEINFO_ATLANTIDA_PG.PV_EXISTEABOATLANTIDA2_PR(LN_num_abo_corp,LV_existe,LN_cod_retorno,SV_msg_retorno,SN_num_evento);
         IF LV_existe='FALSE' THEN
                RAISE fin_NoAtlantida;
         END IF;

         LV_sSql :=  'GA_VAL_ACTIV_NUMPERS_PR';

         GA_VAL_ACTIV_NUMPERS_PR(LN_num_cel_pers,EV_cod_prog, LN_cod_retorno,SN_num_evento,SV_msg_retorno);
         IF NOT LN_cod_retorno = 0 THEN
                RAISE fin_NoPersonal;
         END IF;

         LV_sSql :=  'GA_NUMCEL_PERSONAL_TO_I_PG.AGREGAR_PR';

         GA_NUMCEL_PERSONAL_TO_I_PG.GA_AGREGAR_PR(LN_num_cel_pers, LN_num_cel_corp,CN_ESTADO_PA, USER, SYSDATE, EV_cod_prog,
                                                                                        LN_filasafectas,  LN_p_retornora,  SN_num_evento,  LV_vcod_retorno );
         IF NOT (LV_vcod_retorno = '0' AND LN_filasafectas = 1)  THEN
                SV_msg_retorno := TO_CHAR(LN_p_retornora);
                RAISE fin_noAgregarNumPer;
         END IF;

         LV_sSql :=  'ga_abocel UNION ga_aboamist';

         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         INTO LN_num_abo_pers, LV_tip_terminal, LN_cod_central,LV_num_seriehex, LV_num_min,
         LV_cod_tecnologia,LV_cod_grupo_tec,LN_cod_producto,LV_num_serie,LV_num_imei,LV_cod_plantarif
         FROM ga_abocel
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA'
         UNION
         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         FROM ga_aboamist
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA';

         LV_sSql :=  'PV_PR_DEVVALPARAM';

         PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_param_grpgsm,LV_grupo_gsm);

         IF LV_cod_grupo_tec = LV_grupo_gsm THEN
                LV_imsi := fn_recupera_imsi(LV_num_serie);
                LV_imei := LV_num_imei;
                LV_icc :=  LV_num_serie;
         END IF;

        BEGIN

                LV_sSql :=  'ta_plantarif a , pv_actabo_tiplan b';

                 SELECT cod_actabo INTO LV_cod_actabo
                 FROM ta_plantarif a , pv_actabo_tiplan b
                 WHERE a.cod_plantarif = LV_cod_plantarif
                 AND b.cod_tipmodi = GV_cod_actabo
                 AND a.cod_tiplan  = b.cod_tiplan;

         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   LV_cod_actabo :=  GV_cod_actabo;
         END;

         LV_sSql :=  'FN_CODACTCEN';

         LN_cod_actuacion := FN_CODACTCEN(LN_cod_producto,LV_cod_actabo,GV_cod_modulo,LV_cod_tecnologia);
         LN_filasafectas := 0;

         LV_sSql :=  'ICC_MOVIMIENTO_I_PG.AGREGAR_PR';

           ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(NULL,
                  LN_num_abo_pers,  -- num_abonado,
                  GN_cod_estado_icc,-- cod_estado
                  LV_cod_actabo,
                  GV_cod_modulo,
                  GN_num_intentos,--num_intentos
                  NULL,
                  'PENDIENTE',--des_respuesta
                  LN_cod_actuacion,
                  USER,
                  SYSDATE,
                  LV_tip_terminal,
                  LN_cod_central,
                  NULL,
                  GN_ind_bloqueo,--ind_bloqueo
                  NULL,
                  NULL,
                  NULLIF(EN_num_movimiento,0),--- num_movant
                  LN_num_cel_pers,
                  NULL,
                  LV_num_seriehex,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  LV_num_min,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,--PLAN
                  NULL,--CARGA
                  NULL,
                  NULL,
                  NULL,
                  NULL,--des_mensaje,
                  NULL,--cod_pin,
                  NULL,--cod_idioma,
                  NULL,--cod_enrutamiento,
                  NULL,--tip_enrutamiento,
                  NULL,--des_origen_pin,
                  NULL,--num_lote_pin,
                  NULL,--num_serie_pin,
                  LV_cod_tecnologia,--tip_tecnologia,
                  LV_imsi,--imsi,
                  NULL,--imsi_nue,
                  LV_imei,--imei,
                  NULL,--imei_nue,
                  LV_icc,--icc,
                  NULL,--icc_nue
                  EV_cod_prog,
                  SN_p_correlativo,
                  LN_filasafectas,
                  SV_msg_retorno,  SN_num_evento,  LV_vcod_retorno
                  );

         IF NOT (LV_vcod_retorno = '0' AND LN_filasafectas = 1)  THEN
                         RAISE fin_noICC;
         ELSE
                 SN_cod_retorno := 0;
                 SN_num_evento := 0;
                 SV_msg_retorno := 'OK';
         END IF;


EXCEPTION
                 WHEN fin_NoAtlantida THEN
                          SN_cod_retorno := 1;
             WHEN fin_NoPersonal THEN
                          SN_cod_retorno := 2;
                 WHEN fin_noAgregarNumPer THEN
                          SN_cod_retorno := 3;
                 WHEN fin_noICC THEN
                          SN_cod_retorno := 4;
                 WHEN OTHERS THEN
                          SN_cod_retorno := 9;
                          SV_msg_retorno := SUBSTR(SQLERRM,1,255);
                          SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                                                                                   EV_cod_prog,
                                                                                                                   CV_error_no_clasif,
                                                                                                                   CV_1,
                                                                                                                   USER,
                                                                                                                   NULL,--CV_PACKAGE2,
                                                                                                                   LV_sSql,
                                                                                                                   sqlcode,
                                                                                                                   SQLERRM);
END GA_ACTIVA_NUMPERSONAL_PR;

PROCEDURE GA_DESACTIVA_NUMPERSONAL_PR (
                                                                  EV_num_cel_pers       IN VARCHAR2,--ga_numcel_personal_to.num_cel_pers%TYPE,
                                                                  EV_cod_prog           IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  )
IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_DESACTIVA_NUMPERSONAL_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento que valida y envia comando de central para la activación de un
        número celular como personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="VARCHAR">Número celular personal</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
           <param nom="SN_p_correlativo" Tipo="NUMBER">número movimiento ingresado (0 : sin error)</param>
           <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
           <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/


LN_num_cel_pers                                   ga_numcel_personal_to.num_cel_pers%TYPE;

fin_NoNumPers                                     EXCEPTION;
fin_noModificaEstado                      EXCEPTION;
fin_noICC                                                 EXCEPTION;

LN_filasafectas                                   INTEGER;
LV_cod_retorno                                    VARCHAR(1);

  LV_cod_actabo                                 ga_actabo.cod_actabo%TYPE;
  LN_num_celular                                ga_abocel.num_celular%TYPE;

  LN_num_abo_corp                               ga_abocel.num_abonado%TYPE;
  LN_num_abo_pers                               ga_abocel.num_abonado%TYPE;
  LN_cod_actuacion                              ga_actabo.cod_actcen%TYPE;
  LV_tip_terminal                               ga_abocel.tip_terminal%TYPE;
  LN_cod_central                                ga_abocel.cod_central%TYPE;
  LV_num_seriehex                               ga_abocel.num_seriehex%TYPE;
  LV_num_min                                    ga_abocel.num_min%TYPE;
  LV_cod_tecnologia                             ga_abocel.cod_tecnologia%TYPE;
  LV_imsi                                               icc_movimiento.imsi%TYPE;
  LV_imei                                               icc_movimiento.imei%TYPE;
  LV_icc                                                icc_movimiento.icc%TYPE;
  LV_cod_grupo_tec                              al_grupo_tecnologia_td.cod_grupo%TYPE;
  LV_grupo_gsm                                  al_grupo_tecnologia_td.cod_grupo%TYPE;
  LN_cod_producto                               ga_abocel.cod_producto%TYPE;
  LV_num_serie                                  ga_abocel.num_serie%TYPE;
  LV_num_imei                                   ga_abocel.num_imei%TYPE;
  LV_cod_plantarif                              ga_abocel.cod_plantarif%TYPE;

  LV_sSql          ge_errores_pg.vQuery;


BEGIN
         LN_num_cel_pers := TO_NUMBER(EV_num_cel_pers);--       IN VARCHAR2,--ga_numcel_personal_to.num_cel_pers%TYPE,

         IF GA_EXISTE_NUMPERSONAL_FN(LN_num_cel_pers)=0 THEN
                RAISE fin_NoNumPers;
         END IF;

         GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(LN_num_cel_pers, NULL, NULL, CN_ESTADO_PD, NULL, NULL, EV_cod_prog, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

         IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                RAISE fin_noModificaEstado;
         END IF;

         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         INTO LN_num_abo_pers, LV_tip_terminal, LN_cod_central,LV_num_seriehex, LV_num_min,
         LV_cod_tecnologia,LV_cod_grupo_tec,LN_cod_producto,LV_num_serie,LV_num_imei,LV_cod_plantarif
         FROM ga_abocel
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA'
         UNION
         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         FROM ga_aboamist
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA';

         PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_param_grpgsm,LV_grupo_gsm);

         IF LV_cod_grupo_tec = LV_grupo_gsm THEN
                LV_imsi := fn_recupera_imsi(LV_num_serie);
                LV_imei := LV_num_imei;
                LV_icc :=  LV_num_serie;
         END IF;

        BEGIN

                 SELECT cod_actabo INTO LV_cod_actabo
                 FROM ta_plantarif a , pv_actabo_tiplan b
                 WHERE a.cod_plantarif = LV_cod_plantarif
                 AND b.cod_tipmodi = GV_cod_actabo
                 AND a.cod_tiplan  = b.cod_tiplan;

         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   LV_cod_actabo :=  GV_cod_actabo;
         END;

         LN_cod_actuacion := FN_CODACTCEN(LN_cod_producto,LV_cod_actabo,GV_cod_modulo,LV_cod_tecnologia);
         LN_filasafectas := 0;

           ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(NULL,
                  LN_num_abo_pers,  -- num_abonado,
                  GN_cod_estado_icc,-- cod_estado
                  LV_cod_actabo,
                  GV_cod_modulo,
                  GN_num_intentos,--num_intentos
                  NULL,
                  'PENDIENTE',--des_respuesta
                  LN_cod_actuacion,
                  USER,
                  SYSDATE,
                  LV_tip_terminal,
                  LN_cod_central,
                  NULL,
                  GN_ind_bloqueo,--ind_bloqueo
                  NULL,
                  NULL,
                  NULL,--- num_movant
                  LN_num_cel_pers,
                  NULL,
                  LV_num_seriehex,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  LV_num_min,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,--PLAN
                  NULL,--CARGA
                  NULL,
                  NULL,
                  NULL,
                  NULL,--des_mensaje,
                  NULL,--cod_pin,
                  NULL,--cod_idioma,
                  NULL,--cod_enrutamiento,
                  NULL,--tip_enrutamiento,
                  NULL,--des_origen_pin,
                  NULL,--num_lote_pin,
                  NULL,--num_serie_pin,
                  LV_cod_tecnologia,--tip_tecnologia,
                  LV_imsi,--imsi,
                  NULL,--imsi_nue,
                  LV_imei,--imei,
                  NULL,--imei_nue,
                  LV_icc,--icc,
                  NULL,--icc_nue
                  EV_cod_prog,
                  SN_p_correlativo,
                  LN_filasafectas,
                  SV_msg_retorno,  SN_num_evento,  LV_cod_retorno
                  );

         IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                         RAISE fin_noICC;
         ELSE
                 SN_cod_retorno := 0;
                 SN_num_evento  := 0;
                 SV_msg_retorno := 'OK';
         END IF;

EXCEPTION
                 WHEN fin_NoNumPers THEN
                          SN_cod_retorno := 1;
                          SV_msg_retorno := 'El número personal ingresado no fue encontrado.';
                 WHEN fin_noModificaEstado THEN
                          SN_cod_retorno := 2;
                          SV_msg_retorno := SV_msg_retorno || '. Error al intentar actualizar estado (Pendiente desactivación) del número personal.';
                 WHEN fin_noICC THEN
                      SN_cod_retorno := 3;
                 WHEN OTHERS THEN
                          SN_cod_retorno := 9;
                          SV_msg_retorno := SUBSTR(SQLERRM,1,255);
                          SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                                                                                   EV_cod_prog,
                                                                                                                   CV_error_no_clasif,
                                                                                                                   CV_1,
                                                                                                                   USER,
                                                                                                                   NULL,--CV_PACKAGE2,
                                                                                                                   NULL,--LV_sSql,
                                                                                                                   sqlcode,
                                                                                                                   SQLERRM);
END GA_DESACTIVA_NUMPERSONAL_PR;

PROCEDURE GA_MODIFICA_NUMPERSONAL_PR (
                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                  EV_num_cel_dtno        IN VARCHAR2,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  )
IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_ACTIVA_NUMPERSONAL_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento que valida y envia comando de central para la activación de un
        número celular como personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="VARCHAR">Número celular personal</param>
                   <param nom="EV_num_cel_dtno" Tipo="VARCHAR">Número celular que se desea activar como personal</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
           <param nom="SN_p_correlativo" Tipo="NUMBER">número movimiento ingresado (0 : sin error)</param>
           <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
           <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/

LN_num_cel_pers                                   ga_numcel_personal_to.num_cel_pers%TYPE;
LN_num_cel_dtno                                   ga_numcel_personal_to.num_cel_pers%TYPE;

fin_NoNumPers                                     EXCEPTION;
fin_noModificaEstado                      EXCEPTION;
fin_NoPersonalDtno                                EXCEPTION;
fin_noICC                                                 EXCEPTION;

LN_filasafectas                                   INTEGER;
LV_cod_retorno                                    VARCHAR(1);

LN_cod_retorno                                    INTEGER;

  LV_cod_actabo                                 ga_actabo.cod_actabo%TYPE;
  LN_num_celular                                ga_abocel.num_celular%TYPE;

  LN_num_abo_corp                               ga_abocel.num_abonado%TYPE;
  LN_num_abo_pers                               ga_abocel.num_abonado%TYPE;
  LN_cod_actuacion                              ga_actabo.cod_actcen%TYPE;
  LV_tip_terminal                               ga_abocel.tip_terminal%TYPE;
  LN_cod_central                                ga_abocel.cod_central%TYPE;
  LV_num_seriehex                               ga_abocel.num_seriehex%TYPE;
  LV_num_min                                    ga_abocel.num_min%TYPE;
  LV_cod_tecnologia                             ga_abocel.cod_tecnologia%TYPE;
  LV_imsi                                               icc_movimiento.imsi%TYPE;
  LV_imei                                               icc_movimiento.imei%TYPE;
  LV_icc                                                icc_movimiento.icc%TYPE;
  LV_cod_grupo_tec                              al_grupo_tecnologia_td.cod_grupo%TYPE;
  LV_grupo_gsm                                  al_grupo_tecnologia_td.cod_grupo%TYPE;
  LN_cod_producto                               ga_abocel.cod_producto%TYPE;
  LV_num_serie                                  ga_abocel.num_serie%TYPE;
  LV_num_imei                                   ga_abocel.num_imei%TYPE;
  LV_cod_plantarif                              ga_abocel.cod_plantarif%TYPE;

  LV_sSql          ge_errores_pg.vQuery;


BEGIN

         LN_num_cel_pers := TO_NUMBER(EV_num_cel_pers);
         LN_num_cel_dtno := TO_NUMBER(EV_num_cel_dtno);

         IF GA_EXISTE_NUMPERSONAL_FN(LN_num_cel_pers) = 0 THEN
                RAISE fin_NoNumPers;
         END IF;



         GA_VAL_ACTIV_NUMPERS_MODIF_PR(LN_num_cel_dtno,EV_cod_prog, LN_cod_retorno,SN_num_evento,SV_msg_retorno);
         IF NOT LN_cod_retorno = 0 THEN
                RAISE fin_NoPersonalDtno;
         END IF;

         GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(LN_num_cel_pers, null,null, CN_ESTADO_PM, NULL, NULL, EV_cod_prog, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

         IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                RAISE fin_noModificaEstado;
         END IF;

         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         INTO LN_num_abo_pers, LV_tip_terminal, LN_cod_central,LV_num_seriehex, LV_num_min,
         LV_cod_tecnologia,LV_cod_grupo_tec,LN_cod_producto,LV_num_serie,LV_num_imei,LV_cod_plantarif
         FROM ga_abocel
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA'
         UNION
         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         FROM ga_aboamist
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA';

         PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_param_grpgsm,LV_grupo_gsm);

         IF LV_cod_grupo_tec = LV_grupo_gsm THEN
                LV_imsi := fn_recupera_imsi(LV_num_serie);
                LV_imei := LV_num_imei;
                LV_icc :=  LV_num_serie;
         END IF;

        BEGIN

                 SELECT cod_actabo INTO LV_cod_actabo
                 FROM ta_plantarif a , pv_actabo_tiplan b
                 WHERE a.cod_plantarif = LV_cod_plantarif
                 AND b.cod_tipmodi = GV_cod_actabo
                 AND a.cod_tiplan  = b.cod_tiplan;

         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   LV_cod_actabo :=  GV_cod_actabo;
         END;

         LN_cod_actuacion := FN_CODACTCEN(LN_cod_producto,LV_cod_actabo,GV_cod_modulo,LV_cod_tecnologia);
         LN_filasafectas := 0;

           ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(NULL,
                  LN_num_abo_pers,  -- num_abonado,
                  GN_cod_estado_icc,-- cod_estado
                  LV_cod_actabo,
                  GV_cod_modulo,
                  GN_num_intentos,--num_intentos
                  NULL,
                  'PENDIENTE',--des_respuesta
                  LN_cod_actuacion,
                  USER,
                  SYSDATE,
                  LV_tip_terminal,
                  LN_cod_central,
                  NULL,
                  GN_ind_bloqueo,--ind_bloqueo
                  NULL,
                  NULL,
                  NULL,--- num_movant
                  LN_num_cel_pers,
                  NULL,
                  LV_num_seriehex,
                  NULL,
                  LN_num_cel_dtno,--num_celular_nue
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  LV_num_min,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,--PLAN
                  NULL,--CARGA
                  NULL,
                  NULL,
                  NULL,
                  NULL,--des_mensaje,
                  NULL,--cod_pin,
                  NULL,--cod_idioma,
                  NULL,--cod_enrutamiento,
                  NULL,--tip_enrutamiento,
                  NULL,--des_origen_pin,
                  NULL,--num_lote_pin,
                  NULL,--num_serie_pin,
                  LV_cod_tecnologia,--tip_tecnologia,
                  LV_imsi,--imsi,
                  NULL,--imsi_nue,
                  LV_imei,--imei,
                  NULL,--imei_nue,
                  LV_icc,--icc,
                  NULL,--icc_nue
                  EV_cod_prog,
                  SN_p_correlativo,
                  LN_filasafectas,
                  SV_msg_retorno,  SN_num_evento,  LV_cod_retorno
                  );
         IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                         RAISE fin_noICC;
         ELSE
                 SN_cod_retorno := 0;
                 SN_num_evento  := 0;
                 SV_msg_retorno := 'OK';
         END IF;

EXCEPTION
                 WHEN fin_NoNumPers THEN
                          SN_cod_retorno := 1;
                          SV_msg_retorno := 'El número personal ingresado no fue encontrado.';
                 WHEN fin_noModificaEstado THEN
                          SN_cod_retorno := 2;
                          SV_msg_retorno := SV_msg_retorno || '. Error al intentar actualizar estado (Pendiente modificación) del número personal.';
                 WHEN fin_noICC THEN
                      SN_cod_retorno := 3;
                 WHEN fin_NoPersonalDtno THEN
                          SN_cod_retorno := 4;
                 WHEN OTHERS THEN
                          SN_cod_retorno := 9;
                          SV_msg_retorno := SUBSTR(SQLERRM,1,255);
                          SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                                                                                   EV_cod_prog,
                                                                                                                   CV_error_no_clasif,
                                                                                                                   CV_1,
                                                                                                                   USER,
                                                                                                                   NULL,--CV_PACKAGE2,
                                                                                                                   NULL,--LV_sSql,
                                                                                                                   sqlcode,
                                                                                                                   SQLERRM);

END GA_MODIFICA_NUMPERSONAL_PR;


PROCEDURE GA_MODIFICA_NUMPERSONALCORP_PR (
                                                                  EV_num_cel_pers        IN VARCHAR2,
                                                                  EV_num_cel_dtno        IN VARCHAR2,
                                                                  EV_cod_prog            IN VARCHAR2,
                                                                  SN_p_correlativo      OUT NOCOPY NUMBER,
                                                                  SN_cod_retorno    OUT NOCOPY INTEGER,
                                                                  SN_num_evento     OUT NOCOPY INTEGER,
                                                                  SV_msg_retorno        OUT NOCOPY VARCHAR2
                                                                  )
IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_MODIFICA_NUMPERSONAL_CORP_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento que valida y envia comando de central para la activación de un
        número celular como personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_num_cel_pers" Tipo="VARCHAR">Número celular personal</param>
                   <param nom="EV_num_cel_dtno" Tipo="VARCHAR">Número celular que se desea activar como personal</param>
                   <param nom="EV_cod_prog" Tipo="VARCHAR">Modulo</param>
           </Entrada>
           <Salida>
           <param nom="SN_p_correlativo" Tipo="NUMBER">número movimiento ingresado (0 : sin error)</param>
           <param nom="SN_cod_retorno" Tipo="NUMBER">Código retorno de error (0 : sin error)</param>
           <param nom="SN_num_evento" Tipo="NUMBER">Número de evento</param>
           <param nom="SV_mens_retorno" Tipo="VARCHAR">Mensaje de error</param>
           </Salida>
    </Parámetros>
 </Elemento>
</Documentación>
*/

LN_num_cel_pers                                   ga_numcel_personal_to.num_cel_pers%TYPE;
LN_num_cel_dtno                                   ga_numcel_personal_to.num_cel_pers%TYPE;

fin_NoNumPers                                     EXCEPTION;
fin_noModificaEstado                      EXCEPTION;
fin_NoPersonalDtno                                EXCEPTION;
fin_noICC                                                 EXCEPTION;

LN_filasafectas                                   INTEGER;
LV_cod_retorno                                    VARCHAR(1);

LN_cod_retorno                                    INTEGER;

  LV_cod_actabo                                 ga_actabo.cod_actabo%TYPE;
  LN_num_celular                                ga_abocel.num_celular%TYPE;

  LN_num_abo_corp                               ga_abocel.num_abonado%TYPE;
  LN_num_abo_pers                               ga_abocel.num_abonado%TYPE;
  LN_cod_actuacion                              ga_actabo.cod_actcen%TYPE;
  LV_tip_terminal                               ga_abocel.tip_terminal%TYPE;
  LN_cod_central                                ga_abocel.cod_central%TYPE;
  LV_num_seriehex                               ga_abocel.num_seriehex%TYPE;
  LV_num_min                                    ga_abocel.num_min%TYPE;
  LV_cod_tecnologia                             ga_abocel.cod_tecnologia%TYPE;
  LV_imsi                                               icc_movimiento.imsi%TYPE;
  LV_imei                                               icc_movimiento.imei%TYPE;
  LV_icc                                                icc_movimiento.icc%TYPE;
  LV_cod_grupo_tec                              al_grupo_tecnologia_td.cod_grupo%TYPE;
  LV_grupo_gsm                                  al_grupo_tecnologia_td.cod_grupo%TYPE;
  LN_cod_producto                               ga_abocel.cod_producto%TYPE;
  LV_num_serie                                  ga_abocel.num_serie%TYPE;
  LV_num_imei                                   ga_abocel.num_imei%TYPE;
  LV_cod_plantarif                              ga_abocel.cod_plantarif%TYPE;

  LV_sSql          ge_errores_pg.vQuery;


BEGIN

         LN_num_cel_pers := TO_NUMBER(EV_num_cel_pers);
         LN_num_cel_dtno := TO_NUMBER(EV_num_cel_dtno);

         IF GA_EXISTE_NUMPERSONAL_FN(LN_num_cel_pers) = 0 THEN
                RAISE fin_NoNumPers;
         END IF;




         GA_VAL_ACTIV_NUMPERS_MODIF_PR(LN_num_cel_dtno,EV_cod_prog, LN_cod_retorno,SN_num_evento,SV_msg_retorno);
         IF NOT LN_cod_retorno = 0 THEN
                RAISE fin_NoPersonalDtno;
         END IF;

         GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(LN_num_cel_pers, null,null, CN_ESTADO_PM, NULL, NULL, EV_cod_prog, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

         IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                RAISE fin_noModificaEstado;
         END IF;

         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         INTO LN_num_abo_pers, LV_tip_terminal, LN_cod_central,LV_num_seriehex, LV_num_min,
         LV_cod_tecnologia,LV_cod_grupo_tec,LN_cod_producto,LV_num_serie,LV_num_imei,LV_cod_plantarif
         FROM ga_abocel
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA'
         UNION
         SELECT num_abonado,tip_terminal,cod_central,num_seriehex,al_fn_prefijo_numero(num_celular),
         cod_tecnologia,ga_aprovisionar_central_pg.pv_grupo_tecnologico_fn(cod_tecnologia),cod_producto,num_serie,num_imei,cod_plantarif
         FROM ga_aboamist
         WHERE num_celular = LN_num_cel_pers AND cod_situacion = 'AAA';

         PV_PR_DEVVALPARAM(GV_cod_modulo, LN_cod_producto,GV_param_grpgsm,LV_grupo_gsm);

         IF LV_cod_grupo_tec = LV_grupo_gsm THEN
                LV_imsi := fn_recupera_imsi(LV_num_serie);
                LV_imei := LV_num_imei;
                LV_icc :=  LV_num_serie;
         END IF;

        BEGIN

                 SELECT cod_actabo INTO LV_cod_actabo
                 FROM ta_plantarif a , pv_actabo_tiplan b
                 WHERE a.cod_plantarif = LV_cod_plantarif
                 AND b.cod_tipmodi = GV_cod_actabo
                 AND a.cod_tiplan  = b.cod_tiplan;

         EXCEPTION
                          WHEN NO_DATA_FOUND THEN
                                   LV_cod_actabo :=  GV_cod_actabo;
         END;

         LN_cod_actuacion := FN_CODACTCEN(LN_cod_producto,LV_cod_actabo,GV_cod_modulo,LV_cod_tecnologia);
         LN_filasafectas := 0;

           ICC_MOVIMIENTO_I_PG.ICC_AGREGAR_PR(NULL,
                  LN_num_abo_pers,  -- num_abonado,
                  GN_cod_estado_icc,-- cod_estado
                  LV_cod_actabo,
                  GV_cod_modulo,
                  GN_num_intentos,--num_intentos
                  NULL,
                  'PENDIENTE',--des_respuesta
                  LN_cod_actuacion,
                  USER,
                  SYSDATE,
                  LV_tip_terminal,
                  LN_cod_central,
                  NULL,
                  GN_ind_bloqueo,--ind_bloqueo
                  NULL,
                  NULL,
                  NULL,--- num_movant
                  LN_num_cel_pers,
                  NULL,
                  LV_num_seriehex,
                  NULL,
                  NULL,--num_celular_nue
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  LV_num_min,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,--PLAN
                  NULL,--CARGA
                  NULL,
                  NULL,
                  NULL,
                  NULL,--des_mensaje,
                  NULL,--cod_pin,
                  NULL,--cod_idioma,
                  NULL,--cod_enrutamiento,
                  NULL,--tip_enrutamiento,
                  NULL,--des_origen_pin,
                  NULL,--num_lote_pin,
                  NULL,--num_serie_pin,
                  LV_cod_tecnologia,--tip_tecnologia,
                  LV_imsi,--imsi,
                  NULL,--imsi_nue,
                  LV_imei,--imei,
                  NULL,--imei_nue,
                  LV_icc,--icc,
                  NULL,--icc_nue
                  EV_cod_prog,
                  SN_p_correlativo,
                  LN_filasafectas,
                  SV_msg_retorno,  SN_num_evento,  LV_cod_retorno
                  );
         IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                         RAISE fin_noICC;
         ELSE
                 SN_cod_retorno := 0;
                 SN_num_evento  := 0;
                 SV_msg_retorno := 'OK';
         END IF;

EXCEPTION
                 WHEN fin_NoNumPers THEN
                          SN_cod_retorno := 1;
                          SV_msg_retorno := 'El número personal ingresado no fue encontrado.';
                 WHEN fin_noModificaEstado THEN
                          SN_cod_retorno := 2;
                          SV_msg_retorno := SV_msg_retorno || '. Error al intentar actualizar estado (Pendiente modificación) del número personal.';
                 WHEN fin_noICC THEN
                      SN_cod_retorno := 3;
                 WHEN fin_NoPersonalDtno THEN
                          SN_cod_retorno := 4;
                 WHEN OTHERS THEN
                          SN_cod_retorno := 9;
                          SV_msg_retorno := SUBSTR(SQLERRM,1,255);
                          SN_num_evento := GE_ERRORES_PG.GRABARPL(CN_0,
                                                                                                                   EV_cod_prog,
                                                                                                                   CV_error_no_clasif,
                                                                                                                   CV_1,
                                                                                                                   USER,
                                                                                                                   NULL,--CV_PACKAGE2,
                                                                                                                   NULL,--LV_sSql,
                                                                                                                   sqlcode,
                                                                                                                   SQLERRM);

END GA_MODIFICA_NUMPERSONALCORP_PR;


FUNCTION GA_RET_DESCR_EST_FN(EN_cod_estado       IN ga_numcel_personal_to.cod_estado%TYPE)
RETURN VARCHAR2

IS
/*
<Documentación
TipoDoc = "Function">
 <Elemento
    Nombre = "GA_RET_DESCR_EST_FN"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>Descripción del estado</Retorno>
    <Descripción> Función que retorna la descripción del estado de un número personal
    <Parámetros>
                <Entrada>
                   <param nom="EN_cod_estado" Tipo="NUMBER">Código de estado</param>
                </Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/


  LV_descripcion                                                         ga_estado_cel_personal_vw.descripcion_valor%TYPE;

BEGIN

        SELECT descripcion_valor
        INTO LV_descripcion
        FROM ga_estado_cel_personal_vw
        WHERE cod_dominio = 'ESTADO_CEL_PERSONAL'
        AND valor = EN_cod_estado
        AND ind_estado = 'V';

        Return LV_descripcion;

END GA_RET_DESCR_EST_FN;

PROCEDURE GA_ACTLZA_NUMCEL_PERSONAL_PR
(
  EN_NUM_PER_ORIGEN  IN GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE,
  EN_NUM_PER_DESTINO IN GA_NUMCEL_PERSONAL_TO.NUM_CEL_CORP%TYPE,
  EV_COD_ACTABO          IN GA_ACTABO.COD_ACTABO%TYPE
  )
IS
/*
<Documentación
TipoDoc = "PROCEDURE">
 <Elemento
    Nombre = "GA_ACTLZA_NUMCEL_PERSONAL_PR"
    Lenguaje="PL/SQL"
    Fecha="25-08-2006"
    Versión="1.0"
    Diseñador="Patricio Gallegos"
    Programador="Patricio Gallegos"
    Ambiente Desarrollo="BD">
    <Retorno>NA</Retorno>
    <Descripción> Procedimiento que valida y envia comando de central para la activación de un
        número celular como personal
    <Parámetros>
       <Entrada>
                   <param nom="EN_NUM_PER_ORIGEN" Tipo="NUMBER">número celular origen que puede ser personal o corporativo</param>
                   <param nom="EN_NUM_PER_DESTINO" Tipo="NUMBER">número celular destino para operaciones de cambio de número</param>
                   <param nom="EV_COD_ACTABO" Tipo="VARCHAR">Código de actuación</param>
           </Entrada>
    </Parámetros>
 </Elemento>
</Documentación>
*/

   LN_estado_num GA_NUMCEL_PERSONAL_TO.COD_ESTADO%TYPE;
   error_proceso EXCEPTION;
   fin_sin_error EXCEPTION;

   LN_filasafectas      INTEGER;
   LV_cod_retorno       VARCHAR(1);
   SV_msg_retorno       VARCHAR2(1000);
   SN_num_evento    INTEGER;
   LV_Operacion                 ged_codigos.des_valor%TYPE;

        CV_OPER_BAJA                       CONSTANT VARCHAR2(4)  := 'BAJA';
        CV_OPER_SUSPENCION                 CONSTANT VARCHAR2(10) := 'SUSPENSION';
        CV_OPER_REHABIL                    CONSTANT VARCHAR2(15) := 'REHABILITACION';
        CV_OPER_CAMNUM                     CONSTANT VARCHAR2(12) := 'CAMBIONUMERO';

        CN_TIPO_PERSONAL                   CONSTANT NUMBER(1)  := 1;
        CN_TIPO_CORPORATIVO                CONSTANT NUMBER(1)  := 2;
        LV_ExisteAboPend                   NUMBER(15):= 0;
        LN_tipo_num                                NUMBER(1);

   BEGIN

                IF EN_NUM_PER_ORIGEN IS NULL THEN
                   RAISE fin_sin_error;
                END IF;


                SELECT  des_valor
                INTO LV_Operacion
                FROM GED_CODIGOS
                WHERE COD_MODULO = GV_cod_modulo
                AND NOM_TABLA = 'GA_NUMCEL_PERSONAL_TO'
                AND NOM_COLUMNA = 'COD_ACTABO'
                AND COD_VALOR = EV_COD_ACTABO;

                BEGIN

                        SELECT cod_estado
                        INTO LN_estado_num
                        FROM ga_numcel_personal_to
                        WHERE num_cel_pers = en_num_per_origen;

                        LN_tipo_num := CN_TIPO_PERSONAL;

                        EXCEPTION
                          WHEN NO_DATA_FOUND THEN

                           IF EV_COD_ACTABO = GV_cod_actabo THEN

                                         --     Cuando el movimiento se genera a traves de proceso masivo centrales (generamov) --
                                         -- se debe ingresar numero personal con estado activo  --
                                         GA_NUMCEL_PERSONAL_TO_I_PG.GA_AGREGAR_PR(EN_NUM_PER_ORIGEN, EN_NUM_PER_DESTINO,1, USER, SYSDATE, NULL,
                                                                                        LN_filasafectas,  SV_msg_retorno,  SN_num_evento,  LV_cod_retorno );

                                         IF LV_cod_retorno = '0' AND LN_filasafectas = 1  THEN
                                                RAISE fin_sin_error;
                                         ELSE
                                                RAISE error_proceso;
                                         END IF;

                           ELSE

                                   IF LV_Operacion = CV_OPER_SUSPENCION THEN
                                          RAISE fin_sin_error;
                                   END IF;

                                         --Para bajas y cambio de celular de una abonado atlantida --
                                         BEGIN

                                                SELECT cod_estado
                                                INTO LN_estado_num
                                                FROM ga_numcel_personal_to
                                                WHERE num_cel_corp = en_num_per_origen;

                                                LN_tipo_num := CN_TIPO_CORPORATIVO;

                                         EXCEPTION
                                                  WHEN NO_DATA_FOUND THEN
                                                           RAISE fin_sin_error;
                                         END;

                                         IF EV_COD_ACTABO = 'BP' THEN

                                                SELECT COUNT(1)
                                                INTO LV_ExisteAboPend
                                                FROM ga_Abocel
                                                WHERE num_celular = en_num_per_origen
                                                AND cod_situacion = 'AOP';

                                                IF LV_ExisteAboPend > 0 THEN
                                                           RAISE fin_sin_error;
                                                END IF;
                                        END IF;

                           END IF;
                END;


         --OPERACION NUMERO PERSONAL -- ACTIVACION
         IF LN_estado_num = CN_ESTADO_PA THEN

                GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(EN_NUM_PER_ORIGEN, NULL, NULL, CN_ESTADO_AC, NULL, NULL, NULL, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

                IF LV_cod_retorno = '0' AND LN_filasafectas = 1  THEN
                   RAISE fin_sin_error;
                ELSE
                        RAISE error_proceso;
                END IF;

        --OPERACION NUMERO PERSONAL -- MODIFICACION
         ELSIF LN_estado_num = CN_ESTADO_PM THEN

                GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(EN_NUM_PER_ORIGEN, EN_NUM_PER_DESTINO, NULL, CN_ESTADO_AC, NULL, NULL, NULL, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

                IF LV_cod_retorno = '0' AND LN_filasafectas = 1  THEN
                   RAISE fin_sin_error;
                ELSE
                        RAISE error_proceso;
                END IF;

         --OPERACION NUMERO PERSONAL --DESACTVACION
         ELSIF LN_estado_num = CN_ESTADO_PD THEN

                DELETE FROM ga_numcel_personal_to
                                WHERE num_cel_pers = en_num_per_origen;

         --CAMBIO DE NUMERO CELULAR --
         ELSIF LN_estado_num = CN_ESTADO_AC AND LV_Operacion = CV_OPER_CAMNUM THEN

                --DE NUMERO PERSONAL --
                IF LN_tipo_num = CN_TIPO_PERSONAL THEN

                        UPDATE GA_NUMCEL_PERSONAL_TO
                         SET
                          num_cel_pers = EN_NUM_PER_DESTINO ,
                          nom_usuario  = USER ,
                          fec_ultmod   = SYSDATE
                         WHERE num_cel_pers = EN_NUM_PER_ORIGEN;

                ELSE --DE NUMERO ATLANTIDA

                        UPDATE GA_NUMCEL_PERSONAL_TO
                         SET
                          num_cel_corp = EN_NUM_PER_DESTINO ,
                          nom_usuario  = USER ,
                          fec_ultmod   = SYSDATE
                         WHERE num_cel_corp = EN_NUM_PER_ORIGEN;

                 END IF;


         ELSIF LN_estado_num = CN_ESTADO_AC AND LV_Operacion = CV_OPER_BAJA THEN

                --DE NUMERO PERSONAL --
                IF LN_tipo_num = CN_TIPO_PERSONAL THEN

                   DELETE FROM GA_NUMCEL_PERSONAL_TO
                                   WHERE NUM_CEL_PERS = EN_NUM_PER_ORIGEN;

                ELSE --DE NUMERO ATLANTIDA

          DELETE FROM GA_NUMCEL_PERSONAL_TO
                  WHERE NUM_CEL_CORP = EN_NUM_PER_ORIGEN;

            END IF;

        ELSIF LN_estado_num = CN_ESTADO_AC AND LV_Operacion = CV_OPER_SUSPENCION THEN

                GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(EN_NUM_PER_ORIGEN, NULL, NULL, CN_ESTADO_SU, NULL, NULL, NULL, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

                IF LV_cod_retorno = '0' AND LN_filasafectas = 1  THEN
                   RAISE fin_sin_error;
                ELSE
                        RAISE error_proceso;
                END IF;

         ELSIF LN_estado_num = CN_ESTADO_SU AND LV_Operacion = CV_OPER_REHABIL THEN

                GA_NUMCEL_PERSONAL_TO_U_PG.GA_MODIFICAR_PR(EN_NUM_PER_ORIGEN, NULL, NULL, CN_ESTADO_AC, NULL, NULL, NULL, LN_filasafectas, SV_msg_retorno, SN_num_evento, LV_cod_retorno );

                IF NOT (LV_cod_retorno = '0' AND LN_filasafectas = 1)  THEN
                        RAISE error_proceso;
                END IF;

         END IF;

EXCEPTION
   WHEN fin_sin_error THEN
                NULL;
   WHEN NO_DATA_FOUND THEN
                NULL;
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20203, 'GA_ACTLZA_NUMCEL_PERSONAL_PR'||' '||SQLERRM);
END;


END GA_NUMCEL_PERSONAL_PG;
/
SHOW ERRORS
