import grails.converters.JSON
import web106.site.Page
import web106.site.Website

/**
* filter to secure URLs ( guessing sequencial IDs ).
* Grails detects any Groovy class inside the
* grails-app/conf folder ending with 'Filters' to be a filter by convention.
*
* before - Applied before processing a request URL.
* after - Applied after processing a request URL, but before rendering the view.
* afterView - Applied after rendering the view.
*
*/
class SecurityFilters {

    def filters = {

        urlSanitizeFilter(controller:'*',action:'*') {

            before = {


                //back to old controller
                /*
                if(session.getAttribute("beforeController") != null && session.getAttribute("beforeController") != "") {

                    String beforeController = session.getAttribute("beforeController");
                    session.removeAttribute("beforeController")
                    print "set redirect"

                    redirect(controller: beforeController)

                }
                */



                //controllers for startpage and oauth
                def positiveControllers = ['oauth','logout','login']
                if(params.controller == null || positiveControllers.contains(params.controller)) {

                     //allowed methods

                } else {
                    //workgroup
                    if(params.controller != 'workGroup') {
                        //test for workgroup in session
                        if(!session.getAttribute('activeWorkGroup')){
                           //session.setAttribute("beforeController",params.controller)
                           redirect(controller: 'workGroup')

                        }
                    }
                    //website
                    if(params.controller != 'workGroup' && params.controller != 'website') {

                        if(!session.getAttribute('activeWebsite')){
                            //session.setAttribute("beforeController",params.controller)
                            redirect(controller: 'website')
                        }
                    }
                }
/*

                //
                else if(params?.id) { // if a parameter named 'id' is passed in.
                    // if id is not a number of 1-10 digits,
                    if(!(params?.id ==~ /\d{1,10}/)){
			            redirect(controller: 'errors', action: 'accessDenied', params:[message:'only numbers allowed'])
                        return false
		            }else{
                        def activeWorkGroupId = session.getAttribute('activeWorkGroup')
                        def activeWebsiteId = session.getAttribute('activeWebsite')

                        //get current page
                        def currentpage = Page.find {
                                              id == params.id
                        }

                        if(currentpage == null){
                            redirect(controller: 'errors', action: 'accessDenied', params:[message:'access denied'])
                        }

                        //get current website
                        def currentWebsite = Website.find{
                                     id == activeWebsiteId
                        }

                        if(currentWebsite == null){
                            redirect(controller: 'errors', action: 'accessDenied', params:[message:'access denied'])
                        }

                        //check if website contains current page
                        if(!currentpage in currentWebsite.page){
                            redirect(controller: 'errors', action: 'accessDenied', params:[message:'access denied'])
                        }else{
                            //compare workgroup of current and session page, redirect if not equal
                            if(!currentWebsite.workGroupId ==  activeWorkGroupId){
                                redirect(controller: 'errors', action: 'accessDenied', params:[message:'access denied'])
                            }

                        }
		            }

                }
                 */
            }
        }


        // add other filters here. Filters are executed from top to bottom.
   }
}

