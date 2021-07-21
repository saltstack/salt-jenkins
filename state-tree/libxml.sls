{%- if grains['os'] in ['Ubuntu', 'Debian'] %}
  {%- set libxml2 = "libxml2-dev" %}
{%- elif grains['os'] in ['AlmaLinux', 'Fedora', 'CentOS', 'CentOS Stream'] or grains.os_family == 'Suse' %}
  {%- set libxml2 = "libxml2-devel" %}
{%- else %}
  {%- set libxml2 = "libxml2" %}
{%- endif %}

{{ libxml2 }}:
  pkg.installed:
    - aggregate: False
