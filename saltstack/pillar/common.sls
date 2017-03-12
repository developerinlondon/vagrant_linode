info: common data
packages:
  - htop
  - strace
  - traceroute
  - strace
  - wget
  - gdb
  - telnet
  - lsof
  - ncdu
  - ntp
  - python-pip
  - python-dev
  - python-psutil
  - tree
  - iftop
  - vim

include:
  {% if grains['os_family'] == 'Debian' %}
  - debian
  {% elif grains['os_family'] == 'RedHat' %}
  - redhat
  {% endif %}
