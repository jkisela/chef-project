name             'php_chef'
maintainer       'Joe Kisela'
maintainer_email 'jkisela@gmail.com'
license          'All rights reserved'
description      'Installs/Configures php_chef'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2"
depends "mysql", "4.1.2"
depends "php"
depends "database"



