#' 查询银行账户信息
#'
#' @param token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' bank_getList()
bank_getList <- function(token='34A4B98D-AD90-4691-BDCC-63A86C46A22F') {
sql <- paste0("SELECT  [FCompany] as 公司名称
      ,[FCurrency] as 币别
      ,[FAccountNo] as 账号
      ,[FBank] as 开户行
      ,[FOppOpenBankName] as 支行
  FROM  [RDS_CAS_ODS_ACCOUNTLIST]")
data = tsda::sql_select2(token = token,sql)
return(data)


}
