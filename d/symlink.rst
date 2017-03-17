symlink
=======

Synopsis
********

::

  $ theresa symlink PATHNAME PREDICATE...


Predicates
**********

* `--in-group GROUP`
* `--owned-by USER`
* `--to VALUE`


Examples
********

::

  $ theresa symlink /etc/termcap --to /usr/share/misc/termcap --owned-by root --in-group wheel
