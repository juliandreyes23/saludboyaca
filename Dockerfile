# Llama directamente a tu imagen desde Docker Hub
FROM julxreyes/saludboyaca-app:latest

# Exponemos el puerto que usa Tomcat
EXPOSE 8080

# El comando de ejecución ya viene definido en tu imagen original
CMD ["catalina.sh", "run"]
