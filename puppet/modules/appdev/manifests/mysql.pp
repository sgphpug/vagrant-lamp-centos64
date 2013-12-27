class appdev::mysql(
	$root_pwd = 'media1',
	$dev_db_name = 'loadtest',
	$dev_db_user = 'loadtester',
	$dev_db_pwd = 'media1',
)
{
	class { '::mysql::server':
		root_password    => $root_pwd,
		override_options => {
			'mysqld' => {
				'bind_address' => '0.0.0.0',
				'lower_case_table_names' => '1'
			}
		},
	}
	mysql::db { $dev_db_name:
		user     => $dev_db_user,
		password => $dev_db_pwd,
		host     => ['localhost'],
		grant    => ['all'],
		charset  => 'utf8',
		require => Class['::mysql::server']
	}
	mysql_user {
		"$dev_db_user@%":
			password_hash => mysql_password($dev_db_pwd),
			require => Class['::mysql::server']
			;
	}
	mysql_grant { [
			"$dev_db_user@%/$dev_db_name.*"
		]:
		privileges => ['all'],
		table => "$dev_db_name.*",
		user => "$dev_db_user@%",
		require => Class['::mysql::server']
	}
}