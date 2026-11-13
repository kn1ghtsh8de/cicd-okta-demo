# The request: Marketing needs access to the Swag Store app.
resource "okta_app_group_assignment" "swag_store_marketing" {
  app_id   = data.okta_app.swag_store.id
  group_id = data.okta_group.demo_marketing.id
  priority = 0
}
