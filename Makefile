# @see https://github.com/pgporada/terraform-makefile

.ONESHELL:
.SHELL := /usr/bin/env bash
.PHONY: apply destroy plan plan-target prep import init check-security lint format

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Re-initialize the project
	@echo "Configuring the terraform backend"
	@terraform init \
		-input=false \
		-force-copy

plan: init ## [init] Show what terraform thinks it will do
	@terraform plan \
		-lock=true \
		-input=false \
		-refresh=true \
		-out="plan.out"

format: ## Rewrites all Terraform configuration files to a canonical format.
	@terraform fmt \
		-write=true \
    	-recursive \
		.

docs:
	docker run --rm -v $(PWD):/src -w /src quay.io/terraform-docs/terraform-docs:0.13.0 markdown . --output-file README.md

# https://github.com/terraform-linters/tflint
lint: ## Check for possible errors, best practices, etc in current directory!
	docker run --rm -v $(PWD):/data -t wata727/tflint:0.28.0

# https://github.com/tfsec/tfsec
check-security: ## Static analysis of your terraform templates to spot potential security issues.
	docker run --rm -v $(PWD):/src -t tfsec/tfsec:v0.39 /src

apply: ## Have terraform do the things. This will cost money.
	@echo "Verifying that the plan was generated"
	@if test ! -f "plan.out" ; then \
		echo "Plan file plan.out was not found, you must run 'make plan' first"; \
		false; \
	 fi

	@echo "Applying"
	@terraform apply \
		-lock=true \
		-input=false \
		-auto-approve \
		-refresh=true \
		plan.out

	@echo "Removing plan file"
	@rm -f plan.out

refresh: ## Have terraform refresh state file with current infrastructure
	@echo "Refreshing"
	@terraform refresh \
		-lock=true \
		-input=false

import: ## Have terraform import new resources, must pass RESOURCE and ID to work
	@terraform import \
		-lock=true \
		-input=false \
		$(RESOURCE) \
		$(ID)

destroy: init ## [init] Destroys this project
	@terraform destroy \
		-lock=true \
		-auto-approve \
		-refresh=true
