Chef::Log.info("Add: Basic packages from xenial repos")

[
  "build-essential",
  "gdb",
  "openocd"
].each do |p|
  package p
end

Chef::Log.info("Add: GCC ARM embedded toolchain from PPA")

bash "install_gccarmembedded" do
  code <<-EOH
    add-apt-repository ppa:team-gcc-arm-embedded/ppa -y
    apt-get update
    apt-get install gcc-arm-embedded -y
  EOH
end

Chef::Log.info("Add: Ruby from PPA")

bash "install_ruby" do
  code <<-EOH
    apt-add-repository -y ppa:rael-gc/rvm
    apt-get update
    apt-get install rvm -y
    source /etc/profile.d/rvm.sh
    rvm install ruby-2.3.3
  EOH
end
