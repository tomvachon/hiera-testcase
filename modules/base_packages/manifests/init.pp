# Selector for allowing only deb type operatingsystems through
class base_packages (
  $basepackages = hiera_array($base_packages::basepackages)
  ){
  
  package { $basepackages: ensure => present, }
}
