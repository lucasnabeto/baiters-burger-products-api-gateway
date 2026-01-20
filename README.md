# Baiter's Burger Products API Gateway

Este repositório é responsável por gerenciar o API Gateway para a API de produtos do Baiter's Burger. Ele utiliza o [OpenAPI 3.0](https://swagger.io/specification/) para definir os contratos da API e o [Terraform](https://www.terraform.io/) para provisionar a infraestrutura na AWS.

## Tecnologias

-   **OpenAPI 3.0:** Especificação para descrever, produzir, consumir e visualizar APIs RESTful.
-   **Terraform:** Ferramenta de infraestrutura como código (IaC) para provisionar e gerenciar a infraestrutura da nuvem.
-   **Redocly CLI:** Ferramenta para validar e agrupar as especificações do OpenAPI.
-   **AWS:** A plataforma de nuvem que hospeda todos os serviços.

## Arquitetura

-   **AWS API Gateway:** Serviço gerenciado da AWS para criar, publicar, manter, monitorar e proteger APIs em qualquer escala.
-   **AWS Lambda:** Utilizado para a função de autorização (`LambdaJWTAuthorizer`) que protege os endpoints da API.

## Endpoints da API

A seguir estão os endpoints disponíveis na API de produtos:

-   `POST /api/v1/products`: Registra um novo produto.
-   `GET /api/v1/products`: Lista os produtos por categoria.
-   `GET /api/v1/products/{product_id}`: Busca um produto pelo ID.
-   `PUT /api/v1/products/{product_id}`: Atualiza um produto existente.
-   `DELETE /api/v1/products/{product_id}`: Deleta um produto.

Todos os endpoints são protegidos e requerem um token JWT válido no cabeçalho `Authorization`.

## Integrações

Este API Gateway atua como um proxy para a aplicação principal de produtos, encaminhando as requisições para um Application Load Balancer (ALB) que, por sua vez, distribui a carga para a aplicação Java.

## Repositórios relacionados

Este projeto é parte de uma arquitetura de microsserviços. Os outros repositórios relevantes são:

-   **[baiters-burger-products-app](https://github.com/lucasnabeto/baiters-burger-products-app):** Contém a aplicação Java (Spring Boot) com a lógica de negócio para o gerenciamento de produtos.
-   **[baiters-burger-products-infra](https://github.com/lucasnabeto/baiters-burger-products-infra):** Provisiona a infraestrutura base para a aplicação de produtos, incluindo o Lambda Authorizer.

## Guia de uso

Para provisionar o API Gateway, siga os passos abaixo:

### Pré-requisitos:

-   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) instalado.
-   Credenciais da AWS configuradas.
-   O restante da infraestrutura (ALB, Lambda Authorizer, ECS, etc) deve ter sido provisionado anteriormente pelos repositórios `baiters-burger-products-infra` e `baiters-burger-products-app`, nessa ordem.

### Provisionando a infraestrutura

1. **Navegue até a pasta `infra`:**

    ```bash
    cd infra
    ```

2. **Inicialize o Terraform:**

    ```bash
    terraform init
    ```

3. **Planeje as alterações:**

    ```bash
    terraform plan
    ```

4. **Aplique as alterações:**
    ```bash
    terraform apply
    ```

O Terraform irá provisionar o API Gateway e configurar as integrações conforme definido nos arquivos de especificação.
