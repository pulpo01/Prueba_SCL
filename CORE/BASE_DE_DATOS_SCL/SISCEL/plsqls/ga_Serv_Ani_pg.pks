CREATE OR REPLACE PACKAGE ga_Serv_Ani_pg
/*
<Documentaci�n
   TipoDoc = "Package">
   <Elemento
       Nombre = "ga_Serv_Ani_pg"
       Lenguaje="PL/SQL"
       Fecha="28-12-2006"
       Versi�n="1.0"
       Dise�ador="German Espinoza"
       Programador="Esteban Fuenzalida"
       Ambiente Desarrollo="BD">
       <Retorno>NA</Retorno>
       <Descripci�n>Package Desactivacion de SS anidados o dependientes</Descripci�n>
       <Par�metros>
          <Entrada>NA</Entrada>
          <Salida>NA</Salida>
       </Par�metros>
    </Elemento>
   </Documentaci�n>
*/
IS
   --Constantes Globales
   cv_error_no_clasif   CONSTANT VARCHAR2 (60) := 'Error no clasificado';
   cv_cod_modulo        CONSTANT VARCHAR2 (2)  := 'GA';
   cn_cod_producto      CONSTANT NUMBER        := 1;
   cv_version           CONSTANT VARCHAR2 (5)  := '1.0';

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE Ga_Des_Serv_Ani_pr (
      en_num_abonado    IN              ga_abocel.num_abonado%TYPE,
      ev_Servicio       IN              VARCHAR2
   );

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
END ga_Serv_Ani_pg;
/
SHOW ERRORS
