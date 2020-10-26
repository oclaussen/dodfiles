terraform {
  version = "0.13.4"
}

providers {
  aws = {
    versions = ["~> 3.10"]
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
