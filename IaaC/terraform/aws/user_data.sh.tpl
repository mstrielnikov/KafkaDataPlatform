#!/bin/bash

sudo umount ${ebs_disk_path}

# Create a new partition table
sudo parted -s ${ebs_disk_path} mklabel gpt

# Create a new partition
sudo parted -s $ebs_disk_path mkpart primary 0% 100%

# Format the partition with XFS
sudo mkfs.xfs -f ${ebs_disk_path}1

# Mount the partition to ${ebs_disk_mount_point}
sudo mkdir -p ${ebs_disk_mount_point}
sudo mount ${ebs_disk_path}1 ${ebs_disk_mount_point}

# Add an entry to /etc/fstab to mount the partition on boot
echo "${ebs_disk_path}1  ${ebs_disk_mount_point}  xfs  defaults  0  0" | sudo tee -a /etc/fstab

echo "Disk formatted and mounted to ${ebs_disk_mount_point}"