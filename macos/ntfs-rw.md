# To make an external NTFS drive mountable rw using MacOS experimental support
* http://stackoverflow.com/questions/15316017/how-do-i-specify-a-label-path-with-spaces-in-etc-fstab

Put a line like this in /etc/fstab:

LABEL=TOSHIBA\040EXT none ntfs rw,auto,nobrowse

where the 040 part is a space in the drive label name.
