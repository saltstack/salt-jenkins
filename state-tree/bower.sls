{%- if grains['os'] == 'Ubuntu' %}
nodejs-legacy:
    pkg.installed:
      - aggregate: False
{%- endif %}

{#- for MacOS we want to install node, npm, and bower at the end for issue #41770, so skipping install here. #}
{%- if grains['os'] != 'MacOS' %}

bower:
  npm.installed:
    - require:
      - pkg: npm
      {%- if grains['os'] == 'Ubuntu' %}
      - pkg: nodejs-legacy
      {%- endif %}
{%- endif %}
