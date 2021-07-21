{%- set debian = True if grains['os'] == 'Debian' else False %}

{%- set pkg_name = 'rubyinstaller_x64' if grains['os'] == 'Windows' else 'ruby' %}


{%- if debian %}
include:
  - openssl
{%- endif %}

install_ruby:
  pkg.installed:
    - name: {{ pkg_name }}
    - aggregate: False
    {%- if grains['os'] in ('Windows') %}
    - refresh: True
    {%- endif %}
    {%- if debian %}
    - require:
      - pkg: openssl
    {%- endif %}
