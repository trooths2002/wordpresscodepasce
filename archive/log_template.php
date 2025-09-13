<?php
// MU helper: logs which PHP template WordPress uses for each front-end request.
// This file is intended to be copied to wp-content/mu-plugins/log_template.php
// for temporary debugging and then removed.
if ( ! defined( 'WPINC' ) ) {
    // Prevent direct access
    exit;
}

add_action( 'template_include', function( $template ) {
    $uri = isset( $_SERVER['REQUEST_URI'] ) ? $_SERVER['REQUEST_URI'] : 'CLI';
    $log_line = date( 'c' ) . " " . $uri . " -> " . $template . PHP_EOL;
    @file_put_contents( WP_CONTENT_DIR . '/template-log.txt', $log_line, FILE_APPEND );
    return $template;
} );

// Also log earlier lifecycle hooks to catch redirects that happen before templates load.
add_action( 'init', function() {
    $uri = isset( $_SERVER['REQUEST_URI'] ) ? $_SERVER['REQUEST_URI'] : 'CLI';
    $log_line = date( 'c' ) . " INIT " . $uri . "\n";
    @file_put_contents( WP_CONTENT_DIR . '/template-log.txt', $log_line, FILE_APPEND );
} );

add_action( 'template_redirect', function() {
    $uri = isset( $_SERVER['REQUEST_URI'] ) ? $_SERVER['REQUEST_URI'] : 'CLI';
    $is_front = function_exists( 'is_front_page' ) ? (is_front_page() ? 'front' : 'not-front') : 'unknown';
    $log_line = date( 'c' ) . " TEMPLATE_REDIRECT " . $uri . " (" . $is_front . ")\n";
    @file_put_contents( WP_CONTENT_DIR . '/template-log.txt', $log_line, FILE_APPEND );
} );
