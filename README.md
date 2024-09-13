# Government - Go Version Management

**Government** is a Bash/Zsh-compatible script designed to manage the installation of different Go versions on your system. It fetches a list of available Go releases from the official Go website, lets you select a version to install, and handles the installation and setup automatically. The name is a playful pun on **Go** version management — where this "Government" ensures your Go environment is always up-to-date!

## Features
- Lists all available Go versions from the official [Go download page](https://go.dev/dl/).
- Installs the selected Go version for both `amd64` and `arm64` architectures.
- Cleans up temporary installation files.
- Updates your `~/.bashrc` (for `bash`) or `~/.zshrc` (for `zsh`) to add Go to your `PATH`.
- Ensures that your Go environment is set up with the selected version after installation.

## Prerequisites
- **Bash or Zsh shell**: The script auto-detects your shell and configures the environment accordingly.
- **wget** installed on your system.
- **sudo** privileges: The script installs Go globally in `/usr/local/go`.

## Installation

### 1. Clone the Repository
To install and use **Government**, clone this repository:
```bash
git clone https://github.com/Thundergan/government.git
cd government
```

### 2. Make the Script Executable
Change the permissions to make the script executable:
```bash
chmod +x government.sh
```

### 3. Run the Script
Execute the script:
```bash
./government.sh
```

### 4. Select a Go Version
The script will display a list of all available Go versions. Simply enter the version you'd like to install (e.g., `1.20.7`), and the script will take care of the rest.

Once the installation is complete, the Go binary path will be added to your environment, and you'll need to source your configuration file to apply the changes.

### 5. Reload Your Shell Configuration
To update your environment with the newly installed Go version, run the following command based on your shell:
- **For Bash**:
  ```bash
  source ~/.bashrc
  ```
- **For Zsh**:
  ```bash
  source ~/.zshrc
  ```

## Example Usage
Here’s an example of how you would use the **Government** script:

1. Run the script:
   ```bash
   ./government.sh
   ```

2. The script will fetch and display all available Go versions:
   ```bash
   Available Go versions:
   go1.20.1  go1.20.2  go1.20.3  go1.21.0  go1.21.1  ...
   ```

3. You will be prompted to enter the Go version you want to install:
   ```bash
   Please enter the Go version to install (e.g., 1.20.7):
   ```

4. Once selected, the script will:
   - Download the specified version.
   - Extract and install it to `/usr/local/go`.
   - Update your environment variables to include the new Go binary path.

## Troubleshooting

1. **Permission Denied Error**: Make sure you are running the script with `sudo` privileges, as it installs Go globally to `/usr/local/go`.
   
2. **wget Not Installed**: The script relies on `wget` to fetch Go releases. If you don't have it installed, you can install it using your package manager:
   - **Ubuntu/Debian**:
     ```bash
     sudo apt install wget
     ```
   - **CentOS/Fedora**:
     ```bash
     sudo yum install wget
     ```

3. **Go Not Found After Installation**: Ensure you've sourced your shell configuration file (`~/.bashrc` or `~/.zshrc`) after running the script:
   - **For Bash**: Run `source ~/.bashrc`
   - **For Zsh**: Run `source ~/.zshrc`

## Uninstallation

To uninstall a version of Go installed by **Government**, you can manually remove the Go installation directory:

```bash
sudo rm -rf /usr/local/go
```

Additionally, remove the line that was added to your `~/.bashrc` or `~/.zshrc`:
```bash
export PATH=$PATH:/usr/local/go/bin
```

## Contributing

Contributions are welcome! If you find any bugs or would like to propose new features, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

