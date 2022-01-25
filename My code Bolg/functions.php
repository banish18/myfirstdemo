<?php 

add_action( 'wp_enqueue_scripts', 'salient_child_enqueue_styles', 100);

function salient_child_enqueue_styles() {
		
		$nectar_theme_version = nectar_get_theme_version();
		wp_enqueue_style( 'salient-child-style', get_stylesheet_directory_uri() . '/style.css', '', $nectar_theme_version );
		
    if ( is_rtl() ) {
   		wp_enqueue_style(  'salient-rtl',  get_template_directory_uri(). '/rtl.css', array(), '1', 'screen' );
		}
}
function add_breadcrumb_to_body() {
     echo do_shortcode("[flexy_breadcrumb]");
	?>
	<script>
		jQuery( "div.fbc.fbc-page" ).prependTo( jQuery( ".container.main-content" ) );
		jQuery(".single .row.heading-title.hentry").prependTo( jQuery( ".single .row .post-area.col" ) );
	</script>
	<?php
}
add_action( 'wp_footer', 'add_breadcrumb_to_body' );

/*projects Ajax */

add_action( 'wp_ajax_get_posts_from_cat1', 'get_posts_from_cat1' );
add_action( 'wp_ajax_nopriv_get_posts_from_cat1', 'get_posts_from_cat1' );
 
function get_posts_from_cat1()
{
 extract($_POST);
 
 /* Data Comes from ajax request */

 $cat_name = $cat;
 //echo $cat_name;
 ?>
 <div class="row"> 
		    <?php 
		    if($cat_name == "all"){
		    	$args = array(  'post_type' => 'our_projects', 
								'posts_per_page' => 45, 
								'meta_key' => 'closed_date',
								'orderby'  => 'meta_value',
								'order'	=> 'DESC'
							);
		    }
		    else{
		    	$args = array(  'post_type' => 'our_projects',
		    					'posts_per_page' => 20, 
								'meta_key' => 'closed_date',
								'orderby'  => 'meta_value',
								'order'	=> 'DESC',
					'tax_query' => array(
				        array (
				            'taxonomy' => 'custom-cat',
				            'field' => 'slug',
				            'terms' => $cat_name ,
				        )
				    ),
				);
		    }			
				
				$projectss = new WP_Query( $args );
				$count = $projects->post_count;
				if( $projectss->have_posts() ) {
				$i=1;					
				 while( $projectss->have_posts() ) {
				    $projectss->the_post();

				    $tours = pods('our_projects', get_the_ID());

				    $city = $tours->display('city');
				    $closed_date = $tours->display('closed_date');

				    $orgDate = $closed_date;  
				    $newDate = date("F Y", strtotime($orgDate));  				   

				    $total_cost = $tours->display('total_cost');
				    $total_nmtcs = $tours->display('total_nmtcs');
				    $poverty_rate = $tours->display('poverty_rate');
				    $nnmf_nmtcs = $tours->display('nnmf_nmtcs');
				    $community_minority_population = $tours->display('community_minority_population');
				    $jobs_created = $tours->display('jobs_created');
				    $jobs_created_for_low = $tours->display('jobs_created_for_low');				    
				    $award_winning_text = $tours->display('award_winning_text');
				    $extra_field_name = $tours->display('extra_field_name');
				    $extra_field_value = $tours->display('extra_field_value');

				    if($i==7){
				    	echo '<div class="load-more-sec"><button class="load-more-btn" onclick="load_click();">Load More</button></div>';
				    	echo '<div class="loaded-projects hide">';											
					}
					?>	
					<div class="col-4">
						<div class="project-section1">
							<div class="project-image">
								<img src="<?php echo wp_get_attachment_url( get_post_thumbnail_id($projectss->ID) ); ?>" alt="Image not found" class="img-fluid">
							</div>
							<?php if($award_winning_text){
								echo '<div class="award-strip">AWARD WINNING</div>';
							}	  
							?>          
							<h3 class="project-heading"><?php echo get_the_title(); ?></h3>
						 	<div class="city-date">
						 		<h5 class="city">(<?php echo $city; ?>)</h5> | <h5 class="date">Closed <?php echo $newDate; ?></h5>
						 	</div>
						 	<div class="total-price">
						 		<h4 class="total_cost">$<?php echo $total_cost; ?> Total Costs</h4> | <h4 class="total_nmtcs">$<?php echo $total_nmtcs; ?> Total NMTCS</h4>
						 	</div>
						 	<div class="list-sec">
						 		<ul>
						 			<?php if($poverty_rate){ ?>
						 				<li><div class="bold"><strong><?php echo $poverty_rate; ?>%</strong></div> Poverty Rate</li>
						 			<?php } ?>
						 			<?php if($community_minority_population){ ?>	
						 				<li><div class="bold"><strong><?php echo $community_minority_population; ?>%</strong></div> Community Minority Population</li>
						 			<?php } ?>
						 			<?php if($jobs_created){ ?>
						 				<li><div class="bold"><strong><?php echo $jobs_created; ?></strong></div> Jobs Created</li>
						 			<?php } ?>
						 			<?php if($jobs_created_for_low){ ?>
						 				<li><div class="bold"><strong><?php echo $jobs_created_for_low; ?>%</strong></div> Jobs Created for Low & Mod Income</li>
						 			<?php } ?>
						 			<?php if($extra_field_name && $extra_field_value){ ?>
						 				<li><div class="bold"><strong><?php echo $extra_field_value; ?></strong></div> <?php echo $extra_field_name; ?></li>
						 			<?php } ?>	
						 		</ul>	
						 	</div>
						</div>
						<div class="project-section2">
							<h3 class="project-heading2"><?php echo get_the_title(); ?></h3>
							<div class="project-content">
								<?php echo get_the_content(); ?>
							</div>
							<div class="nnmf_nmtcs">
								<h4>NNMF NMTCS: $<?php echo $nnmf_nmtcs; ?></h4>
							</div>
							<?php if($award_winning_text){ ?>	
								<div class="award-content">
									<h4 class="project-heading2">Award Winner :</h4>
									<?php echo $award_winning_text; ?>
								</div>
							<?php } ?>
						</div>
					</div>		
					<?php
					$i=$i+1;
				 }
				 if($count > 6){
				    	echo '</div>';					
				 }
				}
            ?>                 
    </div>
 <?php
 die();
}
/*projects Ajax */


