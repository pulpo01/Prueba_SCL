CREATE OR REPLACE PACKAGE body AL_DOCUMENTOS_PG as

   FUNCTION AL_PREF_OFICINA_FN (EV_cod_oficina IN ge_oficinas.cod_oficina%TYPE,EV_error OUT NOCOPY VARCHAR)
      RETURN ge_oficinas.cod_prefijo%TYPE
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " AL_PREF_OFICINA_FN" Lenguaje="PL/SQL" Fecha="25-04-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna el Prefijo de Oficina</Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EV_cod_oficina" Tipo="VARCHAR2">Código Oficina</param>
-- </Entrada>
-- <Salida>
-- <param nom="AL_PREOFI_FN" Tipo="VARCHAR2">Prefijo Oficina</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      LV_pref_oficina   ge_oficinas.cod_prefijo%TYPE;
      LV_mensaje        VARCHAR2 (200);
   BEGIN
      BEGIN
         SELECT cod_prefijo
           INTO LV_pref_oficina
           FROM ge_oficinas
          WHERE cod_oficina = EV_cod_oficina;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            EV_error:= '-20191';
      END;


      RETURN LV_pref_oficina;


   EXCEPTION
      WHEN OTHERS THEN
            EV_error:= '-20192';

   END AL_PREF_OFICINA_FN;

   FUNCTION AL_ABREV_TIPDOC_FN (
      EN_cod_tipdocum   IN   ge_tipdocumen.cod_tipdocum%TYPE,EV_error OUT NOCOPY VARCHAR
   )
      RETURN ge_tipdocumen.des_abreviada%TYPE
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " AL_ABREV_TIPDOC_FN" Lenguaje="PL/SQL" Fecha="25-04-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna el Prefijo del Tipo de Documento </Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EN_cod_tipdocum" Tipo="NUMBER">Código Tipo Documento</param>
-- </Entrada>
-- <Salida>
-- <param nom="AL_PRETIPDOC_FN" Tipo="VARCHAR2">Prefijo Tipo Documento</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      LV_pref_tipodoc   ge_tipdocumen.des_abreviada%TYPE;
      LV_mensaje        VARCHAR2 (200);
      LV_error          VARCHAR2(10);
      ERROR_ABREV_TIPDOC      EXCEPTION;
   BEGIN
      BEGIN
         SELECT des_abreviada
         INTO LV_pref_tipodoc
         FROM ge_tipdocumen
         WHERE cod_tipdocum = EN_cod_tipdocum;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            LV_error:= '-20193';
            RAISE ERROR_ABREV_TIPDOC;
      END;


      IF LV_pref_tipodoc IS NULL
      THEN
         LV_error:= '-20194';
         RAISE ERROR_ABREV_TIPDOC;
      ELSE
         RETURN LV_pref_tipodoc;
      END IF;

   EXCEPTION
      WHEN ERROR_ABREV_TIPDOC
      THEN
         EV_error:= LV_error;
         RETURN LV_pref_tipodoc;
      WHEN OTHERS
      THEN
         EV_error:= '-20195';
   END AL_ABREV_TIPDOC_FN;


   FUNCTION AL_PREF_MATRIZ_FN (EV_cod_oficina IN ge_oficinas.cod_oficina%TYPE,EV_error OUT NOCOPY VARCHAR)
      RETURN ge_oficinas.cod_prefijo%TYPE
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " AL_PREF_MATRIZ_FN" Lenguaje="PL/SQL" Fecha="25-04-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna el Prefijo de Oficina</Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EV_cod_oficina" Tipo="VARCHAR2">Código Oficina</param>
-- </Entrada>
-- <Salida>
-- <param nom="AL_PREOFI_FN" Tipo="VARCHAR2">Prefijo Oficina</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************

      LV_pref_oficina   ge_oficinas.cod_prefijo%TYPE;
      LV_mensaje        VARCHAR2 (200);
   BEGIN

      BEGIN
         SELECT cod_prefijo_matriz
           INTO LV_pref_oficina
           FROM ve_ofimatriz_td a, ge_oficinas b
          WHERE a.cod_oficina = EV_cod_oficina
            AND a.cod_matriz  = b.cod_oficina
            AND b.ind_oficina=CN_uno;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            EV_error:= '-20196';
      END;


      RETURN LV_pref_oficina;

   EXCEPTION

      WHEN OTHERS
      THEN
           EV_error:= '-20197';
   END AL_PREF_MATRIZ_FN;


 FUNCTION AL_NEW_PREFIJO_FN (EN_num_solfolios  IN   number ,EV_param IN VARCHAR2,EV_error OUT NOCOPY VARCHAR)
      RETURN al_Asig_documentos.pref_plaza%TYPE
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " AL_NEW_PREFIJO_FN" Lenguaje="PL/SQL" Fecha="28-05-2009" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna el Prefijo de plaza según la operadora y nueva forma de foliacion</Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EN_num_solfolios" Tipo="NUMBER">Número de solicitud de folios</param>
-- </Entrada>
-- <Salida>
-- <param nom="AL_NEW_PREFIJO_FN" Tipo="VARCHAR2">Prefijo  de plaza</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      LV_pref_plaza  al_Asig_documentos.pref_plaza%TYPE;
      LV_serie       al_Asig_documentos.serie%TYPE;
      LV_etiqueta    al_Asig_documentos.etiqueta%TYPE;
      LN_tipdoc      al_Asig_documentos.cod_tipdocum%TYPE;      
      LV_mensaje     VARCHAR2 (200);
   BEGIN
   
   LV_pref_plaza:=NULL;
   LV_serie:=NULL;
   LN_tipdoc:=NULL;
    
    case EV_param
    when CV_par5 then
          Select TRIM(a.cod_tipdocum||'-'||a.serie), a.serie,a.cod_tipdocum 
            into LV_pref_plaza, LV_serie,LN_tipdoc 
            from AL_SOLFOLIOS_TO a where a.num_solfolios=EN_num_solfolios;
    when CV_par6 then
         Select TRIM(a.cod_tipdocum ||'-'||a.serie||'-'||a.etiqueta), a.serie,a.cod_tipdocum  
           into LV_pref_plaza, LV_serie,LN_tipdoc 
           from AL_SOLFOLIOS_TO a where a.num_solfolios=EN_num_solfolios;
    end case;
    if LV_serie  is null  then
      LV_pref_plaza:=LN_tipdoc;
    end if;
    RETURN LV_pref_plaza;

   EXCEPTION
      WHEN OTHERS THEN
            EV_error:= '-20200';
