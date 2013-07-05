class bootstrap { 
    # this makes puppet and vagrant shut up about the puppet group
    group { 'puppet':
        ensure => 'present'
    }

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


    # make sure the packages are up to date before beginning
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
    }

}
