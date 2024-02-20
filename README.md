
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | `"eu-central-1"` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | VCP VARIABLES | `string` | n/a | yes |
| <a name="input_ec2_name"></a> [ec2\_name](#input\_ec2\_name) | n/a | `string` | n/a | yes |
| <a name="input_ec2_type"></a> [ec2\_type](#input\_ec2\_type) | n/a | `string` | n/a | yes |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_eks_node_group_name"></a> [eks\_node\_group\_name](#input\_eks\_node\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_eks_node_role_name"></a> [eks\_node\_role\_name](#input\_eks\_node\_role\_name) | n/a | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | n/a | `string` | n/a | yes |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | Path to the private key file for SSH connection | `any` | n/a | yes |
| <a name="input_rt_cidr_block"></a> [rt\_cidr\_block](#input\_rt\_cidr\_block) | n/a | `string` | n/a | yes |
| <a name="input_subnet_cidr_blocks"></a> [subnet\_cidr\_blocks](#input\_subnet\_cidr\_blocks) | List of CIDR blocks for subnets | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_instance_ids"></a> [ec2\_instance\_ids](#output\_ec2\_instance\_ids) | n/a |
| <a name="output_subnet_1_id"></a> [subnet\_1\_id](#output\_subnet\_1\_id) | SUBNETS LOG |
| <a name="output_subnet_2_id"></a> [subnet\_2\_id](#output\_subnet\_2\_id) | n/a |
| <a name="output_subnet_3_id"></a> [subnet\_3\_id](#output\_subnet\_3\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the created VPC |