END AL_NEW_PREFIJO_FN;


   FUNCTION AL_PREF_DOCUMOFIC_FN (
      EV_cod_oficina    IN   ge_oficinas.cod_oficina%TYPE,
      EN_cod_tipdocum   IN   ge_tipdocumen.cod_tipdocum%TYPE,
      EN_num_solfolios  IN   number default 0 ) --p-mix-09003
      RETURN VARCHAR2
   IS
-- *********************************************************************************************************************
-- <Documentación TipoDoc = "Funcion">
-- <Elemento Nombre = " AL_PREF_DOCUMOFIC_FN" Lenguaje="PL/SQL" Fecha="25-04-2005" Versión="1.0" Diseñador="****" Programador="******" Ambiente="BD">
-- <Retorno>String</Retorno>
-- <Descripción>Función que retorna el Prefijo de Documentos </Descripción>
-- <Parámetros>
-- <Entrada>
-- <param nom="EV_cod_oficina" Tipo="VARCHAR2">Código Oficina</param>
-- <param nom="EN_cod_tipdocum" Tipo="NUMBER>Tipo Documento</param>
-- </Entrada>
-- <Salida>
-- <param nom="AL_PREF_DOCUMOFIC_FN" Tipo="VARCHAR2">Prefijo Documento</param>
-- </Salida>
-- </Parámetros>
-- </Elemento>
-- </Documentación>
-- **********************************************************************************************************************
      LV_par_prefijo   ged_parametros.val_parametro%TYPE;
      LV_prefijo       VARCHAR2 (50);
      LV_mensaje       VARCHAR2 (200);
      CV_oficina       ge_oficinas.cod_prefijo%TYPE;     -- Prefijo Oficina
      CV_matriz        ge_oficinas.cod_prefijo%TYPE;     -- Prefijo Matriz
      CV_tipodoc       ge_tipdocumen.des_abreviada%TYPE; -- Tipo documento Abreviado
      EV_error           VARCHAR2(10):=null;
      LV_new_folio      al_asig_documentos.pref_plaza%TYPE; --P-MIX-09003...
      ERROR_PREFIJO    EXCEPTION;

   BEGIN

