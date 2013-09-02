#node /^node\d+\.test\.com/ {
#include  web-template
#}

node default {
include sudo
}

class base {
include ssh, sudo
}

node 'puppet-master.test.com' {
include base
}

node 'web.test.com' {
 include base
 include apache

#### defination 
  apache::vhost { "web.test.com":
  port  =>  80,
  docroot  => "var/www/",
  ssl  =>  "false",
  priority  => 10,
  serveraliases  =>  "home.test.com",
  }

}

node 'db.test.com' {
 include base
 include mysql
}

node 'mail.test.com' {
 include base
 include postfix
}



