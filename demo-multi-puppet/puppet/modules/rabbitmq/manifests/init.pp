class rabbitmq {

    package { 'rabbitmq-server':
        ensure => latest,
        require => Exec['apt-get update'],
    }

    service { "rabbitmq-server":
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Package["rabbitmq-server"],
    }

    exec { 'add-geeky-vhost':
        command => "rabbitmqctl add_vhost /geeky",
        unless => 'rabbitmqctl list_vhosts | grep geeky',
        path    => "/usr/bin:/usr/sbin:/bin:/sbin",
        user => 'root',
        group => 'root'   
    }

    exec { 'add-geeky-user':
        command => 'rabbitmqctl add_user geeky geeky',
        unless =>   "/usr/sbin/rabbitmqctl list_users | grep geeky",
        path    => "/usr/bin:/usr/sbin:/bin:/sbin",
        user => 'root',
        group => 'root'
    }

  exec { 'set-geeky-permissions':
        command => 'rabbitmqctl set_permissions -p /geeky geeky ".*" ".*" ".*"',
        unless =>   "/usr/sbin/rabbitmqctl list_user_permissions geeky | grep '\\.\\*\\s\\.\\*\\s\\.\\*'",
        path    => "/usr/bin:/usr/sbin:/bin:/sbin",
        user => 'root',
        group => 'root'
  }

  Service['rabbitmq-server'] -> Exec['add-geeky-vhost'] -> Exec['add-geeky-user'] -> Exec['set-geeky-permissions']
}
