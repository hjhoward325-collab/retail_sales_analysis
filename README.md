# SuperStore Sales & Profitability Analysis

A SQL portfolio project analyzing ~102,500 retail orders to uncover profitability patterns across product categories, regions, customer segments, and discounting behavior.

## Overview

This project uses the public **SuperStore Orders** dataset (sourced from Kaggle) to answer real business questions a retail analyst might be asked to investigate: which parts of the business are most profitable, where money is being lost, and how discounting strategy affects margin.

All queries were written and run independently in **DB Browser for SQLite**. No analysis was AI-generated — each query was built from scratch, debugged, and interpreted by hand.

## Dataset

- **Source:** [SuperStore Orders dataset — Kaggle](https://www.kaggle.com/datasets/apoorvaappz/global-super-store-dataset)
- **Size:** 102,581 rows
- **Key fields used:** `category`, `sub_category`, `region`, `segment`, `product_name`, `state`, `year`, `sales`, `profit`, `discount`

## Tools

- SQL (SQLite dialect)
- DB Browser for SQLite

## Key Questions & Findings

### 1. Which product category is most profitable?
Technology generates the highest total profit ($663,778), ahead of Office Supplies ($518,474) and Furniture ($286,782) — despite Office Supplies having higher total sales than Technology. Furniture converts sales to profit the least efficiently of the three.

### 2. Which region performs best?
Central is the strongest region by total profit ($311,404). Canada and Southeast Asia are the weakest performers — Southeast Asia notably has moderate sales volume but very poor profit conversion.

### 3. What are the top 10 most profitable products?
The Canon imageCLASS 2200 Advanced Copier tops the list by profit despite having the lowest sales volume of any product in the top 10 — a clear high-margin, low-volume outlier. A similar pattern shows up comparing the Nokia Smart Phone (w/ Caller ID) against the Cisco Smart Phone (Full Size): Nokia generates strong profit on lower sales volume, while Cisco needs more volume to produce comparable returns.

### 4. Which customer segment is most profitable — and most efficient?
Consumer generates the most total profit ($749,240), but it is **not** the most efficient segment. Calculating profit margin (profit ÷ sales) reveals:
- Home Office: ~19.7% margin
- Corporate: ~18.7% margin
- Consumer: ~18.5% margin

Home Office is actually the most efficient segment per dollar of sales, despite being the smallest in absolute terms. Consumer wins on volume, not efficiency.

### 5. How has the business trended over time?
From 2011–2014, both sales and profit grew every year. However, profit margin peaked in 2013 (~19.4%) and dipped slightly in 2014 (~18.9%) — the business is growing in scale but showing early signs of slightly reduced efficiency as it expands.

### 6. Which sub-categories are profitable vs. operating at a loss?
Using a margin-based classification (Loss: <0%, Low Margin: 0–8%, Profitable: 8%+), every sub-category is profitable **except Tables**, which operates at a striking -22.09% margin — the only sub-category losing money outright.

### 7. Which states/regions are operating at a net loss?
267 states/regions in the dataset show a net loss. The losses are heavily concentrated: a small number of locations (Istanbul, Lagos, Texas, Ohio, Izmir) account for tens of thousands of dollars in losses each, while the majority of loss locations lose only single or double-digit dollar amounts — likely due to very low order volume rather than a systemic pricing or discounting issue.

**Takeaway:** High-volume loss locations like Istanbul (-$29,034) represent the best opportunity for investigation, since sufficient order volume exists to identify a real, diagnosable cause. Very small losses are more likely statistical noise from minimal transaction counts than an actionable pattern.

### 8. Does discounting hurt profit margin — equally across categories?
Furniture has the highest average discount (17%) and the lowest margin (11.9%). Office Supplies and Technology share an identical average discount rate (14%), yet Technology's margin is over 6 points higher (25.1% vs. 18.6%).

**Hypothesis:** Technology products likely carry a higher average price per unit, meaning the same discount percentage represents a smaller absolute dollar reduction to profit compared to lower-priced Office Supplies items. This would be testable with a sales-per-unit (sales ÷ quantity) calculation as a next step.

## Limitations & Next Steps

- No unit price column exists in the raw data; average price was approximated via sales ÷ quantity but not yet formally tested against the discount hypothesis in Question 8.
- Loss-location analysis (Question 7) would benefit from adding an order-count filter to separate genuine problem locations from low-volume noise.
- Future iteration: build a simple visualization layer (Tableau/Excel) on top of these queries to present findings to a non-technical audience.

## Files

- `queries.sql` — all 8 queries in full
- `README.md` — this file
  
  A companion presentation summarizing these findings for a non-technical audience is available on request.
