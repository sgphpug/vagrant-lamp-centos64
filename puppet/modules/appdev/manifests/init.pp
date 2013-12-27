class appdev(
	$root_pwd,
	$dbname,
	$dbuser,
	$dbpassword,
	$app_folder
)
{
	service {
		'iptables':
			ensure => stopped,
			enable => false
			;
	}

	package{
		[
			'vim-enhanced',
			'screen',
			'git'
		]:
			ensure => present,
			require => Yumrepo['epel']
			;
	}

	yumrepo {
	    'epel':
	        descr       => 'Extra Packages for Enterprise Linux 6 - $basearch',
	        enabled     => "1",
	        gpgcheck    => "1",
	        failovermethod => 'priority',
	        gpgkey      => "http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6",
	        mirrorlist  => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch'
	        ;
	}

	class { '::apache': }
	apache::vhost { "appdev":
		port    => '80',
		default_vhost => true,
		docroot => "/var/www/$app_folder/webroot",
		directories => [
			{ path => "/var/www/$app_folder/webroot", order => 'Allow,Deny', allow => 'from all', allow_override => ['All'] }
		],
		require => File["/var/www/$app_folder"]
	}
	class { 'php': }
	class {
		'mysql':
			root_pwd => $root_pwd,
			dev_db_name => $dbname,
			dev_db_user => $dbuser,
			dev_db_pwd => $dbpassword
			;
	}
	file {
		"/var/www/$app_folder":
			ensure => link,
			target => '/data',
			require => Class['::apache']
			;
	}
}