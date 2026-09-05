# Odoo

## What is Odoo?
> Odoo is a suite of open source business apps that cover all your company needs: CRM, eCommerce, accounting, inventory, point of sale, project management, etc.

## Usage & Configuration

### Docker Compose
```yaml
services:
  odoo:
    image: ghcr.io/salamsoft-tech/odoo:19.0
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
    image: postgres:18-alpine
    volumes:
      - ./db_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=odoo
      - POSTGRES_DB=erp
      - POSTGRES_PASSWORD=testmenot
```

### Volumes
| Name | Description |
|------|-------------|
| `/var/lib/odoo` | Odoo data directory |
| `/mnt/extra-addons` | Your extra addons go here, searched before the bundled ones |

### Addons path

Modules are searched in this order, and the **first match wins**:

1. `$ODOO_EXTRA_ADDONS_PATH` (`/mnt/extra-addons` by default)
2. `/opt/bundle-addons` — addons shipped with this image
3. `/opt/oca-addons` — OCA repositories vendored at build time

Mounting a module at `/mnt/extra-addons` therefore overrides a bundled or OCA
copy of the same name. Odoo's own standard modules always take precedence over
all of the above and cannot be shadowed this way.

Note that a same-named module is picked up silently, and Odoo only reloads it
when the manifest version differs from the installed one — deploy an override
with an explicit `-u <module>`.

### Environment variables

| Name | Description | Default Value |
|------|-------------|---------------|
| `ODOO_DATABASE_HOST` | Database server host, `required` | `nil` |
| `ODOO_DATABASE_PORT` | Database server port | `5432` |
| `ODOO_DATABASE_USER` | Database user name, `required` | `nil` |
| `ODOO_DATABASE_PASSWORD` | Database user password, `required` | `nil` |
| `ODOO_DATABASE_MAXCONN` | Maximum number of physical connections to PostgreSQL | `64` |
| `ODOO_EMAIL` | Odoo user email | `admin@example.com` |
| `ODOO_PASSWORD` | Odoo user password | `odooadmin` |
| `ODOO_SKIP_BOOTSTRAP` | Whether to perform initial bootstrapping for the application | `false` |
| `ODOO_LOAD_DEMO_DATA` | Whether to load demo data | `false` |
| `ODOO_EXTRA_ADDONS_PATH` | Addons directory searched before the bundled ones | `/mnt/extra-addons` |
