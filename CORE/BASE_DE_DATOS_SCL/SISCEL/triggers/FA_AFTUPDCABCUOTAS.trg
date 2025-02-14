CREATE OR REPLACE TRIGGER fa_aftupdcabcuotas
AFTER UPDATE
OF IND_PAGADA
ON FA_CABCUOTAS
FOR EACH ROW

DECLARE
Begin
    if :new.num_abonado != 0 then
       Update Ga_EquipAboSer
       Set Ind_Propiedad = 'C'
       Where num_abonado = :new.num_abonado
       And   num_serie   = :new.num_seriele;
    end if;
  exception
    when others then
         raise_application_error(-20554,SQLERRM);
End;
/
SHOW ERRORS
