# Power BI Dashboard

В проекте разработан интерактивный аналитический dashboard в Power BI для анализа продаж.

**Что реализовано:**

* загрузка и подготовка данных в Power Query;
* построение модели данных из таблиц `orders`, `products` и `customers`;
* настройка связей между таблицами;
* создание DAX measures для расчёта основных KPI;
* анализ динамики выручки;
* анализ продаж по категориям, регионам и клиентским сегментам;
* Top-10 товаров по выручке;
* интерактивные фильтры по дате, категории, региону и сегменту.

**Основные KPI:**

* Total Revenue — 9.11M;
* Total Orders — 12,000;
* Average Order Value — 758.88;
* анализ продаж по 30 продуктам.

### DAX

```DAX
Total Revenue =
SUMX(
    orders,
    orders[quantity] * orders[unit_price] * (1 - orders[discount])
)

Total Orders =
DISTINCTCOUNT(orders[order_id])

Units Sold =
SUM(orders[quantity])

Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Orders]
)
```

### Dashboard structure

1. KPI cards — основные показатели продаж.
2. Revenue Trend — динамика выручки во времени.
3. Revenue by Category — структура продаж по категориям.
4. Revenue by Region — сравнение регионов.
5. Revenue by Segment — анализ клиентских сегментов.
6. Top-10 Products — наиболее доходные товары.
7. Slicers — интерактивная фильтрация данных.
