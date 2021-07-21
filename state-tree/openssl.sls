{%- set mac = True if grains['os'] == 'MacOS' else False %}
{%- set debian = True if grains['os'] == 'Debian' else False %}

{%- if debian %}
  {%- set install_method = 'pkg.latest' %}
{%- else %}
  {%- set install_method = 'pkg.installed' %}
{%- endif %}

{%- if mac or debian %}
openssl:
  {{ install_method }}:
    - name: openssl
    {%- if install_method == 'pkg.installed' %}
    - aggregate: False
    {%- endif %}
{%- endif %}
