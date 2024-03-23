terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.26"
    }
    
  }
}




resource "aws_iam_openid_connect_provider" "github_oidc" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}



data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_oidc.arn]
    }
     condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = ["repo:*/*"]
      variable = "token.actions.githubusercontent.com:sub"
    }
  }

}


resource "aws_iam_role" "this" {
  name         = "Github_Role_Policy"
  assume_role_policy  = data.aws_iam_policy_document.assume-role-policy.json
  # managed_policy_arns = [aws_iam_policy.s3_policy.arn]

}
