{%- if grains['os_family'] in ('Debian', 'RedHat', 'Suse', 'Arch') %}
openldap:
  pkg.installed:
    - pkgs:
    {%- if grains['os_family'] == 'Debian' %}
      - libldap2-dev
      - libsasl2-dev
      - libdpkg-perl
    {%- elif grains['os_family'] == 'RedHat' %}
      - openldap-devel
    {%- elif grains['os_family'] == 'FreeBSD' %}
      - openldap-client
      - openldap-server
    {%- elif grains['os_family'] == 'Suse' %}
      - openldap2-devel
      - cyrus-sasl-devel
    {%- elif grains['os_family'] == 'Arch' %}
      - openldap
    {%- endif %}
    - aggregate: False
{%- endif %}
