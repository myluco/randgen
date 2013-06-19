# Copyright (c) 2012 Oracle and/or its affiliates. All rights reserved.
# Use is subject to license terms.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301
# USA

# Certain parts (c) Percona Inc

$combinations=
[
 ['
  --seed=random --duration=300 --querytimeout=60 --sqltrace
  --reporter=Shutdown,Backtrace,QueryTimeout,ErrorLog,ErrorLogAlarm
  --mysqld=--log-output=none --mysqld=--sql_mode=ONLY_FULL_GROUP_BY
  --mysqld=--slow_query_log --mysqld=--userstat
  --views --validator=Transformer'
 ],[
  '--grammar=GRAMMAR --gendata=GENDATA',
 ],[
  '--threads=1',
  '--threads=25'
 ],[
  '--notnull'
  '',
 ],[
  '--mysqld=--innodb_file_per_table=1',
  '--mysqld=--innodb_file_per_table=1 --mysqld=--innodb_file_format=barracuda'
  '',
 ],[
  '--basedir=/Percona-Server',
  '--basedir=/Percona-Server --valgrind --reporter=ValgrindErrors --validator=MarkErrorLog'
 ]
]
