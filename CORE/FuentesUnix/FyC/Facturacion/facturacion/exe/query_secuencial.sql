
      set pages 0;
      set serverout on;
      set verify off;
      set lines 20;
      set head off
      set feedback off;
      SELECT ltrim(rtrim(FA_SEQ_CTLINFORMES.NEXTVAL)) FROM DUAL;
      exit;
      
