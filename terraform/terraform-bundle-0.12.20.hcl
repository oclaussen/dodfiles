terraform {
  version = "0.12.20"
}

providers {
  aws      = ["~> 2.39"]
  external = ["~> 1.2"]
  local    = ["~> 1.3"]
  template = ["~> 2.1"]
  null     = ["~> 2.1"]
}
