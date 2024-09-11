# Etapa 1: Construção da aplicação
FROM eclipse-temurin:21-jdk AS builder

# Definir diretório de trabalho
WORKDIR /app

# Copiar o arquivo de configuração do Maven (pom.xml)
COPY ./pom.xml ./

# Copiar a pasta .mvn (caso exista) e o arquivo mvnw (wrapper do Maven)
COPY .mvn/ .mvn
COPY mvnw .

# Baixar dependências necessárias (etapa de cache)
RUN ./mvnw dependency:go-offline

# Copiar o código-fonte da aplicação
COPY ./src ./src

# Construir a aplicação sem executar os testes
RUN ./mvnw clean package -DskipTests

# Etapa 2: Criar uma imagem JRE minimalista com jlink
FROM eclipse-temurin:21-jdk AS jre-builder

RUN $JAVA_HOME/bin/jlink \
    --module-path $JAVA_HOME/jmods \
    --add-modules java.base,java.compiler,java.desktop,java.instrument,java.management,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.security.jgss,java.sql,jdk.jfr,jdk.unsupported \
    --output /custom-jre \
    --compress=2


# Etapa 3: Imagem final minimalista
FROM debian:bullseye-slim

# Criar um grupo e usuário não-root para rodar a aplicação
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Instalar dependências mínimas
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copiar o JRE minimalista criado na etapa anterior
COPY --from=jre-builder /custom-jre /opt/jre

# Copiar o JAR da aplicação da etapa de construção
COPY --from=builder /app/target/*.jar /app/app.jar

# Copiar o certificado keystore para o local correto
COPY src/main/resources/ssl/helloworld-keystore.p12 /app/ssl/helloworld-keystore.p12

# Definir permissões de execução
RUN chown -R appuser:appgroup /app
USER appuser

# Expor a porta 8443
EXPOSE 8443

# Definir o comando de execução da aplicação
ENTRYPOINT ["/opt/jre/bin/java", "-jar", "/app/app.jar"]