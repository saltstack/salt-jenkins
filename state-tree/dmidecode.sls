{%- if grains['os'] == 'Windows' %}
  {%- set install_method = 'pip.installed' %}
{%- else %}
  {%- set install_method = 'pkg.installed' %}
{%- endif %}

{%- if grains['os'] == 'MacOS' %}
  {%- set dmidecode = 'cavaliercoder/dmidecode/dmidecode' %}
{%- else %}
  {%- set dmidecode = 'dmidecode' %}
{%- endif %}

install-dmidecode:
  {{ install_method }}:
    - name: {{ dmidecode }}
    {%- if install_method == 'pkg.installed' %}
    - aggregate: False
    {%- endif %}
