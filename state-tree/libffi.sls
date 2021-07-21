{%- if grains['os'] in ['Ubuntu', 'Debian'] %}
  {%- set libffi = "libffi-dev" %}
{%- elif grains['os'] in ['AlmaLinux', 'Fedora', 'CentOS', 'CentOS Stream'] or grains.os_family == 'Suse' %}
  {%- set libffi = "libffi-devel" %}
{%- else %}
  {%- set libffi = "libffi" %}
{%- endif %}

{{ libffi }}:
  pkg.installed:
    - aggregate: False
