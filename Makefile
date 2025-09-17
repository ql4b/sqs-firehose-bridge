build:
	GOOS=linux GOARCH=arm64 go build -o bootstrap main.go
	zip lambda.zip bootstrap

clean:
	rm -f bootstrap lambda.zip

.PHONY: build clean