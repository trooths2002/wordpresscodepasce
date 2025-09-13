<?php
// Child theme functions
if ( ! defined( 'ABSPATH' ) ) exit;

/**
 * Enqueue parent and child styles.
 */
function simple_rt_child_enqueue() {
    // Parent style handle assumed 'simple-rt-style' (from parent theme). Fallback to 'simple-theme-style'.
    if ( wp_style_is( 'simple-rt-style', 'registered' ) ) {
        $deps = array( 'simple-rt-style' );
    } else {
        $deps = array( 'simple-theme-style' );
    }
    wp_enqueue_style( 'simple-theme-child-style', get_stylesheet_directory_uri() . '/style.css', $deps, wp_get_theme()->get('Version') );
}
add_action( 'wp_enqueue_scripts', 'simple_rt_child_enqueue' );

/**
 * Get category link by slug, or '#' if not found.
 */
function rt_get_category_link_by_slug( $slug ) {
    $cat = get_category_by_slug( $slug );
    if ( $cat ) return get_category_link( $cat->term_id );
    return '#';
}

/**
 * Get page permalink by slug, or '#' if not found.
 */
function rt_get_page_link_by_slug( $slug ) {
    $page = get_page_by_path( $slug );
    if ( $page ) return get_permalink( $page->ID );
    return '#';
}

// If the child theme's front-page.php is corrupted, prefer loading a clean template.
add_filter( 'template_include', function( $template ) {
    if ( is_front_page() ) {
        $clean = get_stylesheet_directory() . '/front-page-clean.php';
        if ( file_exists( $clean ) ) {
            return $clean;
        }
    }
    return $template;
} );

// Enqueue hero styles specifically
function simple_rt_enqueue_hero_css() {
    $hero_path = get_stylesheet_directory() . '/hero.css';
    if ( file_exists( $hero_path ) ) {
        // Enqueue hero.css without depending on a possibly-missing handle to ensure it prints.
        wp_enqueue_style( 'simple-theme-hero-style', get_stylesheet_directory_uri() . '/hero.css', array(), wp_get_theme()->get('Version') );
    }
}
add_action( 'wp_enqueue_scripts', 'simple_rt_enqueue_hero_css' );
