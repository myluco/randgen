perl ./runall-trials.pl --trials=10 --force --duration=300 --threads=6 --skip-gendata --mysqld=--max-statement-time=10 --mysqld=--lock-wait-timeout=5 --scenario=MariaBackupFull  --grammar=ment328.yy  --basedir=$1 --vardir=/dev/shm/vardir
