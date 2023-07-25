
# S3 interaction with AWS commandline tools

Setup aws commandline tool, you will need keys and secret for the bucket. I recommend always using a profile name instead of leaving to default.

```bash
$ aws configure --profile=myprofile
AWS Access Key ID [None]: XXXXXXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxX
Default region name [None]: 
Default output format [None]: 

# you can also just manually edit the credentials file
$ cat ~/.aws/credentials 
[myprofile]
aws_access_key_id = XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key = xXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxX

```

Listing files [aws documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/ls.html). 

Tips for listing files:
- you can't filter (include/exclude) a list in the same way as you can with a copy command, but you can use partial matching.
- not recursive by default
- grep is the best way to filter results in a more complex manner.

```bash
$ aws s3 --profile='myprofile' ls s3://bucket-name/delivery-zips/
                           PRE analyses/
                           PRE batch1/
                           PRE batch2/
                           PRE batch3/
                           PRE batch4/
                           PRE batch5/
$ aws s3 --profile='myprofile' ls s3://bucket-name/delivery-zips/batch
                           PRE batch1/
                           PRE batch2/
                           PRE batch3/
                           PRE batch4/
                           PRE batch5/
                        
$ aws s3 --profile='myprofile' ls s3://bucket-name/delivery-zips/batch --recursive --human-readable | grep "GSE122465" | grep -v "QC"
2023-05-26 17:42:56  107.7 MiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/Baccin_2019_Nat_Cell_Biol-GSE122465-anndata-annotated.h5ad
2023-05-26 17:43:00   16.3 MiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/Baccin_2019_Nat_Cell_Biol-GSE122465-differential-expressed-genes.xlsx
2023-05-26 17:42:55   15.2 MiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/Baccin_2019_Nat_Cell_Biol-GSE122465-metadata.csv
2023-05-26 17:42:58  101.0 MiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/Baccin_2019_Nat_Cell_Biol-GSE122465-seurat-annotated.RDS
2023-05-26 17:42:58    2.3 KiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/Baccin_2019_Nat_Cell_Biol-README.txt
2023-05-26 17:42:56   43.3 KiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/Baccin_2019_Nat_Cell_Biol.xlsx
2023-05-26 17:43:03    1.8 KiB delivery-zips/batch5/GSE122465/deliverables_2023-05-26/manifest.json

```
## aws s3 cp and sync

[Copy](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html) works across the same bucket, and between s3 and your local file system.

Tips for copy and sync:
- See [examples](https://docs.aws.amazon.com/cli/latest/reference/s3/cp.html#examples)
- sync performs similar operations to cp, but only works on unchanged files.
- sync is recursive by default, cp is not.
- include the `--delete` flag to remove files in destination
- common patterns for include/exclude. Remember filters are applied sequentially.
  - exclude tsv's from a recursive list `--recursive --exclude "*tsv"`
  - only transfer csv and tsvs `--recursive --exclude "*" --include "*tsv" --include "*csv"`
- !!ALWAYS use the `--dryrun` flag before a file move/copy/sync/rm to confirm the scope.


# S3 interaction with Python

Using python takes a little more setup, but can be included in a more complex logic script. Boto3 is the preferred package to support s3 work, here are some simple usage examples.

```py
import boto3
from botocore.exceptions import ClientError
# you can define credentials either in a separate py file, or as environmental variables. Don't check into version control.
from credentials import ACCESS_KEY, ACCESS_SECRET

client = boto3.client(
    "s3",
    region_name="us-east-1",
    aws_access_key_id=ACCESS_KEY,
    aws_secret_access_key=ACCESS_SECRET,
)


def list_s3_files(prefix, batch, dataset_id, dated_folder, bucket_name="bucket-name"):
    # destination S3 location to upload files
    delivery_folder_prefix = os.path.join(prefix, batch, dataset_id, dated_folder)

    # check which deliverables are already on s3
    # will add the trailing slash if it's not already there
    delivery_folder_prefix = os.path.join(delivery_folder_prefix, "")

    # this will list all objects, typically you will need to filter based on response.
    response = client.list_objects(Bucket=bucket_name, Prefix=delivery_folder_prefix)
    files_on_s3 = []
    # make sure we got content to parse
    if response.get("Contents"):
        for file_object in response["Contents"]:
            # the "Key" is just the full filename
            if file_object.get("Key"):
                filepath = file_object["Key"]
                filename = filepath.replace(delivery_folder_prefix, "")
                if not filename.startswith("QC"):
                    files_on_s3.append(filename)

    return files_on_s3


def upload_from_list(delivery_paths, bucket_name="bucket-name"):
    for delivery_path in delivery_paths:
        local_path, s3_key = delivery_path
        print(s3_key)

        # reading file as binary from local storage
        file_as_binary = open(local_path, "rb").read()
        file_as_binary = io.BytesIO(file_as_binary)

        # uploading file
        try:
            client.upload_fileobj(file_as_binary, bucket_name, s3_key)
        except ClientError as ex:
            print("Error: ", ex)


```

