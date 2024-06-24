# Odoo

## What is Odoo?
> Odoo is a suite of open source business apps that cover all your company needs: CRM, eCommerce, accounting, inventory, point of sale, project management, etc.

## Usage & Configuration

### Docker Compose
```yaml
services:
  odoo:
    image: ghcr.io/salamsoft-tech/odoo:17.0
    volumes:
      - ./odoo_data:/var/lib/odoo
    ports:
      - "8069:8069"
    environment:
      - ODOO_EMAIL=admin@example.com
      - ODOO_PASSWORD=odooadmin
      - ODOO_DATABASE_HOST=db
      - ODOO_DATABASE_USER=odoo
      - ODOO_DATABASE_NAME=erp
      - ODOO_DATABASE_PASSWORD=testmenot
  db:
    image: postgres:16-alpine
    volumes:
      - ./db_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=odoo
      - POSTGRES_DB=erp
      - POSTGRES_PASSWORD=testmenot
```

### Environment variables

| Name | Description | Default Value |
|------|-------------|---------------|
| `ODOO_DATABASE_HOST` | Database server host, `required` | `nil` |
| `ODOO_DATABASE_PORT` | Database server port | `5432` |
| `ODOO_DATABASE_USER` | Database user name, `required` | `nil` |
| `ODOO_DATABASE_PASSWORD` | Database user password, `required` | `nil` |
| `ODOO_EMAIL` | Odoo user email | `admin@example.com` |
| `ODOO_PASSWORD` | Odoo user password | `odooadmin` |
| `ODOO_SKIP_BOOTSTRAP` | Whether to perform initial bootstrapping for the application. | `no` |
| `ODOO_LOAD_DEMO_DATA` | Whether to load demo data | `no` |
