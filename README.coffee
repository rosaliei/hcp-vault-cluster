# HashiCorp Vault AWS Secrets Engine Configuration

## Reference Documentation
https://developer.hashicorp.com/vault/docs/secrets/aws

## Initial Setup Commands
```bash
vault secrets list
vault secrets enable aws
vault secrets enable -path=productpage-team aws
```

## AWS Credentials Configuration

### Root Credentials Setup
**Method:** POST  
**Path:** `/productpage-team/config/root`

```bash
vault write /productpage-team/config/root \
  access_key="***REDACTED***" \
  secret_key="***REDACTED***"
```

**Alternative curl command:**
```bash
curl --header "X-Vault-Token: ..." \
  --request POST \
  --data '{"access_key":"***REDACTED***","secret_key":"***REDACTED***"}' \
  http://127.0.0.1:8200/v1/productpage-team/config/root
```

### Read Root Configuration
**Method:** GET  
**Path:** `/productpage-team/config/root`

```bash
vault read /productpage-team/config/root
```

**Alternative curl command:**
```bash
curl --header "X-Vault-Token: ..." \
  http://127.0.0.1:8200/v1/productpage-team/config/root
```

## Credential Management

### Rotate Root Credentials
**Method:** POST  
**Path:** `/productpage-team/config/rotate-root`

```bash
vault write /productpage-team/config/rotate-root
```

## Role Management

### Create Static Role
**Method:** POST  
**Path:** `/productpage-team/static-roles/:name`

```bash
vault write /productpage-team/static-roles/productpage-admin-vault-role \
  username=productpage-admin \
  rotation_period=1m
```

### Create/Update Dynamic Role
**Method:** POST  
**Path:** `/productpage-team/roles/:name`

```bash
# Example dynamic role creation
vault write /productpage-team/roles/my-role \
  credential_type=iam_user \
  policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
EOF
```

### Get Static Credentials
**Method:** GET  
**Path:** `/productpage-team/static-creds/:name`

```bash
vault read /productpage-team/static-creds/productpage-admin-vault-role
```

