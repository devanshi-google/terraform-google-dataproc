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

resource "google_dataproc_job" "job" {
  project      = var.project_id
  region       = var.region
  force_delete = var.force_delete
  labels       = var.labels

  placement {
    cluster_name = var.cluster_name
  }

  dynamic "pyspark_config" {
    for_each = var.pyspark_config != null ? [var.pyspark_config] : []
    content {
      main_python_file_uri = pyspark_config.value.main_python_file_uri
      args                 = pyspark_config.value.args
      python_file_uris     = pyspark_config.value.python_file_uris
      jar_file_uris        = pyspark_config.value.jar_file_uris
      file_uris            = pyspark_config.value.file_uris
      archive_uris         = pyspark_config.value.archive_uris
      properties           = pyspark_config.value.properties

      dynamic "logging_config" {
        for_each = pyspark_config.value.logging_config != null ? [pyspark_config.value.logging_config] : []
        content {
          driver_log_levels = logging_config.value.driver_log_levels
        }
      }
    }
  }

  dynamic "spark_config" {
    for_each = var.spark_config != null ? [var.spark_config] : []
    content {
      main_class        = spark_config.value.main_class
      main_jar_file_uri = spark_config.value.main_jar_file_uri
      args              = spark_config.value.args
      jar_file_uris     = spark_config.value.jar_file_uris
      file_uris         = spark_config.value.file_uris
      archive_uris      = spark_config.value.archive_uris
      properties        = spark_config.value.properties

      dynamic "logging_config" {
        for_each = spark_config.value.logging_config != null ? [spark_config.value.logging_config] : []
        content {
          driver_log_levels = logging_config.value.driver_log_levels
        }
      }
    }
  }

  dynamic "hadoop_config" {
    for_each = var.hadoop_config != null ? [var.hadoop_config] : []
    content {
      main_class        = hadoop_config.value.main_class
      main_jar_file_uri = hadoop_config.value.main_jar_file_uri
      args              = hadoop_config.value.args
      jar_file_uris     = hadoop_config.value.jar_file_uris
      file_uris         = hadoop_config.value.file_uris
      archive_uris      = hadoop_config.value.archive_uris
      properties        = hadoop_config.value.properties

      dynamic "logging_config" {
        for_each = hadoop_config.value.logging_config != null ? [hadoop_config.value.logging_config] : []
        content {
          driver_log_levels = logging_config.value.driver_log_levels
        }
      }
    }
  }

  dynamic "hive_config" {
    for_each = var.hive_config != null ? [var.hive_config] : []
    content {
      query_file_uri      = hive_config.value.query_file_uri
      query_list          = hive_config.value.query_list
      continue_on_failure = hive_config.value.continue_on_failure
      script_variables    = hive_config.value.script_variables
      properties          = hive_config.value.properties
      jar_file_uris       = hive_config.value.jar_file_uris
    }
  }

  dynamic "pig_config" {
    for_each = var.pig_config != null ? [var.pig_config] : []
    content {
      query_file_uri      = pig_config.value.query_file_uri
      query_list          = pig_config.value.query_list
      continue_on_failure = pig_config.value.continue_on_failure
      script_variables    = pig_config.value.script_variables
      properties          = pig_config.value.properties
      jar_file_uris       = pig_config.value.jar_file_uris

      dynamic "logging_config" {
        for_each = pig_config.value.logging_config != null ? [pig_config.value.logging_config] : []
        content {
          driver_log_levels = logging_config.value.driver_log_levels
        }
      }
    }
  }

  dynamic "sparksql_config" {
    for_each = var.sparksql_config != null ? [var.sparksql_config] : []
    content {
      query_file_uri   = sparksql_config.value.query_file_uri
      query_list       = sparksql_config.value.query_list
      script_variables = sparksql_config.value.script_variables
      properties       = sparksql_config.value.properties
      jar_file_uris    = sparksql_config.value.jar_file_uris

      dynamic "logging_config" {
        for_each = sparksql_config.value.logging_config != null ? [sparksql_config.value.logging_config] : []
        content {
          driver_log_levels = logging_config.value.driver_log_levels
        }
      }
    }
  }

  dynamic "presto_config" {
    for_each = var.presto_config != null ? [var.presto_config] : []
    content {
      query_file_uri      = presto_config.value.query_file_uri
      query_list          = presto_config.value.query_list
      continue_on_failure = presto_config.value.continue_on_failure
      output_format       = presto_config.value.output_format
      client_tags         = presto_config.value.client_tags
      properties          = presto_config.value.properties

      dynamic "logging_config" {
        for_each = presto_config.value.logging_config != null ? [presto_config.value.logging_config] : []
        content {
          driver_log_levels = logging_config.value.driver_log_levels
        }
      }
    }
  }
}
