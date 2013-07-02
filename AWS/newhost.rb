#! /usr/bin/ruby
# Load ssh credentials for AWS instance
def set_cred(name, pem, host)
  `cp ~/Downloads/#{pem}.pem ~/.ssh/`
  `sudo chmod 400 ~/.ssh/#{pem}.pem`
  `sudo chmod 700 ~/.ssh`
  `echo 'Host #{name} \n HostName #{host} \n User ubuntu \n IdentityFile "~/.ssh/#{pem}.pem"' >> ~/.ssh/config`
  begin
    `ssh #{name}`
  rescue Exception
    print "exception was raised"
  end
end
