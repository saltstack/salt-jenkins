{%- if grains['os'] in ['Ubuntu', 'Debian'] %}
  {%- set libgit2 = "libgit2-dev" %}
{%- elif grains['os'] in ['Fedora'] or grains.os_family == 'Suse' %}
  {%- set libgit2 = "libgit2-devel" %}
{%- else %}
  {%- set libgit2 = "libgit2" %}
{%- endif %}

{{ libgit2 }}:
  pkg.installed:
    - aggregate: False
