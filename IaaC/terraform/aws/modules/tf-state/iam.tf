/* resource "aws_iam_user" "iam_user_tf_state" {
  name          = "${var.prefix_iam_user}-${var.env}"
  path          = "/"
  force_destroy = var.force_destroy_enabled
  tags          = {
    Name        = "${var.prefix_iam_user}-${var.env}"
    Environment = var.env
  }
}

# Generate API credentials
resource "aws_iam_access_key" "iam_access_key_tf_state" {
  user  = aws_iam_user.iam_user_tf_state.name
}

resource "aws_iam_user_policy" "iam_policy_dynamodb_tf_state" {
  #bridgecrew:skip=BC_AWS_IAM_16:Skipping `Ensure IAM policies are attached only to groups or roles` check because this module intentionally attaches IAM policy directly to a user.
  user   = aws_iam_user.iam_user_tf_state.name
  name   = "${var.prefix_dynamodb}-${var.env}"
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [{
        "Effect": "Allow",
        "Action": [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
          ],
        "Resource": "arn:aws:dynamodb:*:*:${var.prefix_dynamodb}-${var.env}/"
      }]
    })
}

resource "aws_iam_user_policy" "iam_policy_s3_tf_state" {
  #bridgecrew:skip=BC_AWS_IAM_16:Skipping `Ensure IAM policies are attached only to groups or roles` check because this module intentionally attaches IAM policy directly to a user.
  user   = aws_iam_user.ipoam_user_tf_state.name
  name   = "${var.prefix_s3}-${var.env}"
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
          {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::mybucket"
            },
            {
            "Effect": "Allow",
            "Action": [ "s3:GetObject", "s3:PutObject" ],
            "Resource": "arn:aws:s3:::s3-bucket-${var.env}-tf-state}/"
          }
        ]
    })
}  */