# Sales Dashboard

SQL-аналитика продаж и подготовка данных для интерактивного BI-дашборда.

> **Данные синтетические.** Проект создан для демонстрации навыков SQL, PostgreSQL, расчёта KPI и подготовки аналитического слоя для Power BI.

## Цель

Проанализировать продажи по времени, категориям, регионам и сегментам клиентов, подготовить набор SQL-запросов для аналитики и сформировать основу для Power BI dashboard.

## Стек

- PostgreSQL
- SQL
- Power BI
- DAX
- Python / pandas — для проверки и анализа данных

## Dataset

В проекте используются:

- **12 000 заказов**;
- **4 000 клиентов**;
- **30 товаров**;
- период **2024–2025**.

### Таблицы

```text
customers
    │
    └── customer_id
            │
            ▼
         orders
            │
            └── product_id
                    │
                    ▼
                 products
```

### Основные поля orders

- `order_id`
- `order_date`
- `customer_id`
- `product_id`
- `quantity`
- `discount_pct`
- `unit_price`
- `revenue`
- `region`
- `customer_segment`

## SQL workflow

```text
Raw CSV
   ↓
PostgreSQL
   ↓
Data model
   ↓
SQL transformations
   ↓
Analytical dataset
   ↓
Power BI
   ↓
Dashboard
```

## SQL

В папке `sql/`:

- `schema.sql` — создание таблиц;
- `analysis.sql` — аналитические запросы;
- `powerbi_dataset.sql` — подготовка датасета для Power BI.

Используемые конструкции:

- `JOIN`;
- `GROUP BY`;
- `CASE WHEN`;
- агрегатные функции;
- CTE;
- оконные функции;
- расчёт KPI;
- временные агрегации.

## Основные KPI

| KPI | Значение |
|---|---:|
| Orders | 12 000 |
| Revenue | 9 106 553.55 |
| Average Order Value | 758.88 |
| Units Sold | 30 024 |
| Products | 30 |
| Customers | 4 000 |

Значения рассчитаны на синтетических данных проекта.

## Визуальный анализ

### Динамика выручки

![Monthly revenue](reports/figures/01_monthly_revenue.png)

График показывает изменение выручки по месяцам и позволяет искать сезонность и периоды роста/снижения продаж.

### Выручка по категориям

![Revenue by category](reports/figures/02_revenue_by_category.png)

Лидер по выручке — категория **Beauty**, её доля составляет **23.48%** общей выручки.

### Выручка по регионам

![Revenue by region](reports/figures/03_revenue_by_region.png)

### Выручка по сегментам

![Revenue by segment](reports/figures/04_revenue_by_segment.png)

### Top-10 товаров

![Top products](reports/figures/05_top_products.png)

### Discount vs order revenue

![Discount vs revenue](reports/figures/06_discount_vs_revenue.png)

## Power BI

`.pbix` файл в репозитории не включён: проект содержит подготовленный SQL-слой и инструкцию по сборке dashboard в Power BI Desktop.

Рекомендуемая структура dashboard:

```text
┌─────────────────────────────────────────────┐
│ Revenue │ Orders │ AOV │ Units Sold        │
├─────────────────────────────────────────────┤
│                                             │
│        Monthly Revenue Trend                │
│                                             │
├───────────────────────┬─────────────────────┤
│ Revenue by Category   │ Revenue by Region   │
├───────────────────────┼─────────────────────┤
│ Revenue by Segment    │ Top Products        │
└───────────────────────┴─────────────────────┘
```

### Примеры DAX measures

```DAX
Total Revenue =
SUM(orders[revenue])

Orders Count =
DISTINCTCOUNT(orders[order_id])

Units Sold =
SUM(orders[quantity])

AOV =
DIVIDE([Total Revenue], [Orders Count])
```

## Ключевые выводы

1. Общая выручка синтетического набора — 9.11 млн условных единиц.
2. Средний чек — 758.88.
3. Beauty — крупнейшая категория по выручке.
4. Региональные и клиентские сегменты позволяют сравнивать структуру продаж.
5. Динамика по месяцам может использоваться для поиска сезонности и периодов изменения спроса.

## Ограничения

- данные синтетические;
- денежные значения являются условными;
- результаты не отражают показатели реального бизнеса;
- без реального контекста нельзя делать выводы о причинах изменения продаж.

## Запуск PostgreSQL

Создать базу данных, затем выполнить:

```bash
psql -d sales_dashboard -f sql/schema.sql
```

После загрузки CSV выполнить аналитические запросы:

```bash
psql -d sales_dashboard -f sql/analysis.sql
```

Инструкция по подготовке набора для Power BI находится в:

```text
powerbi/README.md
```

## Что можно улучшить

- добавить план/факт;
- рассчитать MoM и YoY;
- добавить retention и repeat purchase rate;
- добавить RFM-сегментацию;
- добавить drill-down по товарам и регионам;
- подключить Power BI к PostgreSQL напрямую.
