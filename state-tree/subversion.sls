{%- if grains['os'] == 'Gentoo' %}
  {%- set subversion = 'dev-vcs/subversion' %}
{%- else %}
  {%- set subversion = 'subversion' %}
{%- endif %}

subversion:
  pkg.installed:
    - name: {{ subversion }}
    - aggregate: False
