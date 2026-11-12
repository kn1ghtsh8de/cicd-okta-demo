# cicd-okta-demo

A tiny, deliberately-small demonstration repo for a lunch-and-learn on Git + CI/CD + Terraform, built around a single fictional Okta change.

## The scenario

> Marketing needs access to the Swag Store app. Because it stores order history, the app should require MFA.

Everything in this repo is fictional and points at a disposable Okta developer org (`dev-xxxxx.okta.com`). No real customer data, no production access.

## What one PR to this repo does

1. Grants the `demo-marketing` group access to the `Swag Store` app
   (resource: `okta_app_group_assignment`).
2. Adds a sign-on policy rule that requires MFA when accessing `Swag Store`
   (resource: `okta_app_signon_policy_rule`).

The same PR is run through four kinds of checks before anyone can merge:

| Check | What it catches |
| --- | --- |
| `terraform fmt -check` | Formatting drift |
| `terraform validate` | Syntax / provider-schema errors |
| `terraform plan` | The exact proposed change, posted as a PR comment |
| Conftest policies | Org rules (e.g. "never assign the built-in `Everyone` group") |
| Claude plan review | A plain-English summary of the plan, posted as a PR comment |

## What this repo deliberately doesn't do

- Doesn't apply anything from a PR. `apply.yml` exists and is wired to a GitHub
  Environment with required reviewers so it's shown but not run during the demo.
- Doesn't manage anything production or customer-facing.
- Doesn't ship real credentials — all secrets live in GitHub + Terraform Cloud.

## Repo layout

```
providers.tf     Okta provider pin
versions.tf      Terraform + provider version pins
main.tf          Data sources + baseline (pre-existing) assignment
assignments.tf   The new group-to-app assignment
policies.tf     The new MFA sign-on policy rule
policies/        Rego rules enforced by Conftest in CI
.github/workflows/
  terraform.yml            Runs on every PR
  apply.yml                Manual, gated by an Environment
  claude-plan-review.yml   Posts the AI summary comment
```

## Running it locally

```bash
export TF_CLOUD_ORGANIZATION=your-tfc-org
export OKTA_ORG_NAME=dev-xxxxx
export OKTA_BASE_URL=okta.com
export OKTA_API_TOKEN=...   # don't commit this

terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform show -json tfplan > plan.json
conftest test plan.json --policy policies/
```

See `../SETUP.md` (not committed — kept alongside the facilitator notes) for the
one-time dev-org / Terraform Cloud / GitHub secrets wiring.
