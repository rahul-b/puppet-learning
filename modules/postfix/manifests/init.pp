#### Postfix classes

class postfix::install {
  package {["postfix", "mailx"]:
    ensure  =>  "present",
   }
 }

class postfix::config {

 File {
    owner  =>  "postfix",
    group  =>  "postfix",
    mode  =>  "0644",
    }
 
 file { "/etc/postfix/master.cf":
    ensure  =>  "present",
    source  =>  "puppet:///modules/postfix/master.cf",
    require  =>  Class["postfix::install"],
    notify   =>  Class["postfix::service"],
   }

 file { "/etc/postfix/main.cf":
    ensure  =>  "present",
    content  =>  template("postfix/main.cf.erb"),
    require  =>  Class["postfix::install"],
    notify  =>  Class["postfix::service"],
  }
}

class postfix::service {
   service {"postfix":
     ensure  =>  "running",
     enable  =>  "true",
     hasstatus  =>  "true",
     hasrestart  =>  "true",
     require  =>  Class["postfix::config"],
    }
  }  

class postfix {
  include postfix::install, postfix::config, postfix::service
}

















    
                    
                   

