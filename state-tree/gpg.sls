{%- if grains['os_family'] == 'RedHat' %}
  {%- set gnupg = 'gnupg2' %}
{%- else %}
  {%- set gnupg = 'gnupg' %}
{%- endif %}

gpg:
  pkg.installed:
    - name: {{ gnupg }}
    - aggregate: False
