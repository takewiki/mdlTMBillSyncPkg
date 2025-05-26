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
#' stk_misDelivery_log_view()
stk_misDelivery_log_view<- function(dms_token,FBillTypeID,FDEPTID,FPickerId,FDate) {
  sql=paste0("
 select FBillTypeID as 单据类型,FDEPTID as 部门,FPickerId as 领料人,FDate  as 日期,FBillNo as 单据编号
 ,FIsDo as 同步状态,FNeedUpdate as 是否需要重传,FLogMessage as 同步信息,
FTotalCount as 单据行数, FTotalQty 单据数量
from rds_dms_ods_t_stk_misDelivery
where FBillTypeID='",FBillTypeID,"'  and FDate ='",FDate,"'   and FDEPTID ='",FDEPTID,"' and FPickerId ='",FPickerId,"'
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
#' stk_misDelivery_Fisdo_update()
stk_misDelivery_Fisdo_update<- function(dms_token,FBillTypeID,FDEPTID,FPickerId,FDate) {
  sql1=paste0("
  update a set  a.FIsDo=5,FLogMessage='单据审核成功!'  from rds_dms_ods_t_stk_misDelivery a
  where FBillTypeID='",FBillTypeID,"'  and FDate ='",FDate,"'   and FDEPTID ='",FDEPTID,"' and FPickerId ='",FPickerId,"'
             ")
  sql2=paste0("
 update a set  a.FIsDo=5  from rds_dms_ods_t_stk_misDeliveryEntry a
 where FBillTypeID='",FBillTypeID,"'  and FDate ='",FDate,"'   and FDEPTID ='",FDEPTID,"' and FPickerId ='",FPickerId,"'
             ")
  tsda::sql_update2(token  =dms_token ,sql  = sql1)
  res <- tsda::sql_update2(token  =dms_token ,sql  = sql2)

  return(res)

}
