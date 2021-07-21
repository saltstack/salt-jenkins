{%- set distro = salt['grains.get']('oscodename', '')  %}
{%- set os_family = salt['grains.get']('os_family', '') %}
{%- set os_major_release = salt['grains.get']('osmajorrelease', 0)|int %}
{%- set os = salt['grains.get']('os', '') %}

{%- if os_family == 'RedHat' %}
  {%- if os_major_release == 6 %}
    {%- set pip_pkg_name = 'python27-pip' %}
  {%- elif os_major_release == 2018 %}
    {%- set pip_pkg_name = 'python36-pip' %}
  {%- else %}
    {%- set pip_pkg_name = 'python3-pip' %}
  {%- endif %}
{%- elif os_family in ('Debian', 'Ubuntu') %}
  {%- if os_major_release == 8 %}
    {%- set pip_pkg_name = 'python-pip' %}
  {%- else %}
    {%- set pip_pkg_name = 'python3-pip' %}
  {%- endif %}
{%- elif os_family == 'Arch' %}
  {%- set pip_pkg_name = 'python-pip' %}
{%- elif os_family == 'FreeBSD' %}
  {%- set pip_pkg_name = 'py38-pip' %}
{%- else %}
  {%- set pip_pkg_name = 'python3-pip' %}
{%- endif %}

pip-install:
{%- if os_family not in ('Windows', 'MacOS') %}
  pkg.installed:
    - name: {{ pip_pkg_name }}
{%- else %}
  cmd.run:
    - name: 'echo "Place holder for system python pip package installation"'
{%- endif %}
