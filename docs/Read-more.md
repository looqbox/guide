# Read More
This section has extra documentation about different areas that don't fall in any other category.

### RKernel
Every R script in Looqbox is processed by a RKernel. RKernels are a logical unit that controls a session in R.

The more RKernel available, the more scripts can be processed at the same time. On the other hand, more RAM in consumed.

Since a good implementation of R scripts in Looqbox run on average below 2 seconds, even for hundreds of users, only a few RKernels are required (usually between 2 and 6). Don't worry, RKernels are started as needed to processes scripts if the current number is not enough.

Every RKernel has a session, so it's possible that during the execution of a script, a RKernel enters in a bad state. In cases that you suspect some kind of bad state is influencing responses, destroy the RKernels. It's also possible that different packages loaded by R scripts have the same function name, in this case, inconsistency can be found while executing different scripts that fall in this case (prefix function calls with the package name to avoid such cases, e.g. httr::config and dplyr::config).

In case of a script breaking (syntax error or exceptions), the RKernel is automatically destroyed (saving the last question asked for debugging purposes).

If a user asks a question and all RKernels are currently being used to processes other responses, a new RKernel starts, and will be available in the pool.

A new RKernel take about 7 seconds to start.

Looqbox has the right to limit the number of RKernel available to each client, and if more than 1 on-premise instance of Looqbox is online at the same time for the same company, the total number of RKernels available will be divided between the instances.

### Available parameters when starting Looqbox

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

