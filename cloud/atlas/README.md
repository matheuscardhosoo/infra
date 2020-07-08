# MongoDB Atlas Provider

- Main reference: [MongoDB Atlas Provider][atlas-provider].

The MongoDB Atlas provider is used to interact with the resources supported by [MongoDB Atlas][atlas]. The provider needs to be configured with the proper credentials before it can be used.

## Programmatic Access to Atlas

- How to create API keys for Atlas access: [Programmatic Access to Atlas][atlas-access].

1. Create a folder for atlas credentials:

```shell
$ mkdir -p ~/.atlas/credentials/
```

2. Create a `dev` and a `prod` files with execution roles:

```shell
$ touch {dev,prod}
$ chmod +x {dev,prod}
```

3. Fill each file with its appropriate credential in the following code.

```shell
$ export MONGODB_ATLAS_PUBLIC_KEY="xxxx"
$ export MONGODB_ATLAS_PRIVATE_KEY="xxxx"
```

___
[atlas]: https://www.mongodb.com/cloud/atlas
[atlas-access]: https://www.mongodb.com/cloud/atlas
[atlas-provider]: https://www.terraform.io/docs/providers/mongodbatlas/index.html