# ec2-elb
hello
Role for deploying EC2 Elastic Load Balancers (ELB) required by OpenShift and SSO deployments

## Requirements

- AWS account required

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `vpc_name` | None       | String - VPC where to deploy ELBs | 
| `region` | None       | String - AWS region |
| `public_subnet_id` | None       | String - The AWS public subnet ID |

## Dependencies

- OpenShift Container Platform is deployed in the region with three masters
- IdM is deployed in the region

## Example Playbook

See the [AWS Infrastructure EC2 ELB](https://dccscr.dsop.io/levelup-automation/aws-infrastructure/blob/development/ec2-elb.yml)

## Testing

TBD

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.  Create an issue and generate a Merge Request with a branch to submit changes. 

## License

TBD

## Contributors

- LevelUP
