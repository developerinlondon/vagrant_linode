include:
  - common.packages
  - common.resolvconf
  {% if grains['os_family'] == 'Debian' %}
  - common.debian
  {% elif grains['os_family'] == 'RedHat' %}
  - common.redhat
  {% endif %}
#  - common.patches

# schedule-highstate:
#   schedule.present:
#     - function: state.highstate
#     - minutes: 60

cron-highstate:
  cron.present:
    - name: salt-call state.highstate
    - identifier: cron-salt-highstate
    - user: root
    - minute: 0,15,30,45

# PS1='\[\033[01;32m\]\u@\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
update-bashrc-domain:
  file.append:
     {% if grains['os_family'] in ['RedHat'] %}
     - name: /etc/bashrc
     {% elif grains['os_family'] in ['Debian'] %}
     - name: /root/.bashrc
     {% endif %}
     - text: |
         PS1='\[\033[01;{{ grains['prompt_color'] }}m\]\u@\H.\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
