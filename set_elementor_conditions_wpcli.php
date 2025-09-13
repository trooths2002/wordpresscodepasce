<?php
// Usage (via WP-CLI eval-file):
// POST_ID=29436 wp eval-file set_elementor_conditions_wpcli.php --path=/var/www/html --allow-root

$post_id = intval( getenv('POST_ID') ?: 0 );
if ( ! $post_id ) {
    echo "Error: POST_ID environment variable not set or invalid.\n";
    return;
}

// Build condition for front page
$conditions = array(
    array(
        'location' => 'front_page',
        'conditions' => array(),
    ),
);

// Update meta using WP API to ensure proper serialization
if ( function_exists( 'update_post_meta' ) ) {
    update_post_meta( $post_id, '_elementor_conditions', $conditions );
    echo "_elementor_conditions meta written for post {$post_id}\n";
} else {
    echo "WP functions not available. Run via wp eval-file.\n";
}
