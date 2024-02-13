# Usa l'immagine di base di Alpine Linux
FROM alpine:latest

# Imposta la directory di lavoro
WORKDIR /app

# Installa curl, ca-certificates e unzip
RUN apk --no-cache add curl ca-certificates unzip

# Imposta una variabile d'ambiente per la versione di PocketBase, con un valore predefinito
ARG POCKETBASE_VERSION=0.3.0

# Scarica l'ultima versione di PocketBase utilizzando la variabile d'ambiente
RUN curl -L "https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip" -o pocketbase.zip \
    && unzip pocketbase.zip -d /app \
    && rm pocketbase.zip

# Rendi eseguibile il binario di PocketBase
RUN chmod +x /app/pocketbase

# Espone la porta predefinita su cui PocketBase ascolta
EXPOSE 8090

# Avvia PocketBase quando il container viene eseguito
CMD ["/app/pocketbase", "serve", "--http=0.0.0.0:8090"]
