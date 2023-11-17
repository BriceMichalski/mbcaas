resource "truenas_dataset" "ssd_k8s" {
  pool = "SSD"
  name = "k8s"
  comments = "SSD root dataset for k8s"

}

# Block
resource "truenas_dataset" "ssd_k8s_block" {
  pool = "SSD"
  name = "block"
  parent = "k8s"
  comments = "Dataset for k8s SSD block storage"

  depends_on = [
    truenas_dataset.ssd_k8s
  ]
}

resource "truenas_dataset" "ssd_k8s_block_volume" {
  pool = "SSD"
  name = "volume"
  parent = "k8s/block"
  comments = "Dataset for k8s SSD block storage volumes"

  depends_on = [
    truenas_dataset.ssd_k8s_block
  ]
}

resource "truenas_dataset" "ssd_k8s_block_snapshot" {
  pool = "SSD"
  name = "snapshot"
  parent = "k8s/block"
  comments = "Dataset for k8s SSD block storage snaphot"

  depends_on = [
    truenas_dataset.ssd_k8s_block
  ]
}

# File
resource "truenas_dataset" "ssd_k8s_file" {
  pool = "SSD"
  name = "file"
  parent = "k8s"
  comments = "SSD root dataset for k8s"

  depends_on = [
    truenas_dataset.ssd_k8s
  ]
}

resource "truenas_dataset" "ssd_k8s_file_volume" {
  pool = "SSD"
  name = "volume"
  parent = "k8s/file"
  comments = "Dataset for k8s SSD file storage volumes"

  depends_on = [
    truenas_dataset.ssd_k8s_file
  ]
}

resource "truenas_dataset" "ssd_k8s_file_snapshot" {
  pool = "SSD"
  name = "snapshot"
  parent = "k8s/file"
  comments = "Dataset for k8s SSD file storage snaphot"

  depends_on = [
    truenas_dataset.ssd_k8s_file
  ]
}
