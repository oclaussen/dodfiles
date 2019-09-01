terraform {
  version = "0.11.14"
}

providers {
  aws      = ["~> 2.23"]
  local    = ["~> 1.3"]
  template = ["~> 2.1"]
  null     = ["~> 2.1"]
}
