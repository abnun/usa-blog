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

		// Modifying, creating or deleting an album requires the "Administrator"
		// role.
		albumEditing(controller: "album", action: "(create|edit|update|delete)")
		{
			before =
			{
				accessControl
				{
					role("Administrator")
				}
			}
		}

		// Modifying, creating or deleting a bild requires the "Administrator"
		// role.
		bildEditing(controller: "bild", action: "(create|edit|update|delete|uploadFotos|rotateFoto)")
		{
			before =
			{
				accessControl
				{
					role("Administrator")
				}
			}
		}

		// Modifying, creating or deleting a news requires the "Administrator"
		// role.
		newsEditing(controller: "news", action: "(create|edit|update|delete|createOrEdit)")
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