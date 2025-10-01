### Build Packer Image
```
cd amis
packer build -var-file="variables.pkrvars.hcl" aws_linux_image.pkr.hcl
```

### Build Packer Image with your choice of vault version
```
packer build \
  -var-file="variables.pkrvars.hcl" \
  -var="vault_version=1.19.10+ent" \
  aws_linux_image.pkr.hcl
```