/* Team Page */

function get_team_members()
{
	ob_start();	
	$argss = array(  'post_type' => 'team',
					'posts_per_page' => 8,
					'meta_key' => 'order_number',
					'orderby'  => 'meta_value',
					'order'	=> 'ASC'
				 );
	$team = new WP_Query( $argss );
	//$count = $team->post_count;
	if( $team->have_posts() ) {
		//$i=1;
		echo "<div class='team-main-sec'>";

		while( $team->have_posts() ) {
			$team->the_post();
		    $pos = pods('team', get_the_ID());
		    $position = $pos->display('position');
			$title_url = get_the_title();
			
		    ?>
		   	<div class="team-col-3">
		   		<a href="management-team/?member=<?php echo urlencode($title_url); ?>" class="team-link">
			   		<div class="team-inner-sec">
				   		<div class="team-mem-img">
							<img src="<?php echo wp_get_attachment_url( get_post_thumbnail_id($team->ID) ); ?>" alt="Image not found" class="img-fluid">
						</div>
						<div class="team-mem-info">
							<h4><?php echo get_the_title(); ?></h4>
							<p class="team-pos"><?php echo $position; ?></p>
						</div>
					</div>
				</a>
		   	</div>
			<?php
		}
        
		echo "</div>";
	}
	return ob_get_clean();  
}
function shortcodes_init(){
 add_shortcode( 'get_team_members', 'get_team_members' );
}
add_action('init', 'shortcodes_init');


/* Team Page */

add_action( 'init', 'remove_dns_prefetch' ); 
function  remove_dns_prefetch () {      
   remove_action( 'wp_head', 'wp_resource_hints', 2, 99 ); 
} 


add_action('pre_get_posts','bamboo_pre_get_posts');
function bamboo_pre_get_posts( $query ) { 
    if( $query->is_main_query() && !$query->is_feed() && !is_admin() ) { 
        $query->set( 'paged', str_replace( '/', '', get_query_var( 'page' ) ) ); 
    } 
}

function custom_pagination($pages = '', $range = 2)
{  
	$showitems = ($range * 2)+1;  

	global $paged;


	if(empty($paged)) $paged = 1; 
	if($pages != $paged){
		 $nextPage = $paged+1;

	}else{
		$nextPage = $paged;
	}
	$prevPage = $paged-1;
	$prevDisCLass = '';
	if($paged == 1){
		$prevDisCLass = 'disable';
	}
	$nextDisCLass = '';
	if($paged == $pages){
		$nextDisCLass = 'disable';
	}

	if(1 != $pages)
	{
		echo "<div class='pagination-label-section'>
		<label>You are on page</label></div>
		<div class='pagination-section'><select class='pagination' id='sel-posts'>";

		for ($i=1; $i <= $pages; $i++)
		{
		 if (1 != $pages &&( !($i >= $paged+$range+1 || $i <= $paged-$range-1) || $pages <= $showitems ))
		 {	
		 	$selected = "";
		 	if($paged == $i){
		 		$selected = "selected='selected'";
		 	}
		     echo  "<option class='current' ".$selected." data-link='".get_pagenum_link($i)."'>".$i."</option>";
		 }
		}


		echo "</select></div>

		<div class='pref-next-pagi'>
		<a class='left-pagi-arr ".$prevDisCLass."' href='".get_pagenum_link($prevPage)."'>
		<img src='".get_stylesheet_directory_uri()."/assets/images/arrow_left_pagination.svg' class='img-fluid' /></a>
		<a class='right-pagi-arr ".$nextDisCLass."'  href='".get_pagenum_link($nextPage)."'>
		<img src='".get_stylesheet_directory_uri()."/assets/images/arrow_right_pagination.svg' class='img-fluid' /></a>
		</div>";
	}
 }


 function get_post_tags($posttags){
 	if ($posttags) {
		$i = 0;
	  foreach($posttags as $tag) {
	  	$i++;
	  	if($i <= 1 && $tag->name != ''){
	  		$tagLink = get_tag_link( $tag->term_id );
	  		echo '<div class="p-tag">

	  		<a class="btn btn-primary read-more" href="'.$tagLink.'" role="button"> '. $tag->name.' </a></div>';	
	  	}
	 
	  }
	}
 }

