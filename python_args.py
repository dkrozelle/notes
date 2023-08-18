#!/usr/bin/env python

# simple sys.argv

import sys

name_of_script = sys.argv[0]
position = sys.argv[1]
sample = sys.argv[2]

# argparse for named arguments

import argparse

parser = argparse.ArgumentParser(description="Extract bids json to tabular format.")
parser.add_argument("bids_path", help="file path to the bids root directory")

query_group = parser.add_mutually_exclusive_group()
query_group.add_argument(
    "--query_list",
    "-q",
    metavar="-q",
    nargs="+",
    default=["sex", "ethnic", "handed", "education"],
    help="space delim list of variables to extract",
)
query_group.add_argument(
    "--query_file", "-f", help="file path for query list, one variable per line"
)

parser.add_argument(
    "--number",
    "-n",
    type=int,
    help="limit report to first n subjects, helpful for debugging",
)
parser.add_argument(
    "--outfile",
    "-o",
    help="file path of tsv output to write, otherwise returned to stdout",
)
args = parser.parse_args()

print(args)
