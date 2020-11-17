FROM gcr.io/distroless/static

ADD user-management ./
ENTRYPOINT ["./user-management"]
EXPOSE 9084
