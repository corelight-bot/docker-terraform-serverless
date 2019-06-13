FROM hashicorp/terraform:0.12.1
# FROM hashicorp/terraform:light # when we can support v.12+
LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Serverless with Terraform for CI/CD"

RUN apk add --update git bash openssh make nodejs nodejs-npm
RUN npm install -g serverless serverless-plugin-git-variables serverless-terraform-outputs
# Note: ignore "serverless update check failed" warning during "npm install"

# Heavyweight considering we only use awscli for configuration, presently.
RUN apk add --update python py-pip && \
    pip install --upgrade awscli   && \
    apk --purge del py-pip         && \
    rm /var/cache/apk/*

ENTRYPOINT ["/bin/bash", "-l", "-c"]
