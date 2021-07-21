{%- if grains['os'] == 'Gentoo' %}
  {%- set patch = 'sys-devel/patch' %}
{%- else %}
  {%- set patch = 'patch' %}
{%- endif %}

patch:
  pkg.installed:
    - name: {{ patch }}
    - aggregate: False
