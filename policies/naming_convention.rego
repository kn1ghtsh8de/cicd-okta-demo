# naming_convention.rego
#
# Warn (don't block) when a newly created group doesn't match the demo-<name>
# convention. This exists in the demo to show the difference between an
# advisory check and a blocking one.
#
# Nothing in the current config creates a group, so this policy is here as a
# teaching exhibit — add a group in the demo and you'll see it fire.

package main

import rego.v1

warn contains msg if {
	some change in input.resource_changes
	change.type == "okta_group"
	"create" in change.change.actions
	name := change.change.after.name
	not regex.match(`^demo-[a-z]+$`, name)
	msg := sprintf(
		"%s: group name %q should match the convention 'demo-<lowercase>'.",
		[change.address, name],
	)
}
