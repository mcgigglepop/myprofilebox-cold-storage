data "archive_file" "create_dist_pkg" {
  source_dir = "${path.cwd}/lambda-layers/lambda/src"
  output_path = "${path.cwd}/lambda-layers/lambda/packages/lambda_function.zip"
  type = "zip"
}