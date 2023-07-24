-- common table expression create a temporary intermediate table usefule for complex joins/filters
WITH regional_sales AS (
    SELECT region, SUM(amount) AS total_sales
    FROM orders
    GROUP BY region
), top_regions AS (
    SELECT region
    FROM regional_sales
    WHERE total_sales > (SELECT SUM(total_sales)/10 FROM regional_sales)
)
SELECT region,
       product,
       SUM(quantity) AS product_units,
       SUM(amount) AS product_sales
FROM orders
WHERE region IN (SELECT region FROM top_regions)
GROUP BY region, product;


-- filter based on values from another table
SELECT 
uniprot,
ensembl_protein_id
FROM dev.uniprot_new
WHERE uniprot in (SELECT uniprot FROM dev.propellerome) 
AND ensembl_protein_id != 'None_Found'