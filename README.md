## Packer Template for Ubuntu with R3 Corda Development Environment
#### Ubuntu Version Installed:  Ubuntu 16.04.5 Server (amd64)

### Requirements
These tools should be installed in your machine.

* Virtualbox
* Packer
* Vagrant

**Create a workspace for your packer configuration. Please refer to the directory structure on this repository**

This is a sample directory structure:
<pre>Packer/
  | ---- ubuntu16045.json
  | ---- http/
              | ---- preseed.cfg
  | ---- scripts/
              | ---- setup.sh
              | ---- curl.sh
              | ---- java.sh
              | ---- intellij.sh
              | ---- xubuntu-desktop.sh
              | ---- cleanup.sh
</pre>

#### Step 1
Create a json file named ubuntu16045.json and paste this inside your json file.
<pre>
{
    "variables": {
      "version": "1"
    },
    "provisioners": [
      {
        "type": "shell",
        "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
        "script": "scripts/setup.sh"
      },
      {
        "type": "shell",
        "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
        "script": "scripts/curl.sh"
      },
      {
        "type": "shell",
        "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
        "script": "scripts/java.sh"
      },
      {
        "type": "shell",
        "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
        "script": "scripts/intellij.sh"
      },
      {
        "type": "shell",
        "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
        "script": "scripts/xubuntu-desktop.sh"
      },
      {
        "type": "shell",
        "execute_command": "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'",
        "script": "scripts/cleanup.sh"
      }
    ],
    "builders": [
      {
        "type": "virtualbox-iso",
        "boot_command": [
          "<enter><wait><f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
          "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
          "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
          "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
          "/install/vmlinuz<wait>",
          " auto<wait>",
          " console-setup/ask_detect=false<wait>",
          " console-setup/layoutcode=us<wait>",
          " console-setup/modelcode=pc105<wait>",
          " debconf/frontend=noninteractive<wait>",
          " debian-installer=en_US<wait>",
          " fb=false<wait>",
          " initrd=/install/initrd.gz<wait>",
          " kbd-chooser/method=us<wait>",
          " keyboard-configuration/layout=USA<wait>",
          " keyboard-configuration/variant=USA<wait>",
          " locale=en_US<wait>",
          " netcfg/get_domain=vm<wait>",
          " netcfg/get_hostname=vagrant<wait>",
          " grub-installer/bootdev=/dev/sda<wait>",
          " noapic<wait>",
          " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
          " -- <wait>",
          "<enter><wait>"
        ],
        "boot_wait": "10s",
        "disk_size": 150000,
        "guest_os_type": "Ubuntu_64",
        "headless": false,
        "http_directory": "http",
        "iso_urls": [
          "iso/ubuntu-16.04.5-server-amd64.iso",
          "http://releases.ubuntu.com/16.04/ubuntu-16.04.5-server-amd64.iso"
        ],
        "iso_checksum_type": "sha256",
        "iso_checksum": "c94de1cc2e10160f325eb54638a5b5aa38f181d60ee33dae9578d96d932ee5f8",
        "ssh_username": "vagrant",
        "ssh_password": "vagrant",
        "ssh_port": 22,
        "ssh_wait_timeout": "10000s",
        "shutdown_command": "echo 'vagrant'|sudo -S shutdown -P now",
        "guest_additions_path": "VBoxGuestAdditions_{{.Version}}.iso",
        "virtualbox_version_file": ".vbox_version",
        "vm_name": "corda-packer",
        "vboxmanage": [
          [
            "modifyvm",
            "{{.Name}}",
            "--memory",
            "4096"
          ],
          [
            "modifyvm",
            "{{.Name}}",
            "--cpus",
            "1"
          ]
        ]
      }
    ],
    "post-processors": [
      [
        {
          "output": "builds/{{.Provider}}-ubuntu1604.box",
          "type": "vagrant"
        }
      ]
    ]
  }
</pre>

Save your file then exit.

#### Step 2

Create a preseed.cfg file under the **http** folder then paste this inside your file.

<pre>
choose-mirror-bin mirror/http/proxy string
d-i base-installer/kernel/override-image string linux-server
d-i clock-setup/utc boolean true
d-i clock-setup/utc-auto boolean true
d-i finish-install/reboot_in_progress note
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i partman-auto/disk string /dev/sda
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman-auto/method string lvm
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-lvm/device_remove_lvm boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/confirm_write_new_label boolean true
d-i pkgsel/include string openssh-server cryptsetup build-essential libssl-dev libreadline-dev zlib1g-dev linux-source dkms nfs-common
d-i pkgsel/install-language-support boolean false
d-i pkgsel/update-policy select none
d-i pkgsel/upgrade select full-upgrade
d-i time/zone string UTC
tasksel tasksel/first multiselect standard, ubuntu-server

d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/layoutcode string us
d-i keyboard-configuration/modelcode string pc105
d-i debian-installer/locale string en_US

# Create vagrant user account.
d-i passwd/user-fullname string vagrant
d-i passwd/username string vagrant
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false
d-i passwd/user-default-groups vagrant sudo
d-i passwd/user-uid string 900
</pre>

Save your file and exit.

#### Step 3
Download all the **.sh** files in the scripts folder in this repository then copy and paste it to your scripts folder.
In this case, we will install the development tools for corda r3.

#### Step 4
At this point, we are done setting up.
Open the terminal inside your **Packer** folder
Run **packer validate ubuntu16045.json** to validate if your template is valid
Run **packer build ubuntu16045.json** to build the image using our template

![alt text](https://github.com/jenriellegaon/packer-ubuntu-corda/blob/master/screenshots/snapshot.png)


Wait until the everything is completed. A vagrant box file will be generated inside the **builds** folder in your **Packer** directory.

## Testing:
#### Option1: Vagrant
Use the **virtualbox-ubuntu1604.box** inside your **builds** folder that is generated after a successful packer build.


#### Option2: Virtualbox
Extract the **virtualbox-ubuntu1604.box** in a directory of your choice then open virtualbox.
Under **File** click **Import Appliance** or simply use the keyboard shortcut **Ctrl + I** then locate the **box.ovf** file inside the folder where you extract the **box** file.
Start your **corda-packer** VM to test if everything works.

#### Credentials:
##### Username: vagrant
##### Password: vagrant


### Credits to:
##### https://www.serverlab.ca/tutorials/dev-ops/automation/how-to-use-packer-to-create-ubuntu-18-04-vagrant-boxes/?fbclid=IwAR1CgDELB9hwjWlrrvGHJJWX6iOKmnaPU2karzwU6R-UtuR7qZTVf0tUdYs**

##### https://github.com/chef/bento/tree/master/ubuntu**
