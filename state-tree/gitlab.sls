get_gl_runner:
  file.managed:
    - name: /usr/local/bin/gitlab-runner
    - source: https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
    - source_hash: https://gitlab-runner-downloads.s3.amazonaws.com/latest/release.sha256
    - mode: 755
