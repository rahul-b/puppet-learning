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
}

node 'db.test.com' {
 include base
 include mysql
}

node 'mail.test.com' {
 include base
 include postfix
}



