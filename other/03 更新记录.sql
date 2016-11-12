USE [ERP]

-- 2012-05-03 修改现金管理无法授权的问题
update ERP.DBO.base_module_list set name = '现金管理报表' where id = 504;

-- 2016-05-06 采购管理模块-库存表 添加是否能查看单价的权限(这个权限后期被应用于系统中所有和单价有关的权限控制)
insert into [BASE_MODULE_LIST] (ID, [name], sub_system_ID) values (105, '库存单价', 1);
insert into [BASE_ACTION_LIST] ([action_name],[ui_action_name], module_ID) values ('可查看', 'dispaly', 105);
insert into [BASE_ACTION_LIST] ([action_name],[ui_action_name], module_ID) values ('不可查看', 'dispaly', 105);

-- 2016-06-02 存货核算页面新增物料出入库核算，为其增加授权功能
INSERT INTO [ERP].[dbo].[BASE_ACTION_LIST]([ACTION_NAME],[MODULE_ID],[UI_ACTION_NAME])VALUES('出入库汇总',402,'labelMaterielInOutCount');


-- 2016-06-04 所有类型单据中的数量，允许输入小数，所以需要修改如下表的中的字段为float类型
ALTER TABLE [dbo].[PURCHASE_ORDER] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[PURCHASE_ORDER] ALTER COLUMN ACTUAL_VALUE FLOAT;
ALTER TABLE [dbo].[PURCHASE_ORDER_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[PURCHASE_IN_ORDER] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[PURCHASE_IN_ORDER_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[PURCHASE_SUPPLIER_PRICE_SHEET] ALTER COLUMN ORNM_FROM_VALUE FLOAT;
ALTER TABLE [dbo].[PURCHASE_SUPPLIER_PRICE_SHEET] ALTER COLUMN ORNM_TO_VALUE FLOAT;
ALTER TABLE [dbo].[SALE_ORDER] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[SALE_ORDER] ALTER COLUMN ACTUAL_VALUE FLOAT;
ALTER TABLE [dbo].[SALE_ORDER_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[SALE_OUT_ORDER] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[SALE_OUT_ORDER_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_IN] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_IN_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_IN_EARNINGS] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_IN_EARNINGS_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_IN_OTHER] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_IN_OTHER_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_OUT] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_OUT_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_OUT_EARNINGS] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_OUT_EARNINGS_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_OUT_OTHER] ALTER COLUMN SUM_VALUE FLOAT;
ALTER TABLE [dbo].[WAREHOUSE_MANAGEMENT_OUT_OTHER_DETAILS] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[STORAGE_STOCK_DETAIL] ALTER COLUMN VALUE FLOAT;
ALTER TABLE [dbo].[STORAGE_STOCK_DETAIL] ALTER COLUMN STORAGE_VALUE FLOAT;
ALTER TABLE [dbo].[INIT_STORAGE_STOCK] ALTER COLUMN VALUE FLOAT;


--2016-11-4 增加预占库存功能，增加预占库存表(WAREHOUSE_MANAGEMENT_PRO_OCCUPIED)
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WAREHOUSE_MANAGEMENT_PRO_OCCUPIED]') AND type in (N'U'))
DROP TABLE [dbo].[WAREHOUSE_MANAGEMENT_PRO_OCCUPIED]
CREATE TABLE [dbo].[WAREHOUSE_MANAGEMENT_PRO_OCCUPIED](
    [PKEY] [int] IDENTITY(1,1) NOT NULL,
    [TRADING_DATE] [datetime] NOT NULL,
    [BILL_NUMBER] [nvarchar](20) COLLATE Chinese_PRC_CI_AS NOT NULL,
    [EXCHANGES_UNIT] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NULL,
    [SUM_VALUE] [int] NOT NULL,
    [SUM_MONEY] [money] NOT NULL,
    [MAKE_ORDER_STAFF] [int] NOT NULL,
    [APPLY_STAFF] [int] NOT NULL,
    [ORDERR_REVIEW] [int] NULL,
    [REVIEW_DATE] [datetime] NULL,
    [IS_REVIEW] [int] NULL
) ON [PRIMARY];

--2016-11-4 增加预占库存功能，增加预占库存清单表(WAREHOUSE_MANAGEMENT_PRO_OCCUPIED_DETAILS)
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WAREHOUSE_MANAGEMENT_PRO_OCCUPIED_DETAILS]') AND type in (N'U'))
DROP TABLE [dbo].[WAREHOUSE_MANAGEMENT_PRO_OCCUPIED_DETAILS]
CREATE TABLE [dbo].[WAREHOUSE_MANAGEMENT_PRO_OCCUPIED_DETAILS](
    [PKEY] [int] IDENTITY(1,1) NOT NULL,
    [ROW_NUMBER] [int] NOT NULL,
    [MATERIEL_ID] [int] NOT NULL,
    [BILL_NUMBER] [nvarchar](20) COLLATE Chinese_PRC_CI_AS NOT NULL,
    [PRICE] [money] NOT NULL,
    [VALUE] [int] NOT NULL,
    [NOTE] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NULL,
        [IS_CANCEL] [int] NULL
) ON [PRIMARY];


