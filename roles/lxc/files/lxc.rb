#!/usr/bin/env ruby
# encoding: utf-8


def lxc_load_b(node = 2)
  i = 0
  while i <= node - 1
    name = "nginx"
    `lxc-create -t ubuntu -n #{name}-#{i}`
    i += 1
  end
end

def lxc_back(node = 3)
  i = 0
  while i <= node - 1
    name = "php"
    `lxc-create -t ubuntu -n #{name}-#{i}`
    i += 1
  end
end

def lxc_start()
  lxcls = `lxc-ls`
  cont = lxcls.split()
  cont.each do |name|
    puts `lxc-start -n #{name} -d`
  end
end

def lxc_hosts_fix()
  lxcls = `lxc-ls`
  cont = lxcls.split()
  cont.each do |name|
    cont.each do |inname|
      hostname = `lxc-info -n #{inname} |awk /IP/'{print $2}'`.rstrip
      fixname = hostname + " " + inname
      `echo #{fixname} >>/var/lib/lxc/#{name}/rootfs/etc/hosts`
    end
  end
end

def lxc_stop_destroy()
  lxcls = `lxc-ls`
  cont = lxcls.split()
  cont.each do |name|
    puts `lxc-stop -n #{name}`
    puts `lxc-destroy -n #{name}`
  end
end

if __FILE__ == $0
  lxc_stop_destroy()
  lxc_load_b()
  lxc_back()
  lxc_start()
  lxc_hosts_fix()
end
