FROM opxhub/gbp:stretch

# Add any tools required for development
RUN apt-get -qq update && apt-get -qq upgrade -y && apt-get -qq install -y \
    bash-completion \
    dh-make \
    fakechroot \
    python-apt \
    python-jinja2 \
    python-lxml \
    python-requests \
    vim \
 && apt-get -qq autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch installer/3.2.0 \
    https://github.com/open-switch/opx-build /usr/local/opx-build
ENV PATH "$PATH:/usr/local/opx-build/scripts"

RUN sed -i "/# If not running interactively, don't do anything/,/^\s*$/{d}" \
    /etc/skel/.bashrc

# Launch into an interactive shell
CMD ["bash", "-l"]

# vi:syntax=dockerfile
