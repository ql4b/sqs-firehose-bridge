# sqs-firehose-bridge

> Lambda container image for bridging SQS messages to Kinesis Data Firehose

Pre-built Lambda function that reads messages from SQS and forwards them to Kinesis Data Firehose for analytics pipelines. Used by [terraform-aws-firehose-analytics](https://github.com/ql4b/terraform-aws-firehose-analytics) module.

## Usage

This image is published to public ECR and designed to be copied to your private ECR repository:

```bash
# Get your private ECR repository URL from Terraform output
private_image="$(terraform output -json analytics | jq -r .sqs_bridge_ecr.repository_url):latest"

# Copy public image to your private repository
docker tag public.ecr.aws/ql4b/sqs-firehose-bridge:latest $private_image
docker push $private_image
```

## Environment Variables

- `FIREHOSE_STREAM_NAME` - Name of the Kinesis Data Firehose stream
- `AWS_REGION` - AWS region (automatically set by Lambda)

## Architecture

```
SQS Queue → Lambda (this image) → Kinesis Data Firehose → S3/OpenSearch
```

The Lambda function:
1. Polls SQS queue for messages
2. Batches messages for efficiency
3. Forwards to Firehose using `PutRecordBatch`
4. Handles errors and retries

## Integration

This image is automatically used by the [terraform-aws-firehose-analytics](https://github.com/ql4b/terraform-aws-firehose-analytics) Terraform module. No manual configuration required.

## Runtime

- **Base**: [lambda-shell-runtime](https://github.com/ql4b/lambda-shell-runtime)
- **Language**: Shell script with AWS CLI
- **Architecture**: ARM64/x86_64

## License

MIT