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
  raise Exception('this is a raised exception')