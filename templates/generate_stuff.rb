generate('rspec:install')
generate('controller wombats index')
generate('integration_test widgets')
generate('mailer Notifications signup')
generate('model thing name:string')
generate('observer widget')
generate('scaffold widget name:string')
generate('scaffold gadget ') # scaffold with no attributes

run('rake db:migrate')
run('rake db:test:prepare')
