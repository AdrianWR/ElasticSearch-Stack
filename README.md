# ElasticSearch-Stack
ElasticSearch Stack, running on DO Kubernetes Engine

# Introduction

Running complex systems is, by not an easy length, a complex task, and please forgive me for this free pun.
There's this moment in the life of a developer, when we are sharp on writing loops, data structures, APIs, and we need to take a setp further, and glue a lot of stuff together.
Be it a simple webserver with just a few endpoints, to a streaming data platform built on top of NoSQL databases, managing these setups implies in a lot of overhead on someone.

This way, one might think in improving them observability stack with log and metrics monitoring, or even tracing.
In this repository, one may find a possible solution on how to aggregate metrics on a Digital Ocean deployed Kubernetes cluster, using [FluentBit](https://fluentbit.io/) as a log collector and the [ElasticSeach stack](https://www.elastic.co/pt/elastic-stack/) as the log monitoring system.

Nonetheless, this proejct is my take on the 2021 edition of the Digital Ocean Kubernetes Challenge, so we'll take a lot of its technology here. for more information, one may take a look at [Digital Ocean Kubernetes Challenge](https://www.digitalocean.com/community/pages/kubernetes-challenge).

# The EFK Stack


# How to Deploy

This project relies heavily on **Terraform** and Helm to deploy the systems described here. For those unaware, [Terraform](https://www.terraform.io/) is a infrastructure-as-code provisioning tool, enabling us to provision API-managed resources in the simple HCL language, but very powerful at its capabilities. 
If you don't Terraform on your local setup, install it following the instructions at [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

By default, the project doesn't have a DO account configured to deploy the infrastructure. To deploy it, one must generate a Digital Ocean access token following the instructions found on [How to Create a Personal Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/). Remember to save the token value, as you have only one chance to copy it. Save the token in a variable called `do_token` in a `terraform.tfvars` file (There are other options to save/apply this variable, but personally I find this the easiest one, though it lacks some security).

First of all, one might need to access the `.tf` files by `cd`'ing into the `tf` directory found at the project's root. Then, the Terraform backend must be initialized, to be later applied its configuration with the `apply` command. Here I'm applying directly with the `-auto-approve` option, but you may find helpful to look through the stack to be deployed before applying (just remove the option).

One may find useful as well to take a look at the [`variables.tf`](./tf/variables.tf) file; here, you may find default options to be used to deploy the stack, such as in which region we are deploying the infrastructure, or the node size selected. 

```shell
cd tf
echo 'do_token = "6cjk17-MY-DO-TOKEN..."' > terraform.tfvars
terraform init -upgrade
terraform apply -auto-approve
```

At the end of the process, which could take several minutes, you may expect a message "Apply Complete!", indicating that the provisioning occurred with success. Now, you have a Digital Ocean Kubernetes cluster with the EFK installed! You may run `terraform output -raw kubeconfig` to fetch the cluster's `kubeconfig`.

# How to Configure

Even if we have the stack deployed, we still can't get the logs on our system. For that, we need to configure the Elasticsearch log index via the Kibana interface. As we don't have a Kibana ingress configured, we can use the `port-forward` feature of the Kubernetes API to make changes to it. Run the following command on the `tf` directory. At we are doing here is port-forwarding ou cluster kibana into the `5601` port of our local machine. Take a look on how we need to specifiy the correct `kubeconfig` and namespace to run the command the right way.

```
kubectl --kubeconfig <(terraform output -raw kubeconfig) -n logging port-forward deployment/kibana-kibana 5601:5601
```

# Acknowledgements

- [How To Set Up an Elasticsearch, Fluentd and Kibana (EFK) Logging Stack on Kubernetes](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-elasticsearch-fluentd-and-kibana-efk-logging-stack-on-kubernetes)