--  Parametro de Nomenclatura del prefijo documento
      BEGIN
         SELECT val_parametro
           INTO LV_par_prefijo
           FROM ged_parametros
          WHERE nom_parametro = CV_nom_param;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            EV_error:= '-20198';
            RAISE ERROR_PREFIJO;
      END;

      case LV_par_prefijo
      when CV_par1 then
         CV_tipodoc := AL_ABREV_TIPDOC_FN (EN_cod_tipdocum,EV_error);
         IF EV_error IS NOT NULL
         THEN
            RAISE ERROR_PREFIJO;
         END IF;
         CV_oficina := AL_PREF_OFICINA_FN(EV_cod_oficina,EV_error);
         IF EV_error IS NOT NULL
         THEN
            RAISE ERROR_PREFIJO;
         END IF;
         LV_prefijo := CV_tipodoc || CV_oficina;
 
     when CV_par2 then
            CV_tipodoc := AL_ABREV_TIPDOC_FN (EN_cod_tipdocum,EV_error);
            IF EV_error IS NOT NULL
            THEN
               RAISE ERROR_PREFIJO;
            END IF;
            LV_prefijo := CV_tipodoc;

     when CV_par3 then
           CV_oficina := AL_PREF_OFICINA_FN (EV_cod_oficina,EV_error);
           IF EV_error IS NOT NULL
           THEN
              RAISE ERROR_PREFIJO;
           END IF;
           CV_matriz  := AL_PREF_MATRIZ_FN (EV_cod_oficina,EV_error);
           IF EV_error IS NOT NULL
           THEN
              RAISE ERROR_PREFIJO;
           END IF;
           LV_prefijo := CV_matriz || CV_oficina;

     when CV_par4 then
          CV_oficina := AL_PREF_OFICINA_FN (EV_cod_oficina,EV_error);
          IF EV_error IS NOT NULL
          THEN
             RAISE ERROR_PREFIJO;
          END IF;
          LV_prefijo := CV_oficina;

    --Inicio P-MIX-09003---
    when CV_par5 then
          LV_new_folio:=null;
          if EN_num_solfolios =0 then
             EV_error:='-20199';
             RAISE ERROR_PREFIJO;
          end if;        
          LV_new_folio:= AL_NEW_PREFIJO_FN(EN_num_solfolios,CV_par5,EV_error);  
          IF EV_error IS NOT NULL
          THEN
             RAISE ERROR_PREFIJO;
          END IF;
          LV_prefijo:=LV_new_folio;
 
     when CV_par6 then     
          LV_new_folio:=null;
          if EN_num_solfolios =0 then
             EV_error:='-20199';
             RAISE ERROR_PREFIJO;
          end if;        
          LV_new_folio:= AL_NEW_PREFIJO_FN(EN_num_solfolios,CV_par6,EV_error);  
          IF EV_error IS NOT NULL
          THEN
             RAISE ERROR_PREFIJO;
          END IF;
          LV_prefijo:=LV_new_folio; 
    --Fin P-MIX-09003---
     end case;
     RETURN LV_prefijo;



   EXCEPTION
      WHEN ERROR_PREFIJO
      THEN
         case EV_error 
         when '-20191' then
            LV_mensaje := 'NO EXISTE CODIGO OFICINA';
         when '-20192' then
            LV_mensaje := 'ERROR AL EJECUTAR FUNCION AL_PREF_OFICINA_FN';
         when  '-20193' then
            LV_mensaje := 'NO EXISTE TIPO DOCUMENTO';
         when '-20194' then
            LV_mensaje := 'ERROR PREFIJO DOCUMENTO NO VALIDO';
         when '-20195' then
            LV_mensaje := 'ERROR AL EJECUTAR FUNCION AL_ABREV_TIPDOC_FN';
         when '-20196' then
            LV_mensaje := 'NO EXISTE CODIGO MATRIZ';
         when '-20197' then
            LV_mensaje := 'ERROR AL EJECUTAR FUNCION AL_PREF_MATRIZ_FN';
         when '-20198' then
            LV_mensaje := 'NO EXISTE PARAMETRO PREFIJO DOCUMENTO';
         when '-20199' then
            LV_mensaje := 'DEBE INDICARSE EL NUMERO DE LA SOLICITUD DE FOLIOS ASOCIADO';
         when '-20200' then
            LV_mensaje := 'ERROR AL EJECUTAR FUNCION AL_NEW_PREFIJO_FN';

         end case;


         RAISE_APPLICATION_ERROR (EV_error, LV_mensaje);
      WHEN OTHERS
      THEN
         RAISE_APPLICATION_ERROR (-20199,
                                      'ERROR '
                                   || TO_CHAR (SQLCODE)
                                   || ': '
                                   || SQLERRM
                                 );
   END AL_PREF_DOCUMOFIC_FN;
END AL_DOCUMENTOS_PG; 
/
SHOW ERRORS
