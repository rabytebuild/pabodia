# Use the base image
FROM kalilinux/kali-linux-docker

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y kali-linux-core kali-desktop-xfce && \
    apt-get clean

# Expose the port on which NoVNC runs (80 inside the container)
EXPOSE 80

# Set the environment variable for screen resolution
ENV RESOLUTION=1380x770

# Start the command to run NoVNC
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
