/etc/vimrc:
  file.managed:
    - source: salt://common/vimrc
    - mode: '0644'
    - user: root
    - group: root

common_packages:
  pkg.installed:
    - names: {{ pillar['packages'] }}
