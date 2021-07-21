{%- if grains['os'] in ['Ubuntu', 'Debian'] %}
  {%- set libxslt = "libxslt1-dev" %}
{%- elif grains['os'] in ['AlmaLinux', 'Fedora', 'CentOS', 'CentOS Stream'] or grains.os_family == 'Suse' %}
  {%- set libxslt = "libxslt-devel" %}
{%- else %}
  {%- set libxslt = "libxslt" %}
{%- endif %}

{{ libxslt }}:
  pkg.installed:
    - aggregate: False
