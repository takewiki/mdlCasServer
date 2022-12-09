#' 返回公司列表
#'
#' @param dms_token 口令
#'
#' @return 返回公司列表
#' @export
#'
#' @examples
#' company_getList()
company_getList <- function(dms_token='34A4B98D-AD90-4691-BDCC-63A86C46A22F') {
  sql <- paste0("
  SELECT  FCompany
      ,FCompanyCode
  FROM  RDS_CAS_ODS_CompanyList
  order by FCompanyCode")
  data = tsda::sql_select2(token = dms_token,sql)
  company = data$FCompany
  res = tsdo::vect_as_list(company)
  return(res)

}



#' 判断公司是否集团
#'
#' @param dms_token 口令
#' @param FCompany 公司名称
#'
#' @return 返回公司列表
#' @export
#'
#' @examples
#' company_isGroup()
company_isGroup <- function(dms_token='34A4B98D-AD90-4691-BDCC-63A86C46A22F',
                            FCompany='赛普集团') {
  sql <- paste0(" select FIsGroup  from RDS_CAS_ODS_CompanyList
  where FCompany ='",FCompany,"'")
  data = tsda::sql_select2(token = dms_token,sql)
  ncount =nrow(data)
  if(ncount >0){
    #返回数据
    group = data$FIsGroup
    if(group == 1){
      res =TRUE
    }else{
      res=FALSE
    }


  }else{
    #没有查到公司名称,直接设置为否
    res = FALSE
  }

  return(res)

}



