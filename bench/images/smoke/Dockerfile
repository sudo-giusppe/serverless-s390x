# Imagen mínima multi-arquitectura para validar el pipeline buildx (amd64 + s390x).
# No es una función de benchmark: solo prueba que podemos construir para s390x.
FROM alpine:3.20

COPY app.sh /app.sh
RUN chmod +x /app.sh

ENTRYPOINT ["/app.sh"]
