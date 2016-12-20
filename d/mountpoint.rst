mountpoint
==========

Synopsis
********

::

  $ theresa mountpoint PATHNAME PREDICATE...


Predicates
**********

* `--for DEVICE`
* `--in-group GROUP`
* `--mode MODE`
* `--options FSTYPE`
* `--owned-by USER`
* `--type FSTYPE`


Examples
********

::

  $ theresa mountpoint /mnt --for /dev/sdb1 --owned-by root --in-group wheel --mode 755

::

  $ theresa mountpoint / --for zpool/ROOT/default --type zfs --options rw,noatime,nfsv4acls
