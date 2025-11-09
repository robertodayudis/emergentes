# Perfumes Store – AWS ECS Deployment

Landing page estática desplegada en AWS usando Docker, ECR, ECS (Fargate) y CloudFormation.

## Descripción
El proyecto implementa una landing page simple (HTML + CSS) servida por **Nginx** dentro de un contenedor **Docker**.  
La infraestructura se define como código mediante **CloudFormation**, siguiendo la estructura propuesta en el trabajo práctico:

- **Network.yaml:** crea la VPC, subnets públicas, internet gateway y security groups.
- **Container.yaml:** crea el cluster ECS, la task definition, el service y el Application Load Balancer (ALB).
- **Dockerfile:** define la imagen Nginx para servir los archivos estáticos.
- **index.html / styles.css:** contenido de la landing.
- **ECR:** almacena la imagen Docker `perfumes:1.0.0`.
- **ECS Fargate:** ejecuta la tarea y publica el servicio a través del ALB.

---

## Despliegue

1. **Construir la imagen y subirla a ECR**

   docker build -t perfumes:1.0.0 .
   docker tag perfumes:1.0.0 <ACCOUNT_ID>.dkr.ecr.sa-east-1.amazonaws.com/perfumes:1.0.0
   docker push <ACCOUNT_ID>.dkr.ecr.sa-east-1.amazonaws.com/perfumes:1.0.0
Desplegar la red


aws cloudformation deploy \
  --region sa-east-1 \
  --stack-name perfumes-network \
  --template-file Network.yaml \
  --capabilities CAPABILITY_NAMED_IAM
Desplegar el contenedor


aws cloudformation deploy \
  --region sa-east-1 \
  --stack-name perfumes-container \
  --template-file Container.yaml \
  --parameter-overrides ImageUri=<ECR_IMAGE_URI> \
  --capabilities CAPABILITY_NAMED_IAM
Acceder a la aplicación

arduino
Copy code
http://perfumes-alb-788758788.sa-east-1.elb.amazonaws.com/
📎 Recursos creados
ECR repo: perfumes

Cluster ECS: perfumes-cluster

Service: perfumes-container

ALB público: perfumes-alb

Región: sa-east-1 (São Paulo)

👥 Autores
- Roberto Acosta

Estado actual
Funciona correctamente sobre HTTP.

Próximos pasos opcionales:

Agregar HTTPS con AWS Certificate Manager.

Incorporar backend /api y base de datos.
