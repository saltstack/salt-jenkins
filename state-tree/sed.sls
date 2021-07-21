{%- if grains['os'] == 'FreeBSD' %}
  {%- set sed = 'gsed' %}
{%- else %}
  {%- set sed = 'sed' %}
{%- endif %}

sed:
  pkg.installed:
    - name: {{ sed }}
    - aggregate: False
