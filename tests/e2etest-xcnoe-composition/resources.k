import models.io.upbound.platformref.aws.v1alpha1
import models.io.crossplane.helm.v1alpha1 as helmv1alpha1
import models.io.crossplane.kubernetes.v1alpha1 as kubernetesv1alpha1
import models.io.upbound.aws.eks.v1beta1 as eksv1beta1
import models.io.upbound.aws.eks.v1beta2 as eksv1beta2
import models.io.upbound.aws.iam.v1beta1 as iamv1beta1
import models.io.upbound.platform.aws.v1alpha1 as platformawsv1alpha1
import models.io.upbound.platform.gitops.v1alpha1 as gitopsv1alpha1
import models.io.upbound.platform.observe.v1alpha1 as platformobservev1alpha1
import models.io.upbound.aws.route53.v1beta1 as route53v1beta1
import models.io.crossplane.helm.v1beta1 as helmv1beta1
import models.io.upbound.platformref.aws.v1alpha1 as platformrefawsv1alpha1
import json

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
            route53zoneId = "Z0115025YFQ7ZQF6BJ6N"
            version = "1.34"
            iam = {
                roleArn = "arn:aws:iam::609897127049:role/AWSReservedSSO_AdministratorAccess_d703c73ed340fde7"
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