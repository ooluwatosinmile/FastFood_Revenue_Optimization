Rename table `9. sales-data` to sales_data; 

select *
from sales_data
;

select distinct* ,
row_number() OVER(partition by Order_ID) AS Row_Num
From sales_data;

With CTE1 as
(
select distinct* ,
row_number() OVER(partition by Order_ID) AS Row_Num
From sales_data
)
select *
from CTE1
WHERE Row_Num >1
;

insert into sales_data1
select * from sales_data;

select * 
from sales_data1;

update sales_data1
set Order_ID = trim(Order_ID),
Product = trim(Product),
Purchase_Type = trim(Purchase_Type),
`Payment Method` = trim(`Payment Method`),
Manager = trim(Manager),
City = Trim(city)
;

select Manager, replace(replace(manager,'   ',' '),'  ',' ')
from sales_data1;

update sales_data1
set manager = replace(replace(manager,'   ',' '),'  ',' ')
;

select *
from sales_data1;

select Distinct(Product)
from sales_data1;

select Distinct(Purchase_Type)
from sales_data1;

select Distinct(`Payment Method`)
from sales_data1;

select Distinct(Manager)
from sales_data1;

update sales_data1
set Manager = replace(manager,'  ',' ');

select Distinct(City)
from sales_data1;

select *
from sales_data1;

update sales_data1
set `date` =str_to_date(`date`,'%d/%m/%Y')
where `date` like '%/%'
;

select `date`,
date_format(str_to_date(`date`,'%d-%m-%Y'),'%Y-%m-%d') as Converted_Date
from sales_data1
where `date` regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
;

Update sales_data1
set `date` = date_format(str_to_date(`date`,'%d-%m-%Y'),'%Y-%m-%d') 
where `date` regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
;

alter table sales_data1
modify `date`  date
;

select *
from sales_data1
;

alter table sales_data1
modify price decimal(10,2)
;

alter table sales_data1
modify quantity decimal(10,2)
;

alter table sales_data1
rename column quantity to Total_Amount;

Alter table sales_data1
add column Quantity int after Price
;

update sales_data1
set Quantity = Total_Amount/Price
;

alter table sales_data1
rename column `Payment Method` to Payment_Method;


select *
from sales_data1
;

-- EDA
-- Top 5 Products by Revenue
SELECT Product, SUM(Total_Amount) AS Total_Revenue 
FROM sales_data1 
GROUP BY Product 
ORDER BY Total_Revenue 
DESC LIMIT 5;-- EDA
-- Top 5 Products by Revenue
SELECT Product, SUM(Total_Amount) AS Total_Revenue 
FROM sales_data1 
GROUP BY Product 
ORDER BY 

-- Top 5 products by Volume
SELECT Product, SUM(Quantity) AS Total_Volume 
FROM sales_data1 
GROUP BY Product 
ORDER BY Total_Volume 
DESC LIMIT 5;

-- Average Price by Products
SELECT Product, round(avg(price),2) AS Average_Price
FROM sales_data1 
GROUP BY Product 
ORDER BY Average_Price DESC;

-- Product Performance Insights
-- By comparing the results of Total Revenue, Total Volume, and Average Price; the following insights can be gained 
-- 1. Revenue Drivers and Profitability
-- The top 3 products by total revenue are Beverages, Fries, and Burgers. However, their contribution is driven by different factors:
-- A. Beverage is a high volume, low margin product
-- This is the highest  volume item, generating the most revenue, but its price is the lowest. It is likely a core, high frequency, add-on purchase.
-- B. Burgers is high margin, low volume product
-- This product has the highest average price but its volume is relatively low. It is the primary value driver per unit sold
-- C. Fries is a strong combo item
-- High volume and high revenue, indicating it's frequently paired with other items, likely Burgers or Chicken Sandwiches.

-- 2. Strategic Opportunities
-- Focus on Burgers for Revenue Growth: 
-- Burgers account for a large portion of revenue despite having a low sales volume (only 2,234 units). 
-- Actionable Insight: Increasing the volume of Burgers sold, perhaps through promotional bundles 
-- This will likely have the fastest positive impact on total revenue due to their high average price ($12.99).

-- The Power of Add-Ons: 
-- Beverages and Fries are the top two items by volume and revenue. 
-- Actionable Insight: These are essential loss-leader or complementary items. 
-- They should be emphasized in upselling prompts For example; "Would you like a beverage with that burger?"

-- Pricing Review for Chicken Sandwiches: 
-- Chicken Sandwiches have a decent average price ($10.32) but generate significantly less revenue ($11,135) 
-- They also have the lowest volume (1,095) of the top items. 
-- Actionable Insight: Investigate if this product's price point is too high relative to its perceived value, or if marketing efforts are needed to boost its volume.

