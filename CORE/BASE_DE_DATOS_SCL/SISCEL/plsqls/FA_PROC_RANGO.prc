CREATE OR REPLACE PROCEDURE        fa_proc_rango(
  v_cod_ciclfact IN varchar2 )
IS
  v_ciclfact       Fa_Rango_Tabla.Cod_CiclFact%TYPE;
  v_productoact    Fa_Rango_Tabla.Cod_Producto%TYPE;
  v_rango_iniact   Fa_Rango_Tabla.Rango_Ini%TYPE;
  v_rango_finact   Fa_Rango_Tabla.Rango_Fin%TYPE;
  v_rango_iniant   Fa_Rango_Tabla.Rango_Ini%TYPE :=0;
  v_rango_finant   Fa_Rango_Tabla.Rango_Fin%TYPE :=0;
  v_productoant    Fa_Rango_Tabla.Cod_Producto%TYPE :=0;
  v_reg_datosgener Ge_DatosGener%ROWTYPE;
  v_contador       number(6) := 0;
  v_flag_celu      number(1) := 0;
  v_flag_beep      number(1) := 0;
  v_flag_trek      number(1) := 0;
  v_flag_trun      number(1) := 0;
  v_flag_gene      number(1) := 0;
  Cursor Cur_Rango is
         Select rango_ini,rango_fin,cod_producto
         From Fa_Rango_Tabla
         Where cod_ciclfact = v_ciclfact
         Order By cod_ciclfact,cod_producto,rango_ini;
  Begin
    fa_pack_pasoh_get.p_getgedatosgener (v_reg_datosgener);
    v_ciclfact  := to_number(v_cod_ciclfact);
    dbms_output.put_line('Ciclo ='||to_char(v_ciclfact));
    Select count(*) Into v_contador
    From Fa_Rango_Tabla
    Where cod_ciclfact = v_ciclfact;
    dbms_output.put_line('Contador ='||to_char(v_contador));
    if v_contador > 0 then
       Open Cur_Rango;
       Fetch Cur_Rango
       Into v_rango_iniact,v_rango_finact,v_productoact;
       if v_productoact = v_reg_datosgener.prod_celular then
          v_flag_celu := 1;
       elsif v_productoact = v_reg_datosgener.prod_beeper then
             v_flag_beep := 1;
       elsif v_productoact = v_reg_datosgener.prod_trunk then
             v_flag_trun := 1;
       elsif v_productoact = v_reg_datosgener.prod_trek then
             v_flag_trek := 1;
       elsif v_productoact = v_reg_datosgener.prod_general then
             v_flag_gene := 1;
       end if;
       For i in 1..v_contador Loop
           dbms_output.put_line('Cabecera del For');
           if i = 1 then
              dbms_output.put_line('Registro if i ='||to_char(i));
              dbms_output.put_line('RangoIniAct ='||to_char(v_rango_iniact));
              dbms_output.put_line('RangoFinAct ='||to_char(v_rango_finact));
              dbms_output.put_line('ProductoAct ='||to_char(v_productoact));
              v_rango_iniant := v_rango_iniact;
              v_rango_finant := v_rango_finact;
              v_productoant  := v_productoact;
           elsif v_productoact = v_productoant then
                 dbms_output.put_line('Productos iguales ELSIF');
                 dbms_output.put_line('ProductoAct =
'||to_char(v_productoact));
                 dbms_output.put_line('ProductoAnt =
'||to_char(v_productoant));
                 dbms_output.put_line('RangoFinAnt =
'||to_char(v_rango_finant));
              dbms_output.put_line('RangoIniAct-1=
'||to_char(v_rango_iniact-1));
                 if v_rango_finant = v_rango_iniact - 1 then
                 dbms_output.put_line('Antes de cambiar,finant = iniact');
                 dbms_output.put_line('RangoIniAct =
'||to_char(v_rango_iniact));
                 dbms_output.put_line('RangoFinAnt =
'||to_char(v_rango_finant));
                 dbms_output.put_line('RangoIniAct =
'||to_char(v_rango_iniact));
                 dbms_output.put_line('RangoFinAct =
'||to_char(v_rango_finact));
                    v_rango_iniant := v_rango_iniact;
                    v_rango_finant := v_rango_finact;
                    v_productoant  := v_productoact;
                 dbms_output.put_line('RangoIniAnt =
'||to_char(v_rango_iniant));
                 dbms_output.put_line('RangoFinAnt =
'||to_char(v_rango_finant));
                 else
                    dbms_output.put_line('Antes de raise finant != iniact');
                    raise_application_error(-20550,
                          'Existe hueco en producto =
'||to_char(v_productoact)
                           ||',Periodo de Facturacion ='||
                           to_char(v_ciclfact)||' y registro ='||to_char(i));
                 end if;
           elsif v_rango_iniact != 1 then
                 dbms_output.put_line('RangoINIACT = '||v_rango_iniact);
                 raise_application_error(-20550,
'Rango Inicial debe comenzar por 1, verifique en rango para el producto =
'||v_productoact);
           else
              dbms_output.put_line('Registro ult. else ='||to_char(i));
              v_rango_iniant := v_rango_iniact;
              v_rango_finant := v_rango_finact;
              v_productoant  := v_productoact;
           end if;
           Fetch Cur_Rango
           Into v_rango_iniact,v_rango_finact,v_productoact;
           Exit When Cur_Rango%NOTFOUND;
           dbms_output.put_line('Fin del For');
           if v_productoact = v_reg_datosgener.prod_celular then
              v_flag_celu := 1;
           elsif v_productoact = v_reg_datosgener.prod_beeper then
                 v_flag_beep := 1;
           elsif v_productoact = v_reg_datosgener.prod_trunk then
                 v_flag_trun := 1;
           elsif v_productoact = v_reg_datosgener.prod_trek then
                 v_flag_trek := 1;
           elsif v_productoact = v_reg_datosgener.prod_general then
                 v_flag_gene := 1;
           end if;
       End Loop;
       Close Cur_Rango;
    end if;
    dbms_output.put_line('Flag_Celu ='||to_char(v_flag_celu));
    dbms_output.put_line('Flag_Beep ='||to_char(v_flag_beep));
    dbms_output.put_line('Flag_Trun ='||to_char(v_flag_trun));
    dbms_output.put_line('Flag_Trek ='||to_char(v_flag_trek));
    dbms_output.put_line('Flag_Gene ='||to_char(v_flag_gene));
    if v_flag_celu = 0 then
       raise_application_error(-20550,'Falta tabla de conceptos para Celular
');
    elsif v_flag_beep = 0 then
          raise_application_error(-20550,
                                  'Falta tabla de conceptos para Beeper');
    elsif v_flag_trun = 0 then
          raise_application_error(-20550,
                                  'Falta tabla de conceptos para Trunking');
    elsif v_flag_trek = 0 then
          raise_application_error(-20550,'Falta tabla de conceptos para Trek
');
    elsif v_flag_gene = 0 then
          raise_application_error(-20550,
                                  'Falta tabla de conceptos para Generales');
    end if;
  exception
    when others then
         raise_application_error(-20550,SQLERRM);
  End fa_proc_rango;
/
SHOW ERRORS
