# terraform-aws-aurora

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-aurora/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-aurora)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-aurora.svg)](https://github.com/JamesWoolfenden/terraform-aws-aurora/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-aurora.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-aurora/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-aws-aurora/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-aurora&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-aws-aurora/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-aurora&benchmark=INFRASTRUCTURE+SECURITY)

Terraform module - creates Aurpora cluster and instances

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

This is just a basic illustration of the resources.

Include this repository as a module in your existing terraform code:

```terraform
module "aurora" {
  source          = "JamesWoolfenden/aurora/aws"
  version         = "0.0.2"
  common_tags     = var.common_tags
  instances       = var.instances
  cluster         = var.cluster
}
```

## Costs

Using the example.

```Text
Monthly cost estimate

Project: .

 Name                                                       Monthly Qty  Unit                    Monthly Cost

 aws_kms_key.aurora
 ├─ Customer master key                                               1  months                         $1.00
 ├─ Requests                                          Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                  Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                  Monthly cost depends on usage: $0.10 per 10k requests

 module.aurora.aws_rds_cluster.default
 ├─ Storage                                                           0  GB                             $0.00
 └─ I/O rate                                                          0  1M requests                    $0.00

 module.aurora.aws_rds_cluster_instance.instances[0]
 └─ Database instance (on-demand, db.r4.large)                      730  hours                        $248.20

 module.aurora.aws_rds_cluster_instance.instances[1]
 └─ Database instance (on-demand, db.r4.large)                      730  hours                        $248.20

 PROJECT TOTAL                                                                                        $497.40

```

## IAM Permissions

```json
{}
```

## IAC comparison

The makefile in the example runs 4 of the main IAC SAST tools:

- Checkov
- TFSec
- Terrascan
- Kics

You can run these as part of the validate scripts contained here and all 4 will output to the **output** folder.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_rds_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.examplea](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_availability_zones.zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `""` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Schedule your Backup retention and enable | `number` | `35` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | All the properties of an Aurora Cluster | `map(any)` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | This is to help you add tags to your cloud objects | `map(any)` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `true` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | Set of log types to export to cloudwatch. If omitted, no logs will be exported | `list(any)` | <pre>[<br>  "audit"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | n/a | `string` | `"aurora"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | `"5.7.mysql_aurora.2.03.2"` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Use IAM | `bool` | `true` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Settings of you database instances | `any` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | n/a | `string` | n/a | yes |
| <a name="input_master_password"></a> [master\_password](#input\_master\_password) | n/a | `string` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance | `string` | `1` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | n/a | `string` | `""` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | n/a | `string` | `"04:00-09:00"` | no |
| <a name="input_promotion_tier"></a> [promotion\_tier](#input\_promotion\_tier) | Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | n/a |
| <a name="output_instances"></a> [instances](#output\_instances) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-s3](https://github.com/jameswoolfenden/terraform-aws-s3) - S3 buckets

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-aurora/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-aurora/issues) to report any bugs or file feature requests.

## Copyrights

Copyright 2019-2021 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-aurora&url=https://github.com/JamesWoolfenden/terraform-aws-aurora
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-aurora&url=https://github.com/JamesWoolfenden/terraform-aws-aurora
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-aws-aurora
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-aws-aurora
[share_email]: mailto:?subject=terraform-aws-aurora&body=https://github.com/JamesWoolfenden/terraform-aws-aurora
