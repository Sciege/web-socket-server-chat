# Base image with GLIBC >= 2.38 required by the Bonezegei engine
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install the Bonezegei Script Interpreter v1.3.3 from the bundled package
WORKDIR /app
COPY pkg/ ./pkg/
RUN apt-get update && apt-get install -y ./pkg/Bonezegei-x86.deb \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf ./pkg/

# Copy the project (app.bzg, package.json, public/, ...)
COPY . .

# Install the 'http' package declared in package.json
RUN bzg install

# WebSocket + HTTP share port 8000
EXPOSE 8000

CMD ["bzg", "run"]
