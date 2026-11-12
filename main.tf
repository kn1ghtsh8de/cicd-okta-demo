# ---------------------------------------------------------------------------
# Look up the fictional groups and apps that already exist in the dev org.
# Using data sources (not hard-coded IDs) is what makes the diff read like
# English for an audience that doesn't live in Terraform every day.
# ---------------------------------------------------------------------------

data "okta_group" "demo_marketing" {
  name = "demo-marketing"
}

data "okta_group" "demo_engineering" {
  name = "demo-engineering"
}

# Built-in "Everyone" group. We reference it only to power a policy check —
# nothing in this config should ever assign it to an app.
data "okta_group" "everyone" {
  name = "Everyone"
}

data "okta_app" "swag_store" {
  label = "Swag Store"
}

data "okta_app" "internal_wiki" {
  label = "Internal Wiki"
}

# App-level sign-on policy that Okta auto-creates for Swag Store.
# We'll add a rule to it in policies.tf.
data "okta_app_signon_policy" "swag_store" {
  app_id = data.okta_app.swag_store.id
}

# ---------------------------------------------------------------------------
# Baseline state: engineering already has access to the internal wiki.
# This exists so the Terraform state isn't empty before our change, and so
# the live demo can show "here is what the world looks like today."
# ---------------------------------------------------------------------------

resource "okta_app_group_assignment" "wiki_engineering" {
  app_id   = data.okta_app.internal_wiki.id
  group_id = data.okta_group.demo_engineering.id
  priority = 0
}
