class ssh {
  include ssh::package, ssh::file, ssh::service
  }

class ssh::package {
    package {"openssh":
      ensure  => "present",
     }
   }
class ssh::file {
     file {"/etc/ssh/sshd_config":
       ensure  => "present",
       owner  =>  "root",
       group  =>  "root",
       mode   =>  "0600",
       source  =>  "puppet:///modules/ssh/sshd_config",
       require =>  Class["ssh::package"],
       notify  =>  Class["ssh::service"],
    }
  }

class ssh::service {
   service {"sshd":
     ensure  =>  "running",
     hasstatus  =>  "true",
     hasrestart  =>  "true",
     enable  =>  "true",
     require  =>  Class["ssh::file"],
   }
}
   

