FROM public.ecr.aws/ql4b/lambda-shell-runtime:full-1.0.0 

LABEL org.opencontainers.image.title="SQS to Firehose Bridge"
LABEL org.opencontainers.image.description="Lambda function that bridges SQS messages to Kinesis Data Firehose for analytics pipelines"
LABEL org.opencontainers.image.vendor="ql4b"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/ql4b/sqs-firehose-bridge"
LABEL org.opencontainers.image.documentation="https://github.com/ql4b/terraform-aws-firehose-analytics"
LABEL org.opencontainers.image.url="https://github.com/ql4b/terraform-aws-firehose-analytics"

WORKDIR /var/task

COPY task/handler.sh handler.sh