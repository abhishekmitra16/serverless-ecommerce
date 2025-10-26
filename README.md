# Serverless E-commerce Platform

A serverless e-commerce platform built using AWS services and Infrastructure as Code (IaC) with Terraform. This project demonstrates the implementation of a scalable, secure, and maintainable serverless architecture for e-commerce applications.

## Architecture Overview

The platform is built using the following AWS services:

- **API Gateway**: RESTful API interface for the e-commerce platform
- **Lambda Functions**: Serverless compute for business logic
- **DynamoDB**: NoSQL database for products and shopping cart data
- **Cognito**: User authentication and authorization
- **Terraform**: Infrastructure as Code for AWS resource provisioning

### Key Features

- Secure user authentication using AWS Cognito
- Product listing and catalog management
- Shopping cart functionality (add/remove items, view cart)
- Serverless architecture for automatic scaling
- Infrastructure as Code for reproducible deployments

## Project Structure

```
├── lambda_functions/          # AWS Lambda function implementations
│   ├── add_to_cart.py
│   ├── get_cart.py
│   ├── list_products.py
│   ├── remove_from_cart.py
│   └── modules/              # Shared Python modules
│       ├── authentication.py
│       └── database.py
├── terraform_modules/        # Modular Terraform configurations
│   ├── api_gateway/
│   ├── cognito/
│   ├── dynamodb/
│   └── lambda/
├── main.tf                  # Main Terraform configuration
├── variables.tf            # Terraform variables
└── outputs.tf             # Terraform outputs
```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 1.0.0
- Python >= 3.8
- AWS CLI configured with your credentials

## Setup and Deployment

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd serverless-ecommerce
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Configure variables:
   - Copy `terraform.tfvars.example` to `terraform.tfvars` (if provided)
   - Update the variables with your desired values

4. Deploy the infrastructure:
   ```bash
   terraform plan    # Review the changes
   terraform apply   # Deploy the infrastructure
   ```

5. Populate sample data (optional):
   ```bash
   cd sample_data_population_script
   python populate_sample_data.py
   ```

## API Endpoints

The following API endpoints are available:

- `GET /products` - List all available products
- `GET /cart` - View user's shopping cart
- `POST /cart` - Add item to cart
- `DELETE /cart/{product_id}` - Remove item from cart

All endpoints require authentication using a JWT token from Cognito.

## Testing

The project includes unit tests for Lambda functions:

```bash
python -m pytest tests/
```

## Security Features

- JWT-based authentication using AWS Cognito
- API Gateway authorization
- Least privilege IAM roles for Lambda functions
- DynamoDB table encryption at rest

## Project Highlights

This portfolio project demonstrates expertise in:

- Serverless Architecture Design
- AWS Services Integration
- Infrastructure as Code (Terraform)
- API Development and Security
- Python Backend Development
- Cloud-Native Development Practices

