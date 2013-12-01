class kale::base(
) {

  stage { 'system':
    before => Stage['main'],
  }

  class { 'kale::apt_update':
    stage => 'system',
  } ->
  class { 'kale::ppa':
    stage => 'system',
  }

}
