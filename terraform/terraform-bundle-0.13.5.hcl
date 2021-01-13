terraform {
  version = "0.13.5"
}

providers {
  aws = {
    versions = ["~> 3.10"]
  }

  google = {
    versions = ["~> 3.49"]
  }

  helm = {
    versions = ["~> 1.3"]
  }

  external = {
    versions = ["~> 2.0"]
  }

  local = {
    versions = ["~> 1.4"]
  }

  template = {
    versions = ["~> 2.2"]
  }

  null = {
    versions = ["~> 3.0"]
  }
}
