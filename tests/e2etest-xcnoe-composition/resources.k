import models.io.upbound.platformref.aws.v1alpha1 as platformrefawsv1alpha1

# Read from options - must be provided via -D flags or environment
_route53ZoneId = option("ROUTE53_ZONE_ID") if option("ROUTE53_ZONE_ID") else "ZXXXXXXXXXXXXX"
_iamRoleArn = option("IAM_ROLE_ARN") if option("IAM_ROLE_ARN") else "arn:aws:iam::123456789012:role/YourE2ETestRole"

_xcnoe = platformrefawsv1alpha1.XCNOE {
    metadata = {
        name = "platform-ref-aws-cnoe"
        labels = {
            "crossplane.io/composite" = "platform-ref-aws-cnoe"
        }
    }
    spec = {
        compositeDeletePolicy = "Foreground"
        parameters = {
            id = "platform-ref-aws-cnoe"
            deletionPolicy = "Delete"
            nodes   = {
                count = 9
                instanceType = "t3.small"
            }
            region = "eu-west-1"
            route53zoneId = _route53ZoneId
            version = "1.34"
            iam = {
                roleArn = _iamRoleArn
            }
            gitops = {
                git = {
                    url = "https://github.com/upbound/configuration-gitops-argocd.git"
                    path = "gitops"
                    ref = {
                        name = "HEAD"
                    }
                }
            }
        }
    }
}