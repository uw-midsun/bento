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

apt_repository 'glide' do
  uri 'ppa:masterminds/glide'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key '890C81B2'
  deb_src true
  action :add
end

ruby_block "insert_line" do
  block do
    file = Chef::Util::FileEdit.new("/home/vagrant/.bashrc")
    file.insert_line_if_no_match("/export GOPATH=\/home\/vagrant\/go/", "export GOPATH=/home/vagrant/go")
    file.insert_line_if_no_match("/export GOBIN=$GOPATH\/bin/", "export GOBIN=$GOPATH/bin")
    file.insert_line_if_no_match("/export PATH=$GOPATH\/bin:$PATH/", "export PATH=$GOPATH/bin:$PATH")
    file.write_file
  end
end

package 'glide'
