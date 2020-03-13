FROM ubuntu:18.04
MAINTAINER Ray X <rxuofficeworks@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update \
    && apt-get install -qy curl \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-get install -qy nodejs \
    # Install pip
    && apt-get install python-pip -qy && \
    # Cleanup old packages
    apt-get -qy autoremove

# Install sceptre
RUN pip install sceptre -U