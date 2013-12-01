class kale::ppa(
) {

  include apt

  apt::ppa { 'ppa:gds/govuk': }
  apt::ppa { 'ppa:chris-lea/redis-server': }

}
