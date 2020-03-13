FROM ubuntu:18.04
MAINTAINER Ray X <rxuofficeworks@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
    # Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    # Install nodejs
    apt-get install -qy nodejs && \
    # Install pip
    apt-get install python-pip -y && \
    # Cleanup old packages
    apt-get -qy autoremove && \
    # Add user jenkins to the image
    adduser --quiet jenkins \
    # Set password for the jenkins user (you may want to alter this).
    && echo "jenkins:jenkins" | chpasswd
    # mkdir /home/jenkins/.m2

# Install sceptre
RUN pip install sceptre -U

# ADD settings.xml /home/jenkins/.m2/
# Copy authorized keys
# COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

# RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
#     chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]