-- Sales Trend over Time
SELECT date, SUM(Total_Amount) AS Daily_Sales 
FROM sales_data1 
GROUP BY date 
ORDER BY date;

-- Performance by Channel
SELECT Purchase_Type, SUM(Total_Amount), round(avg(Total_Amount),2) 
FROM sales_data1 
GROUP BY Purchase_Type;

-- Preferred Payment Method
SELECT Payment_Method, COUNT(Order_ID) AS Transaction_Count, SUM(Total_Amount) 
FROM sales_data1 
GROUP BY Payment_Method 
ORDER BY Transaction_Count DESC;

-- PURCHASE BEHAVIOR ANALYSIS
-- 1. Channel Consistency
-- All three channels (Online, In-store, Drive-thru) have a remarkably similar average transaction amount ($457.94 to $467.78).
-- Maximize Volume: Since average value is consistent, efforts should focus on increasing the volume of transactions across all channels

-- Online is the top revenue source 
-- Online generates the highest total revenue ($48,999.16).
-- Prioritize Digital Experience: Ensure the Online ordering interface is flawless, fast, and constantly optimized, as this channel is the primary revenue stream.

-- 2. Preferred Payment Method
-- Credit card Dominance
-- Credit Card is the most frequently used payment method (120 transactions, $52,970.78 total sales).
-- Reduce Friction for Credit: Ensure payment terminals are fast, reliable, and support modern tap-to-pay options, as this is the majority customer preference.

-- Gift Card Value
-- Gift Cards, despite the lowest transaction count (58), still account for significant revenue ($27,634.56).
-- Promote Gift Cards: Gift Cards lock in future spending. Increase promotion and visibility of gift card sales, especially during holiday periods, to secure future revenue.

-- Sunday sales dip
-- Sales on 2022-11-20 ($678) and 2022-12-04 ($740) are confirmed to be Sundays,showing a drop of app. 70% compared to the weekday average(∼$2,200−$2,500).
-- Operational Review: Investigate the reason for this drastic Sunday drop. 
-- Hypotheses to test: 1. Reduced Hours/Staffing: Are stores closing early or operating with limited menus? 
-- 2. Marketing: Launch Sunday-specific promotions (e.g., family bundles) to encourage traffic on the slowest day.

-- Manager's Best Selling Products
SELECT Manager, Product, SUM(Quantity) AS Total_Sold 
FROM sales_data1 
GROUP BY Manager, Product 
ORDER BY Manager, Total_Sold DESC;

-- City performance by Purchase Type
SELECT City, Purchase_Type, SUM(Total_Amount) AS City_Channel_Revenue 
FROM sales_data1 
GROUP BY City, Purchase_Type 
ORDER BY City, City_Channel_Revenue DESC;

-- Manager Transaction Size by Payment 
SELECT Manager, Payment_Method, round(avg(Total_Amount),2) AS Avg_Transaction_Value 
FROM sales_data1 
GROUP BY Manager, Payment_Method 
ORDER BY Manager, Avg_Transaction_Value DESC;

-- Multivariate Analysis Insights
-- 1. Manager Performance by Product Volume
-- This analysis shows which managers are best at driving unit volume for each product.
-- Joao Silva
-- Higest volume product: Beverages (3864 units)
-- Burger Volume(high margin): 645 units
--  Volume Specialist: Joao is the clear leader in overall volume, especially for the high-volume, low-margin Beverages and Fries. 
-- He sells the most Burgers among all managers.

-- Tom Jackson 
-- Higest volume product: Beverages (3312 units)
-- Burger Volume(high margin): 603 units
-- Strong Generalist: Very strong performance across all categories, nearly matching Joao's Burger volume. Likely a template for balanced sales.

-- Walter Muller
-- Higest volume product: Beverages (1380 units)
-- Burger Volume(high margin): 316 units
-- Low Volume: Walter has the lowest Burger volume and is a low volume seller overall compared to Joao and Tom. This needs investigation.

-- Managerial Actionable Insight: 
-- Joao Silva and Tom Jackson should be studied to understand their successful sales techniques, particularly for driving the high margin Burger volume (645 and 603 units, respectively). 
-- Their methods should be used to train managers with lower Burger sales, like Walter Muller (316 units).

