Para copiar sua imagem Docker para o **Harbor** (ou qualquer outro repositório Docker privado), você precisará seguir algumas etapas básicas. O processo inclui construir a imagem, fazer login no seu registro Harbor, marcar a imagem com o nome correto e empurrá-la para o Harbor.

Aqui está um guia passo a passo para copiar sua imagem Docker para o **Harbor** em `https://harbor.devops.spms.min-saude.pt/`.

### 1. **Login no Harbor**
O primeiro passo é fazer o login no seu registro Harbor. Use o seguinte comando:

```bash
docker login https://harbor.devops.spms.min-saude.pt
```

Você será solicitado a inserir seu nome de usuário e senha.

### 2. **Marcar a Imagem (Tagging)**
Antes de empurrar a imagem, você precisa marcá-la (tag) com o nome do registro Harbor.

A estrutura do nome deve ser:

```bash
<registry_url>/<project>/<repository>:<tag>
```

Por exemplo, se seu projeto no Harbor se chama **my-project**, o repositório da imagem se chama **my-spring-boot-app**, e a versão da imagem é **v1.0.0**, você usaria algo assim:

```bash
docker tag my-spring-boot-app:latest harbor.devops.spms.min-saude.pt/my-project/my-spring-boot-app:v1.0.0
```

### 3. **Enviar a Imagem (Push)**
Depois de marcar a imagem corretamente, você pode empurrá-la para o registro Harbor com o comando `docker push`:

```bash
docker push harbor.devops.spms.min-saude.pt/my-project/my-spring-boot-app:v1.0.0
```

### 4. **Verificar no Harbor**
Após a conclusão do `push`, você pode acessar o Harbor em `https://harbor.devops.spms.min-saude.pt` e verificar se a imagem está presente no repositório correto.

### Exemplo Completo

Aqui está um exemplo completo das etapas em sequência:

1. **Construa a imagem Docker:**

   ```bash
   docker build -t my-spring-boot-app .
   ```

2. **Faça login no Harbor:**

   ```bash
   docker login https://harbor.devops.spms.min-saude.pt
   ```

3. **Marque a imagem:**

   ```bash
   docker tag my-spring-boot-app:latest harbor.devops.spms.min-saude.pt/my-project/my-spring-boot-app:v1.0.0
   ```

4. **Empurre a imagem para o Harbor:**

   ```bash
   docker push harbor.devops.spms.min-saude.pt/my-project/my-spring-boot-app:v1.0.0
   ```

### Possíveis Problemas e Soluções

- **Problemas de login (certificado SSL)**: Se você estiver usando um certificado autofirmado no Harbor, pode ser necessário adicionar o certificado SSL do Harbor ao Docker ou usar a opção `--insecure-registry` na configuração do Docker.

- **Permissões**: Certifique-se de que você tenha permissões adequadas no projeto do Harbor onde está tentando enviar a imagem.

### Conclusão

Seguindo essas etapas, você poderá copiar sua imagem Docker para o Harbor com sucesso. Certifique-se de usar o nome do projeto e repositório corretos no Harbor para evitar erros de autenticação ou de nome de repositório.

### Baixar todas as dependências necessárias
```
./mvnw dependency:copy-dependencies
```


### Uso do JDEPS
- **Verifica dependencias da aplicação**
```
 jdeps --print-module-deps --ignore-missing-deps --multi-release 21 --class-path "target/dependency/*" .\target\helloworld-0.0.1-SNAPSHOT.jar
```

### Docker Builder
```
docker build -t spms-helloworld-app:v1.0.0 .

```
### Quickview of image
```
 docker scout quickview
```

### Docker Container
```
docker run --name helloworld-spms-app-container -p 8443:8443 helloworld-spms-app-image:1.0
```

### Registry Login
```
 docker login harbor.devops.spms.min-saude.pt
```

### Docker tag image and send to registry
```
 docker tag spms-helloworld-app:v1.0.0 harbor.devops.spms.min-saude.pt/servidorterminologias/spms-helloworld-app:v1.0.0
```

### Docker Push
```
docker push harbor.devops.spms.min-saude.pt/servidorterminologias/spms-helloworld-app:v1.0.0
```

### GIT
#### SSH
```
git remote add origin git@github.com:carnegiejunior/spms-helloworld.git
git push -u origin main

```

#### HTTPS
```
git remote add origin https://github.com/carnegiejunior/spms-helloworld.git
git branch -M main
```
