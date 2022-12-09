#' 返回公司列表
#'
#' @param dms_token 口令
#' @param FDate 日期
#'
#' @return 返回公司列表
#' @export
#'
#' @examples
#' company_getList()
dailyRpt_query <- function(dms_token='34A4B98D-AD90-4691-BDCC-63A86C46A22F',FDate='2022-12-01') {
  sql <- paste0("
  select b.FCompany as 公司, FAccount as 账户,FDate as 日期,FBegBal as 昨天余额,FReceive as 当天期收入,FSend as 当天支出,FEndBal as 当天余额

from RDS_CAS_vw_dailyRpt a
left join RDS_CAS_ODS_ACCOUNTLIST b
on a.FAccount = b.FAccountNo
left join RDS_CAS_ODS_CompanyList c
on b.FCompany = c.FCompany

where FDate ='",FDate,"'
order by c.FCompanyCode")
  data = tsda::sql_select2(token = dms_token,sql)

  return(data)

}








#' 账户查询函数
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' dailyRpt_query_server()
dailyRpt_query_server <- function(input,output,session,dms_token) {


  var_cas_dailyRpt_date = tsui::var_date('cas_dailyRpt_date')
  shiny::observeEvent(input$cas_dailyRpt_query,{
    #处理查询
    FDate = var_cas_dailyRpt_date()
    data = dailyRpt_query(dms_token = dms_token,FDate = FDate)
    tsui::run_dataTable2(id = 'cas_dailyRpt_dataView',data = data)
    #下载数据
    file_name = paste0('资金平台日记账_',FDate,'.xlsx')
    tsui::run_download_xlsx(id = 'cas_dailyRpt_dl',data = data,filename = file_name)

  })

}
