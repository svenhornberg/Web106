class UrlMappings {

	static mappings = {
        "/"(view:"/main")

        "/$controller/$action?/$id?(.${format})?"{
            constraints {
                // apply constraints here
            }
        }

        //"/"(view:"/index")
        "500"(view:'/error')
	}
}
