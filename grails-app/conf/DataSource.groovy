dataSource {
    pooled = true
    
    
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
}

// environment specific settings
environments {
    development {
        dataSource {
	    driverClassName = "org.h2.Driver"
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
	    username = "sa"
    	    password = ""
        }
    }
    test {
        dataSource {
		driverClassName = "org.h2.Driver"
		username = "sa"
    	    password = ""
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
		driverClassName = "com.mysql.jdbc.Driver"
    		dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
    		username = "web106"
    		password = "D|u>vYo+8J"
            	dbCreate = "update"
 		url = "jdbc:mysql://web106.cklr3ydv9uj8.eu-west-1.rds.amazonaws.com:3306/web106_prod"
           	properties {
		       maxActive = -1
		       minEvictableIdleTimeMillis=1800000
		       timeBetweenEvictionRunsMillis=1800000
		       numTestsPerEvictionRun=3
		       testOnBorrow=true
		       testWhileIdle=true
		       testOnReturn=false
		       validationQuery="SELECT 1"
		       jdbcInterceptors="ConnectionState"
            }
        }
    }
}
