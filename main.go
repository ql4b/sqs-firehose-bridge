package main

import (
	"context"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/firehose"
	"github.com/aws/aws-sdk-go-v2/service/firehose/types"
)

func handler(ctx context.Context, event events.SQSEvent) error {
	cfg, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		return err
	}

	client := firehose.NewFromConfig(cfg)
	streamName := os.Getenv("FIREHOSE_STREAM_NAME")

	records := make([]types.Record, len(event.Records))
	for i, record := range event.Records {
		records[i] = types.Record{Data: []byte(record.Body)}
	}

	if len(records) > 0 {
		_, err = client.PutRecordBatch(ctx, &firehose.PutRecordBatchInput{
			DeliveryStreamName: &streamName,
			Records:            records,
		})
		return err
	}

	return nil
}

func main() {
	lambda.Start(handler)
}
