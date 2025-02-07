import csv
from db.postgres import postgres
import progressbar
import logging
import db.etl_logging as mylog

schema = "dev"
input_file = "hpo/hpo-category-map.csv"
table_name = "hpo_categories"

mylog.init_logging(table_name)
logging.info(f"Starting ingestion for {table_name}")

db = postgres()

# remove previous tables and create a new definition
db.statement(f"DROP TABLE IF EXISTS {schema}.{table_name} CASCADE;")

db.statement(
    f"""CREATE TABLE {schema}.{table_name}(
                term  TEXT,
                category TEXT
                );"""
)

# we don't have a helper for running copy_expert() yet, so we manually
# open a new connection and cursor
conn = db.new_connection()
cur = conn.cursor()
with open(input_file, "r") as f:
    # Skip the header row, but this assumes loading all columns as-is.
    next(f)
    cur.copy_expert(
        f"""COPY {schema}.{table_name} 
                        FROM STDIN  
                        (FORMAT CSV);""",
        f,
    )
conn.commit()
cur.close()
db.statement(f"GRANT SELECT, UPDATE, INSERT ON {schema}.{table_name} TO readwrite;")

##################################################
# load the term dictionary
input_file = "hpo/hpo-term-name-dict.csv"
table_name = "hpo_terms"

# remove previous tables and create a new definition
db.statement(f"DROP TABLE IF EXISTS {schema}.{table_name} CASCADE;")

db.statement(
    f"""CREATE TABLE {schema}.{table_name}(
                term  TEXT,
                hpo_id TEXT,
                name TEXT
                );"""
)

# we don't have a helper for running copy_expert() yet, so we manually
# open a new connection and cursor
conn = db.new_connection()
cur = conn.cursor()
with open(input_file, "r") as f:
    # Skip the header row, but this assumes loading all columns as-is.
    next(f)
    cur.copy_expert(
        f"""COPY {schema}.{table_name} 
                        FROM STDIN  
                        (FORMAT CSV, QUOTE '\"');""",
        f,
    )
conn.commit()
cur.close()


db.statement(
    f"""CREATE VIEW {schema}.hpo_category_counts AS 
            SELECT hpo.name, count(1)
            FROM dev.hpo_categories as cat
            LEFT JOIN dev.hpo_terms as hpo
                ON cat.category = hpo.term
            GROUP BY hpo.name
            ORDER BY count DESC;"""
)

db.statement(f"GRANT SELECT, UPDATE, INSERT ON {schema}.{table_name} TO readwrite;")
db.statement(
    f"GRANT SELECT, UPDATE, INSERT ON {schema}.hpo_category_counts TO readwrite;"
)
db.statement(f"GRANT ALL ON {schema}.{table_name} TO rancho;")
db.statement(f"GRANT ALL ON {schema}.hpo_category_counts TO rancho;")
db.close()
