class redis {

    # Load repos
    exec { "add-redis-repo-deb":
        command => "echo 'deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu precise main' >> /etc/apt/sources.list",
        unless => "grep \"deb .*chris-lea/redis-server\" /etc/apt/sources.list 2>/dev/null",
        before => Exec["apt-get update"]
    }
    exec { "add-redis-repo-deb-src":
        command => "echo 'deb-src http://ppa.launchpad.net/chris-lea/redis-server/ubuntu precise main' >> /etc/apt/sources.list",
        unless => "grep \"deb-src .*chris-lea/redis-server\" /etc/apt/sources.list 2>/dev/null",
        before => Exec["apt-get update"]
    }
    exec { "add-redis-repo-key":
        command => "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12",
        unless => "apt-key list | grep C7917B12 2>/dev/null",
        before => Exec["apt-get update"]
    }

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