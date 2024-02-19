#!/bin/sh

date >/proc/1/fd/1 2>/proc/1/fd/2
/usr/bin/imapsync --host1 ${HOST1} --user1 ${USER1} --password1 ${PASSWORD1} ${OTHER1} --host2 ${HOST2} --user2 ${USER2} --password2 ${PASSWORD2} ${OTHER2} --logdir=/logs >/proc/1/fd/1 2>/proc/1/fd/2
