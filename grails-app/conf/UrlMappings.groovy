class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(controller: "post", action: 'list_frontend')
	  "500"(view:'/error')
	}
}