/* add_filter( 'posts_where', 'title_like_posts_where', 10, 2 );
function title_like_posts_where( $where, $wp_query ) {
    global $wpdb;
    if ( $post_title_like = $wp_query->get( 'post_title_like' ) ) {
        $where .= ' AND ' . $wpdb->posts . '.post_title LIKE \'%' . esc_sql( $wpdb->esc_like( $post_title_like ) ) . '%\'';
    }
    return $where;
}*/


	function get_searc_data() {
		 global $wpdb;
		//echo "<pre>";print_r($_REQUEST);
		$searchParam = $_REQUEST['q'];

		if(isset($_REQUEST['catData']) && count($_REQUEST['catData']) > 0){
			$catArr = implode(',', $_REQUEST['catData']);
			$posts = $wpdb->get_results("SELECT 
			ID, post_title AS title, post_excerpt AS excerpt,tt.term_id FROM $wpdb->posts p
			JOIN $wpdb->term_relationships tr ON (p.ID = tr.object_id)
			JOIN $wpdb->term_taxonomy tt ON (tr.term_taxonomy_id = tt.term_taxonomy_id)
			JOIN $wpdb->terms t ON (tt.term_id = t.term_id)
			WHERE p.post_type='post'
			AND p.post_status = 'publish'
			AND tt.taxonomy = 'category'
			AND t.term_id IN ($catArr)
			AND post_title LIKE '%". $wpdb->esc_like( $searchParam ) ."%'
			ORDER BY post_date DESC");
		}else{
			$posts = $wpdb->get_results("SELECT 
			ID, post_title AS title, post_excerpt AS excerpt FROM $wpdb->posts p
			WHERE p.post_type='post'
			AND p.post_status = 'publish'
			AND post_title LIKE '%". $wpdb->esc_like( $searchParam ) ."%'
			ORDER BY post_date DESC");
		}

		//echo "<pre>";print_r($posts);

		$postsArr = [];
		$allpostsArr = [];
		foreach ($posts as $post) {
		    $catName = get_the_category( $post->ID )[0]->name;
			if(isset($category[get_the_category( $post->ID)[0]->slug])){
				$catName = '';
			}
			$catSlug = get_the_category( $post->ID)[0]->slug;
			$postsArr[$catSlug][] = array('id' => $post->term_id,'slug' => get_the_category( $post->ID )[0]->name,'value' => html_entity_decode( get_the_title($post->ID)), 'label' => html_entity_decode( get_the_title($post->ID)),'category' =>  $catName);
			$category[get_the_category( $post->ID)[0]->slug] = get_the_category( $post->ID)[0]->slug;
		}

		foreach ($postsArr as $key => $value) {
			foreach ($value as $keyY => $vvalue) {
				$allpostsArr[] = $vvalue;
			}
			
		}




	
		/*$arr_posts = new WP_Query( $args );
		$postsArr = [];
		$allpostsArr = [];
		if ( $arr_posts->have_posts() ) :			  
			while ( $arr_posts->have_posts() ) :
				$arr_posts->the_post();
				//echo "<pre>";print_r(get_the_category( get_the_ID() ));
				$catName = get_the_category( get_the_ID() )[0]->name;
				if(isset($category[get_the_category( get_the_ID())[0]->slug])){
					$catName = '';
				}
				$catSlug = get_the_category( get_the_ID())[0]->slug;
				$postsArr[$catSlug][] = array('id' => get_the_category( get_the_ID() )[0]->term_id,'slug' => get_the_category( get_the_ID() )[0]->name,'value' => html_entity_decode(get_the_title()), 'label' => html_entity_decode(get_the_title()),'category' =>  $catName);
				$category[get_the_category( get_the_ID())[0]->slug] = get_the_category( get_the_ID())[0]->slug;
				
			endwhile;

			foreach ($postsArr as $key => $value) {
				foreach ($value as $keyY => $vvalue) {
					$allpostsArr[] = $vvalue;
				}
				
			}
		else:
		echo 'No records';	
		endif;
		wp_reset_postdata();	*/


		//echo "<pre>";print_r($postsArr);
		echo json_encode($allpostsArr);
		die;
		wp_die();
	}

	add_action( 'wp_ajax_nopriv_get_searc_data', 'get_searc_data' );
	add_action( 'wp_ajax_get_searc_data', 'get_searc_data' );

?>