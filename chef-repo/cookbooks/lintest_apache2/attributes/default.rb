default['apache']['prefork']['startservers']        = 4
default['apache']['prefork']['minspareservers']     = 4
default['apache']['prefork']['maxspareservers']     = 8
default['apache']['prefork']['serverlimit']         = 128
default['apache']['prefork']['maxclients']          = 48
default['apache']['prefork']['maxrequestsperchild'] = 500

default['lintest_wordpress']['mysql_host']  = '127.0.0.1'
default['lintest_wordpress']['vhost_dir']   = '/var/www/vhosts'
default['lintest_wordpress']['docroot']     = node['lintest_wordpress']['vhost_dir'] + 'node'


