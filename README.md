[![CircleCI](https://circleci.com/gh/clamorisse/hugo-s3-blog/tree/master.svg?style=svg)](https://circleci.com/gh/clamorisse/hugo-s3-blog/tree/master)

# Hugo container generated blog in AWS S3

This repository is used to manage a static blog generated with hugo and published in S3.

Its deployment is tested and automated using cirlceCI (infrastructure generated in terraform is not included), using config.yml file in this repository. The instructions below are to manage this repository manually.

Also, contains terraform and other supporting code to manage infrastructure.

The tools used are: terraform, rspec, docker, gohugo and amazon cli.

## Infrastructure: development, applying and testing

Terraform is used to create necessary resources in AWS: S3 bucket.
Route53 record is set manually. 

### Remote config state for terraform

Terraform state file is configured to be store in S3; to configure the remote state:

```
export TFENV=prod
terraform remote config -backend=s3 -backend-config="bucket=example-backups" -backend-config="key=terraform/tf_infra_bucket/$TFENV/terraform.tfstate" -backend-config="region=us-east-1"
```

### Making changes with terraform:

Change tf and vars files, plan and apply changes.

```
terraform plan
terraform apply
```

### Running Rspec tests

### Work in Progress

Terraform plan includes special resource "infra-test" (see terraform plan). It simply executes local script after terraform apply is completed. To initiate a run for the script, you should 'taint' (mark for recreation) this null resource.

Add required Ruby gems:

```
cd terraform/awspec
bundler
```

Then run terraform plan and see tests passing. You can run them manually with `rspec` in terraform/awspec.

```
cd terraform
terraform taint null_resource.infra-tests 
terraform plan 
terraform apply 
```

You should see terraform ideally has no changes to apply, then recreates 'null resource' and runs tests.

## Building docker gohugo image

To build image, run following command in the `docker-hugo-blog`:

```
docker build -t clamorisse/hugo:0.14 .
```

## Website: development and publishing

To work with the site content, cd to the folder

For development, please run docker with these options in the `hugo-site-s3/content-hugo-blog` folder:

```
docker run --rm -it  -p 1313:1313 -v ~/devopsing/hugo-site-s3/content-hugo-blog/:/usr/src/blog clamorisse/hugo:0.14  hugo server --watch --baseUrl=http://docker-default-ip:1313 --bind 0.0.0.0
```

To publish changes (it should be done automatically by a build/deployment server), run this commands:

```
cd hugo-site-s3/content-hugo-blog
docker run --rm -it  -p 1313:1313 -v $(PWD)/:/usr/src/blog clamorisse/hugo:0.14 hugo
aws s3 sync public/ s3://your-bucket-name/
```
