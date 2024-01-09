# Use the latest Windows base image
FROM windows:latest

# Set the working directory
WORKDIR C:/actions-runner

# Download and install Git
RUN Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe -OutFile Git-2.34.1-64-bit.exe -UseBasicParsing ; \
    Start-Process -Wait -FilePath .\Git-2.34.1-64-bit.exe -ArgumentList "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /LOG=`"C:\GitInstall.log`"" ; \
    Remove-Item -Force Git-2.34.1-64-bit.exe

# Download and install the GitHub Actions runner
RUN Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-win-x64-2.311.0.zip -OutFile actions-runner-win-x64-2.311.0.zip ; \
    $checksum = (Get-FileHash -Path actions-runner-win-x64-2.311.0.zip -Algorithm SHA256).Hash; \
    if ($checksum -ne 'e629628ce25c1a7032d845f12dfe3dced630ca13a878b037dde77f5683b039dd') { throw 'Computed checksum did not match' }; \
    Add-Type -AssemblyName System.IO.Compression.FileSystem ; \
    [System.IO.Compression.ZipFile]::ExtractToDirectory('actions-runner-win-x64-2.311.0.zip', '.') ; \
    Remove-Item -Force actions-runner-win-x64-2.311.0.zip

# Configure the GitHub Actions runner
RUN Start-Process -Wait -FilePath .\config.cmd -ArgumentList '--unattended', '--url', 'https://github.com/rabytebuild/pabodia', '--token', 'A3UD6EMBBCUJ7VLQ5XLXYZDFTSVIQ'

# Start the GitHub Actions runner
CMD ["./run.cmd"]
