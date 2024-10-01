resource "proxmox_vm_qemu" "terraform-test-vm" {
    name = "terraform-test-vm"
    desc = "A test for using terraform and cloudinit"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = var.pm_node_name

    # The template name to clone this vm from
    clone = var.template_vm_name

    # Activate QEMU agent for this VM
    # Should only be used if you use an image that already has the agent installed
    # or if you extend your clound init and install it during initialization.
    # Otherwise terraform will fail with a timeout waiting for the agent to become active.
    agent = 0

    os_type = "cloud-init"
    cores = 2
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 2048
    scsihw = "virtio-scsi-pci"

    # Do not forget to enable console output
    serial {
      id = 0
    }

    # Setup the disk
    disks {
      ide {
        ide2 {
          cloudinit {
              storage = "local-lvm"
          }
        }
      }
      scsi {
        scsi0 {
          disk {
            size    = "32G"
            storage = "local-lvm"
          }
        }
      }
    }

    # Setup the network interface
    network {
        model = "virtio"
        bridge = "vmbr0"
    }
    
    # Specify the boot order
    # Needs to include the cloud-init drive (or seems to...)
    boot = "order=scsi0;ide2"

    # Set the cloud init values (user, password, sshkey/s)
    ciuser      = var.pm_ci_user
    cipassword  = var.pm_ci_password
    sshkeys     = var.pm_ci_sshkeys

    ciupgrade   = false # Set to "true" to do an automatic package upgrade after the first boot

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation as well as adding the gateway if using a static ip.
    ipconfig0 = "ip=dhcp"
}