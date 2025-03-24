# Use the postgres-flex:16.6 as the base image
FROM docker-hub-mirror.fly.io/flyio/postgres-flex:16.6

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libpq-dev

# Clone the pgvector repository
RUN cd /tmp && \
    git clone --branch v0.8.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install

# Clean up build dependencies
RUN apt-get remove -y build-essential git curl libpq-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Expose the default PostgreSQL port
EXPOSE 5432

# Start PostgreSQL
CMD ["postgres"]
