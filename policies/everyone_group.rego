# everyone_group.rego
#
# No app-group assignment is allowed to reference the built-in `Everyone`
# group. Scope every assignment to a named group so you can actually tell,
# months from now, who has access to what and why.
#
# This is the rule that catches the planted CI failure in the demo.

package main

import rego.v1

deny contains msg if {
	some resource in input.configuration.root_module.resources
	resource.type == "okta_app_group_assignment"
	"data.okta_group.everyone" in resource.expressions.group_id.references
	msg := sprintf(
		"%s: assignments to the built-in 'Everyone' group are prohibited. Scope to a named group instead.",
		[resource.address],
	)
}
