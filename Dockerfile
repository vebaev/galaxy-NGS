# Galaxy - NGS

FROM bgruening/galaxy-stable:19.01

MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com

ENV GALAXY_CONFIG_BRAND NGS-preprocessing

# Install tools
COPY NGS.yaml $GALAXY_ROOT/tools.yaml

RUN install-tools $GALAXY_ROOT/tools.yaml && \
    /tool_deps/_conda/bin/conda clean --all --yes
