{%- set os = salt['grains.get']('os', '') %}
{%- set os_family = salt['grains.get']('os_family', '') %}
{%- set os_major_release = salt['grains.get']('osmajorrelease', 0)|int %}

{%- if os == 'Ubuntu' and os_major_release == 16 %}
  {%- set nox_version = '2019.11.9' %}
{%- else %}
  {%- set nox_version = '2020.8.22' %}
{%- endif %}

{%- if os_family == 'Windows' %}
  {%- set on_windows=True %}
{%- else %}
  {%- set on_windows=False %}
{%- endif %}

{%- if os_family == 'FreeBSD' %}
  {%- set on_freebsd=True %}
{%- else %}
  {%- set on_freebsd=False %}
{%- endif %}

{%- if on_windows %}
  {%- set pip = 'py -3 -m pip' %}
{%- else %}
  {%- if on_freebsd %}
    {%- set pip = 'pip-3.8' %}
  {%- else %}
    {%- set pip = 'pip3' %}
  {%- endif %}
{%- endif %}
include:
  - python-pip
  - python3

{%- set which_nox = 'nox' | which %}

{%- if not which_nox %}
nox:
  cmd.run:
  {%- if not on_windows %}
    - name: "{{ pip }} install 'nox=={{ nox_version }}' 'virtualenv==20.0.20'"
  {%- else %}
    - name: {{ pip }} install nox=={{ nox_version }} virtualenv==20.0.20
  {%- endif %}
    - require:
      - pip-install
      - python3

  {%- if not on_windows %}
symlink-nox:
  file.symlink:
    - name: /usr/bin/nox
    - target: /usr/local/bin/nox
    - onlyif: '[ -f /usr/local/bin/nox ]'
    - require:
      - nox
  {%- endif %}

nox-version:
  cmd.run:
  {%- if not on_windows %}
    - name: 'nox --version'
  {%- else %}
    - name: 'py -3 -m nox --version'
  {%- endif %}
    - require:
      - nox
  {%- if grains['os'] == 'MacOS' %}
    - runas: vagrant
  {%- endif %}
{%- endif %}
