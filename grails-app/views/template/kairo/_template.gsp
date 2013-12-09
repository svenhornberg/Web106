 <!DOCTYPE html>
<html>
   <head>
	  <style type="text/css">
	  .grey{
	  background-color: grey;
	  }
	  .blue{
	  background-color: blue;
	  }	
	  .red{
	  background-color: red;
	  }  
	  .green{
	  background-color: green;
	  } 
	  .centermessagebox {
	  		    margin: 0 auto;
	  }
	  <!--
	  -->
	 </style>
<link rel="stylesheet"
	href="http://yui.yahooapis.com/pure/0.3.0/pure-min.css" />
<link rel="stylesheet"
	href="http://yui.yahooapis.com/pure/0.3.0/grids-min.css" />
<g:javascript library="jquery" />
<r:require module="jquery-ui"/>
<r:layoutResources />

<script type="text/javascript">
        $(function() {

        	
        	if(document.URL.indexOf("template") == -1) {
            	$('.centermessagebox').hide();
            } 

		

            /*$('#header').on(
                   'drop', function(event, ui){
                        var draggableId = ui.draggable.attr("id");
                        var droppableId = $(this).attr("id");
                        alert("draggableId: "+draggableId+" droppableId: "+droppableId)
                                <g:remoteFunction controller="page" action="remote" params="[id:'1', draggableId:'test']"/>
                            }
                    );  */

            $('#header').on(
                    'drop', function(event, ui){
                        var draggableId = ui.draggable.attr("id");
                        var droppableId = $(this).attr("id");
                        alert("draggableId: "+draggableId+" droppableId: "+droppableId)

                        jQuery.ajax({
                            url: "${createLink(controller: 'page', action: 'remote')}",
                            data: {draggableId:draggableId, droppableId:droppableId},
                            success: function (data) {
                                alert(data);
                            }
                        });

                    }
            );
        });
</script>
</head>
<body>

		<g:if test="${centermessagebox==true}">
			<g:render template="/shared/centermessagebox" />
		</g:if>

		<div id="main" class="pure-u-1">
			
			
			
			<div class="pure-g-r">
				<div id="header" class="pure-u-1-3 grey dropbox">
					${header}
				</div>
				<div id="side1" class="pure-u-2-3 green">
					${side1}
				</div>
			</div>
			<div class="pure-g-r">
				<div id="side2" class="pure-u-1-3 blue">
					${side2}
				</div>
				<div id="content" class="pure-u-1-3 grey">
					${content}
				</div>
				<div id="side3" class="pure-u-1-3 red">
					${side3}
				</div>
			</div>

			<div class="pure-g-r">
				<div id="footer" class="pure-u-1 green">
					${footer}
				</div>
			</div>	
		</div>

	<r:layoutResources />
</body>
</html>
	 
	 
	 
	 
	 
	