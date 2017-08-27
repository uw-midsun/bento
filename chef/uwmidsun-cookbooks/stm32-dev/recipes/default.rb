Chef::Log.info('Add: Basic packages from xenial repos')

[
  'build-essential',
  'gdb',
  'openocd'
].each do |p|
  package p
end

Chef::Log.info('Add: GCC ARM embedded toolchain from PPA')

apt_repository 'team-gcc-arm-embedded' do
  uri 'ppa:team-gcc-arm-embedded/ppa'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'F64D33B0'
  deb_src true
  action :add
end

Chef::Log.info('Install GCC ARM Embedded')
package 'gcc-arm-embedded'

Chef::Log.info('Add: rvm from PPA')

apt_repository 'rael-gc' do
  uri 'ppa:rael-gc/rvm'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key '8094BB14F4E3FBBE'
  deb_src true
  action :add
end

Chef::Log.info('Install rvm')
package 'rvm'

bash 'install_ruby' do
  code <<-EOH
    source /etc/profile.d/rvm.sh
    rvm install ruby-2.3.3
  EOH
end

package 'minicom'

# clang
package 'clang'
package 'clang-format'
