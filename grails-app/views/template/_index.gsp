 <!DOCTYPE html>
<html>
   <head>
	  <style type="text/css">
	  .color{
	  background-color: grey;
	  border-style:solid;
	  border-width:medium;
	  border-color:white;
	  }
	  
	  <!--
	  -->
	  </style>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.3.0/pure-min.css">
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.3.0/grids-min.css">
	<r:layoutResources />
   </head>
<body>

<div id="menu" class="pure-g-r">
    
    <div id="nav" class="pure-u-1-6">
    
		<g:render template="/shared/backendsidebar" />
	
	</div>
	<div id="main" class="pure-u-5-6">

	<h3>Wähle ein Template:</h3>

	
	<g:each var="template" in="${templates}">
		<div class="btn btn-default"><a href="${createLink(action: template.name.toLowerCase())}">${template.name}</a></div>
	</g:each>
 	</div>
 	
      
</div>
	<r:layoutResources />
</body>
</html>