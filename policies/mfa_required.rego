# mfa_required.rego
#
# Any new `ALLOW` rule on an app sign-on policy must require MFA. This mirrors
# a real compliance control: if a reviewer is grading an app-access change,
# they shouldn't also have to remember to check the MFA posture by hand.

package main

import rego.v1

deny contains msg if {
	some change in input.resource_changes
	change.type == "okta_app_signon_policy_rule"
	"create" in change.change.actions
	change.change.after.access == "ALLOW"
	change.change.after.factor_mode != "2FA"
	msg := sprintf(
		"%s: ALLOW rules on app sign-on policies must require MFA (factor_mode = \"2FA\"), got %q.",
		[change.address, change.change.after.factor_mode],
	)
}
