# simple loop through a list of elements
set -e

ds=(
    batch1
    batch2
    batch3
    batch4
    batch5
)
for batch in "${ds[@]}"; do
    echo "$i"
    aws s3 --profile=scds ls s3://rancho-scds/delivery-zips/${batch}/
done