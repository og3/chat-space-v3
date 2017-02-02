server '13.112.50.109', user: 'ec2-user', roles: %w{app db web}

set :ssh_options, keys: '~/AWSpass/key_pair_study.pem'
