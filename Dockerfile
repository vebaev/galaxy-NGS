# Galaxy NGS image 1

FROM bgruening/galaxy-stable:20.05

MAINTAINER Vesselin Baev, baev@uni-plovdiv.bg

# Enable Conda dependency resolution
ENV GALAXY_CONFIG_BRAND="Galaxy NGS" \
    GALAXY_CONFIG_CONDA_AUTO_INSTALL=True

# Install tools
COPY NGS_1.yaml $GALAXY_ROOT/tools_1.yaml
COPY NGS_2.yaml $GALAXY_ROOT/tools_2.yaml
COPY NGS_3.yaml $GALAXY_ROOT/tools_3.yaml



# Split into multiple layers
RUN df -h && \
    install-tools $GALAXY_ROOT/tools_1.yaml && \
    /tool_deps/_conda/bin/conda clean --all --yes && \
    rm -rf /tool_deps/_conda/pkgs && \
    df -h

RUN df -h && \ 
    install-tools $GALAXY_ROOT/tools_2.yaml && \
    /tool_deps/_conda/bin/conda clean --all --yes && \
    rm -rf /tool_deps/_conda/pkgs && \
    df -h
    
RUN df -h && \
    install-tools $GALAXY_ROOT/tools_3.yaml && \
    /tool_deps/_conda/bin/conda clean --all --yes && \
    rm -rf /tool_deps/_conda/pkgs && \
    df -h



# Add Container Style
ENV GALAXY_CONFIG_WELCOME_URL=$GALAXY_CONFIG_DIR/web/welcome.html
COPY config/welcome.html $GALAXY_CONFIG_DIR/web/welcome.html
COPY config/welcome_NGS.png $GALAXY_CONFIG_DIR/web/welcome_NGS.png

