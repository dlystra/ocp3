# s3-bucket

Create and destroy S3 buckets

## Requirements

- AWS account required

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `region` | None       | String - AWS region |
| `s3_bucket_name` | test-s3-bucket | String - The AWS bucket name |
| `marked_for_decommission` | None | Boolean -  True to destroy bucket, renamed as ec2_instance_destroy var in defaults |
| `ec2_instance_destroy` | Value of marked_for_decommission var  | Boolean -  True to destroy bucket |

## Dependencies

None.

## Example Playbook

See the [AWS Infrastructure OpenShift Function](https://dccscr.dsop.io/levelup-automation/aws-infrastructure/blob/development/environments/shared/group_vars/tag_Function_Openshift.yml)

## Testing

TBD

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.  Create an issue and generate a Merge Request with a branch to submit changes. 

## License

TBD

## Contributors

- LevelUP