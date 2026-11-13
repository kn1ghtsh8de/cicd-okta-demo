# Because Swag Store holds order history, require MFA on access.
resource "okta_app_signon_policy_rule" "swag_store_require_mfa" {
  name        = "Require MFA for Swag Store"
  policy_id   = data.okta_app_signon_policy.swag_store.id
  priority    = 0
  access      = "ALLOW"
  factor_mode = "2FA"

  re_authentication_frequency = "PT2H"

  groups_included = [data.okta_group.demo_marketing.id]
}
