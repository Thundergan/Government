#!/bin/bash

# Detect the shell being used
CURRENT_SHELL=$(basename "$SHELL")

# Function to get the available Go versions
get_go_versions() {
    echo "Fetching available Go versions..."
    # List available Go versions from the official Go page, and sort them correctly
    wget -qO- https://go.dev/dl/ | grep -oP 'go[0-9]+\.[0-9]+\.[0-9]+' | sort -Vu
}

# Function to install the selected Go version
install_go_version() {
    local version="$1"
    local temp_dir=$(mktemp -d)

    # Determine the platform architecture
    arch=$(uname -m)
    if [[ "$arch" == "x86_64" ]]; then
        arch="amd64"
    elif [[ "$arch" == "aarch64" ]]; then
        arch="arm64"
    else
        echo "Unsupported architecture: $arch"
        exit 1
    fi

    # Define the URL for the Go tarball
    go_url="https://golang.org/dl/${version}.linux-${arch}.tar.gz"

    echo "Downloading $version from $go_url..."
    wget -q -P "$temp_dir" "$go_url"

    if [[ $? -ne 0 ]]; then
        echo "Error downloading Go version $version"
        rm -rf "$temp_dir"
        exit 1
    fi

    # Remove any existing Go installation
    sudo rm -rf /usr/local/go

    # Extract the downloaded tarball and move to /usr/local
    echo "Installing $version..."
    sudo tar -C /usr/local -xzf "$temp_dir/${version}.linux-${arch}.tar.gz"

    # Clean up the temporary files
    rm -rf "$temp_dir"

    # Set up Go environment variables based on the current shell
    echo "Setting up Go environment variables..."
    if [[ "$CURRENT_SHELL" == "bash" ]]; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    elif [[ "$CURRENT_SHELL" == "zsh" ]]; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
    fi

    # Inform the user to source the relevant shell configuration
    echo "Go installation complete."
    if [[ "$CURRENT_SHELL" == "bash" ]]; then
        echo "Please run 'source ~/.bashrc' to update your environment."
    elif [[ "$CURRENT_SHELL" == "zsh" ]]; then
        echo "Please run 'source ~/.zshrc' to update your environment."
    fi

    # Confirm installation
    export PATH=$PATH:/usr/local/go/bin
    go version
}

# Main script
echo "Available Go versions:"
available_versions=$(get_go_versions)

# Display the versions in a multi-column format using column
echo "$available_versions" | column

# Prompt the user to select a version
echo "Please enter the Go version to install (e.g., 1.20.7):"
read version_input

selected_version="go$version_input"
if echo "$available_versions" | grep -q "$selected_version"; then
    install_go_version "$selected_version"
else
    echo "Invalid version selected. Exiting..."
    exit 1
fi

