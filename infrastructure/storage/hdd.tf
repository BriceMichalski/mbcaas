resource "truenas_dataset" "hdd_k8s" {
  pool = "HDD"
  name = "k8s"
  comments = "HDD root dataset for k8s"

}

# Block
resource "truenas_dataset" "hdd_k8s_block" {
  pool = "HDD"
  name = "block"
  parent = "k8s"
  comments = "Dataset for k8s HDD block storage"

  depends_on = [
    truenas_dataset.hdd_k8s
  ]
}

resource "truenas_dataset" "hdd_k8s_block_volume" {
  pool = "HDD"
  name = "volume"
  parent = "k8s/block"
  comments = "Dataset for k8s HDD block storage volumes"

  depends_on = [
    truenas_dataset.hdd_k8s_block
  ]
}

resource "truenas_dataset" "hdd_k8s_block_snapshot" {
  pool = "HDD"
  name = "snapshot"
  parent = "k8s/block"
  comments = "Dataset for k8s HDD block storage snaphot"

  depends_on = [
    truenas_dataset.hdd_k8s_block
  ]
}

# File
resource "truenas_dataset" "hdd_k8s_file" {
  pool = "HDD"
  name = "file"
  parent = "k8s"
  comments = "HDD root dataset for k8s"

  depends_on = [
    truenas_dataset.hdd_k8s
  ]
}

resource "truenas_dataset" "hdd_k8s_file_volume" {
  pool = "HDD"
  name = "volume"
  parent = "k8s/file"
  comments = "Dataset for k8s HDD file storage volumes"

  depends_on = [
    truenas_dataset.hdd_k8s_file
  ]
}

resource "truenas_dataset" "hdd_k8s_file_snapshot" {
  pool = "HDD"
  name = "snapshot"
  parent = "k8s/file"
  comments = "Dataset for k8s HDD file storage snaphot"

  depends_on = [
    truenas_dataset.hdd_k8s_file
  ]
}
