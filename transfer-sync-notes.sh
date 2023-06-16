
# -r         recursive sync
# -t         retain modified timestamp
# -v         verbose output
# --partial  resume partial transfers
# --progress show progress bar
# -e         specify the remote shell to use

rsync -rtv --partial --progress  \
	-e "ssh -p 2221" danr@ns123.ip-144-217-67.net:/data/derived/ \
	/media/drozelle/Archive/2017-06-01_Project/derived/2017-10-26_derived/

rsync -POvrT
rsync -rv --partial --progress -e "ssh -p 2221" danr@ns123.ip-144-217-67.net:/data/derived/

rsync --partial --progress --verbose --recursive --append-verify

sudo lxc list
sudo lxc file push -r localpath/ server-name/remote/path