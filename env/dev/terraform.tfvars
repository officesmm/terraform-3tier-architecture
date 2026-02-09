region = "ap-northeast-1"
name   = "mix-three-tier-dev"

azs = ["ap-northeast-1a", "ap-northeast-1d", "ap-northeast-1c"]
cf_domain_names  = ["dev-admin.mmcloudbet.com", "dev-agent.mmcloudbet.com"]
hosted_zone_name = "mmcloudbet.com"

s3_bucket_arn    = "arn:aws:s3:::mix-dev-3tier-architecture"
