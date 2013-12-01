class kale::apt_update(
  $max_age = 604800
) {

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update',
    onlyif  => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= ${max_age} ))'"
  }

}
