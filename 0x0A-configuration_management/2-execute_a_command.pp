#This code will kill a process killmenow

exec { 'pkill':
  command  => 'pkill killmenow',
  provider => 'shell',
}
