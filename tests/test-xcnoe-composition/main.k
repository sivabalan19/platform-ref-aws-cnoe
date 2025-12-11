import models.io.crossplane.helm.v1alpha1 as helmv1alpha1
import models.io.crossplane.helm.v1beta1 as helmv1beta1
import models.io.crossplane.helmm.v1beta1 as helmmv1beta1
import models.io.crossplane.kubernetes.v1alpha1 as kubernetesv1alpha1
import models.io.crossplane.kubernetes.v1alpha2 as kubernetesv1alpha2
import models.io.k8s.api.admissionregistration.v1 as admissionregistrationv1
import models.io.k8s.api.admissionregistration.v1alpha1 as admissionregistrationv1alpha1
import models.io.k8s.api.admissionregistration.v1beta1 as admissionregistrationv1beta1
import models.io.k8s.api.apiserverinternal.v1alpha1 as apiserverinternalv1alpha1
import models.io.k8s.api.apps.v1 as appsv1
import models.io.k8s.api.authentication.v1 as authenticationv1
import models.io.k8s.api.authorization.v1 as authorizationv1
import models.io.k8s.api.autoscaling.v1 as autoscalingv1
import models.io.k8s.api.autoscaling.v2 as autoscalingv2
import models.io.k8s.api.batch.v1 as batchv1
import models.io.k8s.api.certificates.v1 as certificatesv1
import models.io.k8s.api.certificates.v1alpha1 as certificatesv1alpha1
import models.io.k8s.api.certificates.v1beta1 as certificatesv1beta1
import models.io.k8s.api.coordination.v1 as coordinationv1
import models.io.k8s.api.coordination.v1alpha2 as coordinationv1alpha2
import models.io.k8s.api.coordination.v1beta1 as coordinationv1beta1
import models.io.k8s.api.core.v1 as corev1
import models.io.k8s.api.discovery.v1 as discoveryv1
import models.io.k8s.api.events.v1 as eventsv1
import models.io.k8s.api.flowcontrol.v1 as flowcontrolv1
import models.io.k8s.api.networking.v1 as networkingv1
import models.io.k8s.api.networking.v1beta1 as networkingv1beta1
import models.io.k8s.api.node.v1 as nodev1
import models.io.k8s.api.policy.v1 as policyv1
import models.io.k8s.api.rbac.v1 as rbacv1
import models.io.k8s.api.resource.v1alpha3 as resourcev1alpha3
import models.io.k8s.api.resource.v1beta1 as resourcev1beta1
import models.io.k8s.api.resource.v1beta2 as resourcev1beta2
import models.io.k8s.api.scheduling.v1 as schedulingv1
import models.io.k8s.api.storage.v1 as storagev1
import models.io.k8s.api.storage.v1alpha1 as storagev1alpha1
import models.io.k8s.api.storage.v1beta1 as storagev1beta1
import models.io.k8s.api.storagemigration.v1alpha1 as storagemigrationv1alpha1
import models.io.k8s.apiextensions_apiserver.pkg.apis.apiextensions.v1 as apiextensionsv1
import models.io.k8s.apimachinery.pkg.api.resource as apiresource
import models.io.k8s.apimachinery.pkg.apis.meta.v1 as metav1
import models.io.k8s.apimachinery.pkg.runtime as pkgruntime
import models.io.k8s.apimachinery.pkg.util.intstr as utilintstr
import models.io.k8s.apimachinery.pkg.version as pkgversion
import models.io.k8s.kube_aggregator.pkg.apis.apiregistration.v1 as apiregistrationv1
import models.io.upbound.aws.cloudwatchevents.v1beta1 as cloudwatcheventsv1beta1
import models.io.upbound.aws.cloudwatchevents.v1beta2 as cloudwatcheventsv1beta2
import models.io.upbound.aws.ec2.v1beta1 as ec2v1beta1
import models.io.upbound.aws.ec2.v1beta2 as ec2v1beta2
import models.io.upbound.aws.eks.v1beta1 as eksv1beta1
import models.io.upbound.aws.eks.v1beta2 as eksv1beta2
import models.io.upbound.aws.iam.v1beta1 as iamv1beta1
import models.io.upbound.aws.route53.v1beta1 as route53v1beta1
import models.io.upbound.aws.route53.v1beta2 as route53v1beta2
import models.io.upbound.aws.sqs.v1beta1 as sqsv1beta1
import models.io.upbound.aws.v1alpha1 as awsv1alpha1
import models.io.upbound.aws.v1beta1 as awsv1beta1
import models.io.upbound.awsm.route53.v1beta1 as awsmroute53v1beta1
import models.io.upbound.awsm.v1beta1 as awsmv1beta1
import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1
import models.io.upbound.dev.meta.v2alpha1 as metav2alpha1
import models.io.upbound.platform.aws.v1alpha1 as platformawsv1alpha1
import models.io.upbound.platform.gitops.v1alpha1 as gitopsv1alpha1
import models.io.upbound.platform.observe.v1alpha1 as observev1alpha1
import models.io.upbound.platformref.aws.v1alpha1 as platformrefawsv1alpha1
import models.k8s.apimachinery.pkg.apis.meta.v1 as apismetav1
import resources

_items = [
    # Test Coversion for Foundation Level - 1 - like vpc, sn, eks cluster, nodegroup, iam roles, etc
    metav1alpha1.CompositionTest {
        metadata.name: "Foundation Validation Test - Level 1"
        spec = {
            assertResources: [resources._network, resources._xeks, resources._xzone, resources._awslbrole, resources._awsdnsrole]
            compositionPath: "apis/cnoes/composition.yaml"
            xrPath: "examples/cnoe/platform-ref-aws-cnoe.yaml"
            xrdPath: "apis/cnoes/definition.yaml"
            timeoutSeconds: 60
            validate: False
        }
    },
    # Test GitOps for Application Level - 2 - like external-dns, openobserve, dns, grafana, etc
    metav1alpha1.CompositionTest {
        metadata.name: "GitOps Validation Test - Level 2"
        spec = {
            observedResources: [resources._network, resources._oxeks, resources._xzone, resources._awslbrole, resources._awsdnsrole]
            assertResources: [resources._xoss, resources._awslbchart, resources._xpchart]
            compositionPath: "apis/cnoes/composition.yaml"
            xrPath: "examples/cnoe/platform-ref-aws-cnoe.yaml"
            xrdPath: "apis/cnoes/definition.yaml"
            timeoutSeconds: 60
            validate: False
        }
    }
]
items = _items
