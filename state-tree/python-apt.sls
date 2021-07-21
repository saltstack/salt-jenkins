{%- set python2_apt = 'python-apt' %}
{%- set python3_apt = 'python3-apt' %}

{%- if grains['os_family'] == 'Debian' and grains['osmajorrelease'] in (9, 10, 18, 20) %}
python2-apt:
  pkg.installed:
    - name: {{ python2_apt }}
    - aggregate: False
{%- endif %}

python3-apt:
  pkg.installed:
    - name: {{ python3_apt }}
    - aggregate: False

python-apt:
  test.succeed_without_changes:
    - require:
{%- if grains['os_family'] == 'Debian' and grains['osmajorrelease'] in (9, 10, 18, 20) %}
      - python2-apt
{%- endif %}
      - python3-apt
