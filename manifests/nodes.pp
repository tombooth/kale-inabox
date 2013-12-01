# Use hiera as a lightweight ENC.
node default {

  $node_role = regsubst($::hostname, '^(.*)-\d$', '\1')

  hiera_include('classes')

  $hosts = hiera_hash( 'hosts', {} )
  if !empty($hosts) {
    create_resources('host', $hosts)
  }

  $collectd_plugins = hiera_array( 'collectd_plugins', [] )
  if !empty($collectd_plugins) {
    collectd::plugin { $collectd_plugins: }
  }

  $nginx_vhosts = hiera_hash( 'nginx_vhosts', {} )
  if !empty($nginx_vhosts) {
    create_resources('nginx::resource::vhost', $nginx_vhosts)
  }

}
