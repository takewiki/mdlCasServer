#' 查询银行账户信息
#'
#' @param dms_token 口令
#' @param FCompany 公司名称
#'
#' @return 返回值
#' @include company.R
#' @export
#'
#' @examples
#' bank_getList()
bank_getList <- function(dms_token='34A4B98D-AD90-4691-BDCC-63A86C46A22F',FCompany='赛普集团') {

flag = company_isGroup(dms_token = dms_token,FCompany = FCompany)
if(flag){
  sql <- paste0("SELECT  [FCompany] as 公司名称
      ,[FCurrency] as 币别
      ,[FAccountNo] as 账号
      ,[FBank] as 开户行
      ,[FOppOpenBankName] as 支行
  FROM  [RDS_CAS_ODS_ACCOUNTLIST]

              ")
}else{
  sql <- paste0("SELECT  [FCompany] as 公司名称
      ,[FCurrency] as 币别
      ,[FAccountNo] as 账号
      ,[FBank] as 开户行
      ,[FOppOpenBankName] as 支行
  FROM  [RDS_CAS_ODS_ACCOUNTLIST]
  where FCompany = '",FCompany,"'

              ")
}

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
#' bankList_query_server()
bankList_query_server <- function(input,output,session,dms_token) {


  var_cas_company_selector1 = tsui::var_ListChoose1('cas_company_selector1')
  shiny::observeEvent(input$cas_bankList_query,{
    #处理查询
    FCompany = var_cas_company_selector1()
    data = bank_getList(dms_token = dms_token,FCompany = FCompany)
    tsui::run_dataTable2(id = 'cas_bankList_dataView',data = data)

  })

}
