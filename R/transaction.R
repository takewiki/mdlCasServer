#' 返回交易明细信息
#'
#' @param dms_token 口令
#' @param FDate 日期
#' @param FAccountNO 银行账号
#'
#' @return 返回公司列表
#' @export
#'
#' @examples
#' transaction_query()
transaction_query <- function(dms_token='34A4B98D-AD90-4691-BDCC-63A86C46A22F',FDate='2022-12-01',FAccountNO ='467677162516') {
  sql <- paste0("SELECT
      [FRecordDate]  as 交易日期,

      [FAccountName] as 公司
	      ,[FBankName] as 银行
	    ,[FAccountNO] as 账号,
		   b.FName as 交易类型,
	 [FTradeTime]   as 交易时间,
      [FAmount]  as 交易金额,
	   [FAmount]* b.FValue as 收支金额
	   ,[FOppAccountName] as 对方名称

      ,[FOppOpenBankName] as 对方银行
	      ,[FOppAccountNO] as 对方账号
      ,[FSerialNO]   as 单据编号
      ,[FDigest]   as 摘要
	   ,[FPurpose]  as 备注
  FROM  [RDS_CAS_ODS_Transaction] a
  inner join RDS_CAS_ODS_tradeType b
  on a.FTradeType = b.FTradeType
  where a.FRecordDate ='",FDate,"'
  and a.FAccountNO ='",FAccountNO,"'
  order by a.FTradeTime")
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
#' transaction_query_server()
transaction_query_server <- function(input,output,session,dms_token) {



  var_cas_transaction_account <- tsui::var_text('cas_transaction_account')
  var_cas_transaction_date = tsui::var_date('cas_transaction_date')
  shiny::observeEvent(input$cas_transaction_query,{
    #处理查询
    FAccountNO = var_cas_transaction_account()
    FDate = var_cas_transaction_date()
    data = transaction_query(dms_token = dms_token,FDate = FDate,FAccountNO =FAccountNO )
    tsui::run_dataTable2(id = 'cas_transaction_dataShow',data = data)
    #处理下载事项
    file_name = paste0('银行交易明细_',FDate,'.xlsx')
    tsui::run_download_xlsx(id = 'cas_transaction_dl',data = data ,filename = file_name)

  })

}

