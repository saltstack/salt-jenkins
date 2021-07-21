{%- set libcurl_pkg = ['libcurl-devel'] %}
{%- if grains['os_family'] == 'Debian' %}
  {%- set libcurl_pkg = ['libcurl4-openssl-dev', 'libssl-dev', 'libgnutls28-dev'] %}
{%- endif %}

# Arch ships libcurl dev files with the curl package
{%- if grains['os_family'] not in ('Arch',) %}
libcurl_and_pycurl_deps:
  pkg.latest:
    - aggregate: False
    - pkgs:
  {%- for pkg in libcurl_pkg %}
      - {{ pkg }}
  {%- endfor %}
{%- endif %}
