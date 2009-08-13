class SecurityFilters
{
    def filters =
	{
        /*// Ensure that all controllers and actions require an authenticated user,
        // except for the "public" controller
        auth(controller: "*", action: "*")
		{
            before =
			{
                // Exclude the "public" controller.
                if (controllerName == "public")
				{
					return true
				}

				// This just means that the user must be authenticated. He does
				// not need any particular role or permission.
				accessControl
				{
					true
				}
			}
		}*/

		// Creating, modifying, or deleting a post requires the "Administrator"
		// role.
		postEditing(controller: "post", action: "(create|edit|save|update|delete)")
		{
			before =
			{
				accessControl
				{
					role("Administrator")
				}
			}
		}

		// Modifying, or deleting a comment (kommentar) requires the "Administrator"
		// role.
		commentEditing(controller: "kommentar", action: "(edit|update|delete)")
		{
			before =
			{
				accessControl
				{
					role("Administrator")
				}
			}
		}
	}
}