create or replace package CUX_COMM_GET is

function get_set_id(P_leadger_id in varchar2,P_segment_name in varchar2)return varchar2;
end CUX_COMM_GET;
/
create or replace package body CUX_COMM_GET is

function get_set_id(P_leadger_id in varchar2,P_segment_name in varchar2)return varchar2
   is 
  l_return varchar2(200);
  begin
  if P_segment_name is null or P_segment_name='' then 
  return '';
 end if;  
  l_return:='';
 SELECT Tv.Flex_Value_Set_Id
   into l_return
   From Fnd_Id_Flex_Segments_Vl Tv, gl_ledgers gl
  Where 1 = 1
    And Tv.Id_Flex_Num = gl.CHART_OF_ACCOUNTS_ID
    And Tv.Id_Flex_Code = 'GLLE'
    And gl.LEDGER_ID = P_leadger_id
    AND tv.SEGMENT_NAME = P_segment_name
    And Tv.Application_Column_Name <> 'LEDGER_SEGMENT' Fetch First 1 Rows Only; 
   return l_return;
end ;
end CUX_COMM_GET;
/
