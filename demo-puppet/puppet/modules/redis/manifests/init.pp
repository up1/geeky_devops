class redis {

    package { 'redis-server':
        ensure => latest,
        require => Exec['apt-get update']
    }

    service { "redis-server":
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Package["redis-server"],
    }
}