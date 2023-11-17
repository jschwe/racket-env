ARG UBUNTU_VERSION=22.04
FROM public.ecr.aws/ubuntu/ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

# unix-signals requires an isntalled linker
RUN apt-get update \
    && apt-get install -y --no-install-recommends sqlite3 \
        curl \
        ca-certificates \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

RUN curl -fSL https://download.racket-lang.org/installers/8.10/racket-8.10-x86_64-linux-cs.sh \
    -o /racket.sh \
    && chmod +x /racket.sh \
    && /racket.sh --unix-style --dest /usr/local/racket \
    && rm /racket.sh

ENV PATH=/usr/local/racket/bin:${PATH}

RUN yes | raco pkg install quickcheck fmt unix-signals
