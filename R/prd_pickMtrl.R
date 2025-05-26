#' 日志查询
#'
#' @param dms_token
#' @param FStartDate
#' @param FEndDate
#'
#' @return
#' @export
#'
#' @examples
#' prd_pickMtrl_log_view()
prd_pickMtrl_log_view<- function(dms_token,FSrcBillNo,FDate) {
  sql=paste0("
 select FSrcBillNo as 源单编号,fdate  as 日期,FBillNo as 单据编号,FIsDo as 同步状态,FNeedUpdate as 是否需要重传,FLogMessage as 同步信息,
FTotalCount as 单据行数, FTotalQty 单据数量
from rds_dms_ods_t_prd_pickMtrl  where FSrcBillNo='",FSrcBillNo,"'  and FDate ='",FDate,"'
             ")
  res <- tsda::sql_select2(token  =dms_token ,sql  = sql)

  return(res)

}


#' 更新同步状态
#'
#' @param erp_token
#' @param FStartDate
#' @param FEndDate
#'
#' @return
#' @export
#'
#' @examples
#' prd_pickMtrl_Fisdo_update()
prd_pickMtrl_Fisdo_update<- function(dms_token,FSrcBillNo,FDate) {
  sql1=paste0("
  update a set  a.FIsDo=5,FLogMessage='单据审核成功!'  from rds_dms_ods_t_prd_pickMtrl a where  FSrcBillNo='",FSrcBillNo,"'  and FDate ='",FDate,"'
             ")
  sql2=paste0("
 update a set  a.FIsDo=5  from rds_dms_ods_t_prd_pickMtrlEntry a where  FSrcBillNo='",FSrcBillNo,"'  and FDate ='",FDate,"'
             ")
  tsda::sql_update2(token  =dms_token ,sql  = sql1)
  res <- tsda::sql_update2(token  =dms_token ,sql  = sql2)

  return(res)

}