-- 2. City Performance by Purchase Channel
-- This shows where each city's revenue is coming from (In-store, Online, Drive-thru).
-- London
-- Top Channel: Online ($28,870.86)
-- Revenue % from Top Channel (Approx.): 82% of city total
-- Key Insights: Digital Focus; London is extremely reliant on Online sales. The physical locations (In-store/Drive-thru) are underutilized.
-- Lisbon
-- Top Channel: In-store ($16,900.66)
-- Revenue % from Top Channel (Approx.): 49% of city total
-- Key Insights: Balanced with In-store Lead; Lisbon shows a strong preference for In-store purchasing, with Online as the solid second.
-- Madrid
-- Top Channel: In-store ($10,855.75)
-- Revenue % from Top Channel (Approx.): 51% of city total
-- Key Insights: In-store Lead; Similar to Lisbon, In-store is the main driver, with a low Online contribution.
-- Paris
-- Top Channel: Drive-thru ($5,302.58)
-- Revenue % from Top Channel (Approx.): 40% of city total
-- Key Insights: Highly Distributed; Paris has a strong Drive-thru presence and low In-store and Online revenue, indicating unique local preferences or store setups.
-- Berlin
-- Top Channel: In-store ($9,692.89)
-- Revenue % from Top Channel (Approx.): 57% of city total
-- Key Insights: In-store Focus, Berlin is mostly In-store, with a decent Drive-thru showing.
-- City Actionable Insight: 
-- Geographic Strategy: Marketing efforts should be tailored to the city's preferred channel. 
-- For London, focus on mobile app push notifications. 
-- For Lisbon and Madrid, focus on in-store customer experience and local signage. 
-- The low Madrid Online revenue ($745.76) suggests a major opportunity or a significant problem with the local digital infrastructure.

-- ACTION PLAN
-- 1. High-Value Target: Manager Joao Silva / City Lisbon
-- Joao Silva is a top volume driver, particularly for Burgers (high margin).
-- His sales are likely coming from Lisbon, where In-store is the primary channel.
-- Action: Ensure the Lisbon location is fully stocked and staffed to handle Joao's high volume, especially on weekdays (since Sundays are low for everyone).

-- 2. Sunday Strategy: The Manager-Channel Solution
-- You know Sunday sales are universally low.
-- London is highly successful Online. Lisbon is highly successful In-store.
-- Action: Design two separate Sunday promotions: one targeting Online buyers for example a "Sunday Funday" Online-only discount, leveraging London's preference)
-- and one targeting In-store buyers (e.g., a "Family Bundle" discount, leveraging Lisbon/Madrid's preference).

SELECT
    Manager,
    City,
    SUM(CASE WHEN Product IN ('Burgers', 'Chicken Sandwiches') THEN Total_Amount ELSE 0 END) AS High_Margin_Revenue
FROM
    sales_data1
GROUP BY
    Manager, City
ORDER BY
    High_Margin_Revenue DESC;
-- This query results confirm the leaders in selling the most profitable products (Burgers and Chicken Sandwiches).
-- Key Insights:
-- Highest High-Margin Performer. Joao in Lisbon is the benchmark for generating revenue from premium products. 
-- His In-store focus (Lisbon's top channel) and high Burger volume are key drivers.
-- Digital Profit Leader. Tom is a top performer, but his city, London, is heavily Online focused. 
-- This suggests Tom is highly effective at driving high-margin sales through the online channel.
-- Middle Performer. Pablo has strong overall volume but generates significantly less high-margin revenue than the top two, indicating a need to improve premium product focus.
-- Low High-Margin Sales. Walter is low on Burger volume and low on high-margin revenue, highlighting an urgent need for training or operational review.

-- Actionable Strategic Roadmap
-- Based on the complete EDA, here are the three most impactful, data-driven strategies:
-- 1. Optimize By Channel & Manager
-- The Learning Model: Create two distinct "Best Practice" guides:
-- In-store High-Margin Sales: Document and train the techniques used by Joao Silva (Lisbon) to drive Burgers and Chicken Sandwiches through the primary in-store channel.
-- Online High-Margin Sales: Study the digital promotions and menu placement strategies used by Tom Jackson (London) to capture high-margin revenue through the Online channel.
-- Targeted Improvement: Implement the In-store training model on Walter Muller (Berlin) and the Online strategies on Pablo Perez (Madrid), whose Online revenue is currently very low
-- 2. Attack the Sunday Sales Dip
-- The 70% drop in Sunday sales compared to weekdays is the largest opportunity for revenue lift.
-- Strategy: Combine the product and channel insights:
-- Run a "Sunday Online Family Bundle" promotion centered on the high-margin Burgers to leverage the proven success of the Online channel (e.g., London).
-- Run a "Sunday In-store Loyalty Offer" to encourage traffic in cities like Lisbon and Madrid.
-- 3. Review Chicken Sandwich Positioning
-- Chicken Sandwiches have a high average price ($10.32) but low total volume (1,095 units).
-- Action: Conduct a quick customer survey to determine if the issue is price sensitivity or lack of marketing. Since Burgers sell well at $12.99, the issue is likely positioning and perceived value rather than price alone.
