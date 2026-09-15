# Power BI Dashboard — Sales Analytics

## Рекомендуемая структура страницы

### KPI cards
- Revenue
- Orders
- Units Sold
- Average Order Value

### Графики
1. Revenue by month — line chart
2. Revenue by category — bar chart
3. Revenue by region — bar/map chart
4. Revenue share by category — donut chart
5. Top 10 products by revenue — horizontal bar chart

### Фильтры
- Date
- Region
- Customer segment
- Category

## Меры DAX

```DAX
Revenue = SUM(orders[revenue])

Orders = DISTINCTCOUNT(orders[order_id])

Units Sold = SUM(orders[quantity])

Average Order Value = DIVIDE([Revenue], [Orders])

Revenue MoM % =
VAR CurrentRevenue = [Revenue]
VAR PreviousRevenue =
    CALCULATE([Revenue], DATEADD('Calendar'[Date], -1, MONTH))
RETURN
    DIVIDE(CurrentRevenue - PreviousRevenue, PreviousRevenue)
```

Создай отдельную таблицу календаря `Calendar`, свяжи `Calendar[Date]` с `orders[order_date]` и используй её для временной аналитики.
