class other {
  $packages = ["curl", "vim", "git", "libcurl3", "libcurl3-dev"]
  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }
}
