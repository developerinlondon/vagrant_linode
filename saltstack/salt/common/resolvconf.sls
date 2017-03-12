add-domain-to-resolv-conf:
  file.append:
    - name: /etc/resolv.conf
    - text: 
      - "#search BLABLA"
