## JSON files


# read
import json

with open("data_file.json", "r") as fh:
    data = json.load(fh)

# write
import json

with open("data_file.json", "w") as fh:
    json.dump(data, fh)


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

[file.replace("SCC_Spec_Doc_", "") for file in files if file.endswith("xlsx")]


## dates

from datetime import datetime

datetime.strptime("06.05.90", "%m.%d.%y")
