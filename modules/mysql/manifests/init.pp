#### Mysql classes

class mysql::install {
 
   package {[ "mysql", "mysql-test", "mysql-devel", "mysql-server" ]:
     ensure  =>  "present",
     require =>  User["mysql"],
   }
 
   user { "mysql":
     ensure  =>  "present",
     comment  =>  "Mysql user",
     gid   =>  "mysql",
     shell  =>  "/bin/false",
     require  =>  Group["mysql"],
   }

  group { "mysql":
     ensure  =>  "present",
     }
}

class mysql::config {
#   file {"/opt/mysql":
#      ensure  =>  "directory",
#      owner  =>  "mysql",
#      group  =>  "mysql",
#      mode  =>   "0777", 
#      }

   file {"/etc/my.cnf":
     ensure  =>  "present",
     source  =>  "puppet:///modules/mysql/etc/my.cnf",
     owner  =>  "mysql",
     group  =>  "mysql",
     require  =>  Class["mysql::install"],#, File["/opt/mysql"] ], 
     notify  =>  Class["mysql::service"],
     }

#   file {"/opt/mysql/var":
#       ensure  =>  "directory",
#       group  =>  "mysql",
#       owner  =>  "mysql",
#       recurse  =>  "true",
#       require  => [ File["/opt/mysql/my.cnf"], File["/opt/mysql"] ],
#      }    
 
#   file {"/etc/my.cnf":
#       require  => File["/opt/mysql/my.cnf"],
#       ensure  =>  "/opt/mysql/my.cnf",
#         }
 } 


class mysql::service {
    service { "mysqld":
      ensure  =>  "running",
      hasstatus  =>  "true",
      hasrestart  =>  "true",
      enable  =>  "true",
      require  =>  Class["mysql::config"],
   }
 }
     

class mysql {
   include mysql::install, mysql::config, mysql::service
}






 



