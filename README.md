# Perfumes

Landing estática servida con Nginx en Docker.

## Ejecutar local
docker build -t perfumes:1.0.0 .
docker run --rm -p 8080:80 --name perfumes perfumes:1.0.0

## Próximos pasos
- Subir imagen a ECR (AWS)
- Desplegar ECS Fargate + ALB con CloudFormation
- Agregar backend (APIs) y base de datos
