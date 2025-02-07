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



# Crosstab functionality

### local admin functions ###

sudo -i -u postgres
psql

\l # list dbs

django postgres
    pg_dump django >dumpfile

### SQL  ###
CREATE USER admin WITH PASSWORD 'jw8s0F4';

-- The SELECT must return 3 columns: identifier, category (column name), value
SELECT id, col, val FROM data ORDER BY 1,2

-- Define the new structure
AS final_result(col1 TEXT, col2 NUMERIC, col3 NUMERIC)

-- Finally, join them into one statement
SELECT *
	FROM crosstab( 'select student, subject, evaluation_result from evaluations order by 1,2')
	AS final_result(Student TEXT, Geography NUMERIC,History NUMERIC,Language NUMERIC,Maths NUMERIC,Music NUMERIC);

-- it makes sense to specifically select only the col values you want to map
	SELECT id, col, val FROM data WHERE col = 'col1' OR col = 'col2'
-- combine fields into a single id field where necessary
	SELECT da_number || '#$#' || assay || '#$#' ||  study as col
-- then in the parent select
	SELECT split_part(final_result.sample, '#$#'::text, 1) AS study


-- Rows in common
SELECT col1, col2 FROM schema.first_table
INTERSECT
SELECT col1, col2 FROM schema.second_table

-- Rows in a not b
SELECT col1, col2 FROM schema.first_table
EXCEPT
SELECT col1, col2 FROM schema.second_table


-- backup a table and add data from another table
CREATE TABLE schema.backup SELECT * FROM schema.original;
ALTER TABLE schema.backup OWNER TO drozelle;
TRUNCATE schema.original;
INSERT INTO schema.original
	SELECT * FROM schema.other_table;

-- convert text column to a new numeric column
ALTER TABLE takeda.scores ADD COLUMN major NUMERIC;

UPDATE takeda.scores SET major = majorscore::numeric;

