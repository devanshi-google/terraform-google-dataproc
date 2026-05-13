# Dataproc Job Submodule

This submodule manages a job resource within a Dataproc cluster on Google Cloud Platform.

## Usage

```hcl
module "dataproc_job" {
  source = "./modules/dataproc-job"

  project_id   = "my-project-id"
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

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| cluster\_name | The name of the cluster where the job will be submitted. | `string` | yes |
| region | The Cloud Dataproc region. | `string` | yes |
| project\_id | The project in which the cluster can be found. | `string` | no |
| force\_delete | Cancel the job before issuing the delete on destroy. | `bool` | no |
| labels | The list of labels to add to the job. | `map(string)` | no |
| pyspark\_config | Configuration for a PySpark job. | `object` | no |
| spark\_config | Configuration for a Spark job. | `object` | no |
| hadoop\_config | Configuration for a Hadoop job. | `object` | no |
| hive\_config | Configuration for a Hive job. | `object` | no |
| pig\_config | Configuration for a Pig job. | `object` | no |
| sparksql\_config | Configuration for a Spark SQL job. | `object` | no |
| presto\_config | Configuration for a Presto job. | `object` | no |

## Outputs

| Name | Description |
|------|-------------|
| job\_id | The ID of the Dataproc job. |
| state | The current state of the Dataproc job. |
| driver\_output\_resource\_uri | A URI pointing to the location of the stdout of the job's driver program. |
