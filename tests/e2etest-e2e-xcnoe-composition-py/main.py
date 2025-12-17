import os
from .model.io.upbound.dev.meta.e2etest import v1alpha1 as e2etest
from .model.io.k8s.apimachinery.pkg.apis.meta import v1 as k8s
from .model.io.upbound.platformref.aws.xcnoe import v1alpha1 as platformrefawsv1alpha1
from .model.io.upbound.aws.providerconfig import v1beta1 as awsv1beta1

# Read from environment variables with defaults
route53_zone_id = os.getenv("ROUTE53_ZONE_ID", "ZXXXXXXXXXXXXX")
iam_role_arn = os.getenv("IAM_ROLE_ARN", "arn:aws:iam::123456789012:role/YourE2ETestRole")

# Create the XCNOE resource
xcnoe = platformrefawsv1alpha1.XCNOE(
    metadata=k8s.ObjectMeta(
        name="platform-ref-aws-cnoe-py",
        labels={
            "crossplane.io/composite": "platform-ref-aws-cnoe"
        }
    ),
    spec=platformrefawsv1alpha1.Spec(
        compositeDeletePolicy="Foreground",
        parameters=platformrefawsv1alpha1.Parameters(
            id="platform-ref-aws-cnoe",
            deletionPolicy="Delete",
            nodes=platformrefawsv1alpha1.Nodes(
                count=9,
                instanceType="t3.small"
            ),
            region="eu-west-1",
            route53zoneId=route53_zone_id,
            version="1.34",
            iam=platformrefawsv1alpha1.Iam(
                roleArn=iam_role_arn
            ),
            gitops=platformrefawsv1alpha1.Gitops(
                git=platformrefawsv1alpha1.Git(
                    url="https://github.com/upbound/configuration-gitops-argocd.git",
                    path="gitops",
                    ref=platformrefawsv1alpha1.Ref(
                        name="HEAD"
                    )
                )
            )
        )
    )
)

# Create the ProviderConfig
provider_config = awsv1beta1.ProviderConfig(
    metadata=k8s.ObjectMeta(
        name="default"
    ),
    spec=awsv1beta1.Spec(
        credentials=awsv1beta1.Credentials(
            source="Upbound",
            upbound=awsv1beta1.Upbound(
                webIdentity=awsv1beta1.WebIdentity(
                    roleARN="arn:aws:iam::609897127049:role/solutions-e2e-provider-aws"
                )
            )
        )
    )
)

# Create the E2ETest
test = e2etest.E2ETest(
    metadata=k8s.ObjectMeta(
        name="e2e-test-xcnoe-platform-ref-aws-py",
    ),
    spec=e2etest.Spec(
        crossplane=e2etest.Crossplane(
            autoUpgrade=e2etest.AutoUpgrade(
                channel="None",
            ),
            version="1.20.4-up.1",
        ),
        defaultConditions=[
            "Ready",
        ],
        manifests=[
            xcnoe.model_dump(exclude_none=True, by_alias=True)
        ],
        extraResources=[
            provider_config.model_dump(exclude_none=True, by_alias=True)
        ],
        skipDelete=True,  # Skip deletion to retain created resources for inspection
        timeoutSeconds=4500,
    )
)
