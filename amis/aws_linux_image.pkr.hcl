source "amazon-ebs" "ubuntu-image" {
  ami_name = "${var.owner}-ubuntu-vault-cli-{{timestamp}}"
  region = "${var.aws_region}"
  instance_type = var.aws_instance_type
#   ami_groups = ["all"] # makes AMI public
  tags = {
    Name = "${var.owner}-ubuntu-vault-cli-{{timestamp}}"
    VaultVersion = "${var.vault_version}"
  }
  source_ami_filter {
      filters = {
        virtualization-type = "hvm"
        name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
        // name = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
        // name = "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"
        root-device-type = "ebs"
      }
      owners = [var.ami_owner_id]
      most_recent = true
  }
  communicator = "ssh"
  ssh_username = "ubuntu"
}

build {
  sources = [
    "source.amazon-ebs.ubuntu-image"
  ]

  provisioner "shell" {
    environment_vars = [
      "VAULT_VERSION=${var.vault_version}"
    ]
    inline = [
      "sleep 10",
      
      # Update system packages
      "sudo apt-get update",
      
      # Install required packages
      "sudo apt-get install -y wget curl unzip gpg",
      
      # Download and install specific Vault version
      "echo \"Installing Vault CLI version: $VAULT_VERSION\"",
      "wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_$${VAULT_VERSION}_linux_amd64.zip",
      
      # Verify checksum (optional but recommended)
      "wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_$${VAULT_VERSION}_SHA256SUMS",
      "wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_$${VAULT_VERSION}_SHA256SUMS.sig",
      
      # Import HashiCorp GPG key for verification
      "curl -s https://keybase.io/hashicorp/pgp_keys.asc | gpg --import",
      
      # Verify signature (optional but recommended for production)
      "gpg --verify vault_$${VAULT_VERSION}_SHA256SUMS.sig vault_$${VAULT_VERSION}_SHA256SUMS",
      
      # Verify checksum
      "grep vault_$${VAULT_VERSION}_linux_amd64.zip vault_$${VAULT_VERSION}_SHA256SUMS | sha256sum -c",
      
      # Extract and install Vault
      "unzip vault_$${VAULT_VERSION}_linux_amd64.zip",
      "sudo mv vault /usr/local/bin/",
      "sudo chmod +x /usr/local/bin/vault",
      
      # Create symlink for system-wide access
      "sudo ln -sf /usr/local/bin/vault /usr/bin/vault",
      
      # Verify installation
      "vault version",
      
      # Install additional useful tools
      "sudo apt-get install -y jq tree htop",
      
      # Clean up downloaded files
      "rm -f vault_$${VAULT_VERSION}_linux_amd64.zip",
      "rm -f vault_$${VAULT_VERSION}_SHA256SUMS*",
      
      # Clean up package cache
      "sudo apt-get clean",
      "sudo apt-get autoremove -y"
    ]
  }
}