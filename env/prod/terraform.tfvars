region = "ap-southeast-1"
name   = "mix-three-tier-prod"

azs = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
cf_domain_names  = ["admin.mmcloudbet.com","agent.mmcloudbet.com"]
hosted_zone_name = "mmcloudbet.com"

s3_bucket_arn    = "arn:aws:s3:::mix-prod-3tier-architecture"