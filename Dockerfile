#R base image
FROM rocker/r-ver:latest

# system libraries of general use
## install debian packages
RUN \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Install libnlopt-dev
RUN apt-get update && apt-get install -y libnlopt-dev

## Copy renv.lock
COPY renv.lock ./renv.lock

RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::restore()'