# project-superstore-sales-analysis
SQL and Tableau analysis of 4 years of retail sales data to identify 
where the business is profitable and where it is losing money.

## Business Question
A retail company has been running heavy discounts and promotions but 
profits remain flat. 
Where is the business making money, 
which products and regions are underperforming, 
and what is driving profit loss?

## Dataset
- Source: Kaggle — Sample Superstore Dataset
- Size: 9,694 orders across 4 years (2014–2017)
- Columns: Order Date, Region, Category, Sub-Category, Sales, Profit, Discount, Customer Segment, Ship Mode
- Link: https://www.kaggle.com/datasets/vivek468/superstore-dataset-final

## Tools Used
- MySQL — data cleaning, exploration, and analysis (6 SQL queries)
- Tableau Desktop — interactive dashboard with 4 visualizations

## Key Findings
1. REGIONAL: West leads profitability at 14.86% margin; Central earns 
   third most revenue but keeps only 8.06% — least efficient region

2. CATEGORY: Furniture generates $733K revenue but only $17K profit 
   (2.32% margin) — 7x lower than Technology and Office Supplies (~17%)

3. LOSS MAKERS: Tables lost $17,726 on $207K in sales; combined with 
   Bookcases and Supplies, three sub-categories lost $22,546 total

4. DISCOUNTS: Orders with 20%+ discounts lose money — 21-30% discounts 
   average a $45.68 loss per order; 30%+ average a $110.82 loss per order.
   1,344 such orders lost $134K combined — eliminating them recovers 
   this entire loss

5. SEGMENTS: Home Office has the fewest customers (148) but highest 
   margin (14.05%) and highest profit per customer ($404). Consumer 
   has the most customers (409) but lowest margin (11.53%) — growing 
   Home Office is more profitable than growing Consumer

6. GROWTH: Business grew 50% from 2014 to 2017. September and November 
   are consistently peak months every year. January always drops sharply 
   after the holiday season.

7. Regional Discount Behavior: Central region has the worst profit margin (8.06%) and also 
the most orders with heavy discounts (475 orders at 30%+, 
losing $94.85 per order on average). West has the best margin 
(14.86%) and fewest heavy discount orders (116). The data 
strongly suggests Central's aggressive discounting strategy 
is the primary driver of its poor profitability.

## Recommendation
1. Cap discounts at 20% — especially in Central, 
which has 475 orders at 30%+ discounts losing $94.85 per order, 
the primary driver of its 8.06% margin vs West's 14.86%.
2. Audit Tables and Bookcases pricing — both run at a net loss
3. Invest in growing the Home Office segment — highest margin, most 
   underserved, only 148 customers vs 409 Consumer customers

## Dashboard
https://public.tableau.com/app/profile/shivani.vallakatla/viz/Superstore_Sales_Performance_Analysis/SuperstoreSalesPerformanceAnalysis

## SQL Queries
All 6 analysis queries with comments are in the /sql folder.
