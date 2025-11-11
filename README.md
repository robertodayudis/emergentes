# Perfumes Store – AWS ECS Deployment

Landing page estática desplegada en AWS utilizando Docker, Amazon ECR, Amazon ECS (Fargate) y AWS CloudFormation.

## Descripción del proyecto

El proyecto implementa una **landing page para una perfumería**, desarrollada con HTML y CSS, servida a través de **Nginx** dentro de un contenedor Docker.  
La infraestructura fue construida mediante **CloudFormation** y desplegada en AWS siguiendo buenas prácticas de infraestructura como código (IaC).

### Componentes principales

- **app/index.html y app/styles.css**: Definen la estructura y el estilo de la landing page.  
- **app/Dockerfile**: Define la imagen Docker con Nginx que servirá el contenido estático.  
- **aws/Network.yaml**: Crea la VPC, subredes públicas, Internet Gateway, route tables y grupos de seguridad.  
- **aws/Registry.yaml**: Crea el repositorio ECR donde se almacena la imagen del proyecto.  
- **aws/Container.yaml**: Crea el cluster ECS, la definición de tarea, el servicio Fargate y el Application Load Balancer (ALB).  

---

## Despliegue

### 1. Construcción y publicación de la imagen

```bash
docker build -t perfumes:1.0.1 app
docker tag perfumes:1.0.1 <ACCOUNT_ID>.dkr.ecr.sa-east-1.amazonaws.com/perfumes-app:1.0.1
aws ecr get-login-password --region sa-east-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.sa-east-1.amazonaws.com
docker push <ACCOUNT_ID>.dkr.ecr.sa-east-1.amazonaws.com/perfumes-app:1.0.1
```

### 2. Despliegue de la red

```bash
aws cloudformation deploy   --region sa-east-1   --stack-name perfumes-network   --template-file aws/Network.yaml   --capabilities CAPABILITY_NAMED_IAM
```

### 3. Creación del registro (ECR)

```bash
aws cloudformation deploy   --region sa-east-1   --stack-name perfumes-registry   --template-file aws/Registry.yaml   --parameter-overrides RepositoryName=perfumes-app   --capabilities CAPABILITY_NAMED_IAM
```

### 4. Despliegue del contenedor

```bash
aws cloudformation deploy   --region sa-east-1   --stack-name perfumes-container   --template-file aws/Container.yaml   --parameter-overrides ImageUri=<ACCOUNT_ID>.dkr.ecr.sa-east-1.amazonaws.com/perfumes-app:1.0.1   --capabilities CAPABILITY_NAMED_IAM
```

### 5. Acceso a la aplicación

Una vez completado el despliegue, se puede acceder a la aplicación mediante la URL generada por el Load Balancer:

```
Clouder-ALB-2145471118.us-east-1.elb.amazonaws.com
```



---

## Recursos creados

- **ECR Repository:** perfumes-app  
- **Cluster ECS:** perfumes-cluster  
- **Service:** perfumes-container  
- **Application Load Balancer:** perfumes-alb  
- **Región:** sa-east-1 (São Paulo)

---

## Autores

- Roberto Acosta  
- Maria Mendoza  
- Diego Romero  
- Kevin Valiente  
