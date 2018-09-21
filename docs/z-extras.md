### Available parameters

The parameters bellow can be added when starting looqbox.

| Parameter | Description |
|------|------|
| ```-e XMX="-Xmx512m"``` | change maximum heap |
| ```-e XMS="-Xms512m"``` | change minimum heap |
| ```-e PORT``` | change Looqbox's port (default 80) |
| ```-e PROXY_HOST="<ip>"``` | when parameter exists, use host as proxy (must define proxy_port as well) |
| ```-e PROXY_PORT="<port>"``` | when parameter exists, use port as proxy (must define proxy_host as well) |

#### Examples

To configure a proxy:

```bash
docker run -d --restart=always --name=looqbox-instance -e PROXY_HOST="127.0.0.1" -e PROXY_PORT="8080" -e CLIENT="<client name>" -e KEY="<client key>" -e RSTUDIO_PASS="<choose a password>" -p 80:80 -p 8787:8787 looqboxrep/fes-public:cloud002
```

To change the initial memory used by Java (default is 2Gb):

```bash
docker run -d --restart=always --name=looqbox-instance -e XMX="-Xmx512m" -e XMS="-Xms512m" -e CLIENT="<client name>" -e KEY="<client key>" -e RSTUDIO_PASS="<choose a password>" -p 80:80 -p 8787:8787 looqboxrep/fes-public:cloud002
```
It's not recommeded to use bellow 512mb. Looqbox is not a full stateless service, don't use it in High Availability without contacting our support.



### Docker commands for looqbox

Those are the most common Docker commands that will be used with Looqbox. Execute them in the order below to update Looqbox's version.

#### Stop Looqbox's container
```bash
docker stop looqbox-instance
```

#### Remove Looqbox's image :(
```bash
docker rm looqbox-instance
```

#### Pull new version
```bash
docker pull looqboxrep/fes-public:cloud002
```

#### Start Looqbox
```bash
docker run -d --restart=always --name=looqbox-instance -e CLIENT="<client name>" -e KEY="<client key>" -e RSTUDIO_PASS="<choose a password>" -p 80:80 -p 8787:8787 looqboxrep/fes-public:cloud002
```

#### Check looqbox's logs
```bash
docker logs -f --tail 200 looqbox-instance
```

