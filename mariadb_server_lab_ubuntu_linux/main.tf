terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

resource "null_resource" "install_mariadb" {
  provisioner "local-exec" {
    command = <<EOF
      export DEBIAN_FRONTEND=noninteractive

      echo "Fixing interrupted dpkg processes..."
      sudo dpkg --configure -a

      echo "Fixing broken dependencies..."
      sudo apt install -f -y

      echo "Updating package list..."
      sudo apt update

      echo "Installing MariaDB server and MySQL client..."
      sudo apt install -y mariadb-server mariadb-client

      echo "Enabling MariaDB service to start on boot..."
      sudo systemctl enable mariadb

      echo "Starting MariaDB service..."
      sudo systemctl start mariadb

      echo "Verifying MariaDB service is running..."
      sudo systemctl is-active mariadb
    EOF
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      export DEBIAN_FRONTEND=noninteractive

      echo "Stopping MariaDB service..."
      sudo systemctl stop mariadb

      echo "Disabling MariaDB service..."
      sudo systemctl disable mariadb

      echo "Removing MariaDB packages..."
      sudo apt remove -y mariadb-server mariadb-client -q
    EOF
  }

  # Ensure this runs only once
  triggers = {
    always_run = timestamp()
  }
}

