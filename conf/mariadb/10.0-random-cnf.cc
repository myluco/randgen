
$combinations = [
	[
	'
		--no-mask
		--seed=time
		--threads=6
		--duration=600
		--queries=100M
		--reporters=QueryTimeout,Backtrace,ErrorLog,Deadlock
		--redefine=conf/mariadb/general-workarounds.yy
    --redefine=conf/mariadb/alter_table.yy
    --redefine=conf/mariadb/bulk_insert.yy
    --redefine=conf/mariadb/event.yy
    --redefine=conf/mariadb/sp.yy
		--mysqld=--log_output=FILE
    --mysqld=--lock-wait-timeout=10
    --mysqld=--innodb-lock-wait-timeout=5
		--genconfig=conf/mariadb/10.0.cnf.template
    --views
	'], 
	[
		'--grammar=conf/mariadb/oltp-transactional.yy --gendata=conf/mariadb/oltp.zz',
		'--grammar=conf/mariadb/oltp.yy --skip-gendata --gendata-advanced',
	],
];

