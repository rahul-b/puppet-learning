#### Apache classes

class apache::install {
   package {"httpd":
     ensure  =>  "present",
    }
  }

class apache::service {
   service {"httpd":
     ensure  =>  "running",
     hasstatus  =>  "true",
     hasrestart  =>  "true",
     enable   =>  "true",
     require  =>  Class["apache::install"],
   }
} 
class apache::config {
   file {"/etc/httpd/conf/httpd.conf":
     ensure  =>  "present",
     source  =>  "puppet:///modules/apache/httpd.conf",
     owner  =>  "root",
     group  =>  "root",
     mode   =>  "644",
     require  => Class["apache::install"],
     notify  =>  Class["apache::service"],
  }
}

define apache::vhost( $port, $docroot, $ssl=true, $template='apache/vhost.conf.erb', $priority, $serveraliases = '')
  {
   
include apache

 file {"/etc/httpd/conf.d/$priority-$name":
   content  =>  template($template),
   owner  =>  "root",
   group  =>  "root",
   mode  =>  "777",
   require  => Class["apache::install"],
   notify  =>  Class["apache::service"],
   }
 }


class apache {
  include apache::install, apache::config, apache::service
 }
