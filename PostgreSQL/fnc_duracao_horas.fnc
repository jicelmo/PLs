/*
SELECT SYSDATE DATA_ATUAL, 
ADD_MONTHS(SYSDATE,-1) MENOS_UM_MES, 
ADD_MONTHS(SYSDATE,1) MAIS_UM_MES, 
LAST_DAY(SYSDATE) ULTIMO_DIA_MES, 
TRUNC(SYSDATE,'MONTH') PRIMEIRO_DIA_MES, 
MONTHS_BETWEEN(SYSDATE,'01-JAN-2001') QTD_MES, 
FLOOR(MONTHS_BETWEEN(SYSDATE,'01-JAN-2001')) ARREDONDA_ABAIXO, 
CEIL(MONTHS_BETWEEN(SYSDATE,'01-JAN-2001')) ARREDONDA_ACIMA, 
ABS(MONTHS_BETWEEN(SYSDATE,'01-JAN-2001')) VALOR_ABSOLUTO, 
ROUND((MONTHS_BETWEEN(SYSDATE,'01-JAN-2001')),2) ARREDONDA, 
TRUNC(SYSDATE,'year') PRIMEIRO_DIA_ANO, 
to_char(SYSDATE,'dd " DE " FMMONTH " DE " YYYY','nls_date_language=portuguese') DIAMES_EXTENSO, 
to_char(SYSDATE,'FMMONTH " DE " YYYY','nls_date_language=portuguese') MES_EXTENSO, 
TO_CHAR(SYSDATE,'HH24:MI') HORA_MINUTO, 
to_char(sysdate,'FMMonth','nls_date_language=portuguese') mes_corrente, 
to_date(lpad(to_char(1234),4,'0'),'hh24mi') dias_data, 
Floor(floor(months_between(SYSDATE,SYSDATE)) / 12) IDADE, 
decode(TO_NUMBER(TO_CHAR(SYSDATE,'D')),2,'segunda-feira',3,'ter�a-feira',4,'quarta-feira', 
5,'quinta-feira',6,'sexta-feira',7,'sabado',1,'domingo') dia_da_semana 
FROM DUAL
*/

create or replace function midiaclip.fnc_duracao_horas
(
  p_data_inicio  date,
  p_data_fim     date
) return varchar2 as

v_resultado varchar2(8);

begin
   select trim(to_char(horas,'00')) ||':'|| trim(to_char(minutos,'00')) ||':'||  trim(to_char(segundos,'00'))
     into v_resultado
     from ( SELECT floor((p_data_fim+p_data_inicio)*24) horas,
                   mod(floor((p_data_fim+p_data_inicio)*24*60),60) minutos,
                   mod(floor((p_data_fim+p_data_inicio)*24*60*60),60) segundos
              FROM dual);

  return v_resultado;
exception
     when no_data_found then return '00:00:00';
     when others        then return '00:00:00';
end fnc_duracao_horas;
/
