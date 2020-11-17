FROM gcr.io/distroless/static

ADD vendors ./
ENTRYPOINT ["./vendors"]
EXPOSE 9084
