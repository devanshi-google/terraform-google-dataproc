/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  type        = string
  description = "The project in which the cluster can be found and jobs subsequently run against. If it is not provided, the provider project is used."
  default     = null
}

variable "region" {
  type        = string
  description = "The Cloud Dataproc region. This essentially determines which clusters are available for this job to be submitted to."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster where the job will be submitted."
}

variable "force_delete" {
  type        = bool
  description = "By default, you can only delete inactive jobs within Dataproc. Setting this to true, and calling destroy, will ensure that the job is first cancelled before issuing the delete."
  default     = true
}

variable "labels" {
  type        = map(string)
  description = "The list of labels (key/value pairs) to add to the job."
  default     = {}
}

variable "pyspark_config" {
  description = "Configuration for a PySpark job."
  type = object({
    main_python_file_uri = string
    args                 = optional(list(string))
    python_file_uris     = optional(list(string))
    jar_file_uris        = optional(list(string))
    file_uris            = optional(list(string))
    archive_uris         = optional(list(string))
    properties           = optional(map(string))
    logging_config = optional(object({
      driver_log_levels = map(string)
    }))
  })
  default = null
}

variable "spark_config" {
  description = "Configuration for a Spark job."
  type = object({
    main_class        = optional(string)
    main_jar_file_uri = optional(string)
    args              = optional(list(string))
    jar_file_uris     = optional(list(string))
    file_uris         = optional(list(string))
    archive_uris      = optional(list(string))
    properties        = optional(map(string))
    logging_config = optional(object({
      driver_log_levels = map(string)
    }))
  })
  default = null
}

variable "hadoop_config" {
  description = "Configuration for a Hadoop job."
  type = object({
    main_class        = optional(string)
    main_jar_file_uri = optional(string)
    args              = optional(list(string))
    jar_file_uris     = optional(list(string))
    file_uris         = optional(list(string))
    archive_uris      = optional(list(string))
    properties        = optional(map(string))
    logging_config = optional(object({
      driver_log_levels = map(string)
    }))
  })
  default = null
}

variable "hive_config" {
  description = "Configuration for a Hive job."
  type = object({
    query_file_uri      = optional(string)
    query_list          = optional(list(string))
    continue_on_failure = optional(bool)
    script_variables    = optional(map(string))
    properties          = optional(map(string))
    jar_file_uris       = optional(list(string))
  })
  default = null
}

variable "pig_config" {
  description = "Configuration for a Pig job."
  type = object({
    query_file_uri      = optional(string)
    query_list          = optional(list(string))
    continue_on_failure = optional(bool)
    script_variables    = optional(map(string))
    properties          = optional(map(string))
    jar_file_uris       = optional(list(string))
    logging_config = optional(object({
      driver_log_levels = map(string)
    }))
  })
  default = null
}

variable "sparksql_config" {
  description = "Configuration for a Spark SQL job."
  type = object({
    query_file_uri   = optional(string)
    query_list       = optional(list(string))
    script_variables = optional(map(string))
    properties       = optional(map(string))
    jar_file_uris    = optional(list(string))
    logging_config = optional(object({
      driver_log_levels = map(string)
    }))
  })
  default = null
}

variable "presto_config" {
  description = "Configuration for a Presto job."
  type = object({
    query_file_uri      = optional(string)
    query_list          = optional(list(string))
    continue_on_failure = optional(bool)
    output_format       = optional(string)
    client_tags         = optional(list(string))
    properties          = optional(map(string))
    logging_config = optional(object({
      driver_log_levels = map(string)
    }))
  })
  default = null
}
