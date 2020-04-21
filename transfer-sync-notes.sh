
# -r         recursive sync
# -t         retain modified timestamp
# -v         verbose output
# --partial  resume partial transfers
# --progress show progress bar
# -e         specify the remote shell to use

rsync -rtv --partial --progress  \
	-e "ssh -p 2221" danr@ns551223.ip-144-217-67.net:/data/derived/ \
	/media/drozelle/Archive/2017-06-01_CHDI_Brain_Morphometry/derived/2017-10-26_derived/

rsync -POvrT
rsync -rv --partial --progress -e "ssh -p 2221" danr@ns551223.ip-144-217-67.net:/data/derived/

rsync --partial --progress --verbose --recursive --append-verify
