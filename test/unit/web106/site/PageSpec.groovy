package web106.site

import grails.test.mixin.TestFor;
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import spock.lang.Specification
import grails.test.mixin.Mock
import web106.site.*
/**
 * See the API for {@link grails.test.mixin.support.GrailsUnitTestMixin} for usage instructions
 */
@TestMixin(GrailsUnitTestMixin)
@Mock([Page, Box])
@TestFor(Page)
class PageSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    def "page set title"() {

		setup:
		def newPage = new Page() 	
		
		when: 
		
		newPage.title = "Welcome to my new Page!"
		
		then:
		
		newPage.title == "Welcome to my new Page!"
    }
	
	def "save new Page"() {
		setup:
		
		def visibleFromDate = new Date()
		def visibleToDate = new Date()
		
		def newPage = new Page(title: "saveMe", visibleTo: visibleToDate, visibleFrom : visibleFromDate)
		
		when:
		
		newPage.save(flush: true, failOnError: true)
		
		then:
		
		newPage.id > 0
	}
	
	
}
