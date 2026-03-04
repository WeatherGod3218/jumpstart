FROM ghcr.io/astral-sh/uv:python3.13-alpine
WORKDIR /usr/local/jumpstart

COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt --system

COPY jumpstart jumpstart

EXPOSE 5000

RUN adduser -u 1001 -S jumpstart

RUN chown jumpstart /usr/local/jumpstart
RUN mkdir -p /usr/local/var
RUN chown jumpstart /usr/local/var
USER jumpstart

CMD ["gunicorn", "jumpstart:app"]
