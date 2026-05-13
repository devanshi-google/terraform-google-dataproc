# terraform-google-dataproc-job

## Description
### Tagline
Manages a job resource within a Dataproc cluster on Google Cloud Platform.

### Detailed
This submodule allows submitting and managing various types of Dataproc jobs (PySpark, Spark, Hadoop, Hive, Pig, SparkSQL, Presto) against a Dataproc cluster.

The resources/services/activations/deletions that this module will create/trigger are:

- Submit a Dataproc job to an existing cluster
- Manage job lifecycle and state monitoring
- Cleanly cancel running jobs during resource deletion (optional)

### PreDeploy
To deploy this module you must have an active billing account, an existing Dataproc cluster, and proper IAM permissions.

## Architecture
![alt text for diagram](https://www.link-to-architecture-diagram.com)
1. Configure target Dataproc cluster name and region.
2. Specify the job configuration (e.g., `pyspark_config` or `spark_config`).
3. Terraform submits the job via the Dataproc API and tracks its execution state.

## Documentation
- [Dataproc Jobs Documentation](https://cloud.google.com/dataproc/docs/concepts/jobs/life-of-a-job)

## Deployment Duration
Configuration: 1 min
Deployment: Depends on job execution duration

## Cost
[Dataproc Pricing Details](https://cloud.google.com/dataproc/pricing)

## Usage

Basic usage of this submodule is as follows:

```hcl
module "dataproc_job" {
  source = "terraform-google-modules/dataproc/google//modules/dataproc-job"

  project_id   = "<PROJECT ID>"
  region       = "us-central1"
  cluster_name = "my-dataproc-cluster"

  pyspark_config = {
    main_python_file_uri = "gs://my-bucket/hello-world.py"
    properties = {
      "spark.logConf" = "true"
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | The name of the cluster where the job will be submitted. | `string` | n/a | yes |
| force\_delete | By default, you can only delete inactive jobs within Dataproc. Setting this to true, and calling destroy, will ensure that the job is first cancelled before issuing the delete. | `bool` | `true` | no |
| hadoop\_config | Configuration for a Hadoop job. | <pre>object({<br>    main_class        = optional(string)<br>    main_jar_file_uri = optional(string)<br>    args              = optional(list(string))<br>    jar_file_uris     = optional(list(string))<br>    file_uris         = optional(list(string))<br>    archive_uris      = optional(list(string))<br>    properties        = optional(map(string))<br>    logging_config = optional(object({<br>      driver_log_levels = map(string)<br>    }))<br>  })</pre> | `null` | no |
| hive\_config | Configuration for a Hive job. | <pre>object({<br>    query_file_uri      = optional(string)<br>    query_list          = optional(list(string))<br>    continue_on_failure = optional(bool)<br>    script_variables    = optional(map(string))<br>    properties          = optional(map(string))<br>    jar_file_uris       = optional(list(string))<br>  })</pre> | `null` | no |
| labels | The list of labels (key/value pairs) to add to the job. | `map(string)` | `{}` | no |
| pig\_config | Configuration for a Pig job. | <pre>object({<br>    query_file_uri      = optional(string)<br>    query_list          = optional(list(string))<br>    continue_on_failure = optional(bool)<br>    script_variables    = optional(map(string))<br>    properties          = optional(map(string))<br>    jar_file_uris       = optional(list(string))<br>    logging_config = optional(object({<br>      driver_log_levels = map(string)<br>    }))<br>  })</pre> | `null` | no |
| presto\_config | Configuration for a Presto job. | <pre>object({<br>    query_file_uri      = optional(string)<br>    query_list          = optional(list(string))<br>    continue_on_failure = optional(bool)<br>    output_format       = optional(string)<br>    client_tags         = optional(list(string))<br>    properties          = optional(map(string))<br>    logging_config = optional(object({<br>      driver_log_levels = map(string)<br>    }))<br>  })</pre> | `null` | no |
| project\_id | The project in which the cluster can be found and jobs subsequently run against. If it is not provided, the provider project is used. | `string` | `null` | no |
| pyspark\_config | Configuration for a PySpark job. | <pre>object({<br>    main_python_file_uri = string<br>    args                 = optional(list(string))<br>    python_file_uris     = optional(list(string))<br>    jar_file_uris        = optional(list(string))<br>    file_uris            = optional(list(string))<br>    archive_uris         = optional(list(string))<br>    properties           = optional(map(string))<br>    logging_config = optional(object({<br>      driver_log_levels = map(string)<br>    }))<br>  })</pre> | `null` | no |
| region | The Cloud Dataproc region. This essentially determines which clusters are available for this job to be submitted to. | `string` | n/a | yes |
| spark\_config | Configuration for a Spark job. | <pre>object({<br>    main_class        = optional(string)<br>    main_jar_file_uri = optional(string)<br>    args              = optional(list(string))<br>    jar_file_uris     = optional(list(string))<br>    file_uris         = optional(list(string))<br>    archive_uris      = optional(list(string))<br>    properties        = optional(map(string))<br>    logging_config = optional(object({<br>      driver_log_levels = map(string)<br>    }))<br>  })</pre> | `null` | no |
| sparksql\_config | Configuration for a Spark SQL job. | <pre>object({<br>    query_file_uri   = optional(string)<br>    query_list       = optional(list(string))<br>    script_variables = optional(map(string))<br>    properties       = optional(map(string))<br>    jar_file_uris    = optional(list(string))<br>    logging_config = optional(object({<br>      driver_log_levels = map(string)<br>    }))<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| driver\_output\_resource\_uri | A URI pointing to the location of the stdout of the job's driver program. |
| job\_id | The ID of the Dataproc job. |
| state | The current state of the Dataproc job. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v1.3+
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.53+

### Service Account

A service account with the following roles must be used to provision the resources of this module:

- Dataproc Editor: `roles/dataproc.editor`

### APIs

A project with the following APIs enabled must be used to host the resources of this module:

- Google Cloud Dataproc API: `dataproc.googleapis.com`

## Contributing

Refer to the [contribution guidelines](../../CONTRIBUTING.md) for information on contributing to this module.

[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](../../SECURITY.md).
