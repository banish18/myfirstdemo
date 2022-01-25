<?php

/**
* Template Name: Test page
*
* @package WordPress
* @subpackage Twenty_Fourteen
* @since Twenty Fourteen 1.0
*/
get_header();
?>
<style>
	
	.ui-widget{
		width:100%;
		margin-top: 10px;
		padding:10px;
	}
	.ui-widget #tags{
		width: 100%;
	}
	.list-group-flush{
		display: flex;
	}
	.list-group-flush li{
		list-style: none;
	}

</style>
<div class="container">
	<div class="row">
		<label>Filters</label>
		 <ul class="list-group list-group-flush">
		    <li class="list-group-item">
		      <!-- Default checked -->
		      <div class="custom-control custom-checkbox">
		        <input type="checkbox" class="category-selection" id="check1" value="59" onclick="getResutls()">
		        <label class="custom-control-label" for="check1">Awards</label>
		      </div>
		    </li>
		    <li class="list-group-item">
		      <!-- Default checked -->
		      <div class="custom-control custom-checkbox">
		        <input type="checkbox" class="category-selection" id="check2" value="65" onclick="getResutls()">
		        <label class="custom-control-label" for="check2" >SDS Capital Group</label>
		      </div>
		    </li>
		    <li class="list-group-item">
		      <!-- Default checked -->
		      <div class="custom-control custom-checkbox">
		        <input type="checkbox" class="category-selection" id="check3" value="64" onclick="getResutls()">
		        <label class="custom-control-label" for="check3">Supportive Housing Fund</label>
		      </div>
		    </li>
		    <li class="list-group-item">
		      <!-- Default checked -->
		      <div class="custom-control custom-checkbox">
		        <input type="checkbox" class="category-selection" id="check4" value="63" onclick="getResutls()">
		        <label class="custom-control-label" for="check4">ASREF I</label>
		      </div>
		    </li>
		    <li class="list-group-item">
		      <!-- Default checked -->
		      <div class="custom-control custom-checkbox">
		        <input type="checkbox" class="category-selection" id="check5" value="63" onclick="getResutls()">
		        <label class="custom-control-label" for="check5">ASREF II</label>
		      </div>
		    </li>
		     <li class="list-group-item">
		      <!-- Default checked -->
		      <div class="custom-control custom-checkbox">
		        <input type="checkbox" class="category-selection" id="check5" value="62" onclick="getResutls()">
		        <label class="custom-control-label" for="check5">National New Markets Fund</label>
		      </div>
		    </li>
		  </ul>
		<div class="ui-widget mt-5 w-100 d-flex">
		  <input id="tags" type="text" placeholder="Type to start searching..." />
		  <input type="hidden" id="seleted_post_id" />
		  <input type="hidden" id="seleted_post_slug" />
		  <input type="button" id="search-post" value="Search" class="btn btn-success" />
		</div>
	</div>
</div>

<?php get_footer(); ?>
<script type="text/javascript">


	  
  jQuery( function() {
   jQuery( "#tags" ).autocomplete({
      source: function( request, response ) {
      	var quotations = [];
      	jQuery('input[class=category-selection]:checked').each(function(index) {
	        quotations.push(jQuery(this).val());
	    });

	   // console.log(quotations);

         jQuery.ajax({
         type : "post",
         dataType : "json",
         url : '/sdsgroup/wp-admin/admin-ajax.php',
         data : {action: "get_searc_data", q: request.term,catData:quotations},
         success: function(data) {
         	response( data );
         }
      });


      },
      minLength: 3,
      select: function( event, ui ) {
      	 return jQuery( "<li>" )
        .append( "<div>" + ui.item.category + "<br>" + ui.item.label  + "</div>" )
        .appendTo( ui );


      	jQuery('#tags').val(ui.item.label); // display the selected text
     	jQuery('#seleted_post_slug').val(ui.item.slug); // save selected id to input
     	jQuery('#seleted_post_id').val(ui.item.id); // save selected id to input
      },
      open: function() {
        //jQuery( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      },
      close: function() {
        //jQuery( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      }
    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
      return jQuery( "<li>" )
        .append( "<div><span>" + item.category + "</span>" + item.label  + "</div>" )
        .appendTo( ul );
    };
    

    jQuery("#search-post").click(function(){
    	var url = 'http://18.221.17.130/sdsgroup/news/';
    	var postSlug = jQuery("#seleted_post_id").val();
    	window.location.href = url+postSlug;
    });

  } );

/*
  var input = jQuery('#tags');

  function __init(){
  	input.autocomplete({
      source: function( request, response ) {
      	var quotations = [];
      	jQuery('input[class=category-selection]:checked').each(function(index) {
	        quotations.push(jQuery(this).val());
	    });

	   // console.log(quotations);

         jQuery.ajax({
         type : "post",
         dataType : "json",
         url : '/sdsgroup/wp-admin/admin-ajax.php',
         data : {action: "get_searc_data", q: request.term,catData:quotations},
         success: function(data) {
         	response( data );
         }
      });


      },
      minLength: 3,
      select: function( event, ui ) {
      	 return jQuery( "<li>" )
        .append( "<div>" + ui.item.category + "<br>" + ui.item.label  + "</div>" )
        .appendTo( ui );


      	jQuery('#tags').val(ui.item.label); // display the selected text
     	jQuery('#seleted_post_slug').val(ui.item.slug); // save selected id to input
     	jQuery('#seleted_post_id').val(ui.item.id); // save selected id to input
      },
      open: function() {
        //jQuery( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      },
      close: function() {
        //jQuery( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      }
    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
      return jQuery( "<li>" )
        .append( "<div><span>" + item.category + "</span>" + item.label  + "</div>" )
        .appendTo( ul );
    };
  }
*/
  function getResutls(){
  	jQuery('#tags').autocomplete('search');
  }

</script>
