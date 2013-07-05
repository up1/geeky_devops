class java {
	package { "openjdk-7-jdk":
		ensure => installed,
		require => Exec['apt-get update']
	}
}
