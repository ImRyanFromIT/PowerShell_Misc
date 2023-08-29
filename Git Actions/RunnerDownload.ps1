# Create a folder under the drive root a
mkdir actions-runner; cd actions-runner
# Download the latest runner package
Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.308.0/actions-runner-win-x64-2.308.0.zip -OutFile actions-runner-win-x64-2.308.0.zip
# Optional: Validate the hash
if((Get-FileHash -Path actions-runner-win-x64-2.308.0.zip -Algorithm SHA256).Hash.ToUpper() -ne '05aa7d07223e7591f138db5a6a5f1b6f24ed22ab8b539307a6cf899f377f320f'.ToUpper()){ throw 'Computed checksum did not match' }
# Extract the installer
Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.308.0.zip", "$PWD")
