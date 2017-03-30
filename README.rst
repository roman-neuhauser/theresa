.. vim: ft=rst sts=2 sw=2 tw=77

.. :Author: Roman Neuhauser
.. :Contact: neuhauser+theresa@sigpipe.cz
.. :Copyright: This document is in the public domain.

.. this file is marked up using reStructuredText
.. lines beginning with ".." are reST directives
.. "foo_" or "`foo bar`_" is a link, defined at ".. _foo" or ".. _foo bar"
.. "::" introduces a literal block (usually some form of code)
.. "`foo`" is some kind of identifier
.. suspicious backslashes in the text ("`std::string`\s") are required for
.. reST to recognize the preceding character as syntax

#######################################################################
                                theresa
#######################################################################
=======================================================================
                  Infrastructure validation made easy
=======================================================================

Introduction
============

`theresa` offers a unified language for `exec(3)`_-centric infrastracture tests.
Tests using `theresa` are just command lines.  You can start small and easy.

.. warning::

  There's no implementation yet, so far I'm just collecting input from
  prospective users and fleshing out the interface.


.. _exec(3):
    http://pubs.opengroup.org/onlinepubs/9699919799/functions/execve.html

.. .. _Cram: https://bitheap.org/cram/
.. .. _Serverspec: http://serverspec.org/
.. .. _Rspec: http://rspec.info/


Things and their Attributes
===========================

Each `theresa` invocation asserts one or more truths about a single
"`thing`":

* blockdev_
* chardev_
* dir_
* file_
* group_
* mountpoint_
* netif_
* pipe_
* symlink_
* user_

.. _blockdev: d/blockdev.rst
.. _chardev: d/chardev.rst
.. _dir: d/dir.rst
.. _file: d/file.rst
.. _group: d/group.rst
.. _mountpoint: d/mountpoint.rst
.. _netif: d/netif.rst
.. _pipe: d/pipe.rst
.. _symlink: d/symlink.rst
.. _user: d/user.rst


Examples
========

::

  $ theresa dir /var/empty --empty --owned-by root --in-group wheel --mode 755
  FAIL: dir /var/empty is in group root
  $ theresa mountpoint / --for zpool/ROOT/default --type zfs --options rw,noatime,nfsv4acls
  $ theresa symlink /etc/termcap --to /usr/share/misc/termcap --owned-by root --in-group wheel
  $ theresa user postgres --in-group postgres --at-home-in /var/db/postgres
  FAIL: user postgres is at home in /var/lib/postgresql


License
=======

Published under the `MIT license`_, see `LICENSE file`_.

.. _MIT license: https://opensource.org/licenses/MIT
.. _LICENSE file: LICENSE
