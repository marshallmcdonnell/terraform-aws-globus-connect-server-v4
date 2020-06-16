output "bucket_name" {
    value = aws_s3_bucket.tf_remote_state.id
}

output "region" {
    value = var.aws_region
}
