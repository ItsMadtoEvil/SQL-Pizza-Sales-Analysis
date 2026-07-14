/*==============================================================
                    PIZZA SALES ANALYSIS
==============================================================*/

USE Pizza_Sales;
GO


/*==============================================================
  DATA PREVIEW
==============================================================*/

SELECT TOP (1000)
      [pizza_id],
      [order_id],
      [pizza_name_id],
      [quantity],
      [order_date],
      [order_time],
      [unit_price],
      [total_price],
      [pizza_size],
      [pizza_category],
      [pizza_ingredients],
      [pizza_name]
FROM [Pizza_Sales].[dbo].[pizza_sales - pizza_sales];



/*==============================================================
  KPI 1 : TOTAL REVENUE
==============================================================*/

SELECT 
    SUM(total_price) AS total_revenue
FROM [pizza_sales - pizza_sales];



/*==============================================================
  KPI 2 : AVERAGE ORDER VALUE
==============================================================*/

SELECT
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 5) 
    AS avg_order_value
FROM [pizza_sales - pizza_sales];



/*==============================================================
  KPI 3 : TOTAL PIZZAS SOLD
==============================================================*/

SELECT
    SUM(quantity) AS total_pizzas_sold
FROM [pizza_sales - pizza_sales];



/*==============================================================
  KPI 4 : TOTAL ORDERS
==============================================================*/

SELECT
    COUNT(DISTINCT order_id) AS total_order
FROM [pizza_sales - pizza_sales];



/*==============================================================
  KPI 5 : AVERAGE PIZZAS PER ORDER
==============================================================*/

SELECT
    CAST(
        SUM(quantity) * 1.00 
        / COUNT(DISTINCT order_id) * 1.00 
        AS DECIMAL(10,2)
    ) AS avg_pizzas_per_order
FROM [pizza_sales - pizza_sales];



/*==============================================================
  DAILY TREND FOR TOTAL ORDERS
==============================================================*/

SELECT 
    DATENAME(DW, order_date) AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM [pizza_sales - pizza_sales]
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC;



/*==============================================================
  HOURLY TREND FOR TOTAL ORDERS
==============================================================*/

SELECT 
    DATEPART(HOUR, order_time) AS Order_Hour,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM [pizza_sales - pizza_sales]
GROUP BY DATEPART(HOUR, order_time)
ORDER BY Order_Hour;



/*==============================================================
  PERCENTAGE OF SALES BY PIZZA CATEGORY
==============================================================*/

SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100 / 
        (SELECT SUM(total_price) 
         FROM [pizza_sales - pizza_sales])
        AS DECIMAL(10,2)
    ) AS PCT
FROM [pizza_sales - pizza_sales]
GROUP BY pizza_category;



/*==============================================================
  PERCENTAGE OF SALES BY PIZZA SIZE
==============================================================*/

SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100 / 
        (SELECT SUM(total_price) 
         FROM [pizza_sales - pizza_sales])
        AS DECIMAL(10,2)
    ) AS PCT
FROM [pizza_sales - pizza_sales]
GROUP BY pizza_size
ORDER BY PCT DESC;



/*==============================================================
  5.	Total Pizzas Sold by Pizza Category
==============================================================*/

SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM [pizza_sales - pizza_sales]
GROUP BY pizza_category;



/*==============================================================
  TOP 5 BEST SELLERS BY TOTAL PIZZAS SOLD
==============================================================*/

SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM [pizza_sales - pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;



/*==============================================================
  BOTTOM 5 WORST SELLERS BY TOTAL PIZZAS SOLD
==============================================================*/

SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM [pizza_sales - pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;