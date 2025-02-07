## JSON files


# read
import json

with open("data_file.json", "r") as fh:
    data = json.load(fh)

# write
import json

with open("data_file.json", "w") as fh:
    json.dump(data, fh, indent=2)


## try catch block
try:
    f = open("demofile.txt")
    try:
        f.write("Lorum Ipsum")
    except:
        print("Something went wrong when writing to the file")
    finally:
        f.close()
except:
    print("Something went wrong when opening the file")
    raise Exception("this is a raised exception")


## regex and string manupulation

[
    filename.replace("SCC_Spec_Doc_", "")
    for filename in filenames
    if filename.endswith("xlsx")
]

import re

re.sub(pattern, repl, string, count=0, flags=0)


## dates

from datetime import datetime

datetime.strptime("06.05.90", "%m.%d.%y")


# iterate a df by row,
# create a dict,
# key comes from the Variable Name column
# Description field comes from Variable Label
# for each File field term, write the corresponding dict to a json file

import json

import pandas as pd

dd = pd.read_csv("data.csv")

entries = {}
current_file = ""

for index, row in dd.iterrows():
    this_file = row["File"]
    # this starts a new file, write previous data to file before initializing
    if current_file != this_file:
        if current_file != "":
            with open(f"{current_file}.json", "w") as fh:
                json.dump(entries, fh, indent=2)
        current_file = this_file
        entries = {}
    entries[row["Variable Name"]] = {"Description": row["Variable Label"]}
