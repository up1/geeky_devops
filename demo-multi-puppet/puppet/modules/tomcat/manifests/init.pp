class tomcat {

  package { "tomcat6":
    ensure => installed,
    require => Package['openjdk-7-jdk'],
  }
  
  package { "tomcat6-admin":
    ensure => installed,
    require => Package['tomcat6'],
  }
  
  service { "tomcat6":
    ensure => running,
    require => Package['tomcat6'],
    subscribe => File["tomcat-users.xml"]
  }

  file { "tomcat-users.xml":
    owner => 'root',
    path => '/etc/tomcat6/tomcat-users.xml',
    require => Package['tomcat6'],
    notify => Service['tomcat6'],
    content => template('/vagrant/puppet/modules/tomcat/templates/tomcat-users.xml.erb')
  }
}
