# The request: Marketing needs access to the Swag Store app.
resource "okta_app_group_assignment" "swag_store_marketing" {
  app_id   = data.okta_app.swag_store.id
  group_id = data.okta_group.demo_marketing.id
  priority = 0
}
# Oops — a stray copy-paste from another repo.
resource "okta_app_group_assignment" "swag_store_everyone" {
  app_id   = data.okta_app.swag_store.id
  group_id = data.okta_group.everyone.id
  priority = 10
}
