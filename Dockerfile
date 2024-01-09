# Use the specified Kali Linux image
FROM kasmweb/kali-rolling-desktop:1.14.0

# Expose the port on which NoVNC runs (6901 inside the container)
EXPOSE 6901

# Set the environment variable for screen resolution (adjust as needed)
ENV RESOLUTION=1366x768

# Start the command to run NoVNC with the specified password
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
