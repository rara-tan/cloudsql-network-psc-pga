resource "google_sql_database_instance" "sql" {
  project          = var.project_id
  name             = "sql"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main_network.id
    }
  }
  deletion_protection = false
}

resource "google_sql_database_instance" "db" {
  project          = var.project_id
  name             = "db"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    availability_type = "REGIONAL"
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    ip_configuration {
      psc_config {
        psc_enabled               = true
        allowed_consumer_projects = [var.project_id]
      }
      ipv4_enabled    = false
    }
  }
  deletion_protection = false
}
