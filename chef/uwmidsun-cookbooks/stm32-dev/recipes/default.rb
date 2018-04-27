Chef::Log.info('Add: Basic packages from xenial repos')

[
  'build-essential',
  'gdb',
  'openocd'
].each do |p|
  package p
end

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


###########################
# golang
###########################
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
    file.insert_line_if_no_match("/export PATH=\/opt\/gcc-arm-embedded\/gcc-arm-embedded-6.3.1\/bin:$PATH/", "export PATH=/opt/gcc-arm-embedded/gcc-arm-embedded-6.3.1/bin:$PATH")
    file.write_file
  end
end

package 'golang-glide'


###########################
# udev rules
###########################
execute 'udevadm-trigger' do
  action :nothing
  command '/sbin/udevadm trigger --action=add'
end

template '/etc/udev/rules.d/99-chef.rules' do
  source 'udev.rules.erb'
  owner 'root'
  group 'root'
  mode 0o644
  notifies :run, 'execute[udevadm-trigger]'
end


###########################
# minicom
###########################
package 'minicom'

template '/etc/minicom/minirc.dfl' do
  source 'minirc.dfl.erb'
  owner 'root'
  group 'root'
  mode 0o644
end


###########################
# clang
###########################
apt_repository 'llvm-5.0' do
  uri 'http://apt.llvm.org/' + node['lsb']['codename']
  distribution 'llvm-toolchain-' + node['lsb']['codename'] + '-5.0'
  components ['main']
  key 'https://apt.llvm.org/llvm-snapshot.gpg.key'
  deb_src true
  action :add
end

package 'clang-5.0'
package 'clang-format-5.0'

execute 'update-alternatives clang-5.0' do
  command 'update-alternatives --install /usr/local/bin/clang clang `which clang-5.0` 10'
end

execute 'update-alternatives clang-format-5.0' do
  command 'update-alternatives --install /usr/local/bin/clang-format clang-format `which clang-format-5.0` 10'
end
