#This code will install flask using Puppet

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3'
}
