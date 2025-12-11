# Composition Resources for AWS CNOE Composition Test
import models.io.upbound.aws.iam.v1beta1 as iamv1beta1
import models.io.upbound.platform.aws.v1alpha1 as platformawsv1alpha1
import models.io.upbound.platform.gitops.v1alpha1 as gitopsv1alpha1
import models.io.upbound.platform.observe.v1alpha1 as platformobservev1alpha1
import models.io.upbound.aws.route53.v1beta1 as route53v1beta1
import models.io.crossplane.helm.v1beta1 as helmv1beta1
import json
import conditions

# USer created using XCNOE Composition
_argocd_admin_user = {
    "apiVersion": "user.keycloak.crossplane.io/v1alpha1"
    "kind": "User"
    "metadata": {
        "generateName": "argocd-admin-user-"
    }
    "spec": {
        "providerConfigRef": {
            "name": "platform-ref-aws-cnoe-keycloak-providerconfig"
        }
        "forProvider": {
            "emailVerified": True
            "email": "argocd-admin@upboundrocks.cloud"
            "firstName": "argocd"
            "lastName": "admin"
            "username": "argocd-admin"
            "enabled": True
            "realmId": "master"
            "initialPassword": [
                {
                    "temporary": False
                    "valueSecretRef": {
                        "name": "argocd-admin-user"
                        "key": "password"
                    }
                }
            ]
        }
    }
}


_argocd_admin_group_membership = {
    "apiVersion": "user.keycloak.crossplane.io/v1alpha1"
    "kind": "Groups"
    "metadata": {
        "generateName": "argocd-admin-user-"
    }
    "spec": {
        "providerConfigRef": {
            "name": "platform-ref-aws-cnoe-keycloak-providerconfig"
        }
        "forProvider": {
            "groupIdsSelector": {
                "matchLabels": {
                    "type": "argocd-admin"
                }
            }
            "realmId": "master"
            "userIdSelector": {
                "matchControllerRef": True
            }
        }
    }
}